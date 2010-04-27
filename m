Return-Path: <anton@ozlabs.org>
Message-Id: <20100427013431.983164873@samba.org>
Date: Tue, 27 Apr 2010 11:32:36 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 rusty@rustcorp.com.au
Subject: [patch 05/15] powerpc: cpumask: Convert iseries SMP code to new
	cpumask API
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

Use new cpumask functions in iseries SMP startup code.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-cpumask/arch/powerpc/platforms/iseries/smp.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/platforms/iseries/smp.c	2010-04-08 19:46:04.129196495 +1000
+++ linux-cpumask/arch/powerpc/platforms/iseries/smp.c	2010-04-22 13:03:16.326695430 +1000
@@ -83,7 +83,7 @@ static void smp_iSeries_message_pass(int
 
 static int smp_iSeries_probe(void)
 {
-	return cpus_weight(cpu_possible_map);
+	return cpumask_weight(cpu_possible_mask);
 }
 
 static void smp_iSeries_kick_cpu(int nr)
