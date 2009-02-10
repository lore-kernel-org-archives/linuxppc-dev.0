Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7C5024F3C7
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 14:20:59 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n1A3KsWU022944
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Feb 2009 21:20:55 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl-booke: Fix mapping functions to use phys_addr_t
Date: Mon,  9 Feb 2009 21:20:54 -0600
Message-Id: <1234236054-29429-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fixed v_mapped_by_tlbcam() and p_mapped_by_tlbcam() to use phys_addr_t
instead of unsigned long.  In 36-bit physical mode we really need these
functions to deal with phys_addr_t when trying to match a physical
address or when returning one.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/mm/fsl_booke_mmu.c |    4 ++--
 arch/powerpc/mm/pgtable_32.c    |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 1971e4e..ea6e41e 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -73,7 +73,7 @@ extern unsigned int tlbcam_index;
 /*
  * Return PA for this VA if it is mapped by a CAM, or 0
  */
-unsigned long v_mapped_by_tlbcam(unsigned long va)
+phys_addr_t v_mapped_by_tlbcam(unsigned long va)
 {
 	int b;
 	for (b = 0; b < tlbcam_index; ++b)
@@ -85,7 +85,7 @@ unsigned long v_mapped_by_tlbcam(unsigned long va)
 /*
  * Return VA for a given PA or 0 if not mapped
  */
-unsigned long p_mapped_by_tlbcam(unsigned long pa)
+unsigned long p_mapped_by_tlbcam(phys_addr_t pa)
 {
 	int b;
 	for (b = 0; b < tlbcam_index; ++b)
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 22972cd..58bcaeb 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -61,8 +61,8 @@ void setbat(int index, unsigned long virt, phys_addr_t phys,
 
 #ifdef HAVE_TLBCAM
 extern unsigned int tlbcam_index;
-extern unsigned long v_mapped_by_tlbcam(unsigned long va);
-extern unsigned long p_mapped_by_tlbcam(unsigned long pa);
+extern phys_addr_t v_mapped_by_tlbcam(unsigned long va);
+extern unsigned long p_mapped_by_tlbcam(phys_addr_t pa);
 #else /* !HAVE_TLBCAM */
 #define v_mapped_by_tlbcam(x)	(0UL)
 #define p_mapped_by_tlbcam(x)	(0UL)
-- 
1.5.6.6
