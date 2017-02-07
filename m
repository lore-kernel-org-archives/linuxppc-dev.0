Return-Path: <liu.hailong6@zte.com.cn>
Received: from mx5.zte.com.cn (mx5.zte.com.cn [63.217.80.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vHT4y02JszDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 13:37:05 +1100 (AEDT)
From: Liu Hailong <liu.hailong6@zte.com.cn>
To: benh@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 jiang.biao2@zte.com.cn, liu.hailong6@zte.com.cn,
 jiang.xuexin@zte.com.cn, liu.song11@zte.com.cn, huang.jian@zte.com.cn,
 zhong.weidong@zte.com.cn
Subject: [PATCH] Powerpc64: Fixup oops when debug programs with
 CONFIG_RELOCATABLE=y
Date: Tue, 7 Feb 2017 10:35:52 +0800
Message-Id: <1486434952-2093-1-git-send-email-liu.hailong6@zte.com.cn>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: LiuHailong <liu.hailong6@zte.com.cn>

Debug interrupts can be taken during regular program or a standard
interrupt, the EA of the instruction causing the interrupt will be
kept in DSRR0.
Kernel will check if this value is between [interrupt_base_book3e,
__end_interrupts].
However, when the kernel build with CONFIG_RELOCATABLE, it can't get
EA of those lables by LOAD_REG_IMMEDIATE(r14,interrupt_base_book3e)
and LOAD_REG_IMMEDIATE(r15,__end_interrupts),then it cases problems
later.
At the same time, r2(toc) are not usable here, so LOAD_REG_ADDR()
dosen't work neither. So we use the *name@got* to get the EV of two
lables directly.
This patch can fix the problem and remove the oops when we gdb a
program with single-step.

Test programs test.c shows as follows:
#include <fcntl.h>
#include <stdio.h>
int main(int argc, char *argv[])
{
	if (access("/proc/sys/kernel/perf_event_paranoid", F_OK) == -1)
		printf("Kernel doesn't have perf_event support\n");
}

Steps to reproduce the bug, for example:
 1) ./gdb ./test
 2) (gdb) b access
 3) (gdb) r
 4) (gdb) s

Then will trigger the oops, it looks like:
(gdb) s
Single stepping Oops: Exception in kernel mode, sig: 5 [#2]
PREEMPT CoreNet Generic
Modules linked in:
CPU: 0 PID: 1135 Comm: test Tainted: G    D    Linux (none) 4.9.5 #79
task: c000000079199580 ti: c00000007ffc4000 task.ti: c000000074064000
NIP: c00000000001a1e4 LR: 000000001000103c CTR: 000000001000100c
REGS: c00000007ffc7cf0 TRAP: 0d08   Tainted: G   D  (Linux (none) 4.9.5)
MSR: 0000000080021000 <CE,ME>  CR: 24000442  XER: 00000000
SOFTE: 1
GPR00: 0000000010001274 00000000ffffeba0 00000000100ab4b0 00000000100764a4
GPR04: 0000000000000000 00000000ffffee2c 00000000ffffee54 00000000100a44c8
GPR08: 0000000000000001 0000000010070000 00000000100a0000 0000000000000001
GPR12: 000000004347432f 00000000100aa648 0000000000000000 0000000000000000
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR24: 0000000000000000 0000000010001950 0000000010001850 0000000000000000
GPR28: 0000000000000000 00000000100000f4 0000000000000000 00000000ffffeba0
NIP [c00000000001a1e4] interrupt_base_book3e+0x1e4/0x348
LR [000000001000103c] 0x1000103c
Call Trace:
Instruction dump:
00000000 00000000 00000000 60000000 4800e600 00000000 00000000 00000000
00000000 00000000 00000000 60000000 <4800e588> 00000000 00000000 00000000

Signed-off-by: Liu Hailong <liu.hailong6@zte.com.cn>
Signed-off-by: Jiang Xuexin <jiang.xuexin@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
Reviewed-by: Liu Song <liu.song11@zte.com.cn>
Reviewed-by: Huang Jian <huang.jian@zte.com.cn>
---
 arch/powerpc/kernel/exceptions-64e.S |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 arch/powerpc/kernel/exceptions-64e.S

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
old mode 100644
new mode 100755
index 38a1f96..ca03eb2
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -735,8 +735,14 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	andis.	r15,r14,(DBSR_IC|DBSR_BT)@h
 	beq+	1f

+#ifdef CONFIG_RELOCATABLE
+	ld	r15,PACATOC(r13)
+	ld	r14,interrupt_base_book3e@got(r15)
+	ld	r15,__end_interrupts@got(r15)
+#else
 	LOAD_REG_IMMEDIATE(r14,interrupt_base_book3e)
 	LOAD_REG_IMMEDIATE(r15,__end_interrupts)
+#endif
 	cmpld	cr0,r10,r14
 	cmpld	cr1,r10,r15
 	blt+	cr0,1f
@@ -799,8 +805,14 @@ kernel_dbg_exc:
 	andis.	r15,r14,(DBSR_IC|DBSR_BT)@h
 	beq+	1f

+#ifdef CONFIG_RELOCATABLE
+	ld	r15,PACATOC(r13)
+	ld	r14,interrupt_base_book3e@got(r15)
+	ld	r15,__end_interrupts@got(r15)
+#else
 	LOAD_REG_IMMEDIATE(r14,interrupt_base_book3e)
 	LOAD_REG_IMMEDIATE(r15,__end_interrupts)
+#endif
 	cmpld	cr0,r10,r14
 	cmpld	cr1,r10,r15
 	blt+	cr0,1f
--
1.7.1
