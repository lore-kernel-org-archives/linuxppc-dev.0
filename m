Return-Path: <ra8135@perf2farm5.am.freescale.net>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 631D42C0095
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jul 2013 05:50:07 +1000 (EST)
From: James Yang <James.Yang@freescale.com>
To: <benh@kernel.crashing.org>, <scottwood@freescale.com>
Subject: [PATCH] powerpc/booke: clear DBCR0_BT in user_disable_single_step()
Date: Fri, 5 Jul 2013 14:49:43 -0500
Message-ID: <1373053783-19668-1-git-send-email-James.Yang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: James Yang <James.Yang@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

BookE version of user_disable_single_step() clears DBCR0_IC for the
instruction completion debug, but did not also clear DBCR0_BT for the
branch taken exception.  This behavior was lost by the 2/2010 patch.

Signed-off-by: James Yang <James.Yang@freescale.com>
---
 arch/powerpc/kernel/ptrace.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 98c2fc1..c634970 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -894,7 +894,7 @@ void user_disable_single_step(struct task_struct *task)
 		 * And, after doing so, if all debug flags are off, turn
 		 * off DBCR0(IDM) and MSR(DE) .... Torez
 		 */
-		task->thread.dbcr0 &= ~DBCR0_IC;
+		task->thread.dbcr0 &= ~(DBCR0_IC|DBCR0_BT);
 		/*
 		 * Test to see if any of the DBCR_ACTIVE_EVENTS bits are set.
 		 */
-- 
1.7.0.4
