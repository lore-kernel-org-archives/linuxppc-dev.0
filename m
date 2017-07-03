Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1S2b1Q5kzDr4B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2017 23:01:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v6 01/10] powerpc/pseries: Fix passing of pp0 in updatepp()
 and updateboltedpp()
Date: Mon,  3 Jul 2017 23:01:45 +1000
Message-Id: <1499086914-25695-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Balbir Singh <bsingharora@gmail.com>

Once upon a time there were only two PP (page protection) bits. In ISA
2.03 an additional PP bit was added, but because of the layout of the
HPTE it could not be made contiguous with the existing PP bits.

The result is that we now have three PP bits, named pp0, pp1, pp2,
where pp0 occupies bit 63 of dword 1 of the HPTE and pp1 and pp2
occupy bits 1 and 0 respectively. Until recently Linux hasn't used
pp0, however with the addition of _PAGE_KERNEL_RO we started using it.

The problem arises in the LPAR code, where we need to translate the PP
bits into the argument for the H_PROTECT hypercall. Currently the code
only passes bits 0-2 of newpp, which covers pp1, pp2 and N (no
execute), meaning pp0 is not passed to the hypervisor at all.

We can't simply pass it through in bit 63, as that would collide with a
different field in the flags argument, as defined in PAPR. Instead we
have to shift it down to bit 8 (IBM bit 55).

Fixes: e58e87adc8bf ("powerpc/mm: Update _PAGE_KERNEL_RO")
Cc: stable@vger.kernel.org # v4.7+
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
[mpe: Simplify the test, rework change log]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/lpar.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 6541d0b03e4c..495ba4e7336d 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -301,7 +301,7 @@ static long pSeries_lpar_hpte_updatepp(unsigned long slot,
 				       int ssize, unsigned long inv_flags)
 {
 	unsigned long lpar_rc;
-	unsigned long flags = (newpp & 7) | H_AVPN;
+	unsigned long flags;
 	unsigned long want_v;
 
 	want_v = hpte_encode_avpn(vpn, psize, ssize);
@@ -309,6 +309,11 @@ static long pSeries_lpar_hpte_updatepp(unsigned long slot,
 	pr_devel("    update: avpnv=%016lx, hash=%016lx, f=%lx, psize: %d ...",
 		 want_v, slot, flags, psize);
 
+	flags = (newpp & 7) | H_AVPN;
+	if (mmu_has_feature(MMU_FTR_KERNEL_RO))
+		/* Move pp0 into bit 8 (IBM 55) */
+		flags |= (newpp & HPTE_R_PP0) >> 55;
+
 	lpar_rc = plpar_pte_protect(flags, slot, want_v);
 
 	if (lpar_rc == H_NOT_FOUND) {
@@ -380,6 +385,10 @@ static void pSeries_lpar_hpte_updateboltedpp(unsigned long newpp,
 	BUG_ON(slot == -1);
 
 	flags = newpp & 7;
+	if (mmu_has_feature(MMU_FTR_KERNEL_RO))
+		/* Move pp0 into bit 8 (IBM 55) */
+		flags |= (newpp & HPTE_R_PP0) >> 55;
+
 	lpar_rc = plpar_pte_protect(flags, slot, 0);
 
 	BUG_ON(lpar_rc != H_SUCCESS);
-- 
2.7.4
