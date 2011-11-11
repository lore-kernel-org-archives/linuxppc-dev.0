Return-Path: <Kexin.Hao@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D4EF71007D1
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2011 15:07:47 +1100 (EST)
From: Kevin Hao <kexin.hao@windriver.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/trace: add a dummy stack frame for trace_hardirqs_off
Date: Fri, 11 Nov 2011 10:04:17 +0800
Message-ID: <1320977057-27891-1-git-send-email-kexin.hao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The trace_hardirqs_off will use CALLER_ADDR0 and CALLER_ADDR1.
If an exception occurs in user mode, there is only one stack frame
on the stack and accessing the CALLER_ADDR1 will causes the following
call trace. So we create a dummy stack frame to make
trace_hardirqs_off happy.

WARNING: at kernel/smp.c:459
Modules linked in:
NIP: c0093280 LR: c00930a0 CTR: c0010780
REGS: edb87ae0 TRAP: 0700   Not tainted  (3.1.0)
MSR: 00021002 <ME,CE>  CR: 28002888  XER: 00000000
TASK = edce2ac0[17658] 'mthread-lock-on' THREAD: edb86000 CPU: 5
GPR00: 00000001 edb87b90 edce2ac0 00000005 c0019594 edb87bd8 00000001 00000fe3
GPR08: 00041000 c084138c 4e20120d edb87b90 48002888 1001aa7c 00000000 00000000
GPR16: 48830000 10012a8c 00000000 10000af4 00000001 c0810000 00000000 00000000
GPR24: ee9aa920 c0816a18 00000000 00000005 c0019594 edb87bd8 ee20178c edb87b90
NIP [c0093280] smp_call_function_many+0x214/0x2b4
LR [c00930a0] smp_call_function_many+0x34/0x2b4
Call Trace:
[edb87b90] [c00930a0] smp_call_function_many+0x34/0x2b4 (unreliable)
[edb87bd0] [c00194ec] __flush_tlb_page+0xac/0x100
[edb87c00] [c001957c] flush_tlb_page+0x3c/0x54
[edb87c10] [c00180ac] ptep_set_access_flags+0x74/0x12c
[edb87c40] [c0128068] handle_pte_fault+0x2f0/0x9ac
[edb87cb0] [c0128c3c] handle_mm_fault+0x104/0x1dc
[edb87ce0] [c05f40f4] do_page_fault+0x2dc/0x630
[edb87e50] [c001078c] handle_page_fault+0xc/0x80
--- Exception: 301 at trace_hardirqs_off+0x68/0x150
    LR = reenable_mmu+0x24/0x78
[edb87f10] [4902f4f8] 0x4902f4f8 (unreliable)
[edb87f40] [c00101d8] reenable_mmu+0x24/0x78
Instruction dump:
3d20c082 8009916c 2f800000 40befe7c 3d20c081 880968c4 2f800001 41befe6c
3d20c084 3929138c 88090004 68000001 <0f000000> 2f800000 419efe50 38000001
---[ end trace f26d2d7d0a9c89a2 ]---

Signed-off-by: Kevin Hao <kexin.hao@windriver.com>
---
 arch/powerpc/kernel/entry_32.S |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 56212bc..4f80cf1 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -215,7 +215,22 @@ reenable_mmu:				/* re-enable mmu so we can */
 	stw	r9,8(r1)
 	stw	r11,12(r1)
 	stw	r3,ORIG_GPR3(r1)
+	/*
+	 * The trace_hardirqs_off will use CALLER_ADDR0 and CALLER_ADDR1.
+	 * If from user mode there is only one stack frame on the stack, and
+	 * accessing CALLER_ADDR1 will cause oops. So we need create a dummy
+	 * stack frame to make trace_hardirqs_off happy.
+	 */
+	andi.	r12,r12,MSR_PR
+	beq	11f
+	stwu	r1,-16(r1)
+	bl	trace_hardirqs_off
+	addi	r1,r1,16
+	b	12f
+
+11:
 	bl	trace_hardirqs_off
+12:
 	lwz	r0,GPR0(r1)
 	lwz	r3,ORIG_GPR3(r1)
 	lwz	r4,GPR4(r1)
-- 
1.7.4.1.433.gcd306
