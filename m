Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgfJR6x6MzDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 14:42:31 +1000 (AEST)
Date: Mon, 28 Aug 2017 14:42:29 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: nixiaoming <nixiaoming@huawei.com>, David Hildenbrand <david@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH] KVM: PPC: Book3S HV: Protect updates to spapr_tce_tables list
Message-ID: <20170828044228.GB12629@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Al Viro pointed out that while one thread of a process is executing
in kvm_vm_ioctl_create_spapr_tce(), another thread could guess the
file descriptor returned by anon_inode_getfd() and close() it before
the first thread has added it to the kvm->arch.spapr_tce_tables list.
That highlights a more general problem: there is no mutual exclusion
between writers to the spapr_tce_tables list, leading to the
possibility of the list becoming corrupted, which could cause a
host kernel crash.

To fix the mutual exclusion problem, we add a mutex_lock/unlock
pair around the list_del_rce in kvm_spapr_tce_release().  Also,
this moves the call to anon_inode_getfd() inside the region
protected by the kvm->lock mutex, after we have done the check for
a duplicate LIOBN.  This means that if another thread does guess the
file descriptor and closes it, its call to kvm_spapr_tce_release()
will not do any harm because it will have to wait until the first
thread has released kvm->lock.

The other things that the second thread could do with the guessed
file descriptor are to mmap it or to pass it as a parameter to a
KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE ioctl on a KVM device fd.  An mmap
call won't cause any harm because kvm_spapr_tce_mmap() and
kvm_spapr_tce_fault() don't access the spapr_tce_tables list or
the kvmppc_spapr_tce_table.list field, and the fields that they do use
have been properly initialized by the time of the anon_inode_getfd()
call.

The KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE ioctl calls
kvm_spapr_tce_attach_iommu_group(), which scans the spapr_tce_tables
list looking for the kvmppc_spapr_tce_table struct corresponding to
the fd given as the parameter.  Either it will find the new entry
or it won't; if it doesn't, it just returns an error, and if it
does, it will function normally.  So, in each case there is no
harmful effect.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_64_vio.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 53766e2..8f2da8b 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -265,8 +265,11 @@ static int kvm_spapr_tce_release(struct inode *inode, struct file *filp)
 {
 	struct kvmppc_spapr_tce_table *stt = filp->private_data;
 	struct kvmppc_spapr_tce_iommu_table *stit, *tmp;
+	struct kvm *kvm = stt->kvm;
 
+	mutex_lock(&kvm->lock);
 	list_del_rcu(&stt->list);
+	mutex_unlock(&kvm->lock);
 
 	list_for_each_entry_safe(stit, tmp, &stt->iommu_tables, next) {
 		WARN_ON(!kref_read(&stit->kref));
@@ -298,7 +301,6 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 	unsigned long npages, size;
 	int ret = -ENOMEM;
 	int i;
-	int fd = -1;
 
 	if (!args->size)
 		return -EINVAL;
@@ -328,11 +330,6 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 			goto fail;
 	}
 
-	ret = fd = anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
-				    stt, O_RDWR | O_CLOEXEC);
-	if (ret < 0)
-		goto fail;
-
 	mutex_lock(&kvm->lock);
 
 	/* Check this LIOBN hasn't been previously allocated */
@@ -344,17 +341,19 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 		}
 	}
 
-	if (!ret) {
+	if (!ret)
+		ret = anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
+				       stt, O_RDWR | O_CLOEXEC);
+
+	if (ret >= 0) {
 		list_add_rcu(&stt->list, &kvm->arch.spapr_tce_tables);
 		kvm_get_kvm(kvm);
 	}
 
 	mutex_unlock(&kvm->lock);
 
-	if (!ret)
-		return fd;
-
-	put_unused_fd(fd);
+	if (ret >= 0)
+		return ret;
 
  fail:
 	for (i = 0; i < npages; i++)
-- 
2.7.4
