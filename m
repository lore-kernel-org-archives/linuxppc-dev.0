Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by ozlabs.org (Postfix) with ESMTP id CB491DE064
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 02:31:27 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id j37so285805waf.9
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 09:31:26 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v4 3/3] powerpc/virtex: Add Xilinx ML510 reference design
	support
To: linuxppc-dev@ozlabs.org, Roderick Colenbrander <thunderbird2k@gmail.com>
Date: Thu, 21 May 2009 10:24:34 -0600
Message-ID: <20090521162434.10880.62883.stgit@localhost.localdomain>
In-Reply-To: <20090521162202.10880.34056.stgit@localhost.localdomain>
References: <20090521162202.10880.34056.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Roderick Colenbrander <thunderbird2k@gmail.com>

Signed-off-by: Roderick Colenbrander <thunderbird2k@gmail.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/44x/Kconfig        |   10 +++++++++-
 arch/powerpc/platforms/44x/Makefile       |    1 +
 arch/powerpc/platforms/44x/virtex_ml510.c |   29 +++++++++++++++++++++++++++++
 arch/powerpc/sysdev/xilinx_intc.c         |    5 +++++
 4 files changed, 44 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/platforms/44x/virtex_ml510.c


diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 0d83a6a..af1c51d 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -156,7 +156,7 @@ config YOSEMITE
 #	  This option enables support for the IBM PPC440GX evaluation board.
 
 config XILINX_VIRTEX440_GENERIC_BOARD
-	bool "Generic Xilinx Virtex 440 board"
+	bool "Xilinx Virtex 5 support"
 	depends on 44x
 	default n
 	select XILINX_VIRTEX_5_FXT
@@ -171,6 +171,14 @@ config XILINX_VIRTEX440_GENERIC_BOARD
 	  Most Virtex 5 designs should use this unless it needs to do some
 	  special configuration at board probe time.
 
+config XILINX_ML510
+	bool "Xilinx ML510 board support"
+	depends on XILINX_VIRTEX440_GENERIC_BOARD
+	select PPC_PCI_CHOICE
+	select XILINX_PCI if PCI
+	select PPC_INDIRECT_PCI if PCI
+	select PPC_I8259 if PCI
+
 config PPC44x_SIMPLE
 	bool "Simple PowerPC 44x board support"
 	depends on 44x
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index 01f51da..ee6185a 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_EBONY)	+= ebony.o
 obj-$(CONFIG_SAM440EP) 	+= sam440ep.o
 obj-$(CONFIG_WARP)	+= warp.o
 obj-$(CONFIG_XILINX_VIRTEX_5_FXT) += virtex.o
+obj-$(CONFIG_XILINX_ML510) += virtex_ml510.o
diff --git a/arch/powerpc/platforms/44x/virtex_ml510.c b/arch/powerpc/platforms/44x/virtex_ml510.c
new file mode 100644
index 0000000..ba4a6e3
--- /dev/null
+++ b/arch/powerpc/platforms/44x/virtex_ml510.c
@@ -0,0 +1,29 @@
+#include <asm/i8259.h>
+#include <linux/pci.h>
+#include "44x.h"
+
+/**
+ * ml510_ail_quirk
+ */
+static void __devinit ml510_ali_quirk(struct pci_dev *dev)
+{
+	/* Enable the IDE controller */
+	pci_write_config_byte(dev, 0x58, 0x4c);
+	/* Assign irq 14 to the primary ide channel */
+	pci_write_config_byte(dev, 0x44, 0x0d);
+	/* Assign irq 15 to the secondary ide channel */
+	pci_write_config_byte(dev, 0x75, 0x0f);
+	/* Set the ide controller in native mode */
+	pci_write_config_byte(dev, 0x09, 0xff);
+
+	/* INTB = disabled, INTA = disabled */
+	pci_write_config_byte(dev, 0x48, 0x00);
+	/* INTD = disabled, INTC = disabled */
+	pci_write_config_byte(dev, 0x4a, 0x00);
+	/* Audio = INT7, Modem = disabled. */
+	pci_write_config_byte(dev, 0x4b, 0x60);
+	/* USB = INT7 */
+	pci_write_config_byte(dev, 0x74, 0x06);
+}
+DECLARE_PCI_FIXUP_EARLY(0x10b9, 0x1533, ml510_ali_quirk);
+
diff --git a/arch/powerpc/sysdev/xilinx_intc.c b/arch/powerpc/sysdev/xilinx_intc.c
index 90b5772..3ee1fd3 100644
--- a/arch/powerpc/sysdev/xilinx_intc.c
+++ b/arch/powerpc/sysdev/xilinx_intc.c
@@ -257,6 +257,11 @@ static void __init xilinx_i8259_setup_cascade(void)
 	i8259_init(cascade_node, 0);
 	set_irq_chained_handler(cascade_irq, xilinx_i8259_cascade);
 
+	/* Program irq 7 (usb/audio), 14/15 (ide) to level sensitive */
+	/* This looks like a dirty hack to me --gcl */
+	outb(0xc0, 0x4d0);
+	outb(0xc0, 0x4d1);
+
  out:
 	of_node_put(cascade_node);
 }
