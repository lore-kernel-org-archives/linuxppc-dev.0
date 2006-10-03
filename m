Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp13.orange.fr (smtp13.orange.fr [193.252.22.54])
	by ozlabs.org (Postfix) with ESMTP id 5260167C03
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 23:46:59 +1000 (EST)
Received: from smtp-msa-out13.orange.fr (mwinf1303 [172.22.144.25])
	by mwinf1305.orange.fr (SMTP Server) with ESMTP id 5CF111C0BBA1
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 14:35:48 +0200 (CEST)
Date: Tue, 3 Oct 2006 14:33:03 +0200
To: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] mv643xx_eth_pcidev : implement hotplug by matching the
	Discovery II/III northbridge pci id (Was: +
	mv643xx_eth_pcidev-implements-hotplug-for-the-marvell-gige-functionality-by-probing-the-northbridge-pci-id.patch
	added to -mm tree)
Message-ID: <20061003123303.GB23670@powerlinux.fr>
References: <200510250811.j9P8B7db002405@shell0.pdx.osdl.net>
	<20060919151611.GA15580@powerlinux.fr>
	<20060919093410.e454e465.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060919093410.e454e465.akpm@osdl.org>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Sven Luther <sl@bplan-gmbh.de>
Reply-To: Sven Luther <sl@bplan-gmbh.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Sven Luther <sl@bplan-gmbh.de>

Match the Marvell Discovery II/III northbridge pci id to add hotplug
support for the builtin gigabit ethernet driver (mv643xx_eth).

Signed-off-by: Sven Luther <sl@bplan-gmbh.de>

---

On Tue, Sep 19, 2006 at 09:34:10AM -0700, Andrew Morton wrote:
> On Tue, 19 Sep 2006 17:16:11 +0200
> Sven Luther <sven.luther@wanadoo.fr> wrote:
> 
> > I was wondering if you still had this patch in your tree, and what its status
> > for upstream inclusion where ? 
> 
> It's in Jeff's net driver tree and I assume he plans on merging it into 2.6.19.

Since i couldn't find any trace of this patch either in the -mm tree or the
-netdev one, i am now resubmitting a cleaned up version of this patch.

The patch was originally submitted on october 25 2005, and signed off by :

Signed-off-by: Nicolas DET <det.nicolas@free.fr>
Signed-off-by: Sven Luther <sl@bplan-gmbh.de>
Cc: Jeff Garzik <jgarzik@pobox.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>

Altough the proper solution to this issue would be to add hotplug support to
the plateform devices through the OF device tree, no support for this has been
added since last year, and with most major distribution having switched to
using udev or something similar, it is important to have a solution for
autoloading this driver. This patch has been in activity in the debian
distribution since last year, and it is possible other distributions use it as
well.

So, i wonder if it would be possible to still add it to 2.6.19, even though
the official schedule is closed, or if not, to add it for 2.6.20 ? 

Friendly,

Sven Luther

--- linux/drivers/net/mv643xx_eth.c.orig	2006-10-03 14:21:33.000000000 +0200
+++ linux/drivers/net/mv643xx_eth.c	2006-10-03 14:23:54.000000000 +0200
@@ -43,6 +43,8 @@
 #include <linux/ethtool.h>
 #include <linux/platform_device.h>
 
+#include <linux/pci.h>
+
 #include <asm/io.h>
 #include <asm/types.h>
 #include <asm/pgtable.h>
@@ -1563,6 +1565,15 @@
 		" and Dale Farnsworth");
 MODULE_DESCRIPTION("Ethernet driver for Marvell MV643XX");
 
+static struct pci_device_id pci_marvell_mv64360[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, PCI_DEVICE_ID_MARVELL_MV64360) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, PCI_DEVICE_ID_MARVELL_MV64460) },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(pci, pci_marvell_mv64360);
+
+
 /*
  * The second part is the low level driver of the gigE ethernet ports.
  */
