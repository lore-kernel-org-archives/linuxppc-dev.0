Return-Path: <jgunthorpe@obsidianresearch.com>
Received: from quartz.orcorp.ca (quartz.orcorp.ca [184.70.90.242])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A236C2C0040
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2012 04:07:21 +1000 (EST)
Date: Fri, 5 Oct 2012 12:07:15 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCHv2] PPC: Enable the Watchdog vector for 405
Message-ID: <20121005180715.GA818@obsidianresearch.com>
References: <20120930232723.GF30637@obsidianresearch.com>
 <1349348756.4260.15.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349348756.4260.15.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The watchdog and FIT code has been #if 0'd for ever, if the CPU takes
an exception to either of those vectors it will jump into the middle
of the PIT or Data TLB code and surely crash.

At least some (all?) 405 cores have both the WDT and FIT
vectors defined, so lets have proper entry points for them.

Tested that the WDT vector works on a 405F6 core.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 arch/powerpc/kernel/head_40x.S |   47 ++++++++++++++++++++++++---------------
 arch/powerpc/kernel/traps.c    |    2 +-
 2 files changed, 30 insertions(+), 19 deletions(-)

Changes in v2:
 - Move all three exception vectors out of line with an explicit
   branch like exceptions-64.S (Benjamin)
 - Fix the #if .. | .. typo to be || (Josh)
 - Include the stub for FITException, and figured out what the very
   obsolete STDN_EXCEPTION might have done. (Benjamin)
 - I kept the WatchdogException trap unconditional, but this would be
   trivial to change, per Josh's comments

The disadvantage to moving the WDT out of line is that the
CRITICAL_EXCEPTION macro has to be expanded..

Thanks everyone

Action shot:

PowerPC Book-E Watchdog Exception
Oops: Watchdog Timeout
NIP: c0006b54 LR: c0006ad4 CTR: c003c800
REGS: c3ffbf50 TRAP: 1022   Not tainted  (3.6.0-00040-ga9db8b3)
MSR: 00029030 <EE,ME,IR,DR>  CR: 24002482  XER: 00000007
TASK = c03c32b0[0] 'swapper' THREAD: c03e0000
GPR00: 00000008 c03e1f90 c03c32b0 00000000 c1872f00 00000001 00000000 00000000 
GPR08: 01000000 c03e73c0 00000000 00000000 22000482 10152d00 7ffe7b60 7ffe7b70 
GPR16: 7ffe7be0 7ffe7d20 100f7560 7ffe7d9c 7ffe7db4 7ffe7d30 7ffe7dcc 7ffe7dd0 
GPR24: 00000000 00000000 00000000 c049e680 c03e0000 c03e003c 00000008 c03e0000 
NIP [c0006b54] cpu_idle+0xd0/0xe8
LR [c0006ad4] cpu_idle+0x50/0xe8
Call Trace:
[c03e1f90] [c0006ad4] cpu_idle+0x50/0xe8 (unreliable)
[c03e1fb0] [c0002990] rest_init+0x64/0x74
[c03e1fc0] [c0296774] start_kernel+0x2cc/0x2d4
[c03e1ff0] [c0002440] start_here+0x34/0x84
Instruction dump:
40820010 7c0000a6 60008000 7c000124 7c00e828 7c00f378 7c00e92d 40a2fff4 
4800000c 7c210b78 7ffffb78 801f003c <700b0004> 4182ff80 7c421378 48048585 
Kernel panic - not syncing: Watchdog Timeout
Call Trace:
Rebooting in 180 seconds..

diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 4989661..8a9b6f5 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -430,30 +430,18 @@ label:
 	EXCEPTION(0x0F00, Trap_0F, unknown_exception, EXC_XFER_EE)
 
 /* 0x1000 - Programmable Interval Timer (PIT) Exception */
-	START_EXCEPTION(0x1000, Decrementer)
-	NORMAL_EXCEPTION_PROLOG
-	lis	r0,TSR_PIS@h
-	mtspr	SPRN_TSR,r0		/* Clear the PIT exception */
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_LITE(0x1000, timer_interrupt)
-
-#if 0
-/* NOTE:
- * FIT and WDT handlers are not implemented yet.
- */
+	. = 0x1000
+	b Decrementer
 
 /* 0x1010 - Fixed Interval Timer (FIT) Exception
 */
-	STND_EXCEPTION(0x1010,	FITException,		unknown_exception)
+	. = 0x1010
+	b FITException
 
 /* 0x1020 - Watchdog Timer (WDT) Exception
 */
-#ifdef CONFIG_BOOKE_WDT
-	CRITICAL_EXCEPTION(0x1020, WDTException, WatchdogException)
-#else
-	CRITICAL_EXCEPTION(0x1020, WDTException, unknown_exception)
-#endif
-#endif
+	. = 0x1020
+	b WDTException
 
 /* 0x1100 - Data TLB Miss Exception
  * As the name implies, translation is not in the MMU, so search the
@@ -738,6 +726,29 @@ label:
 		(MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
 		NOCOPY, crit_transfer_to_handler, ret_from_crit_exc)
 
+	/* Programmable Interval Timer (PIT) Exception. (from 0x1000) */
+Decrementer:
+	NORMAL_EXCEPTION_PROLOG
+	lis	r0,TSR_PIS@h
+	mtspr	SPRN_TSR,r0		/* Clear the PIT exception */
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	EXC_XFER_LITE(0x1000, timer_interrupt)
+
+	/* Fixed Interval Timer (FIT) Exception. (from 0x1010) */
+FITException:
+	NORMAL_EXCEPTION_PROLOG
+	addi	r3,r1,STACK_FRAME_OVERHEAD;
+	EXC_XFER_EE(0x1010, unknown_exception)
+
+	/* Watchdog Timer (WDT) Exception. (from 0x1020) */
+WDTException:
+	CRITICAL_EXCEPTION_PROLOG;
+	addi	r3,r1,STACK_FRAME_OVERHEAD;
+	EXC_XFER_TEMPLATE(WatchdogException, 0x1020+2,
+	                  (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)),
+			  NOCOPY, crit_transfer_to_handler,
+			  ret_from_crit_exc)
+
 /*
  * The other Data TLB exceptions bail out to this point
  * if they can't resolve the lightweight TLB fault.
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index ae0843f..eac1abf 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1514,7 +1514,7 @@ void unrecoverable_exception(struct pt_regs *regs)
 	die("Unrecoverable exception", regs, SIGABRT);
 }
 
-#ifdef CONFIG_BOOKE_WDT
+#if defined(CONFIG_BOOKE_WDT) || defined(CONFIG_40x)
 /*
  * Default handler for a Watchdog exception,
  * spins until a reboot occurs
-- 
1.7.5.4
