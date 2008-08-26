Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B3058DEC84
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Aug 2008 12:09:00 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: paulus@samba.org
Subject: [PATCH v2] powerpc: Fix determining TI_CPU in
	power_save_ppc32_restore()
Date: Mon, 25 Aug 2008 21:08:56 -0500
Message-Id: <1219716536-21643-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The calculation to get TI_CPU based off of SPRG3 was just plain wrong.
Just offset off the stack pointer (to get to thread_info) like all the
other references to TI_CPU do.

This was pointed out by Chen Gong <G.Chen@freescale.com>

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

The first version was just brain damaged.  This version should be cleaner and
doesn't assume anything about the call site having r9 setup already.

(updated for-2.6.27 w/this and rebased to top of linus).

- k

 arch/powerpc/kernel/idle_6xx.S  |    3 ++-
 arch/powerpc/kernel/idle_e500.S |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/idle_6xx.S b/arch/powerpc/kernel/idle_6xx.S
index 019b02d..6dfcdb6 100644
--- a/arch/powerpc/kernel/idle_6xx.S
+++ b/arch/powerpc/kernel/idle_6xx.S
@@ -158,7 +158,8 @@ _GLOBAL(power_save_ppc32_restore)
 	stw	r9,_NIP(r11)		/* make it do a blr */
 
 #ifdef CONFIG_SMP
-	mfspr	r12,SPRN_SPRG3
+	rlwinm	r12,r1,0,0,31-THREAD_SHIFT
+	tophys(r12,r12)			/* check local flags */
 	lwz	r11,TI_CPU(r12)		/* get cpu number * 4 */
 	slwi	r11,r11,2
 #else
diff --git a/arch/powerpc/kernel/idle_e500.S b/arch/powerpc/kernel/idle_e500.S
index 0630403..47a1a98 100644
--- a/arch/powerpc/kernel/idle_e500.S
+++ b/arch/powerpc/kernel/idle_e500.S
@@ -84,10 +84,11 @@ _GLOBAL(power_save_ppc32_restore)
 	stw	r9,_NIP(r11)		/* make it do a blr */
 
 #ifdef CONFIG_SMP
-	mfspr	r12,SPRN_SPRG3
+	rlwinm	r12,r1,0,0,31-THREAD_SHIFT
 	lwz	r11,TI_CPU(r12)		/* get cpu number * 4 */
 	slwi	r11,r11,2
 #else
 	li	r11,0
 #endif
+
 	b	transfer_to_handler_cont
-- 
1.5.5.1
