Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7EF06DDE36
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 07:10:57 +1000 (EST)
Date: Tue, 21 Aug 2007 16:10:48 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH] Check _PAGE_RW and _PAGE_PRESENT on kernel addresses.
Message-ID: <20070821211048.GA8432@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Previously, the TLB miss handlers assumed that pages above KERNELBASE are
always present and read/write.  This assumption is false in the case of
CONFIG_DEBUG_PAGEALLOC.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/head_32.S |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 7d73a13..2d3b804 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -475,10 +475,10 @@ InstructionTLBMiss:
 	li	r1,_PAGE_USER|_PAGE_PRESENT /* low addresses tested as user */
 	lwz	r2,PGDIR(r2)
 	blt+	112f
+	mfspr	r2,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
+	rlwinm	r1,r2,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
 	lis	r2,swapper_pg_dir@ha	/* if kernel address, use */
 	addi	r2,r2,swapper_pg_dir@l	/* kernel page table */
-	mfspr	r1,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
-	rlwinm	r1,r1,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
 112:	tophys(r2,r2)
 	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
 	lwz	r2,0(r2)		/* get pmd entry */
@@ -549,10 +549,10 @@ DataLoadTLBMiss:
 	li	r1,_PAGE_USER|_PAGE_PRESENT /* low addresses tested as user */
 	lwz	r2,PGDIR(r2)
 	blt+	112f
+	mfspr	r2,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
+	rlwinm	r1,r2,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
 	lis	r2,swapper_pg_dir@ha	/* if kernel address, use */
 	addi	r2,r2,swapper_pg_dir@l	/* kernel page table */
-	mfspr	r1,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
-	rlwinm	r1,r1,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
 112:	tophys(r2,r2)
 	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
 	lwz	r2,0(r2)		/* get pmd entry */
@@ -621,10 +621,10 @@ DataStoreTLBMiss:
 	li	r1,_PAGE_RW|_PAGE_USER|_PAGE_PRESENT /* access flags */
 	lwz	r2,PGDIR(r2)
 	blt+	112f
+	mfspr	r2,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
+	rlwimi	r1,r2,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
 	lis	r2,swapper_pg_dir@ha	/* if kernel address, use */
 	addi	r2,r2,swapper_pg_dir@l	/* kernel page table */
-	mfspr	r1,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
-	rlwinm	r1,r1,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
 112:	tophys(r2,r2)
 	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
 	lwz	r2,0(r2)		/* get pmd entry */
-- 
1.5.0.3
