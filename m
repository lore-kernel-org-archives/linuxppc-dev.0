Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7DDAB1A0011
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jun 2014 23:35:20 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 27 Jun 2014 23:35:16 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 06A472BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jun 2014 23:35:15 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5RDYwYs11010542
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jun 2014 23:34:59 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5RDZDFx021734
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jun 2014 23:35:14 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] KVM: PPC: BOOK3S: HV: Update compute_tlbie_rb to handle 16MB
 base page
Date: Fri, 27 Jun 2014 19:05:03 +0530
Message-Id: <1403876103-32459-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When calculating the lower bits of AVA field, use the shift
count based on the base page size. Also add the missing segment
size and remove stale comment.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_book3s_64.h | 6 ++++--
 arch/powerpc/kvm/book3s_hv.c             | 6 ------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 66a0a44b62a8..ca7c1688a7b6 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -158,6 +158,8 @@ static inline unsigned long compute_tlbie_rb(unsigned long v, unsigned long r,
 	 */
 	/* This covers 14..54 bits of va*/
 	rb = (v & ~0x7fUL) << 16;		/* AVA field */
+
+	rb |= v >> (62 - 8);			/*  B field */
 	/*
 	 * AVA in v had cleared lower 23 bits. We need to derive
 	 * that from pteg index
@@ -188,10 +190,10 @@ static inline unsigned long compute_tlbie_rb(unsigned long v, unsigned long r,
 	{
 		int aval_shift;
 		/*
-		 * remaining 7bits of AVA/LP fields
+		 * remaining bits of AVA/LP fields
 		 * Also contain the rr bits of LP
 		 */
-		rb |= (va_low & 0x7f) << 16;
+		rb |= (va_low << mmu_psize_defs[b_psize].shift) & 0x7ff000;
 		/*
 		 * Now clear not needed LP bits based on actual psize
 		 */
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index cbf46eb3f59c..328416f28a55 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1917,12 +1917,6 @@ static void kvmppc_add_seg_page_size(struct kvm_ppc_one_seg_page_size **sps,
 	(*sps)->page_shift = def->shift;
 	(*sps)->slb_enc = def->sllp;
 	(*sps)->enc[0].page_shift = def->shift;
-	/*
-	 * Only return base page encoding. We don't want to return
-	 * all the supporting pte_enc, because our H_ENTER doesn't
-	 * support MPSS yet. Once they do, we can start passing all
-	 * support pte_enc here
-	 */
 	(*sps)->enc[0].pte_enc = def->penc[linux_psize];
 	/*
 	 * Add 16MB MPSS support if host supports it
-- 
1.9.1
