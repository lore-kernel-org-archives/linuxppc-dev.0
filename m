Return-Path: <monstr@monstr.eu>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42]) by ozlabs.org (Postfix) with ESMTP id F31EAB6F06
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 19:22:14 +1000 (EST)
Received: by bwz11 with SMTP id 11so5038755bwz.15
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 02:22:12 -0700 (PDT)
From: Michal Simek <monstr@monstr.eu>
To: 
Subject: [PATCH] powerpc: Replace hardcoded offset by BREAK_INSTR_SIZE
Date: Wed, 28 Jul 2010 11:18:44 +0200
Message-Id: <1280308724-8402-1-git-send-email-monstr@monstr.eu>
Cc: linuxppc-dev@ozlabs.org, Michal Simek <monstr@monstr.eu>,
	Jason Wessel <jason.wessel@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kgdb_handle_breakpoint checks the first arch_kgdb_breakpoint
which is not known by gdb that's why is necessary jump over
it. The jump lenght is equal to BREAK_INSTR_SIZE that's
why is cleaner to use defined macro instead of hardcoded
non-described offset.

Signed-off-by: Michal Simek <monstr@monstr.eu>
CC: Jason Wessel <jason.wessel@windriver.com>
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
1.5.5.6
