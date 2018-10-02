Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39984C004D2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 12:06:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6A142064E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 12:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="eVtDdRjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A142064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PdCV3D8VzF3F6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 22:05:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="eVtDdRjN";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PcSK4b5dzF390
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 21:32:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="eVtDdRjN"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42PcSK1623z9sjB; Tue,  2 Oct 2018 21:32:01 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42PcSJ54sxz9t1f;
 Tue,  2 Oct 2018 21:32:00 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538479920; bh=881mtBhEyL7zBy3MpJn/kXrdAJyEgya8MnUBg6sbQaQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eVtDdRjNp6/zS7sV+foZ5bFuVm9Lvgxs7ecnqu0RoR4NU6fAGRd3s85SpqyPo3vyQ
 rYgpoW2NDxHjTXVmtgMbav3Ts6y/bS9RhIzASHYPCtKkEOmOTIPIH9Pv738pidloxh
 nEgCjN6RKNAbP3mwQVGgnxUVtij9w0K2pUyqVkeo9OKpd3IW3Z+uTkFNRoB0+ser0q
 FS3b5E0wUdLq0RxdXitjf0zgYFCr5oebniCPBCOKEbQP9uezuGGqnmZz+hbXkn2EGh
 LRjyySo1ph1jSj5XoX/N/LTNiYV4BF8/OYBLHahU0MC2twmnZ8ondilxZnikS2Hfzp
 RSvHPEF/m1mWA==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v3 14/33] KVM: PPC: Book3S HV: Make kvmppc_mmu_radix_xlate
 process/partition table agnostic
Date: Tue,  2 Oct 2018 21:31:13 +1000
Message-Id: <1538479892-14835-15-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
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

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

kvmppc_mmu_radix_xlate() is used to translate an effective address
through the process tables. The process table and partition tables have
identical layout. Exploit this fact to make the kvmppc_mmu_radix_xlate()
function able to translate either an effective address through the
process tables or a guest real address through the partition tables.

[paulus@ozlabs.org - reduced diffs from previous code]

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_book3s.h  |   3 +
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 109 +++++++++++++++++++++++----------
 2 files changed, 78 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index dd18d81..91c9779 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -188,6 +188,9 @@ extern int kvmppc_book3s_hcall_implemented(struct kvm *kvm, unsigned long hc);
 extern int kvmppc_book3s_radix_page_fault(struct kvm_run *run,
 			struct kvm_vcpu *vcpu,
 			unsigned long ea, unsigned long dsisr);
+extern int kvmppc_mmu_radix_translate_table(struct kvm_vcpu *vcpu, gva_t eaddr,
+			struct kvmppc_pte *gpte, u64 table,
+			int table_index, u64 *pte_ret_p);
 extern int kvmppc_mmu_radix_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 			struct kvmppc_pte *gpte, bool data, bool iswrite);
 extern int kvmppc_init_vm_radix(struct kvm *kvm);
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 71951b5..f2976f4 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -29,83 +29,92 @@
  */
 static int p9_supported_radix_bits[4] = { 5, 9, 9, 13 };
 
-int kvmppc_mmu_radix_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
-			   struct kvmppc_pte *gpte, bool data, bool iswrite)
+/*
+ * Used to walk a partition or process table radix tree in guest memory
+ * Note: We exploit the fact that a partition table and a process
+ * table have the same layout, a partition-scoped page table and a
+ * process-scoped page table have the same layout, and the 2nd
+ * doubleword of a partition table entry has the same layout as
+ * the PTCR register.
+ */
+int kvmppc_mmu_radix_translate_table(struct kvm_vcpu *vcpu, gva_t eaddr,
+				     struct kvmppc_pte *gpte, u64 table,
+				     int table_index, u64 *pte_ret_p)
 {
 	struct kvm *kvm = vcpu->kvm;
-	u32 pid;
 	int ret, level, ps;
-	__be64 prte, rpte;
-	unsigned long ptbl;
-	unsigned long root, pte, index;
+	unsigned long ptbl, root;
 	unsigned long rts, bits, offset;
-	unsigned long gpa;
-	unsigned long proc_tbl_size;
+	unsigned long size, index;
+	struct prtb_entry entry;
+	u64 pte, base, gpa;
+	__be64 rpte;
 
-	/* Work out effective PID */
-	switch (eaddr >> 62) {
-	case 0:
-		pid = vcpu->arch.pid;
-		break;
-	case 3:
-		pid = 0;
-		break;
-	default:
+	if ((table & PRTS_MASK) > 24)
 		return -EINVAL;
-	}
-	proc_tbl_size = 1 << ((kvm->arch.process_table & PRTS_MASK) + 12);
-	if (pid * 16 >= proc_tbl_size)
+	size = 1ul << ((table & PRTS_MASK) + 12);
+
+	/* Is the table big enough to contain this entry? */
+	if ((table_index * sizeof(entry)) >= size)
 		return -EINVAL;
 
-	/* Read partition table to find root of tree for effective PID */
-	ptbl = (kvm->arch.process_table & PRTB_MASK) + (pid * 16);
-	ret = kvm_read_guest(kvm, ptbl, &prte, sizeof(prte));
+	/* Read the table to find the root of the radix tree */
+	ptbl = (table & PRTB_MASK) + (table_index * sizeof(entry));
+	ret = kvm_read_guest(kvm, ptbl, &entry, sizeof(entry));
 	if (ret)
 		return ret;
 
-	root = be64_to_cpu(prte);
+	/* Root is stored in the first double word */
+	root = be64_to_cpu(entry.prtb0);
 	rts = ((root & RTS1_MASK) >> (RTS1_SHIFT - 3)) |
 		((root & RTS2_MASK) >> RTS2_SHIFT);
 	bits = root & RPDS_MASK;
-	root = root & RPDB_MASK;
+	base = root & RPDB_MASK;
 
 	offset = rts + 31;
 
-	/* current implementations only support 52-bit space */
+	/* Current implementations only support 52-bit space */
 	if (offset != 52)
 		return -EINVAL;
 
+	/* Walk each level of the radix tree */
 	for (level = 3; level >= 0; --level) {
+		/* Check a valid size */
 		if (level && bits != p9_supported_radix_bits[level])
 			return -EINVAL;
 		if (level == 0 && !(bits == 5 || bits == 9))
 			return -EINVAL;
 		offset -= bits;
 		index = (eaddr >> offset) & ((1UL << bits) - 1);
-		/* check that low bits of page table base are zero */
-		if (root & ((1UL << (bits + 3)) - 1))
+		/* Check that low bits of page table base are zero */
+		if (base & ((1UL << (bits + 3)) - 1))
 			return -EINVAL;
-		ret = kvm_read_guest(kvm, root + index * 8,
+		/* Read the entry from guest memory */
+		ret = kvm_read_guest(kvm, base + (index * sizeof(rpte)),
 				     &rpte, sizeof(rpte));
 		if (ret)
 			return ret;
 		pte = __be64_to_cpu(rpte);
 		if (!(pte & _PAGE_PRESENT))
 			return -ENOENT;
+		/* Check if a leaf entry */
 		if (pte & _PAGE_PTE)
 			break;
-		bits = pte & 0x1f;
-		root = pte & 0x0fffffffffffff00ul;
+		/* Get ready to walk the next level */
+		base = pte & RPDB_MASK;
+		bits = pte & RPDS_MASK;
 	}
-	/* need a leaf at lowest level; 512GB pages not supported */
+
+	/* Need a leaf at lowest level; 512GB pages not supported */
 	if (level < 0 || level == 3)
 		return -EINVAL;
 
-	/* offset is now log base 2 of the page size */
+	/* We found a valid leaf PTE */
+	/* Offset is now log base 2 of the page size */
 	gpa = pte & 0x01fffffffffff000ul;
 	if (gpa & ((1ul << offset) - 1))
 		return -EINVAL;
-	gpa += eaddr & ((1ul << offset) - 1);
+	gpa |= eaddr & ((1ul << offset) - 1);
 	for (ps = MMU_PAGE_4K; ps < MMU_PAGE_COUNT; ++ps)
 		if (offset == mmu_psize_defs[ps].shift)
 			break;
@@ -118,6 +127,38 @@ int kvmppc_mmu_radix_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 	gpte->may_read = !!(pte & _PAGE_READ);
 	gpte->may_write = !!(pte & _PAGE_WRITE);
 	gpte->may_execute = !!(pte & _PAGE_EXEC);
+
+	if (pte_ret_p)
+		*pte_ret_p = pte;
+
+	return 0;
+}
+
+int kvmppc_mmu_radix_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
+			   struct kvmppc_pte *gpte, bool data, bool iswrite)
+{
+	u32 pid;
+	u64 pte;
+	int ret;
+
+	/* Work out effective PID */
+	switch (eaddr >> 62) {
+	case 0:
+		pid = vcpu->arch.pid;
+		break;
+	case 3:
+		pid = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = kvmppc_mmu_radix_translate_table(vcpu, eaddr, gpte,
+				vcpu->kvm->arch.process_table, pid, &pte);
+	if (ret)
+		return ret;
+
+	/* Check privilege (applies only to process scoped translations) */
 	if (kvmppc_get_msr(vcpu) & MSR_PR) {
 		if (pte & _PAGE_PRIVILEGED) {
 			gpte->may_read = 0;
-- 
2.7.4

