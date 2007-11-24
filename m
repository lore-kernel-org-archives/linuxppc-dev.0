Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 21C26DDE45
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 11:25:32 +1100 (EST)
Received: from pd2mr6so.prod.shaw.ca (pd2mr6so-qfe3.prod.shaw.ca [10.0.141.9])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JRZ00NCXIGV4DE0@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 23 Nov 2007 17:24:31 -0700 (MST)
Received: from pn2ml2so.prod.shaw.ca ([10.0.121.146])
	by pd2mr6so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JRZ00163IGVT780@pd2mr6so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 23 Nov 2007 17:24:31 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep 5
	2006))
	with ESMTP id <0JRZ00IUIIGTA720@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 23 Nov 2007 17:24:30 -0700 (MST)
Date: Fri, 23 Nov 2007 17:24:31 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/5] USB: Make usb_hcd_irq work for multi-role USB controllers
	w/ shared irq
In-reply-to: <20071124001203.25361.99294.stgit@trillian.cg.shawcable.net>
To: linux-usb-devel@lists.sourceforge.net, akpm@osdl.org,
	dbrownell@users.sourceforge.net, gregkh@suse.de, linuxppc-dev@ozlabs.org
Message-id: <20071124002431.25361.23974.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071124001203.25361.99294.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Peter Korsgaard <peter.korsgaard@barco.com>

Some multi-role (host/peripheral) USB controllers use a shared interrupt
line for all parts of the chip. Export usb_hcd_irq so drivers can call it
from their interrupt handler instead of duplicating code.
Drivers pass an irqnum of 0 to usb_add_hcd to signal that the interrupt handler
shouldn't be registerred by the core.

Signed-off-by: Peter Korsgaard <peter.korsgaard@barco.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/usb/core/hcd.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index fea8256..6ce305c 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1562,6 +1562,7 @@ irqreturn_t usb_hcd_irq (int irq, void *__hcd)
 		usb_hc_died (hcd);
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL_GPL (usb_hcd_irq);
 
 /*-------------------------------------------------------------------------*/
 
@@ -1670,6 +1671,9 @@ EXPORT_SYMBOL (usb_put_hcd);
  * Finish the remaining parts of generic HCD initialization: allocate the
  * buffers of consistent memory, register the bus, request the IRQ line,
  * and call the driver's reset() and start() routines.
+ *
+ * If irqnum is 0, the irq will not be requested. The caller is responsible
+ * for calling usb_hcd_irq at the correct time.
  */
 int usb_add_hcd(struct usb_hcd *hcd,
 		unsigned int irqnum, unsigned long irqflags)
@@ -1723,7 +1727,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 		dev_dbg(hcd->self.controller, "supports USB remote wakeup\n");
 
 	/* enable irqs just before we start the controller */
-	if (hcd->driver->irq) {
+	if (hcd->driver->irq && irqnum) {
 		snprintf(hcd->irq_descr, sizeof(hcd->irq_descr), "%s:usb%d",
 				hcd->driver->description, hcd->self.busnum);
 		if ((retval = request_irq(irqnum, &usb_hcd_irq, irqflags,
