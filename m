Return-Path: <anton@samba.org>
Date: Fri, 9 Mar 2012 14:46:45 +1100
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 3.3.0-rc6-next-20120308 boot failure on POWER7 blade
Message-ID: <20120309144645.5b5997d2@kryten>
In-Reply-To: <1331263785.3105.52.camel@pasglop>
References: <20120309142555.7ec5e0ac@kryten> <1331263785.3105.52.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: sfr@ozlabs.org, linuxppc-dev@lists.ozlabs.org, yinghai@kernel.org,
 linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Ben,

> Looks like something that got fixed but the new patches from Bjorn
> aren't in next yet. I'll fwd you the patch separately to apply on top
> of what you have see if that helps (to confirm that's indeed the
> issue).

Thanks, confirmed that it fixes it. Patch below in case anyone else is
hitting it.

Anton

--

On Sat, 2012-03-03 at 08:52 +1100, Benjamin Herrenschmidt wrote:

> Or give me a chance to dig :-) I'll have a look next week.

This is indeed what bjorn suspected on irc, this patch fixes it:

(Bjorn, please fold it in the original offending patch)

Cheers,
Ben.

diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index b37d0b5..5dd63f1 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -75,6 +75,7 @@ static void of_pci_parse_addrs(struct device_node *node, struct pci_dev *dev)
 {
 	u64 base, size;
 	unsigned int flags;
+	struct pci_bus_region region;
 	struct resource *res;
 	const u32 *addrs;
 	u32 i;
@@ -106,10 +107,12 @@ static void of_pci_parse_addrs(struct device_node *node, struct pci_dev *dev)
 			printk(KERN_ERR "PCI: bad cfg reg num 0x%x\n", i);
 			continue;
 		}
-		res->start = base;
-		res->end = base + size - 1;
+
 		res->flags = flags;
 		res->name = pci_name(dev);
+		region.start = base;
+		region.end = base + size - 1;
+		pcibios_bus_to_resource(dev, res, &region);
 	}
 }
 
@@ -209,6 +212,7 @@ void __devinit of_scan_pci_bridge(struct pci_dev *dev)
 	struct pci_bus *bus;
 	const u32 *busrange, *ranges;
 	int len, i, mode;
+	struct pci_bus_region region;
 	struct resource *res;
 	unsigned int flags;
 	u64 size;
@@ -270,9 +274,10 @@ void __devinit of_scan_pci_bridge(struct pci_dev *dev)
 			res = bus->resource[i];
 			++i;
 		}
-		res->start = of_read_number(&ranges[1], 2);
-		res->end = res->start + size - 1;
 		res->flags = flags;
+		region.start = of_read_number(&ranges[1], 2);
+		region.end = region.start + size - 1;		
+		pcibios_bus_to_resource(dev, res, &region);
 	}
 	sprintf(bus->name, "PCI Bus %04x:%02x", pci_domain_nr(bus),
 		bus->number);


--=-aDzdhtAsqTK5gqnOark/--
