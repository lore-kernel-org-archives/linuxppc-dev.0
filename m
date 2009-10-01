Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id E23BCB7BCE
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Oct 2009 04:38:52 +1000 (EST)
Date: Thu, 1 Oct 2009 22:38:49 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/kgdb: Fix build failure caused by "kgdb.c: unused
	variable 'acc'"
Message-ID: <20091001183849.GA11781@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, Jason Wessel <jason.wessel@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

'acc' isn't used anywhere and thus triggers gcc warning, which causes
build error with CONFIG_PPC_DISABLE_WERROR=n (default):

  cc1: warnings being treated as errors
  arch/powerpc/kernel/kgdb.c: In function 'gdb_regs_to_pt_regs':
  arch/powerpc/kernel/kgdb.c:289: warning: unused variable 'acc'
  make[1]: *** [arch/powerpc/kernel/kgdb.o] Error 1

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/kernel/kgdb.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index fe8f71d..641c74b 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -282,12 +282,6 @@ void gdb_regs_to_pt_regs(unsigned long *gdb_regs, struct pt_regs *regs)
 {
 	unsigned long *ptr = gdb_regs;
 	int reg;
-#ifdef CONFIG_SPE
-	union {
-		u32 v32[2];
-		u64 v64;
-	} acc;
-#endif
 
 	for (reg = 0; reg < 32; reg++)
 		UNPACK64(regs->gpr[reg], ptr);
-- 
1.6.3.3
