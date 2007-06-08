Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] fix stolen time for SMT without LPAR 
In-reply-to: <18023.24703.555674.28511@cargo.ozlabs.ibm.com> 
References: <12635.1180013602@neuling.org> <16370.1180069711@neuling.org>
	<18023.24703.555674.28511@cargo.ozlabs.ibm.com>
Date: Fri, 08 Jun 2007 13:18:50 +1000
Message-ID: <13128.1181272730@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For POWERPC, stolen time accounts for cycles lost to the hypervisor or
PURR cycles attributed to the other SMT thread.  Hence, when a PURR is
available, we should still calculate stolen time, irrespective of being
virtualised.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

> This means that on a machine with SPLPAR but not a PURR, e.g. a JS21,
> we'll try to read the PURR register and do the stolen time calculation
> with whatever value was in the register before the mfspr from the
> PURR.  If we're going to make this change then we also need to add
> code to do the H_PURR hcall instead of reading the PURR directly on
> such machines.

This version bails on reading the PURR if it doesn't exist, so it
doesn't make JS21 any worse.  We still need to fix JS21, but our initial
patches using H_PURR showed some lmbench crappy-ness.

Tested on JS21 and BML.  Like you said offline, this can be 2.6.23. 

 arch/powerpc/kernel/time.c |    2 +-
 include/asm-powerpc/time.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/time.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/time.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/time.c
@@ -214,7 +214,6 @@ static void account_process_time(struct 
  	run_posix_cpu_timers(current);
 }
 
-#ifdef CONFIG_PPC_SPLPAR
 /*
  * Stuff for accounting stolen time.
  */
@@ -273,6 +272,7 @@ void calculate_steal_time(void)
 	spin_unlock(&pme->lock);
 }
 
+#ifdef CONFIG_PPC_SPLPAR
 /*
  * Must be called before the cpu is added to the online map when
  * a cpu is being brought up at runtime.
Index: linux-2.6-ozlabs/include/asm-powerpc/time.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/time.h
+++ linux-2.6-ozlabs/include/asm-powerpc/time.h
@@ -232,7 +232,7 @@ extern void account_process_vtime(struct
 #define account_process_vtime(tsk)		do { } while (0)
 #endif
 
-#if defined(CONFIG_VIRT_CPU_ACCOUNTING) && defined(CONFIG_PPC_SPLPAR)
+#if defined(CONFIG_VIRT_CPU_ACCOUNTING)
 extern void calculate_steal_time(void);
 extern void snapshot_timebases(void);
 #else
