Return-Path: <Lu.Jiang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D45B31A0A0E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 15:00:04 +1100 (AEDT)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
 [147.11.189.40])
 by mail.windriver.com (8.14.9/8.14.5) with ESMTP id sAL3NH7G000731
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 19:23:17 -0800 (PST)
From: Jiang Lu <lu.jiang@windriver.com>
To: <linuxppc-dev@lists.ozlabs.org>, <lu.jiang@windriver.com>
Subject: [PATCH] Powerpc/Oprofile:Disable pagefaults during user stack read
Date: Fri, 21 Nov 2014 11:23:19 +0800
Message-ID: <1416540199-13097-1-git-send-email-lu.jiang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A page fault occurred during reading user stack in oprofile backtrace
would lead following calltrace:

WARNING: at linux/kernel/smp.c:210
Modules linked in:
CPU: 5 PID: 736 Comm: sh Tainted: G W 3.14.23-WR7.0.0.0_standard #1 
task: c0000000f6208bc0 ti: c00000007c72c000 task.ti: c00000007c72c000 
NIP: c0000000000ed6e4 LR: c0000000000ed5b8 CTR: 0000000000000000 
REGS: c00000007c72f050 TRAP: 0700 Tainted: G W (3.14.23-WR7.0.0 
tandard) 
MSR: 0000000080021000 <CE,ME> CR: 48222482 XER: 00000000 
SOFTE: 0 
GPR00: c0000000000ed5b8 c00000007c72f2d0 c0000000010aa048 0000000000000005 
GPR04: c000000000fdb820 c00000007c72f410 0000000000000001 0000000000000005 
GPR08: c0000000010b5768 c000000000f8a048 0000000000000001 0000000000000000 
GPR12: 0000000048222482 c00000000fffe580 0000000022222222 0000000010129664 
GPR16: 0000000010143cc0 0000000000000000 0000000044444444 0000000000000000 
GPR20: c00000007c7221d8 c0000000f638e3c8 000003f15a20120d 0000000000000001 
GPR24: 000000005a20120d c00000007c722000 c00000007cdedda8 00003fffef23b160 
GPR28: 0000000000000001 c00000007c72f410 c000000000fdb820 0000000000000006 
NIP [c0000000000ed6e4] .smp_call_function_single+0x18c/0x248 
LR [c0000000000ed5b8] .smp_call_function_single+0x60/0x248 
Call Trace: 
[c00000007c72f2d0] [c0000000000ed5b8] .smp_call_function_single+0x60/0x248 (unreliable) 
[c00000007c72f3a0] [c000000000030810] .__flush_tlb_page+0x164/0x1b0 
[c00000007c72f460] [c00000000002e054] .ptep_set_access_flags+0xb8/0x168 
[c00000007c72f500] [c0000000001ad3d8] .handle_mm_fault+0x4a8/0xbac 
[c00000007c72f5e0] [c000000000bb3238] .do_page_fault+0x3b8/0x868 
[c00000007c72f810] [c00000000001e1d0] storage_fault_common+0x20/0x44 
 Exception: 301 at .__copy_tofrom_user_base+0x54/0x5b0 
    LR = .op_powerpc_backtrace+0x190/0x20c 
[c00000007c72fb00] [c000000000a2ec34] .op_powerpc_backtrace+0x204/0x20c (unreliable) 
[c00000007c72fbc0] [c000000000a2b5fc] .oprofile_add_ext_sample+0xe8/0x118 
[c00000007c72fc70] [c000000000a2eee0] .fsl_emb_handle_interrupt+0x20c/0x27c 
[c00000007c72fd30] [c000000000a2e440] .op_handle_interrupt+0x44/0x58 
[c00000007c72fdb0] [c000000000016d68] .performance_monitor_exception+0x74/0x90 
[c00000007c72fe30] [c00000000001d8b4] exc_0x260_common+0xfc/0x100 

performance_monitor_exception() is executed in a context with interrupt
disabled and preemption enabled. When there is a user space page fault
happened, do_page_fault() invoke in_atomic() to decide whether kernel
should handle such page fault. in_atomic() only check preempt_count.
So need call pagefault_disable() to disable preemption before reading
user stack.

Signed-off-by: Jiang Lu <lu.jiang@windriver.com>
---
 arch/powerpc/oprofile/backtrace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/oprofile/backtrace.c b/arch/powerpc/oprofile/backtrace.c
index f75301f..cae8ee7 100644
--- a/arch/powerpc/oprofile/backtrace.c
+++ b/arch/powerpc/oprofile/backtrace.c
@@ -10,7 +10,7 @@
 #include <linux/oprofile.h>
 #include <linux/sched.h>
 #include <asm/processor.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <asm/compat.h>
 
 #define STACK_SP(STACK)		*(STACK)
@@ -104,6 +104,7 @@ void op_powerpc_backtrace(struct pt_regs * const regs, unsigned int depth)
 			first_frame = 0;
 		}
 	} else {
+		pagefault_disable();
 #ifdef CONFIG_PPC64
 		if (!is_32bit_task()) {
 			while (depth--) {
@@ -112,7 +113,7 @@ void op_powerpc_backtrace(struct pt_regs * const regs, unsigned int depth)
 					break;
 				first_frame = 0;
 			}
-
+			pagefault_enable();
 			return;
 		}
 #endif
@@ -123,5 +124,6 @@ void op_powerpc_backtrace(struct pt_regs * const regs, unsigned int depth)
 				break;
 			first_frame = 0;
 		}
+		pagefault_enable();
 	}
 }
-- 
1.9.1
