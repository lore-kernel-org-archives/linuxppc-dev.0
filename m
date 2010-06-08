Return-Path: <grant.likely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [PATCH 6/6] of/device: populate platform_device (of_device) resource
	table on allocation
To: ben@kernel.crashing.org, sfr@canb.auug.org.au, monstr@monstr.eu,
	microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, jeremy.kerr@canonical.com,
	linuxppc-dev@lists.ozlabs.org
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 08 Jun 2010 08:26:43 -0600
Message-ID: <20100608142643.26088.61366.stgit@angua>
In-Reply-To: <20100608142152.26088.1108.stgit@angua>
References: <20100608142152.26088.1108.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When allocating a platform_device to represent an OF node, also allocate
space for the resource table and populate it with IRQ and reg property
information.  This change is in preparation for merging the
of_platform_bus_type with the platform_bus_type so that existing
platform_driver code can retrieve base addresses and IRQs data.

Background: a previous commit removed struct of_device and made it a
#define alias for platform_device.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
CC: Michal Simek <monstr@monstr.eu>
CC: Grant Likely <grant.likely@secretlab.ca>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Stephen Rothwell <sfr@canb.auug.org.au>
CC: microblaze-uclinux@itee.uq.edu.au
CC: linuxppc-dev@ozlabs.org
CC: devicetree-discuss@lists.ozlabs.org
---
 drivers/of/platform.c |   31 ++++++++++++++++++++++++++++---
 1 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 4bb898d..10ad0b6 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -441,16 +441,41 @@ struct of_device *of_device_alloc(struct device_node *np,
 				  struct device *parent)
 {
 	struct of_device *dev;
-
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	int rc, i, num_reg = 0, num_irq = 0;
+	struct resource *res, temp_res;
+
+	/* First count how many resources are needed */
+	while (of_address_to_resource(np, num_reg, &temp_res) == 0)
+		num_reg++;
+	while (of_irq_to_resource(np, num_irq, &temp_res) != NO_IRQ)
+		num_irq++;
+
+	/* Allocate the device including space for the resource table, and
+	 * initialize it. */
+	i = num_reg + num_irq;
+	dev = kzalloc(sizeof(*dev) + (sizeof(struct resource) * i), GFP_KERNEL);
 	if (!dev)
 		return NULL;
-
 	dev->dev.of_node = of_node_get(np);
 	dev->dev.dma_mask = &dev->archdata.dma_mask;
 	dev->dev.parent = parent;
 	dev->dev.release = of_release_dev;
 
+	/* Populate the resource table */
+	if (num_irq || num_reg) {
+		dev->resource = (void*)&dev[1];
+		dev->num_resources = num_reg + num_irq;
+		res = dev->resource;
+		for (i = 0; i < num_reg; i++, res++) {
+			rc = of_address_to_resource(np, i, res);
+			WARN_ON(rc);
+		}
+		for (i = 0; i < num_irq; i++, res++) {
+			rc = of_irq_to_resource(np, i, res);
+			WARN_ON(rc == NO_IRQ);
+		}
+	}
+
 	if (bus_id)
 		dev_set_name(&dev->dev, "%s", bus_id);
 	else
