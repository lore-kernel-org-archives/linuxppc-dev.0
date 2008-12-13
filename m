Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AC4E3DDF4B
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Dec 2008 10:33:10 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id mBDNX3Rv015514
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Dec 2008 17:33:04 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH][for 2.6.28] powerpc/fsl-booke: Fix problem with _tlbil_va
	being interrupted
Date: Sat, 13 Dec 2008 17:33:03 -0600
Message-Id: <1229211183-5350-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

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
 1 files changed, 3 insertions(+), 0 deletions(-)

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
