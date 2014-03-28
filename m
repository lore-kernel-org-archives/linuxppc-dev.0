Return-Path: <Dongsheng.Wang@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DEBC414007F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Mar 2014 18:41:45 +1100 (EST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <fweisbec@gmail.com>
Subject: [PATCH] powerpc/irq: Remove HAVE_IRQ_EXIT_ON_IRQ_STACK feature at
 powerpc platform
Date: Fri, 28 Mar 2014 15:38:32 +0800
Message-ID: <1395992312-23035-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: James Hogan <james.hogan@imgtec.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>,
 Helge Deller <deller@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@au1.ibm.com>,
 Wang Dongsheng <dongsheng.wang@freescale.com>, "James
 E.J. Bottomley" <jejb@parisc-linux.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, jason.jin@freescale.com,
 scottwood@freescale.com, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

If softirq use hardirq stack, we will get kernel painc when a hard irq coming again
during __do_softirq enable local irq to deal with softirq action. So we need to switch
satck into softirq stack when invoke soft irq.

 Task--->
	| Task stack
	|
	Interrput->EXCEPTION->do_IRQ->
	^			     | Hard irq stack
	|			     |
	|			     irq_exit->__do_softirq->local_irq_enable--   -->local_irq_disable
	|									| Hard irq stack
	|									|
	|									Interrupt coming again
	|		There will get a Interrupt nesting			|
	------------------------------------------------------------------------

Trace 1: Trap 900

Kernel stack overflow in process e8152f40, r1=e8e05ec0
CPU: 0 PID: 2399 Comm: image_compress/ Not tainted 3.13.0-rc3-03475-g2e3f85b #432
task: e8152f40 ti: c080a000 task.ti: ef176000
NIP: c05bec04 LR: c0305590 CTR: 00000010
REGS: e8e05e10 TRAP: 0901   Not tainted  (3.13.0-rc3-03475-g2e3f85b)
MSR: 00029000 <CE,EE,ME>  CR: 22f22722  XER: 20000000

GPR00: c0305590 e8e05ec0 e8152f40 c07e1e2c 00029000 000000ec fffffffc 00000010
GPR08: 0000007f 00000000 00000000 b02539f3 a00ae278
NIP [c05bec04] _raw_spin_unlock_irqrestore+0x10/0x14
LR [c0305590] add_timer_randomness+0x60/0xfc
Call Trace:
[e8e05ec0] [c0305590] add_timer_randomness+0x60/0xfc (unreliable)
[e8e05ee0] [c026c9a8] blk_update_bidi_request+0x64/0x94
[e8e05f00] [c026cd00] blk_end_bidi_request+0x20/0x7c
[e8e05f20] [c032f21c] scsi_io_completion+0xe0/0x5e8
[e8e05f70] [c0272b84] blk_done_softirq+0x98/0xb8
[e8e05f90] [c004893c] __do_softirq+0xf8/0x1f8
[e8e05fe0] [c0048dbc] irq_exit+0xa4/0xc8
[e8e05ff0] [c000d5f4] call_do_irq+0x24/0x3c
[ef177d50] [c00046ec] do_IRQ+0x8c/0xf8
[ef177d70] [c000f6dc] ret_from_except+0x0/0x18
--- Exception: 501 at lzo1x_1_do_compress+0x248/0x40c
    LR = lzo1x_1_compress+0x98/0x268
[ef177e30] [c07c7440] runqueues+0x0/0x540 (unreliable)
[ef177e60] [00000000]   (null)
[ef177ea0] [c0085a9c] lzo_compress_threadfn+0x6c/0x138
[ef177ef0] [c0062a00] kthread+0xc4/0xd8
[ef177f40] [c000f158] ret_from_kernel_thread+0x5c/0x64
Instruction dump:
40a2fff0 4c00012c 2f890000 419e000c 38600000 4e800020 38600001 4e800020
7c0004ac 39200000 91230000 7c800106 <4e800020> 7d201828 35290001 40810010
Kernel panic - not syncing: kernel stack overflow
CPU: 0 PID: 2399 Comm: image_compress/ Not tainted 3.13.0-rc3-03475-g2e3f85b #432
Call Trace:
Rebooting in 180 seconds..

Trace 2: Trap 500

VFS: Mounted root (ext2 filesystem) on device 1:0.
devtmpfs: mounted
Freeing unused kernel memory: 268K (c079a000 - c07dd000)
INIT: version 2.88 booting
Starting udev
udevd[1423]: starting version 182
random: nonblocking pool is initialized
Kernel stack overflow in process e829ca80, r1=e8badf90
CPU: 0 PID: 1553 Comm: mount.sh Not tainted 3.13.0-rc1-148228-gea7ca7c #21
task: e829ca80 ti: c081c000 task.ti: e9d28000
NIP: c00434bc LR: c0043444 CTR: c0018cec
REGS: e8badee0 TRAP: 0501   Not tainted  (3.13.0-rc1-148228-gea7ca7c)
MSR: 00029000 <CE,EE,ME>  CR: 48222422  XER: 20000000

GPR00: c00439a0 e8badf90 e829ca80 00000001 e80cc780 00000001 b92f44af 00000000
GPR08: 00000001 010ba000 010ba000 ddd3e6d1 48222422
NIP [c00434bc] __do_softirq+0x94/0x1f8
LR [c0043444] __do_softirq+0x1c/0x1f8
Call Trace:
[e8badf90] [100f0000] 0x100f0000 (unreliable)
[e8badfe0] [c00439a0] irq_exit+0xa4/0xc8
[e8badff0] [c000ccd8] call_do_irq+0x24/0x3c
[e9d29f20] [c000479c] do_IRQ+0x8c/0xf8
[e9d29f40] [c000eb54] ret_from_except+0x0/0x18
--- Exception: 501 at 0x1003d540
    LR = 0x10041974
Instruction dump:
3e80c082 3f40c07e 3b60000a 3a941040 3aa00000 3b5a9388 7f16c378 812f0008
5529103a 7d3c482e 7eb8492e 7c008146 <3ba00000> 7e9ea378 48000014 57fff87f
Kernel panic - not syncing: kernel stack overflow
CPU: 0 PID: 1553 Comm: mount.sh Not tainted 3.13.0-rc1-148228-gea7ca7c #21
Call Trace:
Rebooting in 180 seconds..

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Paul Mackerras <paulus@au1.ibm.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: James E.J. Bottomley <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 957bf34..ffde3fb 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -139,7 +139,6 @@ config PPC
 	select OLD_SIGSUSPEND
 	select OLD_SIGACTION if PPC32
 	select HAVE_DEBUG_STACKOVERFLOW
-	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select ARCH_USE_CMPXCHG_LOCKREF if PPC64
 
 config GENERIC_CSUM
-- 
1.8.5
