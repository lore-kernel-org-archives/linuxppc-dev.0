Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <5d2ed2a7e92250bdc6d9959dbeaeb3784a7109b4.1210220828.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 01/12] Move declaration of init_bootmem_done into system.h
Date: Thu,  8 May 2008 14:27:07 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/mm/init_32.c    |    3 +--
 include/asm-powerpc/system.h |    1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 1952b4d..4541859 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -43,6 +43,7 @@
 #include <asm/btext.h>
 #include <asm/tlb.h>
 #include <asm/sections.h>
+#include <asm/system.h>
 
 #include "mmu_decl.h"
 
@@ -76,8 +77,6 @@ void MMU_init(void);
 /* XXX should be in current.h  -- paulus */
 extern struct task_struct *current_set[NR_CPUS];
 
-extern int init_bootmem_done;
-
 /*
  * this tells the system to map all of ram with the segregs
  * (i.e. page tables) instead of the bats.
diff --git a/include/asm-powerpc/system.h b/include/asm-powerpc/system.h
index 2b6559a..df781ad 100644
--- a/include/asm-powerpc/system.h
+++ b/include/asm-powerpc/system.h
@@ -190,6 +190,7 @@ extern struct task_struct *_switch(struct thread_struct *prev,
 
 extern unsigned int rtas_data;
 extern int mem_init_done;	/* set on boot once kmalloc can be called */
+extern int init_bootmem_done;	/* set on !NUMA once bootmem is available */
 extern unsigned long memory_limit;
 extern unsigned long klimit;
 
-- 
1.5.5
