Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FchS4q6vzF3JS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 21:14:48 +1000 (AEST)
Message-Id: <d60ce7dd74704b0ca0a857186f30de4006b63534.1537355312.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 1/2] sched: move stack_canary field at the top of
 task_struct
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 19 Sep 2018 11:14:43 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to allow the use of non global stack protector canary,
the stack canary needs to be located at a know offset defined
in Makefile via -mstack-protector-guard-offset.

On powerpc/32, register r2 points to current task_struct at
all time, the stack_canary located inside task_struct can be
used directly if it is located in a known place.

In order to allow that, this patch moves the stack_canary field
out of the randomized area of task_struct.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 include/linux/sched.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 977cb57d7bc9..1d977b8a4bac 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -601,6 +601,10 @@ struct task_struct {
 	/* -1 unrunnable, 0 runnable, >0 stopped: */
 	volatile long			state;
 
+#ifdef CONFIG_STACKPROTECTOR
+	/* Canary value for the -fstack-protector GCC feature: */
+	unsigned long			stack_canary;
+#endif
 	/*
 	 * This begins the randomizable portion of task_struct. Only
 	 * scheduling-critical items should be added above here.
@@ -746,10 +750,6 @@ struct task_struct {
 	pid_t				pid;
 	pid_t				tgid;
 
-#ifdef CONFIG_STACKPROTECTOR
-	/* Canary value for the -fstack-protector GCC feature: */
-	unsigned long			stack_canary;
-#endif
 	/*
 	 * Pointers to the (original) parent process, youngest child, younger sibling,
 	 * older sibling, respectively.  (p->father can be replaced with
-- 
2.13.3
