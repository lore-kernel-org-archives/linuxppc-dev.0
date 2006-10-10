Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2502967B22
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 15:15:13 +1000 (EST)
Subject: [PATCH] powerpc: Don't crash on cell with 2 BEs when !CONFIG_NUMA
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 15:14:12 +1000
Message-Id: <1160457252.32237.105.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The SPU code will crash if CONFIG_NUMA is not set and SPUs are found on
a non-0 node. This workaround will ignore those SPEs and just print an
message in the kernel log.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-cell/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/spu_base.c	2006-10-10 13:50:25.000000000 +1000
+++ linux-cell/arch/powerpc/platforms/cell/spu_base.c	2006-10-10 15:11:39.000000000 +1000
@@ -847,6 +847,17 @@ static int __init create_spu(struct devi
 	if (!spu)
 		goto out;
 
+	spu->node = find_spu_node_id(spe);
+	if (spu->node >= MAX_NUMNODES) {
+		printk(KERN_WARNING "SPE %s on node %d ignored,"
+		       " node number too big\n", spe->full_name, spu->node);
+		printk(KERN_WARNING "Check if CONFIG_NUMA is enabled.\n");
+		return -ENODEV;
+	}
+	spu->nid = of_node_to_nid(spe);
+	if (spu->nid == -1)
+		spu->nid = 0;
+
 	ret = spu_map_device(spu, spe);
 	/* try old method */
 	if (ret)
@@ -854,10 +865,6 @@ static int __init create_spu(struct devi
 	if (ret)
 		goto out_free;
 
-	spu->node = find_spu_node_id(spe);
-	spu->nid = of_node_to_nid(spe);
-	if (spu->nid == -1)
-		spu->nid = 0;
 	ret = spu_map_interrupts(spu, spe);
 	if (ret)
 		ret = spu_map_interrupts_old(spu, spe);
