Return-Path: <vitb@kernel.crashing.org>
Date: Tue, 8 Jul 2008 20:49:19 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: powerpc: Add missing  reference to coherent_dma_mask
Message-ID: <20080708204919.4ccab01a@vitb-lp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There is dma_mask in of_device upon of_platform_device_create()
but we don't actually set coherent_dma_mask. This may cause weird 
behavior of USB subsystem using of_device USB host drivers.

Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
---

 arch/powerpc/kernel/of_platform.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index e79ad8a..3f37a6e 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -76,6 +76,8 @@ struct of_device* of_platform_device_create(struct device_node *np,
 		return NULL;
 
 	dev->dma_mask = 0xffffffffUL;
+	dev->dev.coherent_dma_mask = DMA_32BIT_MASK;
+
 	dev->dev.bus = &of_platform_bus_type;
 
 	/* We do not fill the DMA ops for platform devices by default.
