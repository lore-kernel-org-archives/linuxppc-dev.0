Return-Path: <B32167@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9B1982C0326
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 21:20:21 +1000 (EST)
From: Priyanka Jain <Priyanka.Jain@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <stable@vger.kernel.org>
Subject: [PATCH] powerpc/32bit:Store temporary result in r0 instead of r8
Date: Fri, 31 May 2013 16:50:02 +0530
Message-ID: <1369999202-1908-1-git-send-email-Priyanka.Jain@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Priyanka Jain <Priyanka.Jain@freescale.com>,
 tiejun.chen@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While returning from exception handling in case of PREEMPT enabled,
_TIF_NEED_RESCHED bit is checked in TI_FLAGS (thread_info flag) of current
task. Only if this bit is set, it should continue with the process of
calling preempt_schedule_irq() to schedule highest priority task if
available.
    
Current code assumes that r8 contains TI_FLAGS and check this for
_TIF_NEED_RESCHED, but as r8 is modified in the code which executes before
this check, r8 no longer contains the expected TI_FLAGS information.
    
As a result check for comparison with _TIF_NEED_RESCHED was failing even if
NEED_RESCHED bit is set in the current thread_info flag. Due to this,
preempt_schedule_irq() and in turn scheduler was not getting called even if
highest priority task is ready for execution.
    
So, store temporary results in r0 instead of r8 to prevent r8 from getting
modified as subsequent code is dependent on its value.

Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
---
 arch/powerpc/kernel/entry_32.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index d22e73e..22b45a4 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -849,7 +849,7 @@ resume_kernel:
 	/* check current_thread_info, _TIF_EMULATE_STACK_STORE */
 	CURRENT_THREAD_INFO(r9, r1)
 	lwz	r8,TI_FLAGS(r9)
-	andis.	r8,r8,_TIF_EMULATE_STACK_STORE@h
+	andis.	r0,r8,_TIF_EMULATE_STACK_STORE@h
 	beq+	1f
 
 	addi	r8,r1,INT_FRAME_SIZE	/* Get the kprobed function entry */
-- 
1.7.4.1
