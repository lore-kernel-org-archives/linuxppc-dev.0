Return-Path: <tglx@linutronix.de>
Received: from tglx.tec.linutronix.de (pD953A967.dip.t-dialin.net
	[217.83.169.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 922A52BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  9 Jan 2005 23:31:26 +1100 (EST)
Date: Sun, 9 Jan 2005 13:22:11 +0100
From: tglx@linutronix.de
Message-ID: <20050109132202.1.patchmail@tglx>
Mime-Version: 1.0
Content-Type: text/plain
To: trini@kernel.crashing.org
Cc: akpm@osdl.org, mingo@elte.hu, linuxppc-embedded@ozlabs.org
Subject: [PATCH 2.6.10-mm2] Fix idle with interrupts disabled (PPC)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The idle-thread-preemption-fix.patch in mm1/2 leads to a stalled box
on PPC machines which do not provide a powersave function and therefor
poll the idle loop with interrupts disabled. The patch reenables interrupts.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 idle.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)
---
Index: 2.6.10-mm2/arch/ppc/kernel/idle.c
===================================================================
--- 2.6.10-mm2/arch/ppc/kernel/idle.c	(revision 141)
+++ 2.6.10-mm2/arch/ppc/kernel/idle.c	(working copy)
@@ -41,14 +41,17 @@
 	if (!need_resched()) {
 		if (powersave != NULL)
 			powersave();
+		else {
 #ifdef CONFIG_SMP
-		else {
 			set_thread_flag(TIF_POLLING_NRFLAG);
+			local_irq_enable();
 			while (!need_resched())
 				barrier();
 			clear_thread_flag(TIF_POLLING_NRFLAG);
+#else
+			local_irq_enable();
+#endif
 		}
-#endif
 	}
 	if (need_resched())
 		schedule();
