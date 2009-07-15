Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 88DB0B70BA
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Jul 2009 16:57:03 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 15 Jul 2009 16:56:58 +1000
Subject: [PATCH] powerpc/pmac: Fix PowerSurge SMP IPI allocation
Message-Id: <20090715065703.78B86DDDB6@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The code for setting up the IPIs for SMP PowerSurge marchines bitrot,
it needs to properly map the HW interrupt number

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
--

 arch/powerpc/platforms/powermac/smp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-work.orig/arch/powerpc/platforms/powermac/smp.c	2009-07-15 16:55:28.000000000 +1000
+++ linux-work/arch/powerpc/platforms/powermac/smp.c	2009-07-15 16:55:36.000000000 +1000
@@ -408,7 +408,7 @@ static void __init smp_psurge_setup_cpu(
 	/* reset the entry point so if we get another intr we won't
 	 * try to startup again */
 	out_be32(psurge_start, 0x100);
-	if (setup_irq(30, &psurge_irqaction))
+	if (setup_irq(irq_create_mapping(NULL, 30), &psurge_irqaction))
 		printk(KERN_ERR "Couldn't get primary IPI interrupt");
 }
 
