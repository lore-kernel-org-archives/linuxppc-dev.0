Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 51F46B6F9D
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Oct 2011 23:53:47 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p96CrgC6021941
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Oct 2011 07:53:43 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/4] powerpc: Remove extraneous CONFIG_PPC_ADV_DEBUG_REGS
	define
Date: Thu,  6 Oct 2011 07:53:39 -0500
Message-Id: <1317905621-5537-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1317905621-5537-1-git-send-email-galak@kernel.crashing.org>
References: <1317905621-5537-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All of DebugException is already protected by CONFIG_PPC_ADV_DEBUG_REGS
there is no need to have another such ifdef inside the function.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/traps.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index f19d977..db733d3 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1291,14 +1291,12 @@ void __kprobes DebugException(struct pt_regs *regs, unsigned long debug_status)
 
 		if (user_mode(regs)) {
 			current->thread.dbcr0 &= ~DBCR0_IC;
-#ifdef CONFIG_PPC_ADV_DEBUG_REGS
 			if (DBCR_ACTIVE_EVENTS(current->thread.dbcr0,
 					       current->thread.dbcr1))
 				regs->msr |= MSR_DE;
 			else
 				/* Make sure the IDM bit is off */
 				current->thread.dbcr0 &= ~DBCR0_IDM;
-#endif
 		}
 
 		_exception(SIGTRAP, regs, TRAP_TRACE, regs->nip);
-- 
1.7.3.4
