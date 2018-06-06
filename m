Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4119p56vXMzF31M
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 00:21:14 +1000 (AEST)
Message-Id: <a74751d73e669ab3117e4479b7a138dc832e8f8b.1528292284.git.christophe.leroy@c-s.fr>
In-Reply-To: <d9ac8da98f53debb4758b98d0227979aca9196f7.1528292284.git.christophe.leroy@c-s.fr>
References: <d9ac8da98f53debb4758b98d0227979aca9196f7.1528292284.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 2/2] powerpc/time: no steal_time when CONFIG_PPC_SPLPAR is
 not selected
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Frederic Weisbecker <fweisbec@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed,  6 Jun 2018 14:21:10 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If CONFIG_PPC_SPLPAR is not selected, steal_time will always
be NUL, so accounting it is pointless

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v4: removed the check in vtime_account_system(), the compiler removes the code regardless.
 v3: new

 arch/powerpc/kernel/time.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 7a9f4e2f22c8..eda78b1ed7d3 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -412,9 +412,6 @@ void vtime_flush(struct task_struct *tsk)
 	if (acct->gtime)
 		account_guest_time(tsk, cputime_to_nsecs(acct->gtime));
 
-	if (acct->steal_time)
-		account_steal_time(cputime_to_nsecs(acct->steal_time));
-
 	if (acct->idle_time)
 		account_idle_time(cputime_to_nsecs(acct->idle_time));
 
@@ -431,13 +428,17 @@ void vtime_flush(struct task_struct *tsk)
 
 	acct->utime = 0;
 	acct->gtime = 0;
-	acct->steal_time = 0;
 	acct->idle_time = 0;
 	acct->stime = 0;
 	acct->hardirq_time = 0;
 	acct->softirq_time = 0;
 
 	vtime_flush_scaled(tsk, acct);
+
+	if (IS_ENABLED(CONFIG_PPC_SPLPAR) && acct->steal_time) {
+		account_steal_time(cputime_to_nsecs(acct->steal_time));
+		acct->steal_time = 0;
+	}
 }
 
 #else /* ! CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
-- 
2.13.3
