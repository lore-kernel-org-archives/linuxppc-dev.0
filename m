Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjwrN2Fs3zDqXy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 02:44:03 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id o126so2575756pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 08:44:03 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] powerpc/pasemi,
 cbe: Do not process decremeter or external wakeup from powersave
Date: Thu, 16 Mar 2017 01:43:50 +1000
Message-Id: <20170315154350.6256-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I would like to start using a dedicated stack for system reset interrupt
and treat it as a Linux nmi, which makes it tricky to call complex
interrupt handlers directly from the system reset trap handler.

So I would like to remove the decrementer and external handler calls from
Cell and Pasemi platforms' system reset handler. I think we can just
remove them if they can be handled when they re-fire as normal interrupts?
At the moment I don't have environments set up to test if this works.

This will make the powersave wakeup a bit slower. We could add alternate
code to IDLETEST here to branch out to powersave wakeup handler like
powernv does. I haven't got a patch for that yet but I could help write
one if it is important and it can be tested.

Thanks,
Nick
---
 arch/powerpc/platforms/cell/pervasive.c | 11 +++++++----
 arch/powerpc/platforms/pasemi/idle.c    | 11 +++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/cell/pervasive.c b/arch/powerpc/platforms/cell/pervasive.c
index e7d075077cb0..a88944db9fc3 100644
--- a/arch/powerpc/platforms/cell/pervasive.c
+++ b/arch/powerpc/platforms/cell/pervasive.c
@@ -88,11 +88,14 @@ static void cbe_power_save(void)
 static int cbe_system_reset_exception(struct pt_regs *regs)
 {
 	switch (regs->msr & SRR1_WAKEMASK) {
-	case SRR1_WAKEEE:
-		do_IRQ(regs);
-		break;
 	case SRR1_WAKEDEC:
-		timer_interrupt(regs);
+		set_dec(1);
+	case SRR1_WAKEEE:
+		/*
+		 * Handle these when interrupts get re-enabled and we take
+		 * them as regular exceptions. We are in an NMI context
+		 * and can't handle these here.
+		 */
 		break;
 	case SRR1_WAKEMT:
 		return cbe_sysreset_hack();
diff --git a/arch/powerpc/platforms/pasemi/idle.c b/arch/powerpc/platforms/pasemi/idle.c
index 75b296bc51af..44e0d9226f0a 100644
--- a/arch/powerpc/platforms/pasemi/idle.c
+++ b/arch/powerpc/platforms/pasemi/idle.c
@@ -53,11 +53,14 @@ static int pasemi_system_reset_exception(struct pt_regs *regs)
 		regs->nip = regs->link;
 
 	switch (regs->msr & SRR1_WAKEMASK) {
-	case SRR1_WAKEEE:
-		do_IRQ(regs);
-		break;
 	case SRR1_WAKEDEC:
-		timer_interrupt(regs);
+		set_dec(1);
+	case SRR1_WAKEEE:
+		/*
+		 * Handle these when interrupts get re-enabled and we take
+		 * them as regular exceptions. We are in an NMI context
+		 * and can't handle these here.
+		 */
 		break;
 	default:
 		/* do system reset */
-- 
2.11.0
