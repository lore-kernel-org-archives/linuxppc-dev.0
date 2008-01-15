Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B8696DDECE
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 13:48:47 +1100 (EST)
Date: Mon, 14 Jan 2008 20:46:29 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Remove update_bridge_resource
Message-ID: <Pine.LNX.4.64.0801142046040.32246@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 85xx/86xx pci code no longer uses update_bridge_resource and it was the
only caller.

---

in my git tree.

 arch/powerpc/kernel/pci_32.c     |   58 --------------------------------------
 include/asm-powerpc/pci-bridge.h |    3 --
 2 files changed, 0 insertions(+), 61 deletions(-)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index a9c6cb2..1698beb 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -93,64 +93,6 @@ fixup_cpc710_pci64(struct pci_dev* dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM,	PCI_DEVICE_ID_IBM_CPC710_PCI64,	fixup_cpc710_pci64);

-
-void __init
-update_bridge_resource(struct pci_dev *dev, struct resource *res)
-{
-	u8 io_base_lo, io_limit_lo;
-	u16 mem_base, mem_limit;
-	u16 cmd;
-	resource_size_t start, end, off;
-	struct pci_controller *hose = dev->sysdata;
-
-	if (!hose) {
-		printk("update_bridge_base: no hose?\n");
-		return;
-	}
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	pci_write_config_word(dev, PCI_COMMAND,
-			      cmd & ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY));
-	if (res->flags & IORESOURCE_IO) {
-		off = (unsigned long) hose->io_base_virt - isa_io_base;
-		start = res->start - off;
-		end = res->end - off;
-		io_base_lo = (start >> 8) & PCI_IO_RANGE_MASK;
-		io_limit_lo = (end >> 8) & PCI_IO_RANGE_MASK;
-		if (end > 0xffff)
-			io_base_lo |= PCI_IO_RANGE_TYPE_32;
-		else
-			io_base_lo |= PCI_IO_RANGE_TYPE_16;
-		pci_write_config_word(dev, PCI_IO_BASE_UPPER16,
-				start >> 16);
-		pci_write_config_word(dev, PCI_IO_LIMIT_UPPER16,
-				end >> 16);
-		pci_write_config_byte(dev, PCI_IO_BASE, io_base_lo);
-		pci_write_config_byte(dev, PCI_IO_LIMIT, io_limit_lo);
-
-	} else if ((res->flags & (IORESOURCE_MEM | IORESOURCE_PREFETCH))
-		   == IORESOURCE_MEM) {
-		off = hose->pci_mem_offset;
-		mem_base = ((res->start - off) >> 16) & PCI_MEMORY_RANGE_MASK;
-		mem_limit = ((res->end - off) >> 16) & PCI_MEMORY_RANGE_MASK;
-		pci_write_config_word(dev, PCI_MEMORY_BASE, mem_base);
-		pci_write_config_word(dev, PCI_MEMORY_LIMIT, mem_limit);
-
-	} else if ((res->flags & (IORESOURCE_MEM | IORESOURCE_PREFETCH))
-		   == (IORESOURCE_MEM | IORESOURCE_PREFETCH)) {
-		off = hose->pci_mem_offset;
-		mem_base = ((res->start - off) >> 16) & PCI_PREF_RANGE_MASK;
-		mem_limit = ((res->end - off) >> 16) & PCI_PREF_RANGE_MASK;
-		pci_write_config_word(dev, PCI_PREF_MEMORY_BASE, mem_base);
-		pci_write_config_word(dev, PCI_PREF_MEMORY_LIMIT, mem_limit);
-
-	} else {
-		DBG(KERN_ERR "PCI: ugh, bridge %s res has flags=%lx\n",
-		    pci_name(dev), res->flags);
-	}
-	pci_write_config_word(dev, PCI_COMMAND, cmd);
-}
-
-
 #ifdef CONFIG_PPC_OF
 /*
  * Functions below are used on OpenFirmware machines.
diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index 9b16d3b..d644452 100644
--- a/include/asm-powerpc/pci-bridge.h
+++ b/include/asm-powerpc/pci-bridge.h
@@ -152,9 +152,6 @@ extern void setup_indirect_pci(struct pci_controller* hose,
 			       resource_size_t cfg_addr,
 			       resource_size_t cfg_data, u32 flags);
 extern void setup_grackle(struct pci_controller *hose);
-extern void __init update_bridge_resource(struct pci_dev *dev,
-					  struct resource *res);
-
 #else	/* CONFIG_PPC64 */

 /*
-- 
1.5.3.7
