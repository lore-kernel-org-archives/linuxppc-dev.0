Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Mon, 07 May 2007 15:58:28 +1000
Subject: [PATCH] Add __init annotations to reserve_mem() and stabs_alloc()
Message-Id: <20070507055830.79831DDEB9@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

reserve_mem() and stabs_alloc() are both called only from other __init
routines, so can be marked __init.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/prom_init.c |    2 +-
 arch/powerpc/mm/stab.c          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: msi-new/arch/powerpc/kernel/prom_init.c
===================================================================
--- msi-new.orig/arch/powerpc/kernel/prom_init.c
+++ msi-new/arch/powerpc/kernel/prom_init.c
@@ -967,7 +967,7 @@ static unsigned long __init prom_next_ce
  * If problems seem to show up, it would be a good start to track
  * them down.
  */
-static void reserve_mem(u64 base, u64 size)
+static void __init reserve_mem(u64 base, u64 size)
 {
 	u64 top = base + size;
 	unsigned long cnt = RELOC(mem_reserve_cnt);
Index: msi-new/arch/powerpc/mm/stab.c
===================================================================
--- msi-new.orig/arch/powerpc/mm/stab.c
+++ msi-new/arch/powerpc/mm/stab.c
@@ -227,7 +227,7 @@ void switch_stab(struct task_struct *tsk
  * the first (bolted) segment, so that do_stab_bolted won't get a
  * recursive segment miss on the segment table itself.
  */
-void stabs_alloc(void)
+void __init stabs_alloc(void)
 {
 	int cpu;
 
