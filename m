Return-Path: <albert_herranz@yahoo.es>
Received: from smtp138.mail.ukl.yahoo.com (smtp138.mail.ukl.yahoo.com
	[77.238.184.69]) by ozlabs.org (Postfix) with SMTP id E3B1FB7E93
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Mar 2010 01:08:30 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-usb@vger.kernel.org
Subject: [RFC PATCH v2 8/9] USB: add HCD_NO_COHERENT_MEM host controller
	driver flag
Date: Sun, 28 Feb 2010 15:08:01 +0100
Message-Id: <1267366082-15248-9-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1267366082-15248-1-git-send-email-albert_herranz@yahoo.es>
References: <1267366082-15248-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The HCD_NO_COHERENT_MEM USB host controller driver flag can be enabled
to instruct the USB stack to avoid allocating coherent memory for USB
buffers.

This flag is useful to overcome some esoteric memory access restrictions
found in some platforms.
For example, the Nintendo Wii video game console is a NOT_COHERENT_CACHE
platform that is unable to safely perform non-32 bit uncached writes
to RAM because the byte enables are not connected to the bus.
Thus, in that platform, "coherent" DMA buffers cannot be directly used
by the kernel code unless it guarantees that all write accesses
to said buffers are done in 32 bit chunks (which is not the case in the
USB subsystem).

To avoid this unwanted behaviour HCD_NO_COHERENT_MEM can be enabled at
the HCD controller, causing USB buffer allocations to be satisfied from
normal kernel memory. In this case, the USB stack will make sure that
the buffers get properly mapped/unmapped for DMA transfers using the DMA
streaming mapping API.

Note that other parts of the USB stack may also use coherent memory,
like for example the hardware descriptors used in the EHCI controllers.
This needs to be checked and addressed separately. In the EHCI example,
hardware descriptors are accessed in 32-bit (or 64-bit) chunks, causing
no problems in the described scenario.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 drivers/usb/core/buffer.c |   15 ++++++++-----
 drivers/usb/core/hcd.c    |   50 +++++++++++++++++++++++++++++++++++++-------
 drivers/usb/core/hcd.h    |   13 ++++++-----
 3 files changed, 58 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index 3ba2fff..fede7a0 100644
--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -53,8 +53,9 @@ int hcd_buffer_create(struct usb_hcd *hcd)
 	char		name[16];
 	int 		i, size;
 
-	if (!hcd->self.controller->dma_mask &&
-	    !(hcd->driver->flags & HCD_LOCAL_MEM))
+	if ((!hcd->self.controller->dma_mask &&
+	    !(hcd->driver->flags & HCD_LOCAL_MEM)) ||
+	    (hcd->driver->flags & HCD_NO_COHERENT_MEM))
 		return 0;
 
 	for (i = 0; i < HCD_BUFFER_POOLS; i++) {
@@ -109,8 +110,9 @@ void *hcd_buffer_alloc(
 	int 			i;
 
 	/* some USB hosts just use PIO */
-	if (!bus->controller->dma_mask &&
-	    !(hcd->driver->flags & HCD_LOCAL_MEM)) {
+	if ((!bus->controller->dma_mask &&
+	    !(hcd->driver->flags & HCD_LOCAL_MEM)) ||
+	    (hcd->driver->flags & HCD_NO_COHERENT_MEM)) {
 		*dma = ~(dma_addr_t) 0;
 		return kmalloc(size, mem_flags);
 	}
@@ -135,8 +137,9 @@ void hcd_buffer_free(
 	if (!addr)
 		return;
 
-	if (!bus->controller->dma_mask &&
-	    !(hcd->driver->flags & HCD_LOCAL_MEM)) {
+	if ((!bus->controller->dma_mask &&
+	    !(hcd->driver->flags & HCD_LOCAL_MEM)) ||
+	    (hcd->driver->flags & HCD_NO_COHERENT_MEM)) {
 		kfree(addr);
 		return;
 	}
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 80995ef..c2596c5 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1260,6 +1260,34 @@ static void hcd_free_coherent(struct usb_bus *bus, dma_addr_t *dma_handle,
 	*dma_handle = 0;
 }
 
+static int urb_needs_setup_dma_map(struct usb_hcd *hcd, struct urb *urb)
+{
+	return !(urb->transfer_flags & URB_NO_SETUP_DMA_MAP) ||
+	       ((hcd->driver->flags & HCD_NO_COHERENT_MEM) &&
+		urb->setup_dma == ~(dma_addr_t)0);
+}
+
+static int urb_needs_setup_dma_unmap(struct usb_hcd *hcd, struct urb *urb)
+{
+	return !(urb->transfer_flags & URB_NO_SETUP_DMA_MAP) ||
+	       ((hcd->driver->flags & HCD_NO_COHERENT_MEM) &&
+		urb->setup_dma && urb->setup_dma != ~(dma_addr_t)0);
+}
+
+static int urb_needs_transfer_dma_map(struct usb_hcd *hcd, struct urb *urb)
+{
+	return !(urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP) ||
+	       ((hcd->driver->flags & HCD_NO_COHERENT_MEM) &&
+		urb->transfer_dma == ~(dma_addr_t)0);
+}
+
+static int urb_needs_transfer_dma_unmap(struct usb_hcd *hcd, struct urb *urb)
+{
+	return !(urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP) ||
+	       ((hcd->driver->flags & HCD_NO_COHERENT_MEM) &&
+		urb->transfer_dma && urb->transfer_dma != ~(dma_addr_t)0);
+}
+
 static int map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 			   gfp_t mem_flags)
 {
@@ -1275,7 +1303,7 @@ static int map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 		return 0;
 
 	if (usb_endpoint_xfer_control(&urb->ep->desc)
-	    && !(urb->transfer_flags & URB_NO_SETUP_DMA_MAP)) {
+	    && urb_needs_setup_dma_map(hcd, urb)) {
 		if (hcd->self.uses_dma) {
 			urb->setup_dma = dma_map_single(
 					hcd->self.controller,
@@ -1296,7 +1324,7 @@ static int map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 
 	dir = usb_urb_dir_in(urb) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
 	if (ret == 0 && urb->transfer_buffer_length != 0
-	    && !(urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP)) {
+	    && urb_needs_transfer_dma_map(hcd, urb)) {
 		if (hcd->self.uses_dma) {
 			urb->transfer_dma = dma_map_single (
 					hcd->self.controller,
@@ -1334,12 +1362,15 @@ static void unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
 		return;
 
 	if (usb_endpoint_xfer_control(&urb->ep->desc)
-	    && !(urb->transfer_flags & URB_NO_SETUP_DMA_MAP)) {
-		if (hcd->self.uses_dma)
+	    && urb_needs_setup_dma_unmap(hcd, urb)) {
+		if (hcd->self.uses_dma) {
 			dma_unmap_single(hcd->self.controller, urb->setup_dma,
 					sizeof(struct usb_ctrlrequest),
 					DMA_TO_DEVICE);
-		else if (hcd->driver->flags & HCD_LOCAL_MEM)
+			if ((hcd->driver->flags & HCD_NO_COHERENT_MEM) &&
+			    (urb->transfer_flags & URB_NO_SETUP_DMA_MAP))
+				urb->setup_dma = ~(dma_addr_t)0;
+		} else if (hcd->driver->flags & HCD_LOCAL_MEM)
 			hcd_free_coherent(urb->dev->bus, &urb->setup_dma,
 					(void **)&urb->setup_packet,
 					sizeof(struct usb_ctrlrequest),
@@ -1348,13 +1379,16 @@ static void unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
 
 	dir = usb_urb_dir_in(urb) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
 	if (urb->transfer_buffer_length != 0
-	    && !(urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP)) {
-		if (hcd->self.uses_dma)
+	    && urb_needs_transfer_dma_unmap(hcd, urb)) {
+		if (hcd->self.uses_dma) {
 			dma_unmap_single(hcd->self.controller,
 					urb->transfer_dma,
 					urb->transfer_buffer_length,
 					dir);
-		else if (hcd->driver->flags & HCD_LOCAL_MEM)
+			if ((hcd->driver->flags & HCD_NO_COHERENT_MEM) &&
+			    (urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP))
+				urb->transfer_dma = ~(dma_addr_t)0;
+		} else if (hcd->driver->flags & HCD_LOCAL_MEM)
 			hcd_free_coherent(urb->dev->bus, &urb->transfer_dma,
 					&urb->transfer_buffer,
 					urb->transfer_buffer_length,
diff --git a/drivers/usb/core/hcd.h b/drivers/usb/core/hcd.h
index bbe2b92..cde42f3 100644
--- a/drivers/usb/core/hcd.h
+++ b/drivers/usb/core/hcd.h
@@ -183,12 +183,13 @@ struct hc_driver {
 	irqreturn_t	(*irq) (struct usb_hcd *hcd);
 
 	int	flags;
-#define	HCD_MEMORY	0x0001		/* HC regs use memory (else I/O) */
-#define	HCD_LOCAL_MEM	0x0002		/* HC needs local memory */
-#define	HCD_USB11	0x0010		/* USB 1.1 */
-#define	HCD_USB2	0x0020		/* USB 2.0 */
-#define	HCD_USB3	0x0040		/* USB 3.0 */
-#define	HCD_MASK	0x0070
+#define	HCD_MEMORY		0x0001	/* HC regs use memory (else I/O) */
+#define	HCD_LOCAL_MEM		0x0002	/* HC needs local memory */
+#define	HCD_NO_COHERENT_MEM	0x0004	/* HC avoids use of "coherent" mem */
+#define	HCD_USB11		0x0010	/* USB 1.1 */
+#define	HCD_USB2		0x0020	/* USB 2.0 */
+#define	HCD_USB3		0x0040	/* USB 3.0 */
+#define	HCD_MASK		0x0070
 
 	/* called to init HCD and root hub */
 	int	(*reset) (struct usb_hcd *hcd);
-- 
1.6.3.3
