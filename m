Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E829CB70A9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Sep 2010 01:11:28 +1000 (EST)
Date: Tue, 28 Sep 2010 17:11:18 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] powerpc: cell: Fix axion_msi irq shutdown
Message-ID: <alpine.LFD.2.00.1009281708350.2416@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Calling unmask_msi_irq on irq shutdown is at least suboptimal.
Use mask_msi_irq instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/platforms/cell/axon_msi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/powerpc/platforms/cell/axon_msi.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/axon_msi.c
+++ linux-2.6/arch/powerpc/platforms/cell/axon_msi.c
@@ -312,7 +312,7 @@ static void axon_msi_teardown_msi_irqs(s
 static struct irq_chip msic_irq_chip = {
 	.mask		= mask_msi_irq,
 	.unmask		= unmask_msi_irq,
-	.shutdown	= unmask_msi_irq,
+	.shutdown	= mask_msi_irq,
 	.name		= "AXON-MSI",
 };
 
