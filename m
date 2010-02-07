Return-Path: <anton@ozlabs.org>
Date: Mon, 8 Feb 2010 10:52:05 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Quieten cede latency printk
Message-ID: <20100207235205.GI32246@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The cede latency stuff is relatively new and we don't need to complain about
it not working on older firmware.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/platforms/pseries/hotplug-cpu.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/pseries/hotplug-cpu.c	2010-02-05 17:36:22.509710985 +1100
+++ powerpc.git/arch/powerpc/platforms/pseries/hotplug-cpu.c	2010-02-05 17:36:30.118124726 +1100
@@ -396,14 +396,6 @@ static int parse_cede_parameters(void)
 				__pa(cede_parameters),
 				CEDE_LATENCY_PARAM_MAX_LENGTH);
 
-	if (call_status != 0)
-		printk(KERN_INFO "CEDE_LATENCY: \
-			%s %s Error calling get-system-parameter(0x%x)\n",
-			__FILE__, __func__, call_status);
-	else
-		printk(KERN_INFO "CEDE_LATENCY: \
-			get-system-parameter successful.\n");
-
 	return call_status;
 }
 
