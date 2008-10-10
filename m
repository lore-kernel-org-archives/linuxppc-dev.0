Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 73825DE09B
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 22:56:43 +1100 (EST)
Date: Fri, 10 Oct 2008 06:56:33 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org, Ben Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Message-id: <patch-xics-7@bga.com>
In-Reply-To: <patch-xics-0@bga.com>
Subject: [PATCH 7/16] xics: initialization cleanups
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We only need to check the ibm,interrupt-server#-size property once, not
once per global server and thread.

We can use !CONFIG_SMP cpu masks and hard_smp_processor_id() to avoid an ifdef.  
Put the node when breaking out of the loop on lpar systems.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: next.git/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- next.git.orig/arch/powerpc/platforms/pseries/xics.c	2008-10-04 17:39:58.000000000 -0500
+++ next.git/arch/powerpc/platforms/pseries/xics.c	2008-10-04 17:40:00.000000000 -0500
@@ -606,21 +606,20 @@ static void xics_update_irq_servers(void
 		if (ireg[j] == hcpuid) {
 			default_server = hcpuid;
 			default_distrib_server = ireg[j+1];
-
-			isize = of_get_property(np,
-					"ibm,interrupt-server#-size", NULL);
-			if (isize)
-				interrupt_server_size = *isize;
 		}
 	}
 
+	/* get the bit size of server numbers */
+	isize = of_get_property(np, "ibm,interrupt-server#-size", NULL);
+	if (isize)
+		interrupt_server_size = *isize;
+
 	of_node_put(np);
 }
 
 static void __init xics_map_one_cpu(int hw_id, unsigned long addr,
 				     unsigned long size)
 {
-#ifdef CONFIG_SMP
 	int i;
 
 	/* This may look gross but it's good enough for now, we don't quite
@@ -634,11 +633,6 @@ static void __init xics_map_one_cpu(int 
 			return;
 		}
 	}
-#else
-	if (hw_id != 0)
-		return;
-	xics_per_cpu[0] = ioremap(addr, size);
-#endif /* CONFIG_SMP */
 }
 
 static void __init xics_init_one_node(struct device_node *np,
@@ -700,8 +694,10 @@ void __init xics_init_IRQ(void)
 
 	for_each_node_by_type(np, "PowerPC-External-Interrupt-Presentation") {
 		found = 1;
-		if (firmware_has_feature(FW_FEATURE_LPAR))
+		if (firmware_has_feature(FW_FEATURE_LPAR)) {
+			of_node_put(np);
 			break;
+			}
 		xics_init_one_node(np, &indx);
 	}
 	if (found == 0)
