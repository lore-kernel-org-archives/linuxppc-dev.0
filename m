Return-Path: <jason.wessel@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id AE7BB1007D6
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jul 2010 05:18:05 +1000 (EST)
From: Jason Wessel <jason.wessel@windriver.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 10/15] powerpc: Replace hardcoded offset by BREAK_INSTR_SIZE
Date: Fri, 30 Jul 2010 14:17:31 -0500
Message-Id: <1280517456-1167-11-git-send-email-jason.wessel@windriver.com>
In-Reply-To: <1280517456-1167-1-git-send-email-jason.wessel@windriver.com>
References: <1280517456-1167-1-git-send-email-jason.wessel@windriver.com>
Cc: Michal Simek <monstr@monstr.eu>, kgdb-bugreport@lists.sourceforge.net,
	Jason Wessel <jason.wessel@windriver.com>,
	linuxppc-dev@ozlabs.org, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michal Simek <monstr@monstr.eu>

kgdb_handle_breakpoint checks the first arch_kgdb_breakpoint
which is not known by gdb that's why is necessary jump over
it. The jump lenght is equal to BREAK_INSTR_SIZE that's
why is cleaner to use defined macro instead of hardcoded
non-described offset.

Signed-off-by: Michal Simek <monstr@monstr.eu>
Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc-dev@ozlabs.org
---
 arch/powerpc/kernel/kgdb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index 82a7b22..7f61a3a 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -129,7 +129,7 @@ static int kgdb_handle_breakpoint(struct pt_regs *regs)
 		return 0;
 
 	if (*(u32 *) (regs->nip) == *(u32 *) (&arch_kgdb_ops.gdb_bpt_instr))
-		regs->nip += 4;
+		regs->nip += BREAK_INSTR_SIZE;
 
 	return 1;
 }
-- 
1.6.4.rc1
