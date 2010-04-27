Return-Path: <anton@ozlabs.org>
Message-Id: <20100427013432.950809577@samba.org>
Date: Tue, 27 Apr 2010 11:32:46 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 rusty@rustcorp.com.au
Subject: [patch 15/15] powerpc: cpumask: Add DEBUG_PER_CPU_MAPS option
References: <20100427013231.510168034@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable the DEBUG_PER_CPU_MAPS option so we can look for problems with
cpumasks .

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-cpumask/arch/powerpc/Kconfig.debug
===================================================================
--- linux-cpumask.orig/arch/powerpc/Kconfig.debug	2010-04-22 14:51:36.359196562 +1000
+++ linux-cpumask/arch/powerpc/Kconfig.debug	2010-04-22 14:52:04.845445439 +1000
@@ -44,6 +44,18 @@ config DEBUG_STACK_USAGE
 
 	  This option will slow down process creation somewhat.
 
+config DEBUG_PER_CPU_MAPS
+	bool "Debug access to per_cpu maps"
+	depends on DEBUG_KERNEL
+	depends on SMP
+	default n
+	---help---
+	  Say Y to verify that the per_cpu map being accessed has
+	  been setup.  Adds a fair amount of code to kernel memory
+	  and decreases performance.
+
+	  Say N if unsure.
+
 config HCALL_STATS
 	bool "Hypervisor call instrumentation"
 	depends on PPC_PSERIES && DEBUG_FS && TRACEPOINTS
