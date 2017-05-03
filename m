Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wHqfp6D0lzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 May 2017 17:34:26 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id v14so3054777pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 May 2017 00:34:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@ozlabs.org>
Subject: [RFC][PATCH] powerpc/64s: Leave IRQs hard enabled over context switch
Date: Wed,  3 May 2017 17:34:14 +1000
Message-Id: <20170503073414.18776-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 4387e9ff25 ("[POWERPC] Fix PMU + soft interrupt disable bug")
hard disabled interrupts over the low level context switch, because
the SLB management can't cope with a PMU interrupt accesing the stack
in that window.

Radix based kernel mapping does not use the SLB so it does not require
interrupts disabled here. This is worth a % or so in context switch
performance, and also allows the low level context switch code to be
profiled.

Extending the soft IRQ disable to cover PMU interrupts will allow this
hard disable to be removed from hash based kernels too, but they will
still have to soft-disable PMU interrupts.

- Q1: Can we do this? It gives nice profiles of context switch code
  rather than assigning it all to local_irq_enable.

- Q2: What is the unrecoverable SLB miss on exception entry? Is there
  anywhere we access the kernel stack with RI disabled? Something else?

---
 arch/powerpc/kernel/process.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index d645da302bf2..915ec20a18a9 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1176,12 +1176,14 @@ struct task_struct *__switch_to(struct task_struct *prev,
 
 	__switch_to_tm(prev, new);
 
-	/*
-	 * We can't take a PMU exception inside _switch() since there is a
-	 * window where the kernel stack SLB and the kernel stack are out
-	 * of sync. Hard disable here.
-	 */
-	hard_irq_disable();
+	if (!radix_enabled()) {
+		/*
+		 * We can't take a PMU exception inside _switch() since there
+		 * is a window where the kernel stack SLB and the kernel stack
+		 * are out of sync. Hard disable here.
+		 */
+		hard_irq_disable();
+	}
 
 	/*
 	 * Call restore_sprs() before calling _switch(). If we move it after
-- 
2.11.0
