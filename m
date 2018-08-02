Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41h2W21Zc5zF1pj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 17:54:05 +1000 (AEST)
Message-Id: <019a806ec215dc5afb078cee0972c968a3993a73.1533151550.git.christophe.leroy@c-s.fr>
In-Reply-To: <af8fe0a5bebd1745ceec07813fa55f1569930f2b.1533151550.git.christophe.leroy@c-s.fr>
References: <af8fe0a5bebd1745ceec07813fa55f1569930f2b.1533151550.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 3/3] powerpc/time: no steal_time when CONFIG_PPC_SPLPAR is
 not selected
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu,  2 Aug 2018 07:54:01 +0000 (UTC)
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
 v5: moved the change to the original localtion
 v4: removed the check in vtime_account_system(), the compiler removes the code regardless.
 v3: new

 arch/powerpc/kernel/time.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 3b03731221c1..b0f5cc491f8b 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -412,8 +412,10 @@ void vtime_flush(struct task_struct *tsk)
 	if (acct->gtime)
 		account_guest_time(tsk, cputime_to_nsecs(acct->gtime));
 
-	if (acct->steal_time)
+	if (IS_ENABLED(CONFIG_PPC_SPLPAR) && acct->steal_time) {
 		account_steal_time(cputime_to_nsecs(acct->steal_time));
+		acct->steal_time = 0;
+	}
 
 	if (acct->idle_time)
 		account_idle_time(cputime_to_nsecs(acct->idle_time));
@@ -433,7 +435,6 @@ void vtime_flush(struct task_struct *tsk)
 
 	acct->utime = 0;
 	acct->gtime = 0;
-	acct->steal_time = 0;
 	acct->idle_time = 0;
 	acct->stime = 0;
 	acct->hardirq_time = 0;
-- 
2.13.3
