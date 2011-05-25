Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id D6E9DB6F9E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 16:34:22 +1000 (EST)
Subject: [PATCH 3/8] powerpc irq: remove stale and misleading comment
From: Milton Miller <miltonm@bga.com>
Message-Id: <irq-stale-remap-comment@mdm.bga.com>
In-Reply-To: <more-irq-cleanups@mdm.bga.com>
References: <more-irq-cleanups@mdm.bga.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 25 May 2011 01:34:18 -0500
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The comment claims we will call host->ops->map() to update the flags if
we find a previously established mapping, but we never did.  We used
to call remap, but that call was removed in da05198002 (powerpc: Remove
irq_host_ops->remap hook).

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: work.git/arch/powerpc/kernel/irq.c
===================================================================
--- work.git.orig/arch/powerpc/kernel/irq.c	2011-05-24 20:43:46.350096135 -0500
+++ work.git/arch/powerpc/kernel/irq.c	2011-05-24 21:03:49.520096058 -0500
@@ -727,9 +727,7 @@ unsigned int irq_create_mapping(struct i
 	}
 	pr_debug("irq: -> using host @%p\n", host);
 
-	/* Check if mapping already exist, if it does, call
-	 * host->ops->map() to update the flags
-	 */
+	/* Check if mapping already exists */
 	virq = irq_find_mapping(host, hwirq);
 	if (virq != NO_IRQ) {
 		pr_debug("irq: -> existing mapping on virq %d\n", virq);
