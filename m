Return-Path: <sshtylyov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 20363DDFBE
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Apr 2008 02:59:15 +1000 (EST)
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
To: jgarzik@pobox.com
Subject: [PATCH] natsemi: fix MMIO for PPC 44x platforms
Date: Sat, 12 Apr 2008 20:58:30 +0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804122058.31075.sshtylyov@ru.mvista.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The driver stores the PCI resource address into 'unsigned long' variable before
calling ioremap()  on it. This warrants a kernel oops when the registers are
accessed on PPC 44x platforms which (being 32-bit) have PCI memory space mapped
beyond 4 GB.

The arch/ppc/ kernel has a fixup in ioremap() that creates an illusion of the
PCI memory resources are mapped below 4 GB, but arch/powerpc/ code got rid of
this trick, having instead CONFIG_RESOURCES_64BIT enabled.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Reposting the patch with the typecast, log, and summary corrected.
This is the same issue as the one that has been recently addressed by commits
3c34ac36ac1084e571ef9b6fb1d6a5b10ccc1fd0 (e1000: Fix for 32 bits platforms with
64 bits resources) and c976816b6e901341ec3c4653147316c15549a1c4 (siimage: fix
kernel oops on PPC 44x).  The patch has only been compile tested though...

 drivers/net/natsemi.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/net/natsemi.c
===================================================================
--- linux-2.6.orig/drivers/net/natsemi.c
+++ linux-2.6/drivers/net/natsemi.c
@@ -786,7 +786,8 @@ static int __devinit natsemi_probe1 (str
 	struct netdev_private *np;
 	int i, option, irq, chip_idx = ent->driver_data;
 	static int find_cnt = -1;
-	unsigned long iostart, iosize;
+	resource_size_t iostart;
+	unsigned long iosize;
 	void __iomem *ioaddr;
 	const int pcibar = 1; /* PCI base address register */
 	int prev_eedata;
@@ -946,10 +947,11 @@ static int __devinit natsemi_probe1 (str
 		goto err_create_file;
 
 	if (netif_msg_drv(np)) {
-		printk(KERN_INFO "natsemi %s: %s at %#08lx "
+		printk(KERN_INFO "natsemi %s: %s at %#08llx "
 		       "(%s), %s, IRQ %d",
-		       dev->name, natsemi_pci_info[chip_idx].name, iostart,
-		       pci_name(np->pci_dev), print_mac(mac, dev->dev_addr), irq);
+		       dev->name, natsemi_pci_info[chip_idx].name,
+		       (unsigned long long)iostart, pci_name(np->pci_dev),
+		       print_mac(mac, dev->dev_addr), irq);
 		if (dev->if_port == PORT_TP)
 			printk(", port TP.\n");
 		else if (np->ignore_phy)
