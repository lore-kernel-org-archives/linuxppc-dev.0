Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0115.outbound.protection.outlook.com [207.46.100.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44A041A0DC0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 09:36:45 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <benh@kernel.crashing.org>,
 <paulus@samba.org>
Subject: [PATCH] powerpc: Remove duplicate tlbcam_index declarations
Date: Wed, 21 Jan 2015 16:22:52 -0600
Message-ID: <1421878972-30501-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

They seem to be leftovers from '14cf11a powerpc: Merge enough to start
building in arch/powerpc'

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 arch/powerpc/mm/fsl_booke_mmu.c | 2 --
 arch/powerpc/mm/pgtable_32.c    | 1 -
 2 files changed, 3 deletions(-)

diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 94cd728..b46912f 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -67,8 +67,6 @@ struct tlbcamrange {
 	phys_addr_t phys;
 } tlbcam_addrs[NUM_TLBCAMS];
 
-extern unsigned int tlbcam_index;
-
 unsigned long tlbcam_sz(int idx)
 {
 	return tlbcam_addrs[idx].limit - tlbcam_addrs[idx].start + 1;
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 50fad38..6eec886 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -63,7 +63,6 @@ void setbat(int index, unsigned long virt, phys_addr_t phys,
 #endif /* HAVE_BATS */
 
 #ifdef HAVE_TLBCAM
-extern unsigned int tlbcam_index;
 extern phys_addr_t v_mapped_by_tlbcam(unsigned long va);
 extern unsigned long p_mapped_by_tlbcam(phys_addr_t pa);
 #else /* !HAVE_TLBCAM */
-- 
2.2.2
