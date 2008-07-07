Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C795EDDEFE
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 09:13:07 +1000 (EST)
Date: Tue, 8 Jul 2008 03:12:56 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: powerpc: Add proper reference to dma_mask
Message-ID: <20080708031256.57176084@vitb-lp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There is dma_mask in of_device that is being filled upon
of_platform_device_create() but we don't properly set the struct device
in there to point back to it. coherent_dma_mask wasn't set up either -
these caused weird lock-ups and behavior of USB subsystem using
of_device USB host drivers.

Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
---

 arch/powerpc/kernel/of_platform.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index e79ad8a..2bf4c04 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -76,6 +76,9 @@ struct of_device* of_platform_device_create(struct device_node *np,
 		return NULL;
 
 	dev->dma_mask = 0xffffffffUL;
+	dev->dev.dma_mask = &dev->dma_mask;
+	dev->dev.coherent_dma_mask = DMA_32BIT_MASK;
+
 	dev->dev.bus = &of_platform_bus_type;
 
 	/* We do not fill the DMA ops for platform devices by default.
