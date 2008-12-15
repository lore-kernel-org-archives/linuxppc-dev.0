Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 15 Dec 2008 16:44:21 +1100
Subject: [PATCH 4/16] powerpc/fsl-booke: Fix problem with _tlbil_va
In-Reply-To: <1229319836.100184.344640589620.qpush@grosgo>
Message-Id: <20081215054518.EC239DDFED@ozlabs.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>

An example calling sequence which we did see:

copy_user_highpage -> kmap_atomic -> flush_tlb_page -> _tlbil_va

We got interrupted after setting up the MAS registers before the
tlbwe and the interrupt handler that caused the interrupt also did
a kmap_atomic (ide code) and thus on returning from the interrupt
the MAS registers no longer contained the proper values.

Since we dont save/restore MAS registers for normal interrupts we
need to disable interrupts in _tlbil_va to ensure atomicity.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

 arch/powerpc/kernel/misc_32.S |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index bdc8b0e..d108715 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -479,6 +479,8 @@ _GLOBAL(_tlbil_pid)
  * (no broadcast)
  */
 _GLOBAL(_tlbil_va)
+	mfmsr	r10
+	wrteei	0
 	slwi	r4,r4,16
 	mtspr	SPRN_MAS6,r4		/* assume AS=0 for now */
 	tlbsx	0,r3
@@ -490,6 +492,7 @@ _GLOBAL(_tlbil_va)
 	tlbwe
 	msync
 	isync
+	wrtee	r10
 	blr
 #endif /* CONFIG_FSL_BOOKE */
 
-- 
1.5.6.5

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
