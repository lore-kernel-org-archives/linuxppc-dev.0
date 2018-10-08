Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63E7C00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 06:02:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B4ED2086D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 06:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="YEDoQfgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B4ED2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42T8rm0RSKzF3Df
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 17:02:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="YEDoQfgs";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42T89j1q7TzF37f
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 16:31:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="YEDoQfgs"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42T89h74jFz9sD2; Mon,  8 Oct 2018 16:31:36 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42T89g56b1z9sRp;
 Mon,  8 Oct 2018 16:31:35 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538976695; bh=puzhdRhOGzkeS3FooLewvz7ZYyNYBvgXZmyKVw3ywf0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YEDoQfgszc2s70Tv95tA1EWX2r/FepvEcP+LuPF6qw6tNnAL1dj6Neuo5JWrTtXuc
 6EXWGTRsNNY2az7spNZv9MMuu5NrOZ+auFvkxwr7VxOQ20KLA0X9pUNhW1NvK/hNrY
 3IMzyec+7DpiHBT+VN8orvsYoQu3JR5CDlgWwb31dJBvX1Mq4qtWDeb4QYG2wcBSi0
 DVj+3zsHS5pd2gZdJVlA4o44iewBytUUM+lhoU7y7UBTshUYkNHBYFaYH0MzZ52tdY
 rg3mpJzbdS58Tl8OAJ5ua3FtRY7dBCo2NXcQXVMM+k0nUPGCeDuTFZobhh16c+8WZf
 hgwy2KaZtil4A==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v5 11/33] KVM: PPC: Book3S HV: Add a debugfs file to dump
 radix mappings
Date: Mon,  8 Oct 2018 16:30:57 +1100
Message-Id: <1538976679-1363-12-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
References: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This adds a file called 'radix' in the debugfs directory for the
guest, which when read gives all of the valid leaf PTEs in the
partition-scoped radix tree for a radix guest, in human-readable
format.  It is analogous to the existing 'htab' file which dumps
the HPT entries for a HPT guest.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_book3s_64.h |   1 +
 arch/powerpc/include/asm/kvm_host.h      |   1 +
 arch/powerpc/kvm/book3s_64_mmu_radix.c   | 179 +++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv.c             |   2 +
 4 files changed, 183 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index dc435a5..af25aaa 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -435,6 +435,7 @@ static inline struct kvm_memslots *kvm_memslots_raw(struct kvm *kvm)
 }
 
 extern void kvmppc_mmu_debugfs_init(struct kvm *kvm);
+extern void kvmhv_radix_debugfs_init(struct kvm *kvm);
 
 extern void kvmhv_rm_send_ipi(int cpu);
 
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 3cd0b9f..a3d4f61 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -291,6 +291,7 @@ struct kvm_arch {
 	u64 process_table;
 	struct dentry *debugfs_dir;
 	struct dentry *htab_dentry;
+	struct dentry *radix_dentry;
 	struct kvm_resize_hpt *resize_hpt; /* protected by kvm->lock */
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 933c574..71951b5 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -10,6 +10,9 @@
 #include <linux/string.h>
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
+#include <linux/anon_inodes.h>
+#include <linux/file.h>
+#include <linux/debugfs.h>
 
 #include <asm/kvm_ppc.h>
 #include <asm/kvm_book3s.h>
@@ -853,6 +856,182 @@ static void pmd_ctor(void *addr)
 	memset(addr, 0, RADIX_PMD_TABLE_SIZE);
 }
 
+struct debugfs_radix_state {
+	struct kvm	*kvm;
+	struct mutex	mutex;
+	unsigned long	gpa;
+	int		chars_left;
+	int		buf_index;
+	char		buf[128];
+	u8		hdr;
+};
+
+static int debugfs_radix_open(struct inode *inode, struct file *file)
+{
+	struct kvm *kvm = inode->i_private;
+	struct debugfs_radix_state *p;
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	kvm_get_kvm(kvm);
+	p->kvm = kvm;
+	mutex_init(&p->mutex);
+	file->private_data = p;
+
+	return nonseekable_open(inode, file);
+}
+
+static int debugfs_radix_release(struct inode *inode, struct file *file)
+{
+	struct debugfs_radix_state *p = file->private_data;
+
+	kvm_put_kvm(p->kvm);
+	kfree(p);
+	return 0;
+}
+
+static ssize_t debugfs_radix_read(struct file *file, char __user *buf,
+				 size_t len, loff_t *ppos)
+{
+	struct debugfs_radix_state *p = file->private_data;
+	ssize_t ret, r;
+	unsigned long n;
+	struct kvm *kvm;
+	unsigned long gpa;
+	pgd_t *pgt;
+	pgd_t pgd, *pgdp;
+	pud_t pud, *pudp;
+	pmd_t pmd, *pmdp;
+	pte_t *ptep;
+	int shift;
+	unsigned long pte;
+
+	kvm = p->kvm;
+	if (!kvm_is_radix(kvm))
+		return 0;
+
+	ret = mutex_lock_interruptible(&p->mutex);
+	if (ret)
+		return ret;
+
+	if (p->chars_left) {
+		n = p->chars_left;
+		if (n > len)
+			n = len;
+		r = copy_to_user(buf, p->buf + p->buf_index, n);
+		n -= r;
+		p->chars_left -= n;
+		p->buf_index += n;
+		buf += n;
+		len -= n;
+		ret = n;
+		if (r) {
+			if (!n)
+				ret = -EFAULT;
+			goto out;
+		}
+	}
+
+	gpa = p->gpa;
+	pgt = kvm->arch.pgtable;
+	while (len != 0 && gpa < RADIX_PGTABLE_RANGE) {
+		if (!p->hdr) {
+			n = scnprintf(p->buf, sizeof(p->buf),
+				      "pgdir: %lx\n", (unsigned long)pgt);
+			p->hdr = 1;
+			goto copy;
+		}
+
+		pgdp = pgt + pgd_index(gpa);
+		pgd = READ_ONCE(*pgdp);
+		if (!(pgd_val(pgd) & _PAGE_PRESENT)) {
+			gpa = (gpa & PGDIR_MASK) + PGDIR_SIZE;
+			continue;
+		}
+
+		pudp = pud_offset(&pgd, gpa);
+		pud = READ_ONCE(*pudp);
+		if (!(pud_val(pud) & _PAGE_PRESENT)) {
+			gpa = (gpa & PUD_MASK) + PUD_SIZE;
+			continue;
+		}
+		if (pud_val(pud) & _PAGE_PTE) {
+			pte = pud_val(pud);
+			shift = PUD_SHIFT;
+			goto leaf;
+		}
+
+		pmdp = pmd_offset(&pud, gpa);
+		pmd = READ_ONCE(*pmdp);
+		if (!(pmd_val(pmd) & _PAGE_PRESENT)) {
+			gpa = (gpa & PMD_MASK) + PMD_SIZE;
+			continue;
+		}
+		if (pmd_val(pmd) & _PAGE_PTE) {
+			pte = pmd_val(pmd);
+			shift = PMD_SHIFT;
+			goto leaf;
+		}
+
+		ptep = pte_offset_kernel(&pmd, gpa);
+		pte = pte_val(READ_ONCE(*ptep));
+		if (!(pte & _PAGE_PRESENT)) {
+			gpa += PAGE_SIZE;
+			continue;
+		}
+		shift = PAGE_SHIFT;
+	leaf:
+		n = scnprintf(p->buf, sizeof(p->buf),
+			      " %lx: %lx %d\n", gpa, pte, shift);
+		gpa += 1ul << shift;
+	copy:
+		p->chars_left = n;
+		if (n > len)
+			n = len;
+		r = copy_to_user(buf, p->buf, n);
+		n -= r;
+		p->chars_left -= n;
+		p->buf_index = n;
+		buf += n;
+		len -= n;
+		ret += n;
+		if (r) {
+			if (!ret)
+				ret = -EFAULT;
+			break;
+		}
+	}
+	p->gpa = gpa;
+
+ out:
+	mutex_unlock(&p->mutex);
+	return ret;
+}
+
+static ssize_t debugfs_radix_write(struct file *file, const char __user *buf,
+			   size_t len, loff_t *ppos)
+{
+	return -EACCES;
+}
+
+static const struct file_operations debugfs_radix_fops = {
+	.owner	 = THIS_MODULE,
+	.open	 = debugfs_radix_open,
+	.release = debugfs_radix_release,
+	.read	 = debugfs_radix_read,
+	.write	 = debugfs_radix_write,
+	.llseek	 = generic_file_llseek,
+};
+
+void kvmhv_radix_debugfs_init(struct kvm *kvm)
+{
+	kvm->arch.radix_dentry = debugfs_create_file("radix", 0400,
+						     kvm->arch.debugfs_dir, kvm,
+						     &debugfs_radix_fops);
+}
+
 int kvmppc_radix_init(void)
 {
 	unsigned long size = sizeof(void *) << RADIX_PTE_INDEX_SIZE;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index e310117..70ae0ce 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4481,6 +4481,8 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
 	snprintf(buf, sizeof(buf), "vm%d", current->pid);
 	kvm->arch.debugfs_dir = debugfs_create_dir(buf, kvm_debugfs_dir);
 	kvmppc_mmu_debugfs_init(kvm);
+	if (radix_enabled())
+		kvmhv_radix_debugfs_init(kvm);
 
 	return 0;
 }
-- 
2.7.4

