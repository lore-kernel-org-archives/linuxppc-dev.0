Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 41R7070qy8zF35P
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 17:31:02 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH kernel] KVM: PPC: Expose userspace mm context id via debugfs
Date: Thu, 12 Jul 2018 17:30:26 +1000
Message-Id: <20180712073026.19463-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds a debugfs entry with mm context id of a process which is using
KVM. This id is an index in the process table so the userspace can dump
that tree provided it is granted access to /dev/mem.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/kvm_host.h |  1 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 58 +++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index fa4efa7..bb72667 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -284,6 +284,7 @@ struct kvm_arch {
 	u64 process_table;
 	struct dentry *debugfs_dir;
 	struct dentry *htab_dentry;
+	struct dentry *mm_ctxid_dentry;
 	struct kvm_resize_hpt *resize_hpt; /* protected by kvm->lock */
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 7f3a8cf..3b9eb17 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -2138,11 +2138,69 @@ static const struct file_operations debugfs_htab_fops = {
 	.llseek	 = generic_file_llseek,
 };
 
+static int debugfs_mm_ctxid_open(struct inode *inode, struct file *file)
+{
+	struct kvm *kvm = inode->i_private;
+
+	kvm_get_kvm(kvm);
+	file->private_data = kvm;
+
+	return nonseekable_open(inode, file);
+}
+
+static int debugfs_mm_ctxid_release(struct inode *inode, struct file *file)
+{
+	struct kvm *kvm = file->private_data;
+
+	kvm_put_kvm(kvm);
+	return 0;
+}
+
+static ssize_t debugfs_mm_ctxid_read(struct file *file, char __user *buf,
+				 size_t len, loff_t *ppos)
+{
+	struct kvm *kvm = file->private_data;
+	ssize_t n, left, ret;
+	char tmp[64];
+
+	if (!kvm_is_radix(kvm))
+		return 0;
+
+	ret = snprintf(tmp, sizeof(tmp) - 1, "%lu\n", kvm->mm->context.id);
+	if (*ppos >= ret)
+		return 0;
+
+	left = min_t(ssize_t, ret - *ppos, len);
+	n = copy_to_user(buf, tmp + *ppos, left);
+	ret = left - n;
+	*ppos += ret;
+
+	return ret;
+}
+
+static ssize_t debugfs_mm_ctxid_write(struct file *file, const char __user *buf,
+			   size_t len, loff_t *ppos)
+{
+	return -EACCES;
+}
+
+static const struct file_operations debugfs_mm_ctxid_fops = {
+	.owner	 = THIS_MODULE,
+	.open	 = debugfs_mm_ctxid_open,
+	.release = debugfs_mm_ctxid_release,
+	.read	 = debugfs_mm_ctxid_read,
+	.write	 = debugfs_mm_ctxid_write,
+	.llseek	 = generic_file_llseek,
+};
+
 void kvmppc_mmu_debugfs_init(struct kvm *kvm)
 {
 	kvm->arch.htab_dentry = debugfs_create_file("htab", 0400,
 						    kvm->arch.debugfs_dir, kvm,
 						    &debugfs_htab_fops);
+	kvm->arch.mm_ctxid_dentry = debugfs_create_file("mm_ctxid", 0400,
+						    kvm->arch.debugfs_dir, kvm,
+						    &debugfs_mm_ctxid_fops);
 }
 
 void kvmppc_mmu_book3s_hv_init(struct kvm_vcpu *vcpu)
-- 
2.11.0
