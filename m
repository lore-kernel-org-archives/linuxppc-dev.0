Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 15 Dec 2008 16:45:05 +1100
Subject: [PATCH 13/16] powerpc/44x: No need to mask MSR:CE,
	ME or DE in _tlbil_va on 440
In-Reply-To: <1229319836.100184.344640589620.qpush@grosgo>
Message-Id: <20081215054603.6BB25DDFB5@ozlabs.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The handlers for Critical, Machine Check or Debug interrupts
will save and restore MMUCR nowadays, thus we only need to
disable normal interrupts when invalidating TLB entries.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/mm/tlb_nohash_low.S |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

--- linux-work.orig/arch/powerpc/mm/tlb_nohash_low.S	2008-12-15 13:34:57.000000000 +1100
+++ linux-work/arch/powerpc/mm/tlb_nohash_low.S	2008-12-15 13:35:07.000000000 +1100
@@ -75,18 +75,19 @@ _GLOBAL(_tlbil_va)
 	mfspr	r5,SPRN_MMUCR
 	rlwimi	r5,r4,0,24,31			/* Set TID */
 
-	/* We have to run the search with interrupts disabled, even critical
-	 * and debug interrupts (in fact the only critical exceptions we have
-	 * are debug and machine check).  Otherwise  an interrupt which causes
-	 * a TLB miss can clobber the MMUCR between the mtspr and the tlbsx. */
+	/* We have to run the search with interrupts disabled, otherwise
+	 * an interrupt which causes a TLB miss can clobber the MMUCR
+	 * between the mtspr and the tlbsx.
+	 *
+	 * Critical and Machine Check interrupts take care of saving
+	 * and restoring MMUCR, so only normal interrupts have to be
+	 * taken care of.
+	 */
 	mfmsr	r4
-	lis	r6,(MSR_EE|MSR_CE|MSR_ME|MSR_DE)@ha
-	addi	r6,r6,(MSR_EE|MSR_CE|MSR_ME|MSR_DE)@l
-	andc	r6,r4,r6
-	mtmsr	r6
+	wrteei	0
 	mtspr	SPRN_MMUCR,r5
 	tlbsx.	r3, 0, r3
-	mtmsr	r4
+	wrtee	r4
 	bne	1f
 	sync
 	/* There are only 64 TLB entries, so r3 < 64,
