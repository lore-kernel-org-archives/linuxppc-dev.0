Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 70171B723E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 15:06:34 +1000 (EST)
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Message-Id: <d88a2fc47f45788be9d698b16e7707531ca58b0b.1244696770.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc/cell: Use driver_data acessors, not platform_data
Date: Thu, 11 Jun 2009 15:06:34 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Axon MSI driver incorrectly uses platform_data, rather than
the proper accessors for driver_data.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/axon_msi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 0ce45c2..c71498d 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -329,7 +329,7 @@ static struct irq_host_ops msic_host_ops = {
 
 static int axon_msi_shutdown(struct of_device *device)
 {
-	struct axon_msic *msic = device->dev.platform_data;
+	struct axon_msic *msic = dev_get_drvdata(&device->dev);
 	u32 tmp;
 
 	pr_debug("axon_msi: disabling %s\n",
@@ -416,7 +416,7 @@ static int axon_msi_probe(struct of_device *device,
 	msic->read_offset = dcr_read(msic->dcr_host, MSIC_WRITE_OFFSET_REG)
 				& MSIC_FIFO_SIZE_MASK;
 
-	device->dev.platform_data = msic;
+	dev_set_drvdata(&device->dev, msic);
 
 	ppc_md.setup_msi_irqs = axon_msi_setup_msi_irqs;
 	ppc_md.teardown_msi_irqs = axon_msi_teardown_msi_irqs;
-- 
1.6.2.1
