Return-Path: <grant.likely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [PATCH 1/6] of: Use full node name in resource structures
To: ben@kernel.crashing.org, sfr@canb.auug.org.au, monstr@monstr.eu,
	microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, jeremy.kerr@canonical.com,
	linuxppc-dev@lists.ozlabs.org
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 08 Jun 2010 08:26:18 -0600
Message-ID: <20100608142618.26088.24079.stgit@angua>
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

Resource names appear in human readable output, so when extracting IRQ
and address resources from a device tree node, use the full node name
to give proper context in places like /proc/iomem.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
CC: Michal Simek <monstr@monstr.eu>
CC: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: microblaze-uclinux@itee.uq.edu.au
CC: linuxppc-dev@ozlabs.org
---
 drivers/of/address.c |    2 +-
 drivers/of/irq.c     |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 5c220c3..fcadb72 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -549,7 +549,7 @@ static int __of_address_to_resource(struct device_node *dev, const u32 *addrp,
 		r->end = taddr + size - 1;
 	}
 	r->flags = flags;
-	r->name = dev->name;
+	r->name = dev->full_name;
 	return 0;
 }
 
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 5c097be..8e8cdce 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -330,6 +330,7 @@ unsigned int of_irq_to_resource(struct device_node *dev, int index,
 	if (r && irq != NO_IRQ) {
 		r->start = r->end = irq;
 		r->flags = IORESOURCE_IRQ;
+		r->name = dev->full_name;
 	}
 
 	return irq;
