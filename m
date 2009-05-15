Return-Path: <thunderbird2k@gmail.com>
Received: from mail-ew0-f167.google.com (mail-ew0-f167.google.com
	[209.85.219.167]) by ozlabs.org (Postfix) with ESMTP id 819B4DE0D5
	for <linuxppc-dev@ozlabs.org>; Sat, 16 May 2009 08:26:57 +1000 (EST)
Received: by ewy11 with SMTP id 11so2748988ewy.9
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 15:26:55 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 16 May 2009 00:19:06 +0200
Message-ID: <c8485d470905151519y312df92fsfa37c2f5484a1ea0@mail.gmail.com>
Subject: Patch 1/2: Add support for Xilinx PLB PCI soft-core [attempt3]
From: Roderick Colenbrander <thunderbird2k@gmail.com>
To: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

As requested here the same patch but now with a signed-off line which I for=
got.

Regards,
Roderick Colenbrander

Signed-off-by: Roderick Colenbrander <thunderbird2k@gmail.com>


>From 2b34a315b18834448c0a8218d4da85ffaf76039e Mon Sep 17 00:00:00 2001
From: Roderick Colenbrander <thunderbird2k@gmail.com>
Date: Tue, 14 Apr 2009 15:45:07 +0200
Subject: [PATCH] Add support for the Xilinx PLB PCI soft-core which is
used on Xilinx ML410 and ML510 FPGA boards.

---
=A0arch/powerpc/sysdev/Kconfig =A0 =A0 =A0| =A0 =A04 ++
=A0arch/powerpc/sysdev/Makefile =A0 =A0 | =A0 =A01 +
=A0arch/powerpc/sysdev/virtex_pci.c | =A0 99 ++++++++++++++++++++++++++++++=
++++++++
=A03 files changed, 104 insertions(+), 0 deletions(-)
=A0create mode 100644 arch/powerpc/sysdev/virtex_pci.c

diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
index 3965828..2d0be14 100644
--- a/arch/powerpc/sysdev/Kconfig
+++ b/arch/powerpc/sysdev/Kconfig
@@ -12,3 +12,7 @@ config PPC_MSI_BITMAP
=A0 =A0 =A0 =A0depends on PCI_MSI
=A0 =A0 =A0 =A0default y if MPIC
=A0 =A0 =A0 =A0default y if FSL_PCI
+
+config XILINX_VIRTEX_PCI
+ =A0 =A0 =A0 bool
+ =A0 =A0 =A0 depends on PCI
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index b33b28a..b93794e 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_IPIC) =A0 =A0 =A0 =A0 =A0 =A0+=3D ipic.o
=A0obj-$(CONFIG_4xx) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D uic.o
=A0obj-$(CONFIG_4xx_SOC) =A0 =A0 =A0 =A0 =A0+=3D ppc4xx_soc.o
=A0obj-$(CONFIG_XILINX_VIRTEX) =A0 =A0+=3D xilinx_intc.o
+obj-$(CONFIG_XILINX_VIRTEX_PCI) =A0 =A0 =A0 =A0+=3D virtex_pci.o
=A0obj-$(CONFIG_OF_RTC) =A0 =A0 =A0 =A0 =A0 +=3D of_rtc.o
=A0ifeq ($(CONFIG_PCI),y)
=A0obj-$(CONFIG_4xx) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D ppc4xx_pci.o
diff --git a/arch/powerpc/sysdev/virtex_pci.c b/arch/powerpc/sysdev/virtex_=
pci.c
new file mode 100644
index 0000000..b5137b5
--- /dev/null
+++ b/arch/powerpc/sysdev/virtex_pci.c
@@ -0,0 +1,99 @@
+/*
+ * PCI support for Xilinx plbv46_pci soft-core which can be used on
+ * Xilinx Virtex ML410 / ML510 boards.
+ *
+ * Copyright 2009 Roderick Colenbrander
+ *
+ * The pci bridge fixup code was copied from ppc4xx_pci.c and was written
+ * by Benjamin Herrenschmidt.
+ * Copyright 2007 Ben. Herrenschmidt <benh@kernel.crashing.org>, IBM Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/pci.h>
+#include <mm/mmu_decl.h>
+#include <asm/io.h>
+
+#define XPLB_PCI_ADDR 0x10c
+#define XPLB_PCI_DATA 0x110
+#define XPLB_PCI_BUS =A00x114
+
+#define PCI_HOST_ENABLE_CMD PCI_COMMAND_SERR | PCI_COMMAND_PARITY |
PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY
+
+static void fixup_virtex_pci_bridge(struct pci_dev *dev)
+{
+ =A0 =A0 =A0 struct pci_controller *hose;
+ =A0 =A0 =A0 int i;
+
+ =A0 =A0 =A0 if (dev->devfn || dev->bus->self)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
+
+ =A0 =A0 =A0 hose =3D pci_bus_to_host(dev->bus);
+ =A0 =A0 =A0 if (!hose)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
+
+ =A0 =A0 =A0 if(!of_device_is_compatible(hose->dn, "xlnx,plbv46-pci-1.03.a=
"))
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
+
+ =A0 =A0 =A0 /* Hide the PCI host BARs from the kernel as their content do=
esn't
+ =A0 =A0 =A0 =A0* fit well in the resource management
+ =A0 =A0 =A0 =A0*/
+ =A0 =A0 =A0 for (i =3D 0; i < DEVICE_COUNT_RESOURCE; i++)
+ =A0 =A0 =A0 {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->resource[i].start =3D 0;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->resource[i].end =3D 0;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->resource[i].flags =3D 0;
+ =A0 =A0 =A0 }
+
+ =A0 =A0 =A0 dev_info(&dev->dev, "PCI: Hiding Xilinx plb-pci host bridge
resources %s\n", pci_name(dev));
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, fixup_virtex_pci_bridge);
+
+void virtex_pci_init(void)
+{
+ =A0 =A0 =A0 struct pci_controller *hose;
+ =A0 =A0 =A0 struct resource r;
+ =A0 =A0 =A0 void __iomem *pci_reg;
+ =A0 =A0 =A0 struct device_node *pci_node =3D of_find_compatible_node(NULL=
,
NULL, "xlnx,plbv46-pci-1.03.a");
+
+ =A0 =A0 =A0 if(!pci_node)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
+
+ =A0 =A0 =A0 printk("Found a Xilinx plb-pci host bridge\n");
+
+ =A0 =A0 =A0 if(of_address_to_resource(pci_node, 0, &r))
+ =A0 =A0 =A0 {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("No address for Xilinx plb-pci host br=
idge\n");
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
+ =A0 =A0 =A0 }
+
+ =A0 =A0 =A0 hose =3D pcibios_alloc_controller(pci_node);
+ =A0 =A0 =A0 if (!hose)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
+
+ =A0 =A0 =A0 hose->first_busno =3D 0;
+ =A0 =A0 =A0 hose->last_busno =3D 0;
+
+ =A0 =A0 =A0 /* Setup config space */
+ =A0 =A0 =A0 setup_indirect_pci(hose, r.start + XPLB_PCI_ADDR, r.start +
XPLB_PCI_DATA, PPC_INDIRECT_TYPE_SET_CFG_TYPE);
+
+ =A0 =A0 =A0 /* According to the xilinx plbv46_pci documentation the soft-=
core starts
+ =A0 =A0 =A0 =A0* a self-init when the bus master enable bit is set. Witho=
ut this bit
+ =A0 =A0 =A0 =A0* set the pci bus can't be scanned.
+ =A0 =A0 =A0 =A0*/
+ =A0 =A0 =A0 early_write_config_word(hose, 0, 0, PCI_COMMAND, PCI_HOST_ENA=
BLE_CMD);
+
+ =A0 =A0 =A0 /* Set the max latency timer to 255 */
+ =A0 =A0 =A0 early_write_config_byte(hose, 0, 0, PCI_LATENCY_TIMER, 0xff);
+
+ =A0 =A0 =A0 /* Set the max bus number to 255 */
+ =A0 =A0 =A0 pci_reg =3D of_iomap(pci_node, 0);
+ =A0 =A0 =A0 out_8(pci_reg + XPLB_PCI_BUS, 0xff);
+ =A0 =A0 =A0 iounmap(pci_reg);
+
+ =A0 =A0 =A0 /* Register the host bridge with the linux kernel! */
+ =A0 =A0 =A0 pci_process_bridge_OF_ranges(hose, pci_node, 1);
+}
--
1.5.6.3



_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
