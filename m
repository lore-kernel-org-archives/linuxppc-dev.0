Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPMrP5cV5zDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 04:01:41 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id 5so2446270pgj.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 09:01:41 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 3/4] powerpc/powernv: cope with non-synchronous machine checks
Date: Fri, 17 Feb 2017 03:01:13 +1000
Message-Id: <20170216170114.25247-4-npiggin@gmail.com>
In-Reply-To: <20170216170114.25247-1-npiggin@gmail.com>
References: <20170216170114.25247-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Asynchronous machine checks don't correspond to the instruction or
even task that is currently running. Therefore only synchronous
machine checks should attempt to kill the currently running task
to recover.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/opal.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 282293572dc8..8cd1656f0535 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -404,26 +404,17 @@ static int opal_recover_mce(struct pt_regs *regs,
 	} else if (evt->disposition == MCE_DISPOSITION_RECOVERED) {
 		/* Platform corrected itself */
 		recovered = 1;
-	} else if (ea && !is_kernel_addr(ea)) {
+	} else if (evt->severity == MCE_SEV_FATAL) {
+		/* Async or otherwise fatal machine check */
+		pr_err("Machine check interrupt unrecoverable\n");
+		recovered = 0;
+	} else if (user_mode(regs) && !is_global_init(current)) {
 		/*
-		 * Faulting address is not in kernel text. We should be fine.
-		 * We need to find which process uses this address.
 		 * For now, kill the task if we have received exception when
 		 * in userspace.
 		 *
 		 * TODO: Queue up this address for hwpoisioning later.
 		 */
-		if (user_mode(regs) && !is_global_init(current)) {
-			_exception(SIGBUS, regs, BUS_MCEERR_AR, regs->nip);
-			recovered = 1;
-		} else
-			recovered = 0;
-	} else if (user_mode(regs) && !is_global_init(current) &&
-		evt->severity == MCE_SEV_ERROR_SYNC) {
-		/*
-		 * If we have received a synchronous error when in userspace
-		 * kill the task.
-		 */
 		_exception(SIGBUS, regs, BUS_MCEERR_AR, regs->nip);
 		recovered = 1;
 	}
-- 
2.11.0
