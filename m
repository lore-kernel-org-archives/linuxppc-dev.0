Return-Path: <jgunthorpe@obsidianresearch.com>
Received: from quartz.orcorp.ca (quartz.orcorp.ca [184.70.90.242])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D86A32C0164
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2012 09:48:55 +1000 (EST)
Received: from jgg by quartz.orcorp.ca with local (Exim 4.72)
 (envelope-from <jgunthorpe@obsidianresearch.com>) id 1TISux-00085o-Qg
 for linuxppc-dev@lists.ozlabs.org; Sun, 30 Sep 2012 17:27:23 -0600
Date: Sun, 30 Sep 2012 17:27:23 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] PPC: Enable the Watchdog vector for 405
Message-ID: <20120930232723.GF30637@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the body of the PIT exception out of line to make room.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 arch/powerpc/kernel/head_40x.S |   26 +++++++++++++-------------
 arch/powerpc/kernel/traps.c    |    2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 4989661..7edd7b1 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -431,29 +431,19 @@ label:
 
 /* 0x1000 - Programmable Interval Timer (PIT) Exception */
 	START_EXCEPTION(0x1000, Decrementer)
-	NORMAL_EXCEPTION_PROLOG
-	lis	r0,TSR_PIS@h
-	mtspr	SPRN_TSR,r0		/* Clear the PIT exception */
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_LITE(0x1000, timer_interrupt)
+	b pit_longer
 
-#if 0
 /* NOTE:
- * FIT and WDT handlers are not implemented yet.
+ * FIT handler is not implemented yet.
  */
 
 /* 0x1010 - Fixed Interval Timer (FIT) Exception
 */
-	STND_EXCEPTION(0x1010,	FITException,		unknown_exception)
+//	STND_EXCEPTION(0x1010,	FITException,		unknown_exception)
 
 /* 0x1020 - Watchdog Timer (WDT) Exception
 */
-#ifdef CONFIG_BOOKE_WDT
 	CRITICAL_EXCEPTION(0x1020, WDTException, WatchdogException)
-#else
-	CRITICAL_EXCEPTION(0x1020, WDTException, unknown_exception)
-#endif
-#endif
 
 /* 0x1100 - Data TLB Miss Exception
  * As the name implies, translation is not in the MMU, so search the
@@ -738,6 +728,16 @@ label:
 		(MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
 		NOCOPY, crit_transfer_to_handler, ret_from_crit_exc)
 
+	/* Programmable Interval Timer (PIT) Exception. The PIT runs into
+	   the space reserved for other exceptions, so we branch down
+	   to here. */
+pit_longer:
+	NORMAL_EXCEPTION_PROLOG
+	lis	r0,TSR_PIS@h
+	mtspr	SPRN_TSR,r0		/* Clear the PIT exception */
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	EXC_XFER_LITE(0x1000, timer_interrupt)
+
 /*
  * The other Data TLB exceptions bail out to this point
  * if they can't resolve the lightweight TLB fault.
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index ae0843f..0701ec1 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1514,7 +1514,7 @@ void unrecoverable_exception(struct pt_regs *regs)
 	die("Unrecoverable exception", regs, SIGABRT);
 }
 
-#ifdef CONFIG_BOOKE_WDT
+#if defined(CONFIG_BOOKE_WDT) | defined(CONFIG_40x)
 /*
  * Default handler for a Watchdog exception,
  * spins until a reboot occurs
-- 
1.7.4.1
