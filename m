Return-Path: <albert_herranz@yahoo.es>
Received: from smtp134.mail.ukl.yahoo.com (smtp134.mail.ukl.yahoo.com
	[77.238.184.65]) by ozlabs.org (Postfix) with SMTP id 54728B7F5A
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Mar 2010 23:12:08 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v3 07/11] USB: add HCD_NO_COHERENT_MEM host controller
	driver flag
Date: Sun,  7 Mar 2010 13:11:48 +0100
Message-Id: <1267963912-984-8-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1267963912-984-1-git-send-email-albert_herranz@yahoo.es>
References: <1267963912-984-1-git-send-email-albert_herranz@yahoo.es>
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
 drivers/usb/core/buffer.c |   29 +++++++++++++++++++++++------
 drivers/usb/core/hcd.c    |   32 +++++++++++++++++++++++++++-----
 drivers/usb/core/hcd.h    |   13 +++++++------
 3 files changed, 57 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index 3ba2fff..10cd11d 100644
--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -36,6 +36,26 @@ static const size_t	pool_max [HCD_BUFFER_POOLS] = {
 
 /* SETUP primitives */
 
+static inline int hcd_uses_pio(struct usb_hcd *hcd)
+{
+	if ((!hcd->self.controller->dma_mask &&
+	    !(hcd->driver->flags & HCD_LOCAL_MEM)))
+		return 1;
+	return 0;
+}
+
+static inline int hcd_needs_non_dma_mem(struct usb_hcd *hcd)
+{
+	/*
+	 * PIO-based and HCD_NO_COHERENT_MEM-based controllers use
+	 * normal kernel memory.
+	 * The rest want DMA memory.
+	 */
+	if (hcd_uses_pio(hcd) || (hcd->driver->flags & HCD_NO_COHERENT_MEM))
+		return 1;
+	return 0;
+}
+
 /**
  * hcd_buffer_create - initialize buffer pools
  * @hcd: the bus whose buffer pools are to be initialized
@@ -53,8 +73,7 @@ int hcd_buffer_create(struct usb_hcd *hcd)
 	char		name[16];
 	int 		i, size;
 
-	if (!hcd->self.controller->dma_mask &&
-	    !(hcd->driver->flags & HCD_LOCAL_MEM))
+	if (hcd_needs_non_dma_mem(hcd))
 		return 0;
 
 	for (i = 0; i < HCD_BUFFER_POOLS; i++) {
@@ -109,8 +128,7 @@ void *hcd_buffer_alloc(
 	int 			i;
 
 	/* some USB hosts just use PIO */
-	if (!bus->controller->dma_mask &&
-	    !(hcd->driver->flags & HCD_LOCAL_MEM)) {
+	if (hcd_needs_non_dma_mem(hcd)) {
 		*dma = ~(dma_addr_t) 0;
 		return kmalloc(size, mem_flags);
 	}
@@ -135,8 +153,7 @@ void hcd_buffer_free(
 	if (!addr)
 		return;
 
-	if (!bus->controller->dma_mask &&
-	    !(hcd->driver->flags & HCD_LOCAL_MEM)) {
+	if (hcd_needs_non_dma_mem(hcd)) {
 		kfree(addr);
 		return;
 	}
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 44ad710..174853a 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1316,9 +1316,19 @@ static int urb_needs_setup_map(struct usb_hcd *hcd, struct urb *urb)
 	/* setup mappings are required only for control requests */
 	if (!usb_endpoint_xfer_control(&urb->ep->desc))
 		return 0;
-
-	/* If the caller set URB_NO_SETUP_DMA_MAP then no mapping is needed */
-	if ((urb->transfer_flags & URB_NO_SETUP_DMA_MAP))
+	/*
+	 * Setup packets are 8 bytes long and don't use scatter/gather.
+	 *
+	 * If the caller sets URB_NO_SETUP_DMA_MAP and urb->setup_dma
+	 * contains a valid DMA handle then it is already mapped, except
+	 * if the controller can't use coherent memory (HCD_NO_COHERENT_MEM).
+	 *
+	 * urb->setup_dma is set to ~0 when allocating USB buffers for
+	 * PIO-based or HCD_NO_COHERENT_MEM-based controllers.
+	 */
+	if ((urb->transfer_flags & URB_NO_SETUP_DMA_MAP) &&
+	    urb->setup_dma != ~(dma_addr_t)0 &&
+	    !(hcd->driver->flags & HCD_NO_COHERENT_MEM))
 		return 0;
 
 	return 1;
@@ -1330,8 +1340,20 @@ static int urb_needs_transfer_map(struct usb_hcd *hcd, struct urb *urb)
 	if (urb->transfer_buffer_length == 0)
 		return 0;
 
-	/* If the caller set URB_NO_SETUP_DMA_MAP then no mapping is needed */
-	if ((urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP))
+	/* if this is a scatter/gather request, it should be already mapped */
+	if (urb->num_sgs > 0)
+		return 0;
+	/*
+	 * If the caller sets URB_NO_TRANSFER_DMA_MAP and urb->transfer_dma
+	 * contains a valid DMA handle then it is already mapped, except
+	 * if the controller can't use coherent memory (HCD_NO_COHERENT_MEM).
+	 *
+	 * urb->transfer_dma is set to ~0 when allocating USB buffers for
+	 * PIO-based or HCD_NO_COHERENT_MEM-based controllers.
+	 */
+	if ((urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP) &&
+	    urb->transfer_dma != ~(dma_addr_t)0 &&
+	    !(hcd->driver->flags & HCD_NO_COHERENT_MEM))
 		return 0;
 
 	return 1;
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
