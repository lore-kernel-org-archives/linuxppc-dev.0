Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rV1H65JvPzDqdD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 19:21:38 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id 66so1392987pfy.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 02:21:38 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, mpe@ellerman.id.au, paulus@samba.org,
 benh@kernel.crashing.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 agraf@suse.com, rkrcmar@redhat.com,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH 3/4] kvm/stats: Add provisioning for 64-bit vcpu statistics
Date: Wed, 15 Jun 2016 19:21:07 +1000
Message-Id: <1465982468-18833-3-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1465982468-18833-1-git-send-email-sjitindarsingh@gmail.com>
References: <1465982468-18833-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

vcpus have statistics associated with them which can be viewed within the
debugfs. Currently it is assumed within the vcpu_stat_get() and
vcpu_stat_get_per_vm() functions that all of these statistics are
represented as 32-bit numbers. The next patch adds some 64-bit statistics,
so add provisioning for the display of 64-bit vcpu statistics.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/kvm/book3s.c |  1 +
 include/linux/kvm_host.h  |  1 +
 virt/kvm/kvm_main.c       | 60 +++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 47018fc..ed9132b 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -40,6 +40,7 @@
 #include "trace.h"
 
 #define VCPU_STAT(x) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU
+#define VCPU_STAT_U64(x) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU_U64
 
 /* #define EXIT_DEBUG */
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 1c9c973..667b30e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -991,6 +991,7 @@ static inline bool kvm_is_error_gpa(struct kvm *kvm, gpa_t gpa)
 enum kvm_stat_kind {
 	KVM_STAT_VM,
 	KVM_STAT_VCPU,
+	KVM_STAT_VCPU_U64,
 };
 
 struct kvm_stat_data {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 02e98f3..ac47ffb 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3566,6 +3566,20 @@ static int vcpu_stat_get_per_vm(void *data, u64 *val)
 	return 0;
 }
 
+static int vcpu_stat_u64_get_per_vm(void *data, u64 *val)
+{
+	int i;
+	struct kvm_stat_data *stat_data = (struct kvm_stat_data *)data;
+	struct kvm_vcpu *vcpu;
+
+	*val = 0;
+
+	kvm_for_each_vcpu(i, vcpu, stat_data->kvm)
+		*val += *(u64 *)((void *)vcpu + stat_data->offset);
+
+	return 0;
+}
+
 static int vcpu_stat_get_per_vm_open(struct inode *inode, struct file *file)
 {
 	__simple_attr_check_format("%llu\n", 0ull);
@@ -3573,6 +3587,13 @@ static int vcpu_stat_get_per_vm_open(struct inode *inode, struct file *file)
 				 NULL, "%llu\n");
 }
 
+static int vcpu_stat_u64_get_per_vm_open(struct inode *inode, struct file *file)
+{
+	__simple_attr_check_format("%llu\n", 0ull);
+	return kvm_debugfs_open(inode, file, vcpu_stat_u64_get_per_vm,
+				 NULL, "%llu\n");
+}
+
 static const struct file_operations vcpu_stat_get_per_vm_fops = {
 	.owner   = THIS_MODULE,
 	.open    = vcpu_stat_get_per_vm_open,
@@ -3582,9 +3603,19 @@ static const struct file_operations vcpu_stat_get_per_vm_fops = {
 	.llseek  = generic_file_llseek,
 };
 
+static const struct file_operations vcpu_stat_u64_get_per_vm_fops = {
+	.owner   = THIS_MODULE,
+	.open    = vcpu_stat_u64_get_per_vm_open,
+	.release = kvm_debugfs_release,
+	.read    = simple_attr_read,
+	.write   = simple_attr_write,
+	.llseek  = generic_file_llseek,
+};
+
 static const struct file_operations *stat_fops_per_vm[] = {
-	[KVM_STAT_VCPU] = &vcpu_stat_get_per_vm_fops,
-	[KVM_STAT_VM]   = &vm_stat_get_per_vm_fops,
+	[KVM_STAT_VCPU]		= &vcpu_stat_get_per_vm_fops,
+	[KVM_STAT_VCPU_U64]	= &vcpu_stat_u64_get_per_vm_fops,
+	[KVM_STAT_VM]		= &vm_stat_get_per_vm_fops,
 };
 
 static int vm_stat_get(void *_offset, u64 *val)
@@ -3627,9 +3658,30 @@ static int vcpu_stat_get(void *_offset, u64 *val)
 
 DEFINE_SIMPLE_ATTRIBUTE(vcpu_stat_fops, vcpu_stat_get, NULL, "%llu\n");
 
+static int vcpu_stat_u64_get(void *_offset, u64 *val)
+{
+	unsigned offset = (long)_offset;
+	struct kvm *kvm;
+	struct kvm_stat_data stat_tmp = {.offset = offset};
+	u64 tmp_val;
+
+	*val = 0;
+	spin_lock(&kvm_lock);
+	list_for_each_entry(kvm, &vm_list, vm_list) {
+		stat_tmp.kvm = kvm;
+		vcpu_stat_u64_get_per_vm((void *)&stat_tmp, &tmp_val);
+		*val += tmp_val;
+	}
+	spin_unlock(&kvm_lock);
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(vcpu_stat_u64_fops, vcpu_stat_u64_get, NULL, "%llu\n");
+
 static const struct file_operations *stat_fops[] = {
-	[KVM_STAT_VCPU] = &vcpu_stat_fops,
-	[KVM_STAT_VM]   = &vm_stat_fops,
+	[KVM_STAT_VCPU]		= &vcpu_stat_fops,
+	[KVM_STAT_VCPU_U64]	= &vcpu_stat_u64_fops,
+	[KVM_STAT_VM]		= &vm_stat_fops,
 };
 
 static int kvm_init_debug(void)
-- 
2.5.5
