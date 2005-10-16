Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 933886857A
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Oct 2005 18:44:02 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joerg Dorchain <joerg@dorchain.net>
In-Reply-To: <20051016081759.GA2609@Redstar.dorchain.net>
References: <20051014123823.GA9477@Redstar.dorchain.net>
	<1129327105.21765.39.camel@gaston>
	<20051016081759.GA2609@Redstar.dorchain.net>
Content-Type: text/plain
Date: Sun, 16 Oct 2005 18:42:46 +1000
Message-Id: <1129452167.7620.34.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: 2.6.13 ati (ibook) frambuffer problem
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2005-10-16 at 10:17 +0200, Joerg Dorchain wrote:
> On Sat, Oct 15, 2005 at 07:58:25AM +1000, Benjamin Herrenschmidt wrote:
> > 
> > This looks like a bug that was introduced by linus in 2.6.13 and that I
> > _think_ should be fixed in the stable series, so if you get 2.6.13.x (x
> > = latest stable release) it should work.
> 
> 2.6.13.4 does not fix it and(, as far as I skimmed it,) contains no
> changes to the ati framebuffer code.

Hrm... annoying, I was sure it was fixed, I'll have to check. The bug
isn't actually in the ATI code, but in the PCI code. Well, maybe you are
hitting something else...

The bug I'm thinking about was fixed by git commit
6821eb3b64158ec230982f4db5f027b326edd620, here's the patch. Let me know
if it helps.

---

[PATCH] Fix PCI ROM mapping

This fixes a problem with pci_map_rom() which doesn't properly
update the ROM BAR value with the address thas allocated for it by the
PCI code. This problem, among other, breaks boot on Mac laptops.

It'ss a new version based on Linus latest one with better error
checking.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>

 drivers/pci/rom.c |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -21,13 +21,21 @@
  * between the ROM and other resources, so enabling it may disable access
  * to MMIO registers or other card memory.
  */
-static void pci_enable_rom(struct pci_dev *pdev)
+static int pci_enable_rom(struct pci_dev *pdev)
 {
+       struct resource *res = pdev->resource + PCI_ROM_RESOURCE;
+       struct pci_bus_region region;
        u32 rom_addr;
 
+       if (!res->flags)
+               return -1;
+
+       pcibios_resource_to_bus(pdev, &region, res);
        pci_read_config_dword(pdev, pdev->rom_base_reg, &rom_addr);
-       rom_addr |= PCI_ROM_ADDRESS_ENABLE;
+       rom_addr &= ~PCI_ROM_ADDRESS_MASK;
+       rom_addr |= region.start | PCI_ROM_ADDRESS_ENABLE;
        pci_write_config_dword(pdev, pdev->rom_base_reg, rom_addr);
+       return 0;
 }
 
 /**
@@ -71,19 +79,21 @@ void __iomem *pci_map_rom(struct pci_dev
        } else {
                if (res->flags & IORESOURCE_ROM_COPY) {
                        *size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
-                       return (void __iomem *)pci_resource_start(pdev, PCI_ROM_RESOURCE);
+                       return (void __iomem *)pci_resource_start(pdev,
+                                                            PCI_ROM_RESOURCE);
                } else {
                        /* assign the ROM an address if it doesn't have one */
-                       if (res->parent == NULL)
-                               pci_assign_resource(pdev, PCI_ROM_RESOURCE);
-
+                       if (res->parent == NULL &&
+                           pci_assign_resource(pdev,PCI_ROM_RESOURCE))
+                               return NULL;
                        start = pci_resource_start(pdev, PCI_ROM_RESOURCE);
                        *size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
                        if (*size == 0)
                                return NULL;
 
                        /* Enable ROM space decodes */
-                       pci_enable_rom(pdev);
+                       if (pci_enable_rom(pdev))
+                               return NULL;
                }
        }
 
