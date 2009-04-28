Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CE394DDEE3
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 23:32:40 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH v2] powerpc: Fix up elf_read_implies_exec() usage
Date: Tue, 28 Apr 2009 08:32:36 -0500
Message-Id: <1240925556-9110-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We believe if a toolchain supports PT_GNU_STACK that it sets the proper
PHDR permissions.  Therefor elf_read_implies_exec() should only be true
if we don't see PT_GNU_STACK set.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
* Rebased patch on paulus/merge tree which picked up an older patch to fixed
  elf_read_implies_exec() on pure PPC32 systems but not in the way we desired.

Paul, lets try this one for .30.

- k

 arch/powerpc/include/asm/elf.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index d6b4a12..014a624 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -256,11 +256,11 @@ do {								\
  * even if we have an executable stack.
  */
 # define elf_read_implies_exec(ex, exec_stk) (test_thread_flag(TIF_32BIT) ? \
-		(exec_stk != EXSTACK_DISABLE_X) : 0)
+		(exec_stk == EXSTACK_DEFAULT) : 0)
 #else 
 # define SET_PERSONALITY(ex) \
   set_personality(PER_LINUX | (current->personality & (~PER_MASK)))
-# define elf_read_implies_exec(ex, exec_stk) (exec_stk != EXSTACK_DISABLE_X)
+# define elf_read_implies_exec(ex, exec_stk) (exec_stk == EXSTACK_DEFAULT)
 #endif /* __powerpc64__ */
 
 extern int dcache_bsize;
-- 
1.6.0.6
