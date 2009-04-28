Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 14888DDEDA
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 23:08:47 +1000 (EST)
Date: Tue, 28 Apr 2009 08:08:40 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: Fix up elf_read_implies_exec() usage
Message-ID: <Pine.LNX.4.64.0904280808220.8094@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
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

Additionally we believe if a toolchain supported PT_GNU_STACK that it
sets the proper PHDR permissions so we only have elf_read_implies_exec()
true if we don't see PT_GNU_STACK set.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Paul, please pick this up for 2.6.30 and send onto linus.

- k

 arch/powerpc/include/asm/elf.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index 087c22f..014a624 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -256,10 +256,11 @@ do {								\
  * even if we have an executable stack.
  */
 # define elf_read_implies_exec(ex, exec_stk) (test_thread_flag(TIF_32BIT) ? \
-		(exec_stk != EXSTACK_DISABLE_X) : 0)
+		(exec_stk == EXSTACK_DEFAULT) : 0)
 #else
 # define SET_PERSONALITY(ex) \
   set_personality(PER_LINUX | (current->personality & (~PER_MASK)))
+# define elf_read_implies_exec(ex, exec_stk) (exec_stk == EXSTACK_DEFAULT)
 #endif /* __powerpc64__ */

 extern int dcache_bsize;
-- 
1.6.0.6
