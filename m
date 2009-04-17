Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 75B13DE0C1
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 04:03:07 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: ppc32 needs elf_read_implies_exec()
Date: Fri, 17 Apr 2009 13:03:01 -0500
Message-Id: <1239991381-11649-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On ppc64 we implemented elf_read_implies_exec() for 32-bit binaries
because old toolchains had bugs with regards to marking PHDRs as
executable that needed to be.  For some reason we didn't do this on
ppc32 builds.  This hadn't been an issue until recent changes to I$/D$
handling that impacted the per-page exec handling on embedded PPC.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/elf.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index 1a856b1..b6ada56 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -259,6 +259,7 @@ do {								\
 		(exec_stk != EXSTACK_DISABLE_X) : 0)
 #else 
 # define SET_PERSONALITY(ex) set_personality(PER_LINUX)
+# define elf_read_implies_exec(ex, exec_stk) (exec_stk != EXSTACK_DISABLE_X)
 #endif /* __powerpc64__ */
 
 extern int dcache_bsize;
-- 
1.6.0.6
