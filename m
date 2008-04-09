Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@ozlabs.org>
Date: Wed, 09 Apr 2008 17:21:26 +1000
Subject: [PATCH 1/6] [POWERPC] Initialize paca->current earlier
Message-Id: <20080409072222.29925DDE1F@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, we initialize the "current" pointer in the PACA (which
is used by the "current" macro in the kernel) before calling
setup_system(). That means that early_setup() is called with
current still "NULL" which is -not- a good idea. It happens to
work so far but breaks with lockdep when early code calls printk.

This changes it so that all PACAs are statically initialized with
__current pointing to the init task. For non-0 CPUs, this is fixed
up before use.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/head_64.S |    4 ----
 arch/powerpc/kernel/paca.c    |    3 ++-
 2 files changed, 2 insertions(+), 5 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/head_64.S	2008-04-02 18:20:53.000000000 +1100
+++ linux-work/arch/powerpc/kernel/head_64.S	2008-04-02 18:24:45.000000000 +1100
@@ -1505,10 +1505,6 @@ _INIT_GLOBAL(start_here_common)
 	li	r0,0
 	stdu	r0,-STACK_FRAME_OVERHEAD(r1)
 
-	/* ptr to current */
-	LOAD_REG_IMMEDIATE(r4, init_task)
-	std	r4,PACACURRENT(r13)
-
 	/* Load the TOC */
 	ld	r2,PACATOC(r13)
 	std	r1,PACAKSAVE(r13)
Index: linux-work/arch/powerpc/kernel/paca.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/paca.c	2008-04-02 18:28:07.000000000 +1100
+++ linux-work/arch/powerpc/kernel/paca.c	2008-04-02 18:28:22.000000000 +1100
@@ -72,7 +72,8 @@ struct slb_shadow slb_shadow[] __cacheli
 	.paca_index = (number),		/* Paca Index */		    \
 	.kernel_toc = (unsigned long)(&__toc_start) + 0x8000UL,		    \
 	.hw_cpu_id = 0xffff,						    \
-	.slb_shadow_ptr = &slb_shadow[number],
+	.slb_shadow_ptr = &slb_shadow[number],				    \
+	.__current = &init_task,
 
 #ifdef CONFIG_PPC_ISERIES
 #define PACA_INIT_ISERIES(number)					    \
