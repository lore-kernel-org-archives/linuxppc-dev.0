Return-Path: <B32167@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1C9432C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2013 16:28:20 +1000 (EST)
From: Priyanka Jain <Priyanka.Jain@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/32bit,PREEMPT:Load TI_FLAGS to check NEED_RESCHED
Date: Mon, 27 May 2013 11:57:56 +0530
Message-ID: <1369636076-2644-1-git-send-email-Priyanka.Jain@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Priyanka Jain <Priyanka.Jain@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add instruction to load TI_FLAGS in r8
    
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
    

Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
---
 arch/powerpc/kernel/entry_32.S |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index d22e73e..0239c7f 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -887,6 +887,7 @@ resume_kernel:
 #ifdef CONFIG_PREEMPT
 	/* check current_thread_info->preempt_count */
 	lwz	r0,TI_PREEMPT(r9)
+	lwz	r8,TI_FLAGS(r9)
 	cmpwi	0,r0,0		/* if non-zero, just restore regs and return */
 	bne	restore
 	andi.	r8,r8,_TIF_NEED_RESCHED
-- 
1.7.4.1
