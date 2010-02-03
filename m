Return-Path: <albert_herranz@yahoo.es>
Received: from smtp133.mail.ukl.yahoo.com (smtp133.mail.ukl.yahoo.com
	[77.238.184.64]) by ozlabs.org (Postfix) with SMTP id 1EE5EB7EE1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  4 Feb 2010 05:31:02 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linux-usb@vger.kernel.org
Subject: [RFC PATCH 1/2] USB: add HCD_BOUNCE_BUFFERS host controller driver
	flag
Date: Wed,  3 Feb 2010 19:30:39 +0100
Message-Id: <1265221840-25634-2-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1265221840-25634-1-git-send-email-albert_herranz@yahoo.es>
References: <1265221840-25634-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The HCD_BOUNCE_BUFFERS USB host controller driver flag can be enabled
to instruct the USB stack to always bounce USB buffers to/from coherent
memory buffers _just_ before/after a host controller transmission.

This setting allows overcoming some platform-specific limitations.

For example, the Nintendo Wii video game console is a NOT_COHERENT_CACHE
platform that is unable to safely perform non-32 bit uncached writes
to RAM because the byte enables are not connected to the bus.
Thus, in that platform, "coherent" DMA buffers cannot be directly used
by the kernel code unless it guarantees that all write accesses
to said buffers are done in 32 bit chunks (which is not the case in the
USB subsystem).

To avoid this unwanted behaviour HCD_BOUNCE_BUFFERS can be enabled at
the HCD controller, causing buffer allocations to be satisfied from
normal memory and, only at the very last moment, before the actual
transfer, buffers get copied to/from their corresponding DMA coherent
bounce buffers.

Note that HCD_LOCAL_MEM doesn't help in solving this problem as in that
case buffers may be allocated from coherent memory in the first place
and thus potentially accessed in non-32 bit chuncks by USB drivers.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 drivers/usb/core/hcd.c |  337 +++++++++++++++++++++++++++++++++++++++--------
 drivers/usb/core/hcd.h |   13 +-
 2 files changed, 286 insertions(+), 64 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 80995ef..befca85 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1260,6 +1260,173 @@ static void hcd_free_coherent(struct usb_bus *bus, dma_addr_t *dma_handle,
 	*dma_handle = 0;
 }
 
+/*
+ * The HCD_BOUNCE_BUFFERS USB host controller driver flag can be enabled
+ * to instruct the USB stack to always bounce USB buffers to/from coherent
+ * memory buffers _just_ before/after a host controller transmission.
+ *
+ * This setting allows overcoming some platform-specific limitations.
+ *
+ * For example, the Nintendo Wii video game console is a NOT_COHERENT_CACHE
+ * platform that is unable to safely perform non-32 bit uncached writes
+ * to RAM because the byte enables are not connected to the bus.
+ * Thus, in that platform, "coherent" DMA buffers cannot be directly used
+ * by the kernel code unless it guarantees that all write accesses
+ * to said buffers are done in 32 bit chunks (which is not the case in the
+ * USB subsystem).
+ *
+ * To avoid this unwanted behaviour HCD_BOUNCE_BUFFERS can be enabled at
+ * the HCD controller, causing buffer allocations to be satisfied from
+ * normal memory and, only at the very last moment, before the actual
+ * transfer, buffers get copied to/from their corresponding DMA coherent
+ * bounce buffers.
+ *
+ * Note that HCD_LOCAL_MEM doesn't help in solving this problem as in that
+ * case buffers may be allocated from coherent memory in the first place
+ * and thus potentially accessed in non-32 bit chuncks by USB drivers.
+ *
+ */
+
+#define HCD_BOUNCE_ALIGN	4
+
+#define hcd_align_up(addr, size)	(((addr)+((size)-1))&(~((size)-1)))
+
+struct hcd_coherent_buffer_ctx {
+	unsigned char *vaddr;
+	dma_addr_t dma_handle;
+};
+
+/**
+ * hcd_memcpy32_to_coherent - copy data to a bounce buffer
+ * @dst: destination dma bounce buffer
+ * @src: source buffer
+ * @len: number of bytes to copy
+ *
+ * This function copies @len bytes from @src to @dst in 32 bit chunks.
+ * The caller must guarantee that @dst length is 4 byte aligned and
+ * that @dst length is greater than or equal to @src length.
+ */
+static void *hcd_memcpy32_to_coherent(void *dst, const void *src, size_t len)
+{
+	u32 *q = dst, *p = (void *)src;
+	u8 *s;
+
+	while (len >= 4) {
+		*q++ = *p++;
+		len -= 4;
+	}
+	s = (u8 *)p;
+	switch (len) {
+	case 3:
+		*q = s[0] << 24 | s[1] << 16 | s[2] << 8;
+		break;
+	case 2:
+		*q = s[0] << 24 | s[1] << 16;
+		break;
+	case 1:
+		*q = s[0] << 24;
+		break;
+	default:
+		break;
+	}
+	return dst;
+}
+
+/**
+ * hcd_memcpy32_from_coherent - copy data from a bounce buffer
+ * @dst: destination buffer
+ * @src: source dma bounce buffer
+ * @len: number of bytes to copy
+ *
+ * This function copies @len bytes from @src to @dst in 32 bit chunks.
+ * The caller must guarantee that @src length is 4 byte aligned and
+ * that @src length is greater than or equal to @dst length.
+ */
+static void *hcd_memcpy32_from_coherent(void *dst, const void *src, size_t len)
+{
+	u32 *q = dst, *p = (void *)src;
+	u32 v;
+	u8 *d;
+
+	while (len >= 4) {
+		*q++ = *p++;
+		len -= 4;
+	}
+	if (len) {
+		d = (u8 *)q;
+		v = p[0];
+		switch (len) {
+		case 3:
+			d[2] = (v >> 8) & 0xff;
+			/* FALL THROUGH */
+		case 2:
+			d[1] = (v >> 16) & 0xff;
+			/* FALL THROUGH */
+		case 1:
+			d[0] = (v >> 24) & 0xff;
+			break;
+		default:
+			break;
+		}
+	}
+	return dst;
+}
+
+static int hcd_bounce_to_coherent(struct device *dev,
+				  gfp_t mem_flags, dma_addr_t *dma_handle,
+				  void **vaddr_handle, size_t size,
+				  enum dma_data_direction dir)
+{
+	struct hcd_coherent_buffer_ctx ctx;
+	unsigned char *vaddr;
+	size_t up_size = hcd_align_up(size + sizeof(ctx), HCD_BOUNCE_ALIGN);
+
+	BUILD_BUG_ON(sizeof(ctx) & (HCD_BOUNCE_ALIGN-1));
+
+	if (!*vaddr_handle) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	ctx.vaddr = *vaddr_handle;
+	ctx.dma_handle = *dma_handle;
+
+	vaddr = dma_alloc_coherent(dev, up_size, dma_handle, mem_flags);
+	if (!vaddr)
+		return -ENOMEM;
+
+	hcd_memcpy32_to_coherent(vaddr + up_size - sizeof(ctx), &ctx,
+				 sizeof(ctx));
+	if (dir == DMA_TO_DEVICE)
+		hcd_memcpy32_to_coherent(vaddr, *vaddr_handle, size);
+
+	*vaddr_handle = vaddr;
+	return 0;
+}
+
+static void hcd_bounce_from_coherent(struct device *dev, dma_addr_t *dma_handle,
+				     void **vaddr_handle, size_t size,
+				     enum dma_data_direction dir)
+{
+	struct hcd_coherent_buffer_ctx ctx;
+	unsigned char *vaddr = *vaddr_handle;
+	size_t up_size = hcd_align_up(size + sizeof(ctx), HCD_BOUNCE_ALIGN);
+
+	if (!*vaddr_handle)
+		return;
+
+	hcd_memcpy32_from_coherent(&ctx, vaddr + up_size - sizeof(ctx),
+				   sizeof(ctx));
+	BUG_ON(!ctx.vaddr);
+	if (dir == DMA_FROM_DEVICE)
+		hcd_memcpy32_from_coherent(ctx.vaddr, vaddr, size);
+
+	dma_free_coherent(dev, up_size, vaddr, *dma_handle);
+
+	*vaddr_handle = ctx.vaddr;
+	*dma_handle = ctx.dma_handle;
+}
+
 static int map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 			   gfp_t mem_flags)
 {
@@ -1274,53 +1441,80 @@ static int map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 	if (is_root_hub(urb->dev))
 		return 0;
 
-	if (usb_endpoint_xfer_control(&urb->ep->desc)
-	    && !(urb->transfer_flags & URB_NO_SETUP_DMA_MAP)) {
-		if (hcd->self.uses_dma) {
-			urb->setup_dma = dma_map_single(
-					hcd->self.controller,
-					urb->setup_packet,
-					sizeof(struct usb_ctrlrequest),
-					DMA_TO_DEVICE);
-			if (dma_mapping_error(hcd->self.controller,
-						urb->setup_dma))
-				return -EAGAIN;
-		} else if (hcd->driver->flags & HCD_LOCAL_MEM)
-			ret = hcd_alloc_coherent(
-					urb->dev->bus, mem_flags,
+	if (usb_endpoint_xfer_control(&urb->ep->desc)) {
+		if (hcd->driver->flags & HCD_BOUNCE_BUFFERS) {
+			if (!(urb->transfer_flags & URB_NO_SETUP_DMA_MAP))
+				urb->setup_dma = 0;
+			ret = hcd_bounce_to_coherent(
+					hcd->self.controller, mem_flags,
 					&urb->setup_dma,
 					(void **)&urb->setup_packet,
 					sizeof(struct usb_ctrlrequest),
 					DMA_TO_DEVICE);
+		} else if (!(urb->transfer_flags & URB_NO_SETUP_DMA_MAP)) {
+			if (hcd->self.uses_dma) {
+				urb->setup_dma = dma_map_single(
+						hcd->self.controller,
+						urb->setup_packet,
+						sizeof(struct usb_ctrlrequest),
+						DMA_TO_DEVICE);
+				if (dma_mapping_error(hcd->self.controller,
+						      urb->setup_dma))
+					return -EAGAIN;
+			} else if (hcd->driver->flags & HCD_LOCAL_MEM)
+				ret = hcd_alloc_coherent(
+						urb->dev->bus, mem_flags,
+						&urb->setup_dma,
+						(void **)&urb->setup_packet,
+						sizeof(struct usb_ctrlrequest),
+						DMA_TO_DEVICE);
+		}
 	}
 
 	dir = usb_urb_dir_in(urb) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
-	if (ret == 0 && urb->transfer_buffer_length != 0
-	    && !(urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP)) {
-		if (hcd->self.uses_dma) {
-			urb->transfer_dma = dma_map_single (
-					hcd->self.controller,
-					urb->transfer_buffer,
-					urb->transfer_buffer_length,
-					dir);
-			if (dma_mapping_error(hcd->self.controller,
-						urb->transfer_dma))
-				return -EAGAIN;
-		} else if (hcd->driver->flags & HCD_LOCAL_MEM) {
-			ret = hcd_alloc_coherent(
-					urb->dev->bus, mem_flags,
+	if (ret == 0 && urb->transfer_buffer_length != 0) {
+		if (hcd->driver->flags & HCD_BOUNCE_BUFFERS) {
+			if (!(urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP))
+				urb->transfer_dma = 0;
+			ret = hcd_bounce_to_coherent(
+					hcd->self.controller, mem_flags,
 					&urb->transfer_dma,
 					&urb->transfer_buffer,
 					urb->transfer_buffer_length,
 					dir);
 
-			if (ret && usb_endpoint_xfer_control(&urb->ep->desc)
-			    && !(urb->transfer_flags & URB_NO_SETUP_DMA_MAP))
-				hcd_free_coherent(urb->dev->bus,
-					&urb->setup_dma,
-					(void **)&urb->setup_packet,
-					sizeof(struct usb_ctrlrequest),
-					DMA_TO_DEVICE);
+			if (ret && usb_endpoint_xfer_control(&urb->ep->desc))
+				hcd_bounce_from_coherent(hcd->self.controller,
+						&urb->setup_dma,
+						(void **)&urb->setup_packet,
+						sizeof(struct usb_ctrlrequest),
+						DMA_TO_DEVICE);
+		} else if (!(urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP)) {
+			if (hcd->self.uses_dma) {
+				urb->transfer_dma = dma_map_single(
+						hcd->self.controller,
+						urb->transfer_buffer,
+						urb->transfer_buffer_length,
+						dir);
+				if (dma_mapping_error(hcd->self.controller,
+						      urb->transfer_dma))
+					return -EAGAIN;
+			} else if (hcd->driver->flags & HCD_LOCAL_MEM) {
+				ret = hcd_alloc_coherent(
+						urb->dev->bus, mem_flags,
+						&urb->transfer_dma,
+						&urb->transfer_buffer,
+						urb->transfer_buffer_length,
+						dir);
+
+				if (ret &&
+				    usb_endpoint_xfer_control(&urb->ep->desc))
+					hcd_free_coherent(urb->dev->bus,
+						&urb->setup_dma,
+						(void **)&urb->setup_packet,
+						sizeof(struct usb_ctrlrequest),
+						DMA_TO_DEVICE);
+			}
 		}
 	}
 	return ret;
@@ -1333,32 +1527,49 @@ static void unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
 	if (is_root_hub(urb->dev))
 		return;
 
-	if (usb_endpoint_xfer_control(&urb->ep->desc)
-	    && !(urb->transfer_flags & URB_NO_SETUP_DMA_MAP)) {
-		if (hcd->self.uses_dma)
-			dma_unmap_single(hcd->self.controller, urb->setup_dma,
-					sizeof(struct usb_ctrlrequest),
-					DMA_TO_DEVICE);
-		else if (hcd->driver->flags & HCD_LOCAL_MEM)
-			hcd_free_coherent(urb->dev->bus, &urb->setup_dma,
-					(void **)&urb->setup_packet,
-					sizeof(struct usb_ctrlrequest),
-					DMA_TO_DEVICE);
+	if (usb_endpoint_xfer_control(&urb->ep->desc)) {
+		if (hcd->driver->flags & HCD_BOUNCE_BUFFERS)
+			hcd_bounce_from_coherent(hcd->self.controller,
+						&urb->setup_dma,
+						(void **)&urb->setup_packet,
+						sizeof(struct usb_ctrlrequest),
+						DMA_TO_DEVICE);
+		else if (!(urb->transfer_flags & URB_NO_SETUP_DMA_MAP)) {
+			if (hcd->self.uses_dma)
+				dma_unmap_single(hcd->self.controller,
+						 urb->setup_dma,
+						 sizeof(struct usb_ctrlrequest),
+						 DMA_TO_DEVICE);
+			else if (hcd->driver->flags & HCD_LOCAL_MEM)
+				hcd_free_coherent(urb->dev->bus,
+						&urb->setup_dma,
+						(void **)&urb->setup_packet,
+						sizeof(struct usb_ctrlrequest),
+						DMA_TO_DEVICE);
+		}
 	}
 
 	dir = usb_urb_dir_in(urb) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
-	if (urb->transfer_buffer_length != 0
-	    && !(urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP)) {
-		if (hcd->self.uses_dma)
-			dma_unmap_single(hcd->self.controller,
-					urb->transfer_dma,
-					urb->transfer_buffer_length,
-					dir);
-		else if (hcd->driver->flags & HCD_LOCAL_MEM)
-			hcd_free_coherent(urb->dev->bus, &urb->transfer_dma,
-					&urb->transfer_buffer,
-					urb->transfer_buffer_length,
-					dir);
+	if (urb->transfer_buffer_length != 0) {
+		if (hcd->driver->flags & HCD_BOUNCE_BUFFERS)
+			hcd_bounce_from_coherent(hcd->self.controller,
+						&urb->transfer_dma,
+						&urb->transfer_buffer,
+						urb->transfer_buffer_length,
+						dir);
+		else if (!(urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP)) {
+			if (hcd->self.uses_dma)
+				dma_unmap_single(hcd->self.controller,
+						urb->transfer_dma,
+						urb->transfer_buffer_length,
+						dir);
+			else if (hcd->driver->flags & HCD_LOCAL_MEM)
+				hcd_free_coherent(urb->dev->bus,
+						&urb->transfer_dma,
+						&urb->transfer_buffer,
+						urb->transfer_buffer_length,
+						dir);
+		}
 	}
 }
 
@@ -2022,6 +2233,16 @@ struct usb_hcd *usb_create_hcd (const struct hc_driver *driver,
 	dev_set_drvdata(dev, hcd);
 	kref_init(&hcd->kref);
 
+	if (driver->flags & HCD_BOUNCE_BUFFERS) {
+		/*
+		 * This will force allocation of HCD buffers in normal kernel
+		 * memory via kmalloc().
+		 * Note that this is fine as we always bounce them later
+		 * to coherent memory.
+		 */
+		dev->dma_mask = NULL;
+	}
+
 	usb_bus_init(&hcd->self);
 	hcd->self.controller = dev;
 	hcd->self.bus_name = bus_name;
diff --git a/drivers/usb/core/hcd.h b/drivers/usb/core/hcd.h
index bbe2b92..e0b8179 100644
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
+#define HCD_BOUNCE_BUFFERS	0x0004	/* HC needs to bounce buffers */
+#define	HCD_USB11		0x0010	/* USB 1.1 */
+#define	HCD_USB2		0x0020	/* USB 2.0 */
+#define	HCD_USB3		0x0040	/* USB 3.0 */
+#define	HCD_MASK		0x0070
 
 	/* called to init HCD and root hub */
 	int	(*reset) (struct usb_hcd *hcd);
-- 
1.6.3.3
