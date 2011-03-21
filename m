Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 083ACB6F72
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Mar 2011 05:28:39 +1100 (EST)
From: Milton Miller <miltonm@bga.com>
Subject: [PATCH] powerpc: pseries/smp: query-cpu-stopped-state support won't
	change
To: linuxppc-dev@lists.ozlabs.org
Message-id: <quieten-query-cpu-stopped-state@mdm.bga.com>
In-Reply-To: <patches-for-39-rc1@mdm.bga.com>
References: <patches-for-39-rc1@mdm.bga.com>
Date: Mon, 21 Mar 2011 12:12:13 -0600
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If a given firmware doesn't have a token to support query-cpu-stopped-state,
its not likely to change during the lifetime of the kernel.   

Only print this information once, not once per secondary thread.

While here, make the line wrap grep friendly.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: work.git/arch/powerpc/platforms/pseries/smp.c
===================================================================
--- work.git.orig/arch/powerpc/platforms/pseries/smp.c	2011-03-21 11:27:54.000000000 -0500
+++ work.git/arch/powerpc/platforms/pseries/smp.c	2011-03-21 11:29:51.000000000 -0500
@@ -64,8 +64,8 @@ int smp_query_cpu_stopped(unsigned int p
 	int qcss_tok = rtas_token("query-cpu-stopped-state");
 
 	if (qcss_tok == RTAS_UNKNOWN_SERVICE) {
-		printk(KERN_INFO "Firmware doesn't support "
-				"query-cpu-stopped-state\n");
+		printk_once(KERN_INFO
+			"Firmware doesn't support query-cpu-stopped-state\n");
 		return QCSS_HARDWARE_ERROR;
 	}
 
