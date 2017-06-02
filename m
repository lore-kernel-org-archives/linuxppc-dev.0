Return-Path: <npiggin@gmail.com>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfGN51X8pzDqLV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 17:40:37 +1000 (AEST)
Received: by mail-it0-x243.google.com with SMTP id 67so8872422itx.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Jun 2017 00:40:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Anton Blanchard <anton@samba.org>
Subject: [PATCH 12/14] powerpc/64s: Leave IRQs hard enabled over context
 switch for radix
Date: Fri,  2 Jun 2017 17:39:44 +1000
Message-Id: <20170602073946.8983-13-npiggin@gmail.com>
In-Reply-To: <20170602073946.8983-1-npiggin@gmail.com>
References: <20170602073946.8983-1-npiggin@gmail.com>
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
interrupts disabled here. This is worth 1-2% in context switch
performance.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/process.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 633ec9967141..ea1618b62bf8 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1199,12 +1199,14 @@ struct task_struct *__switch_to(struct task_struct *prev,
 
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
