Return-Path: <anton@samba.org>
Date: Fri, 8 Jul 2011 16:35:38 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, miltonm@bga.com, michael@ellerman.id.au
Subject: [PATCH] powerpc/irq: Quieten irq mapping printks
Message-ID: <20110708163538.43a58fdf@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


HFI creates interrupts each time a window is setup. This results in
a lot of messages in the kernel log buffer:

    irq: irq 199007 on host null mapped to virtual irq 351

This box has over 3500 of them, causing more important kernel
messages to be overwritten. We can get at this information via
debugfs now so we may as well turn it into a pr_debug.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/arch/powerpc/kernel/irq.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/kernel/irq.c	2011-07-08 08:49:44.288874115 +1000
+++ linux-powerpc/arch/powerpc/kernel/irq.c	2011-07-08 08:49:47.458927046 +1000
@@ -744,7 +744,7 @@ unsigned int irq_create_mapping(struct i
 	if (irq_setup_virq(host, virq, hwirq))
 		return NO_IRQ;
 
-	printk(KERN_DEBUG "irq: irq %lu on host %s mapped to virtual irq %u\n",
+	pr_debug("irq: irq %lu on host %s mapped to virtual irq %u\n",
 		hwirq, host->of_node ? host->of_node->full_name : "null", virq);
 
 	return virq;
