Return-Path: <albert_herranz@yahoo.es>
Received: from smtp134.mail.ukl.yahoo.com (smtp134.mail.ukl.yahoo.com
	[77.238.184.65]) by ozlabs.org (Postfix) with SMTP id 1DB58B7E1A
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Mar 2010 23:12:04 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v3 06/11] USB: refactor unmap_urb_for_dma/map_urb_for_dma
Date: Sun,  7 Mar 2010 13:11:47 +0100
Message-Id: <1267963912-984-7-git-send-email-albert_herranz@yahoo.es>
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

Split unmap_urb_for_dma() and map_urb_for_dma() into smaller pieces
to make the code easier to read and maintain.

This patch adds four new URB flags which are used by map_urb_for_dma()
to mark URBs with the exact method used to map the setup packet and/or the
transfer buffer.
These flags are checked too at unmap_urb_for_dma() time to determine how
to unmap the setup packet and/or the transfer buffer. The flags are cleared
when the actual unmap happens.

No functional change.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 drivers/usb/core/hcd.c |  211 +++++++++++++++++++++++++++++++-----------------
 include/linux/usb.h    |    5 +
 2 files changed, 143 insertions(+), 73 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 80995ef..44ad710 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1260,106 +1260,171 @@ static void hcd_free_coherent(struct usb_bus *bus, dma_addr_t *dma_handle,
 	*dma_handle = 0;
 }
 
-static int map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
-			   gfp_t mem_flags)
+static void unmap_urb_setup_packet(struct usb_hcd *hcd, struct urb *urb)
+{
+	if (urb->transfer_flags & URB_SETUP_DMA_MAPPED) {
+		urb->transfer_flags &= ~URB_SETUP_DMA_MAPPED;
+		dma_unmap_single(hcd->self.controller, urb->setup_dma,
+				 sizeof(struct usb_ctrlrequest),
+				 DMA_TO_DEVICE);
+	} else if (urb->transfer_flags & URB_SETUP_BOUNCE_MAPPED) {
+		/* bounce from "local" memory */
+		urb->transfer_flags &= ~URB_SETUP_BOUNCE_MAPPED;
+		hcd_free_coherent(urb->dev->bus, &urb->setup_dma,
+				  (void **)&urb->setup_packet,
+				  sizeof(struct usb_ctrlrequest),
+				  DMA_TO_DEVICE);
+	} else {
+		/* nothing to do for PIO-based controller requests */
+	}
+}
+
+static void unmap_urb_transfer_buffer(struct usb_hcd *hcd, struct urb *urb)
 {
 	enum dma_data_direction dir;
-	int ret = 0;
 
-	/* Map the URB's buffers for DMA access.
-	 * Lower level HCD code should use *_dma exclusively,
-	 * unless it uses pio or talks to another transport,
-	 * or uses the provided scatter gather list for bulk.
-	 */
+	dir = usb_urb_dir_in(urb) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+	if (urb->transfer_flags & URB_TRANSFER_DMA_MAPPED) {
+		urb->transfer_flags &= ~URB_TRANSFER_DMA_MAPPED;
+		dma_unmap_single(hcd->self.controller,
+				 urb->transfer_dma,
+				 urb->transfer_buffer_length,
+				 dir);
+	} else if (urb->transfer_flags & URB_TRANSFER_BOUNCE_MAPPED) {
+		/* bounce from "local" memory */
+		urb->transfer_flags &= ~URB_TRANSFER_BOUNCE_MAPPED;
+		hcd_free_coherent(urb->dev->bus, &urb->transfer_dma,
+				  &urb->transfer_buffer,
+				  urb->transfer_buffer_length,
+				  dir);
+	} else {
+		/* nothing to do for PIO-based controller requests */
+	}
+}
+
+static void unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
+{
 	if (is_root_hub(urb->dev))
+		return;
+
+	unmap_urb_setup_packet(hcd, urb);
+	unmap_urb_transfer_buffer(hcd, urb);
+}
+
+static int urb_needs_setup_map(struct usb_hcd *hcd, struct urb *urb)
+{
+	/* setup mappings are required only for control requests */
+	if (!usb_endpoint_xfer_control(&urb->ep->desc))
+		return 0;
+
+	/* If the caller set URB_NO_SETUP_DMA_MAP then no mapping is needed */
+	if ((urb->transfer_flags & URB_NO_SETUP_DMA_MAP))
+		return 0;
+
+	return 1;
+}
+
+static int urb_needs_transfer_map(struct usb_hcd *hcd, struct urb *urb)
+{
+	/* don't need to map anything if there's nothing to map */
+	if (urb->transfer_buffer_length == 0)
 		return 0;
 
-	if (usb_endpoint_xfer_control(&urb->ep->desc)
-	    && !(urb->transfer_flags & URB_NO_SETUP_DMA_MAP)) {
+	/* If the caller set URB_NO_SETUP_DMA_MAP then no mapping is needed */
+	if ((urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP))
+		return 0;
+
+	return 1;
+}
+
+static int map_urb_setup_packet(struct usb_hcd *hcd, struct urb *urb,
+				gfp_t mem_flags)
+{
+	int ret;
+
+	if (urb_needs_setup_map(hcd, urb)) {
 		if (hcd->self.uses_dma) {
 			urb->setup_dma = dma_map_single(
-					hcd->self.controller,
-					urb->setup_packet,
-					sizeof(struct usb_ctrlrequest),
-					DMA_TO_DEVICE);
+						hcd->self.controller,
+						urb->setup_packet,
+						sizeof(struct usb_ctrlrequest),
+						DMA_TO_DEVICE);
 			if (dma_mapping_error(hcd->self.controller,
-						urb->setup_dma))
+					      urb->setup_dma))
 				return -EAGAIN;
-		} else if (hcd->driver->flags & HCD_LOCAL_MEM)
-			ret = hcd_alloc_coherent(
-					urb->dev->bus, mem_flags,
-					&urb->setup_dma,
-					(void **)&urb->setup_packet,
-					sizeof(struct usb_ctrlrequest),
-					DMA_TO_DEVICE);
+			urb->transfer_flags |= URB_SETUP_DMA_MAPPED;
+		} else if (hcd->driver->flags & HCD_LOCAL_MEM) {
+			/* bounce to "local" memory */
+			ret = hcd_alloc_coherent(urb->dev->bus, mem_flags,
+						 &urb->setup_dma,
+						 (void **)&urb->setup_packet,
+						 sizeof(struct usb_ctrlrequest),
+						 DMA_TO_DEVICE);
+			if (ret)
+				return ret;
+			urb->transfer_flags |= URB_SETUP_BOUNCE_MAPPED;
+		} else {
+			/* nothing to do for PIO-based controller requests */
+		}
 	}
+	return 0;
+}
+
+static int map_urb_transfer_buffer(struct usb_hcd *hcd, struct urb *urb,
+				   gfp_t mem_flags)
+{
+	enum dma_data_direction dir;
+	int ret;
 
 	dir = usb_urb_dir_in(urb) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
-	if (ret == 0 && urb->transfer_buffer_length != 0
-	    && !(urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP)) {
+	if (urb_needs_transfer_map(hcd, urb)) {
 		if (hcd->self.uses_dma) {
 			urb->transfer_dma = dma_map_single (
-					hcd->self.controller,
-					urb->transfer_buffer,
-					urb->transfer_buffer_length,
-					dir);
+						hcd->self.controller,
+						urb->transfer_buffer,
+						urb->transfer_buffer_length,
+						dir);
 			if (dma_mapping_error(hcd->self.controller,
-						urb->transfer_dma))
+					      urb->transfer_dma))
 				return -EAGAIN;
+			urb->transfer_flags |= URB_TRANSFER_DMA_MAPPED;
 		} else if (hcd->driver->flags & HCD_LOCAL_MEM) {
-			ret = hcd_alloc_coherent(
-					urb->dev->bus, mem_flags,
-					&urb->transfer_dma,
-					&urb->transfer_buffer,
-					urb->transfer_buffer_length,
-					dir);
-
-			if (ret && usb_endpoint_xfer_control(&urb->ep->desc)
-			    && !(urb->transfer_flags & URB_NO_SETUP_DMA_MAP))
-				hcd_free_coherent(urb->dev->bus,
-					&urb->setup_dma,
-					(void **)&urb->setup_packet,
-					sizeof(struct usb_ctrlrequest),
-					DMA_TO_DEVICE);
+			/* bounce to "local" memory */
+			ret = hcd_alloc_coherent(urb->dev->bus, mem_flags,
+						 &urb->transfer_dma,
+						 &urb->transfer_buffer,
+						 urb->transfer_buffer_length,
+						 dir);
+			if (ret)
+				return ret;
+			urb->transfer_flags |= URB_TRANSFER_BOUNCE_MAPPED;
+		} else {
+			/* nothing to do for PIO-based controller requests */
 		}
 	}
-	return ret;
+	return 0;
 }
 
-static void unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
+static int map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
+			   gfp_t mem_flags)
 {
-	enum dma_data_direction dir;
+	int error;
 
+	/* Map the URB's buffers for DMA access.
+	 * Lower level HCD code should use *_dma exclusively,
+	 * unless it uses pio or talks to another transport,
+	 * or uses the provided scatter gather list for bulk.
+	 */
 	if (is_root_hub(urb->dev))
-		return;
-
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
-	}
+		return 0;
 
-	dir = usb_urb_dir_in(urb) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
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
+	error = map_urb_setup_packet(hcd, urb, mem_flags);
+	if (!error) {
+		error = map_urb_transfer_buffer(hcd, urb, mem_flags);
+		if (error)
+			unmap_urb_setup_packet(hcd, urb);
 	}
+	return error;
 }
 
 /*-------------------------------------------------------------------------*/
diff --git a/include/linux/usb.h b/include/linux/usb.h
index d7ace1b..5e99cbd 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -985,6 +985,11 @@ extern int usb_disabled(void);
 #define URB_DIR_OUT		0
 #define URB_DIR_MASK		URB_DIR_IN
 
+#define URB_SETUP_DMA_MAPPED		0x1000 /* via dma_map_single */
+#define URB_SETUP_BOUNCE_MAPPED		0x2000 /* via hcd_alloc_coherent */
+#define URB_TRANSFER_DMA_MAPPED		0x4000 /* via dma_map_single */
+#define URB_TRANSFER_BOUNCE_MAPPED	0x8000 /* via hcd_alloc_coherent */
+
 struct usb_iso_packet_descriptor {
 	unsigned int offset;
 	unsigned int length;		/* expected length */
-- 
1.6.3.3
