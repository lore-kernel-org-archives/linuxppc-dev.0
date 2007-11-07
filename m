Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out1.tiscali.nl (smtp-out1.tiscali.nl [195.241.79.176])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3A389DDEC0
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 09:01:49 +1100 (EST)
Received: from [82.171.216.234] (helo=[192.168.1.2])
	by smtp-out1.tiscali.nl with esmtp (Tiscali http://www.tiscali.nl)
	id 1Ipsy0-0002B4-MI
	for <linuxppc-dev@ozlabs.org>; Wed, 07 Nov 2007 23:01:44 +0100
Message-ID: <473235C6.2050104@tiscali.nl>
Date: Wed, 07 Nov 2007 23:01:42 +0100
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: inbalanced ioremap/iounmap? in cpm_pic_init();
	arch/powerpc/sysdev/commproc.c
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It appears to me that ioremap/iounmap in cpm_pic_init() is imbalanced. I am not
certain about this, nor was the patch tested. please review.
--
fix ioremap/iounmap imbalance

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
index f6a6378..7b1dd9c 100644
--- a/arch/powerpc/sysdev/commproc.c
+++ b/arch/powerpc/sysdev/commproc.c
@@ -152,13 +152,13 @@ unsigned int cpm_pic_init(void)
 	cpic_reg = ioremap(res.start, res.end - res.start + 1);
 	if (cpic_reg == NULL)
 		goto end;
 
 	sirq = irq_of_parse_and_map(np, 0);
 	if (sirq == NO_IRQ)
-		goto end;
+		goto io_out;
 
 	/* Initialize the CPM interrupt controller. */
 	hwirq = (unsigned int)irq_map[sirq].hwirq;
 	out_be32(&cpic_reg->cpic_cicr,
 	    (CICR_SCD_SCC4 | CICR_SCC_SCC3 | CICR_SCB_SCC2 | CICR_SCA_SCC1) |
 		((hwirq/2) << 13) | CICR_HP_MASK);
@@ -167,13 +167,13 @@ unsigned int cpm_pic_init(void)
 
 	cpm_pic_host = irq_alloc_host(of_node_get(np), IRQ_HOST_MAP_LINEAR,
 				      64, &cpm_pic_host_ops, 64);
 	if (cpm_pic_host == NULL) {
 		printk(KERN_ERR "CPM2 PIC: failed to allocate irq host!\n");
 		sirq = NO_IRQ;
-		goto end;
+		goto io_out;
 	}
 
 	/* Install our own error handler. */
 	np = of_find_compatible_node(NULL, NULL, "fsl,cpm1");
 	if (np == NULL)
 		np = of_find_node_by_type(NULL, "cpm");
@@ -187,13 +187,15 @@ unsigned int cpm_pic_init(void)
 		goto end;
 
 	if (setup_irq(eirq, &cpm_error_irqaction))
 		printk(KERN_ERR "Could not allocate CPM error IRQ!");
 
 	setbits32(&cpic_reg->cpic_cicr, CICR_IEN);
-
+	goto end;
+io_out:
+	iounmap(cpic_reg);
 end:
 	of_node_put(np);
 	return sirq;
 }
 
 void __init cpm_reset(void)
