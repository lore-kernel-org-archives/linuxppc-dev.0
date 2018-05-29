Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wJp1732SzDr69
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 02:19:21 +1000 (AEST)
Message-Id: <96d2828025d815e91e3946f6ef45a09d9a206ca3.1527610536.git.christophe.leroy@c-s.fr>
In-Reply-To: <2e937890abac10677aae3c1e345dd934a6794c37.1527610536.git.christophe.leroy@c-s.fr>
References: <2e937890abac10677aae3c1e345dd934a6794c37.1527610536.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 3/3] powerpc/time: no steal_time if !CONFIG_PPC_SPLPAR
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 29 May 2018 16:19:18 +0000 (UTC)
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
 New in v3
 
 arch/powerpc/kernel/time.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 7d6040233003..85d1b1ff45f3 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -346,7 +346,8 @@ void vtime_account_system(struct task_struct *tsk)
 	stime = vtime_delta(tsk, &stime_scaled, &steal_time);
 
 	stime -= min(stime, steal_time);
-	acct->steal_time += steal_time;
+	if (IS_ENABLED(CONFIG_PPC_SPLPAR))
+		acct->steal_time += steal_time;
 
 	if ((tsk->flags & PF_VCPU) && !irq_count()) {
 		acct->gtime += stime;
@@ -401,7 +402,7 @@ void vtime_flush(struct task_struct *tsk)
 	if (acct->gtime)
 		account_guest_time(tsk, cputime_to_nsecs(acct->gtime));
 
-	if (acct->steal_time)
+	if (IS_ENABLED(CONFIG_PPC_SPLPAR) && acct->steal_time)
 		account_steal_time(cputime_to_nsecs(acct->steal_time));
 
 	if (acct->idle_time)
@@ -425,7 +426,8 @@ void vtime_flush(struct task_struct *tsk)
 	acct->stime_scaled = 0;
 #endif
 	acct->gtime = 0;
-	acct->steal_time = 0;
+	if (IS_ENABLED(CONFIG_PPC_SPLPAR))
+		acct->steal_time = 0;
 	acct->idle_time = 0;
 	acct->stime = 0;
 	acct->hardirq_time = 0;
-- 
2.13.3
