Return-Path: <matt@ozlabs.org>
Message-ID: <4D8C47B5.3060805@ozlabs.org>
Date: Fri, 25 Mar 2011 18:43:49 +1100
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: sarah.a.sharp@linux.intel.com
Subject: [PATCH 1/5] xhci: Make xHCI driver endian-safe
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch changes the struct members defining access to xHCI device-visible
memory to use __le32/__le64 where appropriate, and then adds swaps where
required.  Checked with sparse that all accesses are correct.

MMIO accesses use readl/writel so already are performed LE, but prototypes
now reflect this with __le*.

There were a couple of (debug) instances of DMA pointers being truncated to
32bits which have been fixed too.

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 drivers/usb/host/xhci-dbg.c  |   51 ++++----
 drivers/usb/host/xhci-hub.c  |   18 ++--
 drivers/usb/host/xhci-mem.c  |  122 ++++++++++----------
 drivers/usb/host/xhci-ring.c |  269 ++++++++++++++++++++++--------------------
 drivers/usb/host/xhci.c      |  118 ++++++++++--------
 drivers/usb/host/xhci.h      |  134 +++++++++++-----------
 6 files changed, 371 insertions(+), 341 deletions(-)

diff --git a/drivers/usb/host/xhci-dbg.c b/drivers/usb/host/xhci-dbg.c
index 0231814..2e04861 100644
--- a/drivers/usb/host/xhci-dbg.c
+++ b/drivers/usb/host/xhci-dbg.c
@@ -147,7 +147,7 @@ static void xhci_print_op_regs(struct xhci_hcd *xhci)
 
 static void xhci_print_ports(struct xhci_hcd *xhci)
 {
-	u32 __iomem *addr;
+	__le32 __iomem *addr;
 	int i, j;
 	int ports;
 	char *names[NUM_PORT_REGS] = {
@@ -253,27 +253,27 @@ void xhci_print_trb_offsets(struct xhci_hcd *xhci, union xhci_trb *trb)
 void xhci_debug_trb(struct xhci_hcd *xhci, union xhci_trb *trb)
 {
 	u64	address;
-	u32	type = xhci_readl(xhci, &trb->link.control) & TRB_TYPE_BITMASK;
+	u32	type = le32_to_cpu(trb->link.control) & TRB_TYPE_BITMASK;
 
 	switch (type) {
 	case TRB_TYPE(TRB_LINK):
 		xhci_dbg(xhci, "Link TRB:\n");
 		xhci_print_trb_offsets(xhci, trb);
 
-		address = trb->link.segment_ptr;
+		address = le64_to_cpu(trb->link.segment_ptr);
 		xhci_dbg(xhci, "Next ring segment DMA address = 0x%llx\n", address);
 
 		xhci_dbg(xhci, "Interrupter target = 0x%x\n",
-				GET_INTR_TARGET(trb->link.intr_target));
+			 GET_INTR_TARGET(le32_to_cpu(trb->link.intr_target)));
 		xhci_dbg(xhci, "Cycle bit = %u\n",
-				(unsigned int) (trb->link.control & TRB_CYCLE));
+			 (unsigned int) (le32_to_cpu(trb->link.control) & TRB_CYCLE));
 		xhci_dbg(xhci, "Toggle cycle bit = %u\n",
-				(unsigned int) (trb->link.control & LINK_TOGGLE));
+			 (unsigned int) (le32_to_cpu(trb->link.control) & LINK_TOGGLE));
 		xhci_dbg(xhci, "No Snoop bit = %u\n",
-				(unsigned int) (trb->link.control & TRB_NO_SNOOP));
+			 (unsigned int) (le32_to_cpu(trb->link.control) & TRB_NO_SNOOP));
 		break;
 	case TRB_TYPE(TRB_TRANSFER):
-		address = trb->trans_event.buffer;
+		address = le64_to_cpu(trb->trans_event.buffer);
 		/*
 		 * FIXME: look at flags to figure out if it's an address or if
 		 * the data is directly in the buffer field.
@@ -281,11 +281,12 @@ void xhci_debug_trb(struct xhci_hcd *xhci, union xhci_trb *trb)
 		xhci_dbg(xhci, "DMA address or buffer contents= %llu\n", address);
 		break;
 	case TRB_TYPE(TRB_COMPLETION):
-		address = trb->event_cmd.cmd_trb;
+		address = le64_to_cpu(trb->event_cmd.cmd_trb);
 		xhci_dbg(xhci, "Command TRB pointer = %llu\n", address);
 		xhci_dbg(xhci, "Completion status = %u\n",
-				(unsigned int) GET_COMP_CODE(trb->event_cmd.status));
-		xhci_dbg(xhci, "Flags = 0x%x\n", (unsigned int) trb->event_cmd.flags);
+			 (unsigned int) GET_COMP_CODE(le32_to_cpu(trb->event_cmd.status)));
+		xhci_dbg(xhci, "Flags = 0x%x\n",
+			 (unsigned int) le32_to_cpu(trb->event_cmd.flags));
 		break;
 	default:
 		xhci_dbg(xhci, "Unknown TRB with TRB type ID %u\n",
@@ -311,16 +312,16 @@ void xhci_debug_trb(struct xhci_hcd *xhci, union xhci_trb *trb)
 void xhci_debug_segment(struct xhci_hcd *xhci, struct xhci_segment *seg)
 {
 	int i;
-	u32 addr = (u32) seg->dma;
+	u64 addr = seg->dma;
 	union xhci_trb *trb = seg->trbs;
 
 	for (i = 0; i < TRBS_PER_SEGMENT; ++i) {
 		trb = &seg->trbs[i];
-		xhci_dbg(xhci, "@%08x %08x %08x %08x %08x\n", addr,
-				lower_32_bits(trb->link.segment_ptr),
-				upper_32_bits(trb->link.segment_ptr),
-				(unsigned int) trb->link.intr_target,
-				(unsigned int) trb->link.control);
+		xhci_dbg(xhci, "@%016llx %08x %08x %08x %08x\n", addr,
+			 (u32)lower_32_bits(le64_to_cpu(trb->link.segment_ptr)),
+			 (u32)upper_32_bits(le64_to_cpu(trb->link.segment_ptr)),
+			 (unsigned int) le32_to_cpu(trb->link.intr_target),
+			 (unsigned int) le32_to_cpu(trb->link.control));
 		addr += sizeof(*trb);
 	}
 }
@@ -391,18 +392,18 @@ void xhci_dbg_ep_rings(struct xhci_hcd *xhci,
 
 void xhci_dbg_erst(struct xhci_hcd *xhci, struct xhci_erst *erst)
 {
-	u32 addr = (u32) erst->erst_dma_addr;
+	u64 addr = erst->erst_dma_addr;
 	int i;
 	struct xhci_erst_entry *entry;
 
 	for (i = 0; i < erst->num_entries; ++i) {
 		entry = &erst->entries[i];
-		xhci_dbg(xhci, "@%08x %08x %08x %08x %08x\n",
-				(unsigned int) addr,
-				lower_32_bits(entry->seg_addr),
-				upper_32_bits(entry->seg_addr),
-				(unsigned int) entry->seg_size,
-				(unsigned int) entry->rsvd);
+		xhci_dbg(xhci, "@%016llx %08x %08x %08x %08x\n",
+			 addr,
+			 lower_32_bits(le64_to_cpu(entry->seg_addr)),
+			 upper_32_bits(le64_to_cpu(entry->seg_addr)),
+			 (unsigned int) le32_to_cpu(entry->seg_size),
+			 (unsigned int) le32_to_cpu(entry->rsvd));
 		addr += sizeof(*entry);
 	}
 }
@@ -436,7 +437,7 @@ char *xhci_get_slot_state(struct xhci_hcd *xhci,
 {
 	struct xhci_slot_ctx *slot_ctx = xhci_get_slot_ctx(xhci, ctx);
 
-	switch (GET_SLOT_STATE(slot_ctx->dev_state)) {
+	switch (GET_SLOT_STATE(le32_to_cpu(slot_ctx->dev_state))) {
 	case 0:
 		return "enabled/disabled";
 	case 1:
diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index a78f2eb..ae1d24c 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -50,7 +50,7 @@ static void xhci_common_hub_descriptor(struct xhci_hcd *xhci,
 	temp |= 0x0008;
 	/* Bits 6:5 - no TTs in root ports */
 	/* Bit  7 - no port indicators */
-	desc->wHubCharacteristics = (__force __u16) cpu_to_le16(temp);
+	desc->wHubCharacteristics = cpu_to_le16(temp);
 }
 
 /* Fill in the USB 2.0 roothub descriptor */
@@ -314,7 +314,7 @@ void xhci_ring_device(struct xhci_hcd *xhci, int slot_id)
 }
 
 static void xhci_disable_port(struct usb_hcd *hcd, struct xhci_hcd *xhci,
-		u16 wIndex, u32 __iomem *addr, u32 port_status)
+		u16 wIndex, __le32 __iomem *addr, u32 port_status)
 {
 	/* Don't allow the USB core to disable SuperSpeed ports. */
 	if (hcd->speed == HCD_USB3) {
@@ -331,7 +331,7 @@ static void xhci_disable_port(struct usb_hcd *hcd, struct xhci_hcd *xhci,
 }
 
 static void xhci_clear_port_change_bit(struct xhci_hcd *xhci, u16 wValue,
-		u16 wIndex, u32 __iomem *addr, u32 port_status)
+		u16 wIndex, __le32 __iomem *addr, u32 port_status)
 {
 	char *port_change_bit;
 	u32 status;
@@ -376,7 +376,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	unsigned long flags;
 	u32 temp, temp1, status;
 	int retval = 0;
-	u32 __iomem **port_array;
+	__le32 __iomem **port_array;
 	int slot_id;
 	struct xhci_bus_state *bus_state;
 
@@ -664,7 +664,7 @@ int xhci_hub_status_data(struct usb_hcd *hcd, char *buf)
 	int i, retval;
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 	int ports;
-	u32 __iomem **port_array;
+	__le32 __iomem **port_array;
 	struct xhci_bus_state *bus_state;
 
 	if (hcd->speed == HCD_USB3) {
@@ -709,7 +709,7 @@ int xhci_bus_suspend(struct usb_hcd *hcd)
 {
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 	int max_ports, port_index;
-	u32 __iomem **port_array;
+	__le32 __iomem **port_array;
 	struct xhci_bus_state *bus_state;
 	unsigned long flags;
 
@@ -779,7 +779,7 @@ int xhci_bus_suspend(struct usb_hcd *hcd)
 
 		if (DEV_HIGHSPEED(t1)) {
 			/* enable remote wake up for USB 2.0 */
-			u32 __iomem *addr;
+			__le32 __iomem *addr;
 			u32 tmp;
 
 			/* Add one to the port status register address to get
@@ -801,7 +801,7 @@ int xhci_bus_resume(struct usb_hcd *hcd)
 {
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 	int max_ports, port_index;
-	u32 __iomem **port_array;
+	__le32 __iomem **port_array;
 	struct xhci_bus_state *bus_state;
 	u32 temp;
 	unsigned long flags;
@@ -875,7 +875,7 @@ int xhci_bus_resume(struct usb_hcd *hcd)
 
 		if (DEV_HIGHSPEED(temp)) {
 			/* disable remote wake up for USB 2.0 */
-			u32 __iomem *addr;
+			__le32 __iomem *addr;
 			u32 tmp;
 
 			/* Add one to the port status register address to get
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index a003e79..e3a219d 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -89,16 +89,17 @@ static void xhci_link_segments(struct xhci_hcd *xhci, struct xhci_segment *prev,
 		return;
 	prev->next = next;
 	if (link_trbs) {
-		prev->trbs[TRBS_PER_SEGMENT-1].link.segment_ptr = next->dma;
+		prev->trbs[TRBS_PER_SEGMENT-1].link.
+			segment_ptr = cpu_to_le64(next->dma);
 
 		/* Set the last TRB in the segment to have a TRB type ID of Link TRB */
-		val = prev->trbs[TRBS_PER_SEGMENT-1].link.control;
+		val = le32_to_cpu(prev->trbs[TRBS_PER_SEGMENT-1].link.control);
 		val &= ~TRB_TYPE_BITMASK;
 		val |= TRB_TYPE(TRB_LINK);
 		/* Always set the chain bit with 0.95 hardware */
 		if (xhci_link_trb_quirk(xhci))
 			val |= TRB_CHAIN;
-		prev->trbs[TRBS_PER_SEGMENT-1].link.control = val;
+		prev->trbs[TRBS_PER_SEGMENT-1].link.control = cpu_to_le32(val);
 	}
 	xhci_dbg(xhci, "Linking segment 0x%llx to segment 0x%llx (DMA)\n",
 			(unsigned long long)prev->dma,
@@ -186,7 +187,8 @@ static struct xhci_ring *xhci_ring_alloc(struct xhci_hcd *xhci,
 
 	if (link_trbs) {
 		/* See section 4.9.2.1 and 6.4.4.1 */
-		prev->trbs[TRBS_PER_SEGMENT-1].link.control |= (LINK_TOGGLE);
+		prev->trbs[TRBS_PER_SEGMENT-1].link.
+			control |= cpu_to_le32(LINK_TOGGLE);
 		xhci_dbg(xhci, "Wrote link toggle flag to"
 				" segment %p (virtual), 0x%llx (DMA)\n",
 				prev, (unsigned long long)prev->dma);
@@ -548,7 +550,8 @@ struct xhci_stream_info *xhci_alloc_stream_info(struct xhci_hcd *xhci,
 		addr = cur_ring->first_seg->dma |
 			SCT_FOR_CTX(SCT_PRI_TR) |
 			cur_ring->cycle_state;
-		stream_info->stream_ctx_array[cur_stream].stream_ring = addr;
+		stream_info->stream_ctx_array[cur_stream].
+			stream_ring = cpu_to_le64(addr);
 		xhci_dbg(xhci, "Setting stream %d ring ptr to 0x%08llx\n",
 				cur_stream, (unsigned long long) addr);
 
@@ -614,10 +617,10 @@ void xhci_setup_streams_ep_input_ctx(struct xhci_hcd *xhci,
 	max_primary_streams = fls(stream_info->num_stream_ctxs) - 2;
 	xhci_dbg(xhci, "Setting number of stream ctx array entries to %u\n",
 			1 << (max_primary_streams + 1));
-	ep_ctx->ep_info &= ~EP_MAXPSTREAMS_MASK;
-	ep_ctx->ep_info |= EP_MAXPSTREAMS(max_primary_streams);
-	ep_ctx->ep_info |= EP_HAS_LSA;
-	ep_ctx->deq  = stream_info->ctx_array_dma;
+	ep_ctx->ep_info &= cpu_to_le32(~EP_MAXPSTREAMS_MASK);
+	ep_ctx->ep_info |= cpu_to_le32(EP_MAXPSTREAMS(max_primary_streams)
+				       | EP_HAS_LSA);
+	ep_ctx->deq  = cpu_to_le64(stream_info->ctx_array_dma);
 }
 
 /*
@@ -630,10 +633,9 @@ void xhci_setup_no_streams_ep_input_ctx(struct xhci_hcd *xhci,
 		struct xhci_virt_ep *ep)
 {
 	dma_addr_t addr;
-	ep_ctx->ep_info &= ~EP_MAXPSTREAMS_MASK;
-	ep_ctx->ep_info &= ~EP_HAS_LSA;
+	ep_ctx->ep_info &= cpu_to_le32(~(EP_MAXPSTREAMS_MASK | EP_HAS_LSA));
 	addr = xhci_trb_virt_to_dma(ep->ring->deq_seg, ep->ring->dequeue);
-	ep_ctx->deq  = addr | ep->ring->cycle_state;
+	ep_ctx->deq  = cpu_to_le64(addr | ep->ring->cycle_state);
 }
 
 /* Frees all stream contexts associated with the endpoint,
@@ -781,11 +783,11 @@ int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id,
 	dev->udev = udev;
 
 	/* Point to output device context in dcbaa. */
-	xhci->dcbaa->dev_context_ptrs[slot_id] = dev->out_ctx->dma;
+	xhci->dcbaa->dev_context_ptrs[slot_id] = cpu_to_le64(dev->out_ctx->dma);
 	xhci_dbg(xhci, "Set slot id %d dcbaa entry %p to 0x%llx\n",
-			slot_id,
-			&xhci->dcbaa->dev_context_ptrs[slot_id],
-			(unsigned long long) xhci->dcbaa->dev_context_ptrs[slot_id]);
+		 slot_id,
+		 &xhci->dcbaa->dev_context_ptrs[slot_id],
+		 (unsigned long long) le64_to_cpu(xhci->dcbaa->dev_context_ptrs[slot_id]));
 
 	return 1;
 fail:
@@ -810,8 +812,9 @@ void xhci_copy_ep0_dequeue_into_input_ctx(struct xhci_hcd *xhci,
 	 * configured device has reset, so all control transfers should have
 	 * been completed or cancelled before the reset.
 	 */
-	ep0_ctx->deq = xhci_trb_virt_to_dma(ep_ring->enq_seg, ep_ring->enqueue);
-	ep0_ctx->deq |= ep_ring->cycle_state;
+	ep0_ctx->deq = cpu_to_le64(xhci_trb_virt_to_dma(ep_ring->enq_seg,
+							ep_ring->enqueue)
+				   | ep_ring->cycle_state);
 }
 
 /*
@@ -885,24 +888,22 @@ int xhci_setup_addressable_virt_dev(struct xhci_hcd *xhci, struct usb_device *ud
 	slot_ctx = xhci_get_slot_ctx(xhci, dev->in_ctx);
 
 	/* 2) New slot context and endpoint 0 context are valid*/
-	ctrl_ctx->add_flags = SLOT_FLAG | EP0_FLAG;
+	ctrl_ctx->add_flags = cpu_to_le32(SLOT_FLAG | EP0_FLAG);
 
 	/* 3) Only the control endpoint is valid - one endpoint context */
-	slot_ctx->dev_info |= LAST_CTX(1);
-
-	slot_ctx->dev_info |= (u32) udev->route;
+	slot_ctx->dev_info |= cpu_to_le32(LAST_CTX(1) | (u32) udev->route);
 	switch (udev->speed) {
 	case USB_SPEED_SUPER:
-		slot_ctx->dev_info |= (u32) SLOT_SPEED_SS;
+		slot_ctx->dev_info |= cpu_to_le32((u32) SLOT_SPEED_SS);
 		break;
 	case USB_SPEED_HIGH:
-		slot_ctx->dev_info |= (u32) SLOT_SPEED_HS;
+		slot_ctx->dev_info |= cpu_to_le32((u32) SLOT_SPEED_HS);
 		break;
 	case USB_SPEED_FULL:
-		slot_ctx->dev_info |= (u32) SLOT_SPEED_FS;
+		slot_ctx->dev_info |= cpu_to_le32((u32) SLOT_SPEED_FS);
 		break;
 	case USB_SPEED_LOW:
-		slot_ctx->dev_info |= (u32) SLOT_SPEED_LS;
+		slot_ctx->dev_info |= cpu_to_le32((u32) SLOT_SPEED_LS);
 		break;
 	case USB_SPEED_WIRELESS:
 		xhci_dbg(xhci, "FIXME xHCI doesn't support wireless speeds\n");
@@ -916,7 +917,7 @@ int xhci_setup_addressable_virt_dev(struct xhci_hcd *xhci, struct usb_device *ud
 	port_num = xhci_find_real_port_number(xhci, udev);
 	if (!port_num)
 		return -EINVAL;
-	slot_ctx->dev_info2 |= (u32) ROOT_HUB_PORT(port_num);
+	slot_ctx->dev_info2 |= cpu_to_le32((u32) ROOT_HUB_PORT(port_num));
 	/* Set the port number in the virtual_device to the faked port number */
 	for (top_dev = udev; top_dev->parent && top_dev->parent->parent;
 			top_dev = top_dev->parent)
@@ -927,31 +928,31 @@ int xhci_setup_addressable_virt_dev(struct xhci_hcd *xhci, struct usb_device *ud
 
 	/* Is this a LS/FS device under an external HS hub? */
 	if (udev->tt && udev->tt->hub->parent) {
-		slot_ctx->tt_info = udev->tt->hub->slot_id;
-		slot_ctx->tt_info |= udev->ttport << 8;
+		slot_ctx->tt_info = cpu_to_le32(udev->tt->hub->slot_id |
+						(udev->ttport << 8));
 		if (udev->tt->multi)
-			slot_ctx->dev_info |= DEV_MTT;
+			slot_ctx->dev_info |= cpu_to_le32(DEV_MTT);
 	}
 	xhci_dbg(xhci, "udev->tt = %p\n", udev->tt);
 	xhci_dbg(xhci, "udev->ttport = 0x%x\n", udev->ttport);
 
 	/* Step 4 - ring already allocated */
 	/* Step 5 */
-	ep0_ctx->ep_info2 = EP_TYPE(CTRL_EP);
+	ep0_ctx->ep_info2 = cpu_to_le32(EP_TYPE(CTRL_EP));
 	/*
 	 * XXX: Not sure about wireless USB devices.
 	 */
 	switch (udev->speed) {
 	case USB_SPEED_SUPER:
-		ep0_ctx->ep_info2 |= MAX_PACKET(512);
+		ep0_ctx->ep_info2 |= cpu_to_le32(MAX_PACKET(512));
 		break;
 	case USB_SPEED_HIGH:
 	/* USB core guesses at a 64-byte max packet first for FS devices */
 	case USB_SPEED_FULL:
-		ep0_ctx->ep_info2 |= MAX_PACKET(64);
+		ep0_ctx->ep_info2 |= cpu_to_le32(MAX_PACKET(64));
 		break;
 	case USB_SPEED_LOW:
-		ep0_ctx->ep_info2 |= MAX_PACKET(8);
+		ep0_ctx->ep_info2 |= cpu_to_le32(MAX_PACKET(8));
 		break;
 	case USB_SPEED_WIRELESS:
 		xhci_dbg(xhci, "FIXME xHCI doesn't support wireless speeds\n");
@@ -962,12 +963,10 @@ int xhci_setup_addressable_virt_dev(struct xhci_hcd *xhci, struct usb_device *ud
 		BUG();
 	}
 	/* EP 0 can handle "burst" sizes of 1, so Max Burst Size field is 0 */
-	ep0_ctx->ep_info2 |= MAX_BURST(0);
-	ep0_ctx->ep_info2 |= ERROR_COUNT(3);
+	ep0_ctx->ep_info2 |= cpu_to_le32(MAX_BURST(0) | ERROR_COUNT(3));
 
-	ep0_ctx->deq =
-		dev->eps[0].ring->first_seg->dma;
-	ep0_ctx->deq |= dev->eps[0].ring->cycle_state;
+	ep0_ctx->deq = cpu_to_le64(dev->eps[0].ring->first_seg->dma |
+				   dev->eps[0].ring->cycle_state);
 
 	/* Steps 7 and 8 were done in xhci_alloc_virt_device() */
 
@@ -1099,8 +1098,8 @@ static inline u32 xhci_get_max_esit_payload(struct xhci_hcd *xhci,
 	if (udev->speed == USB_SPEED_SUPER)
 		return ep->ss_ep_comp.wBytesPerInterval;
 
-	max_packet = GET_MAX_PACKET(ep->desc.wMaxPacketSize);
-	max_burst = (ep->desc.wMaxPacketSize & 0x1800) >> 11;
+	max_packet = GET_MAX_PACKET(le16_to_cpu(ep->desc.wMaxPacketSize));
+	max_burst = (le16_to_cpu(ep->desc.wMaxPacketSize) & 0x1800) >> 11;
 	/* A 0 in max burst means 1 transfer per ESIT */
 	return max_packet * (max_burst + 1);
 }
@@ -1149,10 +1148,10 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
 	}
 	virt_dev->eps[ep_index].skip = false;
 	ep_ring = virt_dev->eps[ep_index].new_ring;
-	ep_ctx->deq = ep_ring->first_seg->dma | ep_ring->cycle_state;
+	ep_ctx->deq = cpu_to_le64(ep_ring->first_seg->dma | ep_ring->cycle_state);
 
-	ep_ctx->ep_info = xhci_get_endpoint_interval(udev, ep);
-	ep_ctx->ep_info |= EP_MULT(xhci_get_endpoint_mult(udev, ep));
+	ep_ctx->ep_info = cpu_to_le32(xhci_get_endpoint_interval(udev, ep)
+				      | EP_MULT(xhci_get_endpoint_mult(udev, ep)));
 
 	/* FIXME dig Mult and streams info out of ep companion desc */
 
@@ -1160,22 +1159,22 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
 	 * error count = 0 means infinite retries.
 	 */
 	if (!usb_endpoint_xfer_isoc(&ep->desc))
-		ep_ctx->ep_info2 = ERROR_COUNT(3);
+		ep_ctx->ep_info2 = cpu_to_le32(ERROR_COUNT(3));
 	else
-		ep_ctx->ep_info2 = ERROR_COUNT(1);
+		ep_ctx->ep_info2 = cpu_to_le32(ERROR_COUNT(1));
 
-	ep_ctx->ep_info2 |= xhci_get_endpoint_type(udev, ep);
+	ep_ctx->ep_info2 |= cpu_to_le32(xhci_get_endpoint_type(udev, ep));
 
 	/* Set the max packet size and max burst */
 	switch (udev->speed) {
 	case USB_SPEED_SUPER:
-		max_packet = ep->desc.wMaxPacketSize;
-		ep_ctx->ep_info2 |= MAX_PACKET(max_packet);
+		max_packet = le16_to_cpu(ep->desc.wMaxPacketSize);
+		ep_ctx->ep_info2 |= cpu_to_le32(MAX_PACKET(max_packet));
 		/* dig out max burst from ep companion desc */
 		max_packet = ep->ss_ep_comp.bMaxBurst;
 		if (!max_packet)
 			xhci_warn(xhci, "WARN no SS endpoint bMaxBurst\n");
-		ep_ctx->ep_info2 |= MAX_BURST(max_packet);
+		ep_ctx->ep_info2 |= cpu_to_le32(MAX_BURST(max_packet));
 		break;
 	case USB_SPEED_HIGH:
 		/* bits 11:12 specify the number of additional transaction
@@ -1183,20 +1182,21 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
 		 */
 		if (usb_endpoint_xfer_isoc(&ep->desc) ||
 				usb_endpoint_xfer_int(&ep->desc)) {
-			max_burst = (ep->desc.wMaxPacketSize & 0x1800) >> 11;
-			ep_ctx->ep_info2 |= MAX_BURST(max_burst);
+			max_burst = (le16_to_cpu(ep->desc.wMaxPacketSize)
+				     & 0x1800) >> 11;
+			ep_ctx->ep_info2 |= cpu_to_le32(MAX_BURST(max_burst));
 		}
 		/* Fall through */
 	case USB_SPEED_FULL:
 	case USB_SPEED_LOW:
-		max_packet = GET_MAX_PACKET(ep->desc.wMaxPacketSize);
-		ep_ctx->ep_info2 |= MAX_PACKET(max_packet);
+		max_packet = GET_MAX_PACKET(le16_to_cpu(ep->desc.wMaxPacketSize));
+		ep_ctx->ep_info2 |= cpu_to_le32(MAX_PACKET(max_packet));
 		break;
 	default:
 		BUG();
 	}
 	max_esit_payload = xhci_get_max_esit_payload(xhci, udev, ep);
-	ep_ctx->tx_info = MAX_ESIT_PAYLOAD_FOR_EP(max_esit_payload);
+	ep_ctx->tx_info = cpu_to_le32(MAX_ESIT_PAYLOAD_FOR_EP(max_esit_payload));
 
 	/*
 	 * XXX no idea how to calculate the average TRB buffer length for bulk
@@ -1213,7 +1213,7 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
 	 * use Event Data TRBs, and we don't chain in a link TRB on short
 	 * transfers, we're basically dividing by 1.
 	 */
-	ep_ctx->tx_info |= AVG_TRB_LENGTH_FOR_EP(max_esit_payload);
+	ep_ctx->tx_info |= cpu_to_le32(AVG_TRB_LENGTH_FOR_EP(max_esit_payload));
 
 	/* FIXME Debug endpoint context */
 	return 0;
@@ -1313,7 +1313,7 @@ static int scratchpad_alloc(struct xhci_hcd *xhci, gfp_t flags)
 	if (!xhci->scratchpad->sp_dma_buffers)
 		goto fail_sp4;
 
-	xhci->dcbaa->dev_context_ptrs[0] = xhci->scratchpad->sp_dma;
+	xhci->dcbaa->dev_context_ptrs[0] = cpu_to_le64(xhci->scratchpad->sp_dma);
 	for (i = 0; i < num_sp; i++) {
 		dma_addr_t dma;
 		void *buf = pci_alloc_consistent(to_pci_dev(dev),
@@ -1690,7 +1690,7 @@ static void xhci_set_hc_event_deq(struct xhci_hcd *xhci)
 }
 
 static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
-		u32 __iomem *addr, u8 major_revision)
+		__le32 __iomem *addr, u8 major_revision)
 {
 	u32 temp, port_offset, port_count;
 	int i;
@@ -1755,7 +1755,7 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
  */
 static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
 {
-	u32 __iomem *addr;
+	__le32 __iomem *addr;
 	u32 offset;
 	unsigned int num_ports;
 	int i, port_index;
@@ -2008,8 +2008,8 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 	/* set ring base address and size for each segment table entry */
 	for (val = 0, seg = xhci->event_ring->first_seg; val < ERST_NUM_SEGS; val++) {
 		struct xhci_erst_entry *entry = &xhci->erst.entries[val];
-		entry->seg_addr = seg->dma;
-		entry->seg_size = TRBS_PER_SEGMENT;
+		entry->seg_addr = cpu_to_le64(seg->dma);
+		entry->seg_size = cpu_to_le32(TRBS_PER_SEGMENT);
 		entry->rsvd = 0;
 		seg = seg->next;
 	}
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index cfc1ad9..3898f22 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -100,7 +100,7 @@ static inline bool last_trb_on_last_seg(struct xhci_hcd *xhci, struct xhci_ring
 		return (trb == &seg->trbs[TRBS_PER_SEGMENT]) &&
 			(seg->next == xhci->event_ring->first_seg);
 	else
-		return trb->link.control & LINK_TOGGLE;
+		return le32_to_cpu(trb->link.control) & LINK_TOGGLE;
 }
 
 /* Is this TRB a link TRB or was the last TRB the last TRB in this event ring
@@ -113,13 +113,15 @@ static inline int last_trb(struct xhci_hcd *xhci, struct xhci_ring *ring,
 	if (ring == xhci->event_ring)
 		return trb == &seg->trbs[TRBS_PER_SEGMENT];
 	else
-		return (trb->link.control & TRB_TYPE_BITMASK) == TRB_TYPE(TRB_LINK);
+		return (le32_to_cpu(trb->link.control) & TRB_TYPE_BITMASK)
+			== TRB_TYPE(TRB_LINK);
 }
 
 static inline int enqueue_is_link_trb(struct xhci_ring *ring)
 {
 	struct xhci_link_trb *link = &ring->enqueue->link;
-	return ((link->control & TRB_TYPE_BITMASK) == TRB_TYPE(TRB_LINK));
+	return ((le32_to_cpu(link->control) & TRB_TYPE_BITMASK) ==
+		TRB_TYPE(TRB_LINK));
 }
 
 /* Updates trb to point to the next TRB in the ring, and updates seg if the next
@@ -197,7 +199,7 @@ static void inc_enq(struct xhci_hcd *xhci, struct xhci_ring *ring,
 	union xhci_trb *next;
 	unsigned long long addr;
 
-	chain = ring->enqueue->generic.field[3] & TRB_CHAIN;
+	chain = le32_to_cpu(ring->enqueue->generic.field[3]) & TRB_CHAIN;
 	next = ++(ring->enqueue);
 
 	ring->enq_updates++;
@@ -223,12 +225,14 @@ static void inc_enq(struct xhci_hcd *xhci, struct xhci_ring *ring,
 				 * (which may mean the chain bit is cleared).
 				 */
 				if (!xhci_link_trb_quirk(xhci)) {
-					next->link.control &= ~TRB_CHAIN;
-					next->link.control |= chain;
+					next->link.control &=
+						cpu_to_le32(~TRB_CHAIN);
+					next->link.control |=
+						cpu_to_le32(chain);
 				}
 				/* Give this link TRB to the hardware */
 				wmb();
-				next->link.control ^= TRB_CYCLE;
+				next->link.control ^= cpu_to_le32(TRB_CYCLE);
 			}
 			/* Toggle the cycle bit after the last ring segment. */
 			if (last_trb_on_last_seg(xhci, ring, ring->enq_seg, next)) {
@@ -319,7 +323,7 @@ void xhci_ring_ep_doorbell(struct xhci_hcd *xhci,
 		unsigned int ep_index,
 		unsigned int stream_id)
 {
-	__u32 __iomem *db_addr = &xhci->dba->doorbell[slot_id];
+	__le32 __iomem *db_addr = &xhci->dba->doorbell[slot_id];
 	struct xhci_virt_ep *ep = &xhci->devs[slot_id]->eps[ep_index];
 	unsigned int ep_state = ep->ep_state;
 
@@ -380,7 +384,7 @@ static struct xhci_segment *find_trb_seg(
 	while (cur_seg->trbs > trb ||
 			&cur_seg->trbs[TRBS_PER_SEGMENT - 1] < trb) {
 		generic_trb = &cur_seg->trbs[TRBS_PER_SEGMENT - 1].generic;
-		if (generic_trb->field[3] & LINK_TOGGLE)
+		if (le32_to_cpu(generic_trb->field[3]) & LINK_TOGGLE)
 			*cycle_state ^= 0x1;
 		cur_seg = cur_seg->next;
 		if (cur_seg == start_seg)
@@ -447,6 +451,10 @@ static struct xhci_ring *xhci_urb_to_transfer_ring(struct xhci_hcd *xhci,
  *    any link TRBs with the toggle cycle bit set.
  *  - Finally we move the dequeue state one TRB further, toggling the cycle bit
  *    if we've moved it past a link TRB with the toggle cycle bit set.
+ *
+ * Some of the uses of xhci_generic_trb are grotty, but if they're done
+ * with correct __le32 accesses they should work fine.  Only users of this are
+ * in here.
  */
 void xhci_find_new_dequeue_state(struct xhci_hcd *xhci,
 		unsigned int slot_id, unsigned int ep_index,
@@ -480,7 +488,7 @@ void xhci_find_new_dequeue_state(struct xhci_hcd *xhci,
 	/* Dig out the cycle state saved by the xHC during the stop ep cmd */
 	xhci_dbg(xhci, "Finding endpoint context\n");
 	ep_ctx = xhci_get_ep_ctx(xhci, dev->out_ctx, ep_index);
-	state->new_cycle_state = 0x1 & ep_ctx->deq;
+	state->new_cycle_state = 0x1 & le64_to_cpu(ep_ctx->deq);
 
 	state->new_deq_ptr = cur_td->last_trb;
 	xhci_dbg(xhci, "Finding segment containing last TRB in TD.\n");
@@ -493,8 +501,8 @@ void xhci_find_new_dequeue_state(struct xhci_hcd *xhci,
 	}
 
 	trb = &state->new_deq_ptr->generic;
-	if ((trb->field[3] & TRB_TYPE_BITMASK) == TRB_TYPE(TRB_LINK) &&
-				(trb->field[3] & LINK_TOGGLE))
+	if ((le32_to_cpu(trb->field[3]) & TRB_TYPE_BITMASK) ==
+	    TRB_TYPE(TRB_LINK) && (le32_to_cpu(trb->field[3]) & LINK_TOGGLE))
 		state->new_cycle_state ^= 0x1;
 	next_trb(xhci, ep_ring, &state->new_deq_seg, &state->new_deq_ptr);
 
@@ -529,12 +537,14 @@ static void td_to_noop(struct xhci_hcd *xhci, struct xhci_ring *ep_ring,
 	for (cur_seg = cur_td->start_seg, cur_trb = cur_td->first_trb;
 			true;
 			next_trb(xhci, ep_ring, &cur_seg, &cur_trb)) {
-		if ((cur_trb->generic.field[3] & TRB_TYPE_BITMASK) ==
-				TRB_TYPE(TRB_LINK)) {
+		u32 f;
+		if ((le32_to_cpu(cur_trb->generic.field[3]) & TRB_TYPE_BITMASK)
+		    == TRB_TYPE(TRB_LINK)) {
 			/* Unchain any chained Link TRBs, but
 			 * leave the pointers intact.
 			 */
-			cur_trb->generic.field[3] &= ~TRB_CHAIN;
+			f = le32_to_cpu(cur_trb->generic.field[3]) & ~TRB_CHAIN;
+			cur_trb->generic.field[3] = cpu_to_le32(f);
 			xhci_dbg(xhci, "Cancel (unchain) link TRB\n");
 			xhci_dbg(xhci, "Address = %p (0x%llx dma); "
 					"in seg %p (0x%llx dma)\n",
@@ -547,8 +557,9 @@ static void td_to_noop(struct xhci_hcd *xhci, struct xhci_ring *ep_ring,
 			cur_trb->generic.field[1] = 0;
 			cur_trb->generic.field[2] = 0;
 			/* Preserve only the cycle bit of this TRB */
-			cur_trb->generic.field[3] &= TRB_CYCLE;
-			cur_trb->generic.field[3] |= TRB_TYPE(TRB_TR_NOOP);
+			f = (le32_to_cpu(cur_trb->generic.field[3]) & TRB_CYCLE)
+				| TRB_TYPE(TRB_TR_NOOP);
+			cur_trb->generic.field[3] = cpu_to_le32(f);
 			xhci_dbg(xhci, "Cancel TRB %p (0x%llx dma) "
 					"in seg %p (0x%llx dma)\n",
 					cur_trb,
@@ -655,9 +666,9 @@ static void handle_stopped_endpoint(struct xhci_hcd *xhci,
 	struct xhci_dequeue_state deq_state;
 
 	if (unlikely(TRB_TO_SUSPEND_PORT(
-			xhci->cmd_ring->dequeue->generic.field[3]))) {
+			     le32_to_cpu(xhci->cmd_ring->dequeue->generic.field[3])))) {
 		slot_id = TRB_TO_SLOT_ID(
-			xhci->cmd_ring->dequeue->generic.field[3]);
+			le32_to_cpu(xhci->cmd_ring->dequeue->generic.field[3]));
 		virt_dev = xhci->devs[slot_id];
 		if (virt_dev)
 			handle_cmd_in_cmd_wait_list(xhci, virt_dev,
@@ -670,8 +681,8 @@ static void handle_stopped_endpoint(struct xhci_hcd *xhci,
 	}
 
 	memset(&deq_state, 0, sizeof(deq_state));
-	slot_id = TRB_TO_SLOT_ID(trb->generic.field[3]);
-	ep_index = TRB_TO_EP_INDEX(trb->generic.field[3]);
+	slot_id = TRB_TO_SLOT_ID(le32_to_cpu(trb->generic.field[3]));
+	ep_index = TRB_TO_EP_INDEX(le32_to_cpu(trb->generic.field[3]));
 	ep = &xhci->devs[slot_id]->eps[ep_index];
 
 	if (list_empty(&ep->cancelled_td_list)) {
@@ -903,9 +914,9 @@ static void handle_set_deq_completion(struct xhci_hcd *xhci,
 	struct xhci_ep_ctx *ep_ctx;
 	struct xhci_slot_ctx *slot_ctx;
 
-	slot_id = TRB_TO_SLOT_ID(trb->generic.field[3]);
-	ep_index = TRB_TO_EP_INDEX(trb->generic.field[3]);
-	stream_id = TRB_TO_STREAM_ID(trb->generic.field[2]);
+	slot_id = TRB_TO_SLOT_ID(le32_to_cpu(trb->generic.field[3]));
+	ep_index = TRB_TO_EP_INDEX(le32_to_cpu(trb->generic.field[3]));
+	stream_id = TRB_TO_STREAM_ID(le32_to_cpu(trb->generic.field[2]));
 	dev = xhci->devs[slot_id];
 
 	ep_ring = xhci_stream_id_to_ring(dev, ep_index, stream_id);
@@ -921,11 +932,11 @@ static void handle_set_deq_completion(struct xhci_hcd *xhci,
 	ep_ctx = xhci_get_ep_ctx(xhci, dev->out_ctx, ep_index);
 	slot_ctx = xhci_get_slot_ctx(xhci, dev->out_ctx);
 
-	if (GET_COMP_CODE(event->status) != COMP_SUCCESS) {
+	if (GET_COMP_CODE(le32_to_cpu(event->status)) != COMP_SUCCESS) {
 		unsigned int ep_state;
 		unsigned int slot_state;
 
-		switch (GET_COMP_CODE(event->status)) {
+		switch (GET_COMP_CODE(le32_to_cpu(event->status))) {
 		case COMP_TRB_ERR:
 			xhci_warn(xhci, "WARN Set TR Deq Ptr cmd invalid because "
 					"of stream ID configuration\n");
@@ -933,9 +944,9 @@ static void handle_set_deq_completion(struct xhci_hcd *xhci,
 		case COMP_CTX_STATE:
 			xhci_warn(xhci, "WARN Set TR Deq Ptr cmd failed due "
 					"to incorrect slot or ep state.\n");
-			ep_state = ep_ctx->ep_info;
+			ep_state = le32_to_cpu(ep_ctx->ep_info);
 			ep_state &= EP_STATE_MASK;
-			slot_state = slot_ctx->dev_state;
+			slot_state = le32_to_cpu(slot_ctx->dev_state);
 			slot_state = GET_SLOT_STATE(slot_state);
 			xhci_dbg(xhci, "Slot state = %u, EP state = %u\n",
 					slot_state, ep_state);
@@ -947,7 +958,7 @@ static void handle_set_deq_completion(struct xhci_hcd *xhci,
 		default:
 			xhci_warn(xhci, "WARN Set TR Deq Ptr cmd with unknown "
 					"completion code of %u.\n",
-					GET_COMP_CODE(event->status));
+				  GET_COMP_CODE(le32_to_cpu(event->status)));
 			break;
 		}
 		/* OK what do we do now?  The endpoint state is hosed, and we
@@ -958,10 +969,10 @@ static void handle_set_deq_completion(struct xhci_hcd *xhci,
 		 */
 	} else {
 		xhci_dbg(xhci, "Successful Set TR Deq Ptr cmd, deq = @%08llx\n",
-				ep_ctx->deq);
+			 le64_to_cpu(ep_ctx->deq));
 		if (xhci_trb_virt_to_dma(dev->eps[ep_index].queued_deq_seg,
-					dev->eps[ep_index].queued_deq_ptr) ==
-				(ep_ctx->deq & ~(EP_CTX_CYCLE_MASK))) {
+					 dev->eps[ep_index].queued_deq_ptr) ==
+		    (le64_to_cpu(ep_ctx->deq) & ~(EP_CTX_CYCLE_MASK))) {
 			/* Update the ring's dequeue segment and dequeue pointer
 			 * to reflect the new position.
 			 */
@@ -990,13 +1001,13 @@ static void handle_reset_ep_completion(struct xhci_hcd *xhci,
 	int slot_id;
 	unsigned int ep_index;
 
-	slot_id = TRB_TO_SLOT_ID(trb->generic.field[3]);
-	ep_index = TRB_TO_EP_INDEX(trb->generic.field[3]);
+	slot_id = TRB_TO_SLOT_ID(le32_to_cpu(trb->generic.field[3]));
+	ep_index = TRB_TO_EP_INDEX(le32_to_cpu(trb->generic.field[3]));
 	/* This command will only fail if the endpoint wasn't halted,
 	 * but we don't care.
 	 */
 	xhci_dbg(xhci, "Ignoring reset ep completion code of %u\n",
-			(unsigned int) GET_COMP_CODE(event->status));
+		 (unsigned int) GET_COMP_CODE(le32_to_cpu(event->status)));
 
 	/* HW with the reset endpoint quirk needs to have a configure endpoint
 	 * command complete before the endpoint can be used.  Queue that here
@@ -1033,8 +1044,7 @@ static int handle_cmd_in_cmd_wait_list(struct xhci_hcd *xhci,
 	if (xhci->cmd_ring->dequeue != command->command_trb)
 		return 0;
 
-	command->status =
-		GET_COMP_CODE(event->status);
+	command->status = GET_COMP_CODE(le32_to_cpu(event->status));
 	list_del(&command->cmd_list);
 	if (command->completion)
 		complete(command->completion);
@@ -1046,7 +1056,7 @@ static int handle_cmd_in_cmd_wait_list(struct xhci_hcd *xhci,
 static void handle_cmd_completion(struct xhci_hcd *xhci,
 		struct xhci_event_cmd *event)
 {
-	int slot_id = TRB_TO_SLOT_ID(event->flags);
+	int slot_id = TRB_TO_SLOT_ID(le32_to_cpu(event->flags));
 	u64 cmd_dma;
 	dma_addr_t cmd_dequeue_dma;
 	struct xhci_input_control_ctx *ctrl_ctx;
@@ -1055,7 +1065,7 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 	struct xhci_ring *ep_ring;
 	unsigned int ep_state;
 
-	cmd_dma = event->cmd_trb;
+	cmd_dma = le64_to_cpu(event->cmd_trb);
 	cmd_dequeue_dma = xhci_trb_virt_to_dma(xhci->cmd_ring->deq_seg,
 			xhci->cmd_ring->dequeue);
 	/* Is the command ring deq ptr out of sync with the deq seg ptr? */
@@ -1068,9 +1078,10 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 		xhci->error_bitmask |= 1 << 5;
 		return;
 	}
-	switch (xhci->cmd_ring->dequeue->generic.field[3] & TRB_TYPE_BITMASK) {
+	switch (le32_to_cpu(xhci->cmd_ring->dequeue->generic.field[3])
+		& TRB_TYPE_BITMASK) {
 	case TRB_TYPE(TRB_ENABLE_SLOT):
-		if (GET_COMP_CODE(event->status) == COMP_SUCCESS)
+		if (GET_COMP_CODE(le32_to_cpu(event->status)) == COMP_SUCCESS)
 			xhci->slot_id = slot_id;
 		else
 			xhci->slot_id = 0;
@@ -1095,7 +1106,7 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 		ctrl_ctx = xhci_get_input_control_ctx(xhci,
 				virt_dev->in_ctx);
 		/* Input ctx add_flags are the endpoint index plus one */
-		ep_index = xhci_last_valid_endpoint(ctrl_ctx->add_flags) - 1;
+		ep_index = xhci_last_valid_endpoint(le32_to_cpu(ctrl_ctx->add_flags)) - 1;
 		/* A usb_set_interface() call directly after clearing a halted
 		 * condition may race on this quirky hardware.  Not worth
 		 * worrying about, since this is prototype hardware.  Not sure
@@ -1104,8 +1115,8 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 		 */
 		if (xhci->quirks & XHCI_RESET_EP_QUIRK &&
 				ep_index != (unsigned int) -1 &&
-				ctrl_ctx->add_flags - SLOT_FLAG ==
-					ctrl_ctx->drop_flags) {
+		    le32_to_cpu(ctrl_ctx->add_flags) - SLOT_FLAG ==
+		    le32_to_cpu(ctrl_ctx->drop_flags)) {
 			ep_ring = xhci->devs[slot_id]->eps[ep_index].ring;
 			ep_state = xhci->devs[slot_id]->eps[ep_index].ep_state;
 			if (!(ep_state & EP_HALTED))
@@ -1122,18 +1133,18 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 bandwidth_change:
 		xhci_dbg(xhci, "Completed config ep cmd\n");
 		xhci->devs[slot_id]->cmd_status =
-			GET_COMP_CODE(event->status);
+			GET_COMP_CODE(le32_to_cpu(event->status));
 		complete(&xhci->devs[slot_id]->cmd_completion);
 		break;
 	case TRB_TYPE(TRB_EVAL_CONTEXT):
 		virt_dev = xhci->devs[slot_id];
 		if (handle_cmd_in_cmd_wait_list(xhci, virt_dev, event))
 			break;
-		xhci->devs[slot_id]->cmd_status = GET_COMP_CODE(event->status);
+		xhci->devs[slot_id]->cmd_status = GET_COMP_CODE(le32_to_cpu(event->status));
 		complete(&xhci->devs[slot_id]->cmd_completion);
 		break;
 	case TRB_TYPE(TRB_ADDR_DEV):
-		xhci->devs[slot_id]->cmd_status = GET_COMP_CODE(event->status);
+		xhci->devs[slot_id]->cmd_status = GET_COMP_CODE(le32_to_cpu(event->status));
 		complete(&xhci->addr_dev);
 		break;
 	case TRB_TYPE(TRB_STOP_RING):
@@ -1150,7 +1161,7 @@ bandwidth_change:
 	case TRB_TYPE(TRB_RESET_DEV):
 		xhci_dbg(xhci, "Completed reset device command.\n");
 		slot_id = TRB_TO_SLOT_ID(
-				xhci->cmd_ring->dequeue->generic.field[3]);
+			le32_to_cpu(xhci->cmd_ring->dequeue->generic.field[3]));
 		virt_dev = xhci->devs[slot_id];
 		if (virt_dev)
 			handle_cmd_in_cmd_wait_list(xhci, virt_dev, event);
@@ -1164,8 +1175,8 @@ bandwidth_change:
 			break;
 		}
 		xhci_dbg(xhci, "NEC firmware version %2x.%02x\n",
-				NEC_FW_MAJOR(event->status),
-				NEC_FW_MINOR(event->status));
+			 NEC_FW_MAJOR(le32_to_cpu(event->status)),
+			 NEC_FW_MINOR(le32_to_cpu(event->status)));
 		break;
 	default:
 		/* Skip over unknown commands on the event ring */
@@ -1180,7 +1191,7 @@ static void handle_vendor_event(struct xhci_hcd *xhci,
 {
 	u32 trb_type;
 
-	trb_type = TRB_FIELD_TO_TYPE(event->generic.field[3]);
+	trb_type = TRB_FIELD_TO_TYPE(le32_to_cpu(event->generic.field[3]));
 	xhci_dbg(xhci, "Vendor specific event TRB type = %u\n", trb_type);
 	if (trb_type == TRB_NEC_CMD_COMP && (xhci->quirks & XHCI_NEC_HOST))
 		handle_cmd_completion(xhci, &event->event_cmd);
@@ -1234,14 +1245,14 @@ static void handle_port_status(struct xhci_hcd *xhci,
 	unsigned int faked_port_index;
 	u8 major_revision;
 	struct xhci_bus_state *bus_state;
-	u32 __iomem **port_array;
+	__le32 __iomem **port_array;
 
 	/* Port status change events always have a successful completion code */
-	if (GET_COMP_CODE(event->generic.field[2]) != COMP_SUCCESS) {
+	if (GET_COMP_CODE(le32_to_cpu(event->generic.field[2])) != COMP_SUCCESS) {
 		xhci_warn(xhci, "WARN: xHC returned failed port status event\n");
 		xhci->error_bitmask |= 1 << 8;
 	}
-	port_id = GET_PORT_ID(event->generic.field[0]);
+	port_id = GET_PORT_ID(le32_to_cpu(event->generic.field[0]));
 	xhci_dbg(xhci, "Port Status Change Event for port %d\n", port_id);
 
 	max_ports = HCS_MAX_PORTS(xhci->hcs_params1);
@@ -1438,7 +1449,7 @@ static int xhci_requires_manual_halt_cleanup(struct xhci_hcd *xhci,
 		 * endpoint anyway.  Check if a babble halted the
 		 * endpoint.
 		 */
-		if ((ep_ctx->ep_info & EP_STATE_MASK) == EP_STATE_HALTED)
+		if ((le32_to_cpu(ep_ctx->ep_info) & EP_STATE_MASK) == EP_STATE_HALTED)
 			return 1;
 
 	return 0;
@@ -1476,12 +1487,12 @@ static int finish_td(struct xhci_hcd *xhci, struct xhci_td *td,
 	struct urb_priv	*urb_priv;
 	u32 trb_comp_code;
 
-	slot_id = TRB_TO_SLOT_ID(event->flags);
+	slot_id = TRB_TO_SLOT_ID(le32_to_cpu(event->flags));
 	xdev = xhci->devs[slot_id];
-	ep_index = TRB_TO_EP_ID(event->flags) - 1;
-	ep_ring = xhci_dma_to_transfer_ring(ep, event->buffer);
+	ep_index = TRB_TO_EP_ID(le32_to_cpu(event->flags)) - 1;
+	ep_ring = xhci_dma_to_transfer_ring(ep, le64_to_cpu(event->buffer));
 	ep_ctx = xhci_get_ep_ctx(xhci, xdev->out_ctx, ep_index);
-	trb_comp_code = GET_COMP_CODE(event->transfer_len);
+	trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->transfer_len));
 
 	if (skip)
 		goto td_cleanup;
@@ -1575,12 +1586,12 @@ static int process_ctrl_td(struct xhci_hcd *xhci, struct xhci_td *td,
 	struct xhci_ep_ctx *ep_ctx;
 	u32 trb_comp_code;
 
-	slot_id = TRB_TO_SLOT_ID(event->flags);
+	slot_id = TRB_TO_SLOT_ID(le32_to_cpu(event->flags));
 	xdev = xhci->devs[slot_id];
-	ep_index = TRB_TO_EP_ID(event->flags) - 1;
-	ep_ring = xhci_dma_to_transfer_ring(ep, event->buffer);
+	ep_index = TRB_TO_EP_ID(le32_to_cpu(event->flags)) - 1;
+	ep_ring = xhci_dma_to_transfer_ring(ep, le64_to_cpu(event->buffer));
 	ep_ctx = xhci_get_ep_ctx(xhci, xdev->out_ctx, ep_index);
-	trb_comp_code = GET_COMP_CODE(event->transfer_len);
+	trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->transfer_len));
 
 	xhci_debug_trb(xhci, xhci->event_ring->dequeue);
 	switch (trb_comp_code) {
@@ -1619,7 +1630,7 @@ static int process_ctrl_td(struct xhci_hcd *xhci, struct xhci_td *td,
 				event_trb != td->last_trb)
 			td->urb->actual_length =
 				td->urb->transfer_buffer_length
-				- TRB_LEN(event->transfer_len);
+				- TRB_LEN(le32_to_cpu(event->transfer_len));
 		else
 			td->urb->actual_length = 0;
 
@@ -1653,7 +1664,7 @@ static int process_ctrl_td(struct xhci_hcd *xhci, struct xhci_td *td,
 				/* We didn't stop on a link TRB in the middle */
 				td->urb->actual_length =
 					td->urb->transfer_buffer_length -
-					TRB_LEN(event->transfer_len);
+					TRB_LEN(le32_to_cpu(event->transfer_len));
 				xhci_dbg(xhci, "Waiting for status "
 						"stage event\n");
 				return 0;
@@ -1680,8 +1691,8 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_td *td,
 	struct xhci_segment *cur_seg;
 	u32 trb_comp_code;
 
-	ep_ring = xhci_dma_to_transfer_ring(ep, event->buffer);
-	trb_comp_code = GET_COMP_CODE(event->transfer_len);
+	ep_ring = xhci_dma_to_transfer_ring(ep, le64_to_cpu(event->buffer));
+	trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->transfer_len));
 	urb_priv = td->urb->hcpriv;
 	idx = urb_priv->td_cnt;
 
@@ -1744,15 +1755,14 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_td *td,
 		for (cur_trb = ep_ring->dequeue,
 		     cur_seg = ep_ring->deq_seg; cur_trb != event_trb;
 		     next_trb(xhci, ep_ring, &cur_seg, &cur_trb)) {
-			if ((cur_trb->generic.field[3] &
+			if ((le32_to_cpu(cur_trb->generic.field[3]) &
 			 TRB_TYPE_BITMASK) != TRB_TYPE(TRB_TR_NOOP) &&
-			    (cur_trb->generic.field[3] &
+			    (le32_to_cpu(cur_trb->generic.field[3]) &
 			 TRB_TYPE_BITMASK) != TRB_TYPE(TRB_LINK))
-				len +=
-				    TRB_LEN(cur_trb->generic.field[2]);
+				len += TRB_LEN(le32_to_cpu(cur_trb->generic.field[2]));
 		}
-		len += TRB_LEN(cur_trb->generic.field[2]) -
-			TRB_LEN(event->transfer_len);
+		len += TRB_LEN(le32_to_cpu(cur_trb->generic.field[2])) -
+			TRB_LEN(le32_to_cpu(event->transfer_len));
 
 		if (trb_comp_code != COMP_STOP_INVAL) {
 			td->urb->iso_frame_desc[idx].actual_length = len;
@@ -1778,8 +1788,8 @@ static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_td *td,
 	struct xhci_segment *cur_seg;
 	u32 trb_comp_code;
 
-	ep_ring = xhci_dma_to_transfer_ring(ep, event->buffer);
-	trb_comp_code = GET_COMP_CODE(event->transfer_len);
+	ep_ring = xhci_dma_to_transfer_ring(ep, le64_to_cpu(event->buffer));
+	trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->transfer_len));
 
 	switch (trb_comp_code) {
 	case COMP_SUCCESS:
@@ -1815,18 +1825,18 @@ static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_td *td,
 			"%d bytes untransferred\n",
 			td->urb->ep->desc.bEndpointAddress,
 			td->urb->transfer_buffer_length,
-			TRB_LEN(event->transfer_len));
+		 TRB_LEN(le32_to_cpu(event->transfer_len)));
 	/* Fast path - was this the last TRB in the TD for this URB? */
 	if (event_trb == td->last_trb) {
-		if (TRB_LEN(event->transfer_len) != 0) {
+		if (TRB_LEN(le32_to_cpu(event->transfer_len)) != 0) {
 			td->urb->actual_length =
 				td->urb->transfer_buffer_length -
-				TRB_LEN(event->transfer_len);
+				TRB_LEN(le32_to_cpu(event->transfer_len));
 			if (td->urb->transfer_buffer_length <
 					td->urb->actual_length) {
 				xhci_warn(xhci, "HC gave bad length "
 						"of %d bytes left\n",
-						TRB_LEN(event->transfer_len));
+					  TRB_LEN(le32_to_cpu(event->transfer_len)));
 				td->urb->actual_length = 0;
 				if (td->urb->transfer_flags & URB_SHORT_NOT_OK)
 					*status = -EREMOTEIO;
@@ -1857,20 +1867,20 @@ static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_td *td,
 		for (cur_trb = ep_ring->dequeue, cur_seg = ep_ring->deq_seg;
 				cur_trb != event_trb;
 				next_trb(xhci, ep_ring, &cur_seg, &cur_trb)) {
-			if ((cur_trb->generic.field[3] &
+			if ((le32_to_cpu(cur_trb->generic.field[3]) &
 			 TRB_TYPE_BITMASK) != TRB_TYPE(TRB_TR_NOOP) &&
-			    (cur_trb->generic.field[3] &
+			    (le32_to_cpu(cur_trb->generic.field[3]) &
 			 TRB_TYPE_BITMASK) != TRB_TYPE(TRB_LINK))
 				td->urb->actual_length +=
-					TRB_LEN(cur_trb->generic.field[2]);
+					TRB_LEN(le32_to_cpu(cur_trb->generic.field[2]));
 		}
 		/* If the ring didn't stop on a Link or No-op TRB, add
 		 * in the actual bytes transferred from the Normal TRB
 		 */
 		if (trb_comp_code != COMP_STOP_INVAL)
 			td->urb->actual_length +=
-				TRB_LEN(cur_trb->generic.field[2]) -
-				TRB_LEN(event->transfer_len);
+				TRB_LEN(le32_to_cpu(cur_trb->generic.field[2])) -
+				TRB_LEN(le32_to_cpu(event->transfer_len));
 	}
 
 	return finish_td(xhci, td, event_trb, event, ep, status, false);
@@ -1900,7 +1910,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	u32 trb_comp_code;
 	int ret = 0;
 
-	slot_id = TRB_TO_SLOT_ID(event->flags);
+	slot_id = TRB_TO_SLOT_ID(le32_to_cpu(event->flags));
 	xdev = xhci->devs[slot_id];
 	if (!xdev) {
 		xhci_err(xhci, "ERROR Transfer event pointed to bad slot\n");
@@ -1908,20 +1918,21 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	}
 
 	/* Endpoint ID is 1 based, our index is zero based */
-	ep_index = TRB_TO_EP_ID(event->flags) - 1;
+	ep_index = TRB_TO_EP_ID(le32_to_cpu(event->flags)) - 1;
 	xhci_dbg(xhci, "%s - ep index = %d\n", __func__, ep_index);
 	ep = &xdev->eps[ep_index];
-	ep_ring = xhci_dma_to_transfer_ring(ep, event->buffer);
+	ep_ring = xhci_dma_to_transfer_ring(ep, le64_to_cpu(event->buffer));
 	ep_ctx = xhci_get_ep_ctx(xhci, xdev->out_ctx, ep_index);
 	if (!ep_ring ||
-		(ep_ctx->ep_info & EP_STATE_MASK) == EP_STATE_DISABLED) {
+	    (le32_to_cpu(ep_ctx->ep_info) & EP_STATE_MASK) ==
+	    EP_STATE_DISABLED) {
 		xhci_err(xhci, "ERROR Transfer event for disabled endpoint "
 				"or incorrect stream ring\n");
 		return -ENODEV;
 	}
 
-	event_dma = event->buffer;
-	trb_comp_code = GET_COMP_CODE(event->transfer_len);
+	event_dma = le64_to_cpu(event->buffer);
+	trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->transfer_len));
 	/* Look for common error cases */
 	switch (trb_comp_code) {
 	/* Skip codes that require special handling depending on
@@ -1974,14 +1985,16 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		if (!list_empty(&ep_ring->td_list))
 			xhci_dbg(xhci, "Underrun Event for slot %d ep %d "
 					"still with TDs queued?\n",
-				TRB_TO_SLOT_ID(event->flags), ep_index);
+				 TRB_TO_SLOT_ID(le32_to_cpu(event->flags)),
+				 ep_index);
 		goto cleanup;
 	case COMP_OVERRUN:
 		xhci_dbg(xhci, "overrun event on endpoint\n");
 		if (!list_empty(&ep_ring->td_list))
 			xhci_dbg(xhci, "Overrun Event for slot %d ep %d "
 					"still with TDs queued?\n",
-				TRB_TO_SLOT_ID(event->flags), ep_index);
+				 TRB_TO_SLOT_ID(le32_to_cpu(event->flags)),
+				 ep_index);
 		goto cleanup;
 	case COMP_MISSED_INT:
 		/*
@@ -2010,9 +2023,11 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		if (list_empty(&ep_ring->td_list)) {
 			xhci_warn(xhci, "WARN Event TRB for slot %d ep %d "
 					"with no TDs queued?\n",
-				  TRB_TO_SLOT_ID(event->flags), ep_index);
+				  TRB_TO_SLOT_ID(le32_to_cpu(event->flags)),
+				  ep_index);
 			xhci_dbg(xhci, "Event TRB with TRB type ID %u\n",
-			  (unsigned int) (event->flags & TRB_TYPE_BITMASK)>>10);
+				 (unsigned int) (le32_to_cpu(event->flags)
+						 & TRB_TYPE_BITMASK)>>10);
 			xhci_print_trb_offsets(xhci, (union xhci_trb *) event);
 			if (ep->skip) {
 				ep->skip = false;
@@ -2048,7 +2063,8 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 			 * corresponding TD has been cancelled. Just ignore
 			 * the TD.
 			 */
-			if ((event_trb->generic.field[3] & TRB_TYPE_BITMASK)
+			if ((le32_to_cpu(event_trb->generic.field[3])
+			     & TRB_TYPE_BITMASK)
 					 == TRB_TYPE(TRB_TR_NOOP)) {
 				xhci_dbg(xhci, "event_trb is a no-op TRB. "
 						"Skip it\n");
@@ -2129,15 +2145,15 @@ static void xhci_handle_event(struct xhci_hcd *xhci)
 
 	event = xhci->event_ring->dequeue;
 	/* Does the HC or OS own the TRB? */
-	if ((event->event_cmd.flags & TRB_CYCLE) !=
-			xhci->event_ring->cycle_state) {
+	if ((le32_to_cpu(event->event_cmd.flags) & TRB_CYCLE) !=
+	    xhci->event_ring->cycle_state) {
 		xhci->error_bitmask |= 1 << 2;
 		return;
 	}
 	xhci_dbg(xhci, "%s - OS owns TRB\n", __func__);
 
 	/* FIXME: Handle more event types. */
-	switch ((event->event_cmd.flags & TRB_TYPE_BITMASK)) {
+	switch ((le32_to_cpu(event->event_cmd.flags) & TRB_TYPE_BITMASK)) {
 	case TRB_TYPE(TRB_COMPLETION):
 		xhci_dbg(xhci, "%s - calling handle_cmd_completion\n", __func__);
 		handle_cmd_completion(xhci, &event->event_cmd);
@@ -2159,7 +2175,8 @@ static void xhci_handle_event(struct xhci_hcd *xhci)
 			update_ptrs = 0;
 		break;
 	default:
-		if ((event->event_cmd.flags & TRB_TYPE_BITMASK) >= TRB_TYPE(48))
+		if ((le32_to_cpu(event->event_cmd.flags) & TRB_TYPE_BITMASK) >=
+		    TRB_TYPE(48))
 			handle_vendor_event(xhci, event);
 		else
 			xhci->error_bitmask |= 1 << 3;
@@ -2209,12 +2226,12 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 	xhci_dbg(xhci, "op reg status = %08x\n", status);
 	xhci_dbg(xhci, "Event ring dequeue ptr:\n");
 	xhci_dbg(xhci, "@%llx %08x %08x %08x %08x\n",
-			(unsigned long long)
-			xhci_trb_virt_to_dma(xhci->event_ring->deq_seg, trb),
-			lower_32_bits(trb->link.segment_ptr),
-			upper_32_bits(trb->link.segment_ptr),
-			(unsigned int) trb->link.intr_target,
-			(unsigned int) trb->link.control);
+		 (unsigned long long)
+		 xhci_trb_virt_to_dma(xhci->event_ring->deq_seg, trb),
+		 lower_32_bits(le64_to_cpu(trb->link.segment_ptr)),
+		 upper_32_bits(le64_to_cpu(trb->link.segment_ptr)),
+		 (unsigned int) le32_to_cpu(trb->link.intr_target),
+		 (unsigned int) le32_to_cpu(trb->link.control));
 
 	if (status & STS_FATAL) {
 		xhci_warn(xhci, "WARNING: Host System Error\n");
@@ -2315,10 +2332,10 @@ static void queue_trb(struct xhci_hcd *xhci, struct xhci_ring *ring,
 	struct xhci_generic_trb *trb;
 
 	trb = &ring->enqueue->generic;
-	trb->field[0] = field1;
-	trb->field[1] = field2;
-	trb->field[2] = field3;
-	trb->field[3] = field4;
+	trb->field[0] = cpu_to_le32(field1);
+	trb->field[1] = cpu_to_le32(field2);
+	trb->field[2] = cpu_to_le32(field3);
+	trb->field[3] = cpu_to_le32(field4);
 	inc_enq(xhci, ring, consumer, more_trbs_coming);
 }
 
@@ -2371,17 +2388,16 @@ static int prepare_ring(struct xhci_hcd *xhci, struct xhci_ring *ep_ring,
 		next = ring->enqueue;
 
 		while (last_trb(xhci, ring, ring->enq_seg, next)) {
-
 			/* If we're not dealing with 0.95 hardware,
 			 * clear the chain bit.
 			 */
 			if (!xhci_link_trb_quirk(xhci))
-				next->link.control &= ~TRB_CHAIN;
+				next->link.control &= cpu_to_le32(~TRB_CHAIN);
 			else
-				next->link.control |= TRB_CHAIN;
+				next->link.control |= cpu_to_le32(TRB_CHAIN);
 
 			wmb();
-			next->link.control ^= (u32) TRB_CYCLE;
+			next->link.control ^= cpu_to_le32((u32) TRB_CYCLE);
 
 			/* Toggle the cycle bit after the last ring segment. */
 			if (last_trb_on_last_seg(xhci, ring, ring->enq_seg, next)) {
@@ -2424,8 +2440,8 @@ static int prepare_transfer(struct xhci_hcd *xhci,
 	}
 
 	ret = prepare_ring(xhci, ep_ring,
-			ep_ctx->ep_info & EP_STATE_MASK,
-			num_trbs, mem_flags);
+			   le32_to_cpu(ep_ctx->ep_info) & EP_STATE_MASK,
+			   num_trbs, mem_flags);
 	if (ret)
 		return ret;
 
@@ -2527,9 +2543,9 @@ static void giveback_first_trb(struct xhci_hcd *xhci, int slot_id,
 	 */
 	wmb();
 	if (start_cycle)
-		start_trb->field[3] |= start_cycle;
+		start_trb->field[3] |= cpu_to_le32(start_cycle);
 	else
-		start_trb->field[3] &= ~0x1;
+		start_trb->field[3] &= cpu_to_le32(~TRB_CYCLE);
 	xhci_ring_ep_doorbell(xhci, slot_id, ep_index, stream_id);
 }
 
@@ -2547,7 +2563,7 @@ int xhci_queue_intr_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 	int xhci_interval;
 	int ep_interval;
 
-	xhci_interval = EP_INTERVAL_TO_UFRAMES(ep_ctx->ep_info);
+	xhci_interval = EP_INTERVAL_TO_UFRAMES(le32_to_cpu(ep_ctx->ep_info));
 	ep_interval = urb->interval;
 	/* Convert to microframes */
 	if (urb->dev->speed == USB_SPEED_LOW ||
@@ -2936,12 +2952,11 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 	if (start_cycle == 0)
 		field |= 0x1;
 	queue_trb(xhci, ep_ring, false, true,
-			/* FIXME endianness is probably going to bite my ass here. */
-			setup->bRequestType | setup->bRequest << 8 | setup->wValue << 16,
-			setup->wIndex | setup->wLength << 16,
-			TRB_LEN(8) | TRB_INTR_TARGET(0),
-			/* Immediate data in pointer */
-			field);
+		  setup->bRequestType | setup->bRequest << 8 | le16_to_cpu(setup->wValue) << 16,
+		  le16_to_cpu(setup->wIndex) | le16_to_cpu(setup->wLength) << 16,
+		  TRB_LEN(8) | TRB_INTR_TARGET(0),
+		  /* Immediate data in pointer */
+		  field);
 
 	/* If there's data, queue data TRBs */
 	field = 0;
@@ -3162,8 +3177,8 @@ int xhci_queue_isoc_tx_prepare(struct xhci_hcd *xhci, gfp_t mem_flags,
 	/* Check the ring to guarantee there is enough room for the whole urb.
 	 * Do not insert any td of the urb to the ring if the check failed.
 	 */
-	ret = prepare_ring(xhci, ep_ring, ep_ctx->ep_info & EP_STATE_MASK,
-				num_trbs, mem_flags);
+	ret = prepare_ring(xhci, ep_ring, le32_to_cpu(ep_ctx->ep_info) & EP_STATE_MASK,
+			   num_trbs, mem_flags);
 	if (ret)
 		return ret;
 
@@ -3175,7 +3190,7 @@ int xhci_queue_isoc_tx_prepare(struct xhci_hcd *xhci, gfp_t mem_flags,
 			urb->dev->speed == USB_SPEED_FULL)
 		urb->start_frame >>= 3;
 
-	xhci_interval = EP_INTERVAL_TO_UFRAMES(ep_ctx->ep_info);
+	xhci_interval = EP_INTERVAL_TO_UFRAMES(le32_to_cpu(ep_ctx->ep_info));
 	ep_interval = urb->interval;
 	/* Convert to microframes */
 	if (urb->dev->speed == USB_SPEED_LOW ||
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 9a3645f..88e6298 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -968,9 +968,10 @@ static int xhci_check_maxpacket(struct xhci_hcd *xhci, unsigned int slot_id,
 
 	out_ctx = xhci->devs[slot_id]->out_ctx;
 	ep_ctx = xhci_get_ep_ctx(xhci, out_ctx, ep_index);
-	hw_max_packet_size = MAX_PACKET_DECODED(ep_ctx->ep_info2);
-	max_packet_size = urb->dev->ep0.desc.wMaxPacketSize;
+	hw_max_packet_size = MAX_PACKET_DECODED(le32_to_cpu(ep_ctx->ep_info2));
+	max_packet_size = le16_to_cpu(urb->dev->ep0.desc.wMaxPacketSize);
 	if (hw_max_packet_size != max_packet_size) {
+		u32 i;
 		xhci_dbg(xhci, "Max Packet Size for ep 0 changed.\n");
 		xhci_dbg(xhci, "Max packet size in usb_device = %d\n",
 				max_packet_size);
@@ -983,15 +984,15 @@ static int xhci_check_maxpacket(struct xhci_hcd *xhci, unsigned int slot_id,
 				xhci->devs[slot_id]->out_ctx, ep_index);
 		in_ctx = xhci->devs[slot_id]->in_ctx;
 		ep_ctx = xhci_get_ep_ctx(xhci, in_ctx, ep_index);
-		ep_ctx->ep_info2 &= ~MAX_PACKET_MASK;
-		ep_ctx->ep_info2 |= MAX_PACKET(max_packet_size);
+		i = (le32_to_cpu(ep_ctx->ep_info2) & ~MAX_PACKET_MASK);
+		ep_ctx->ep_info2 = cpu_to_le32(i | MAX_PACKET(max_packet_size));
 
 		/* Set up the input context flags for the command */
 		/* FIXME: This won't work if a non-default control endpoint
 		 * changes max packet sizes.
 		 */
 		ctrl_ctx = xhci_get_input_control_ctx(xhci, in_ctx);
-		ctrl_ctx->add_flags = EP0_FLAG;
+		ctrl_ctx->add_flags = cpu_to_le32(EP0_FLAG);
 		ctrl_ctx->drop_flags = 0;
 
 		xhci_dbg(xhci, "Slot %d input context\n", slot_id);
@@ -1005,7 +1006,7 @@ static int xhci_check_maxpacket(struct xhci_hcd *xhci, unsigned int slot_id,
 		/* Clean up the input context for later use by bandwidth
 		 * functions.
 		 */
-		ctrl_ctx->add_flags = SLOT_FLAG;
+		ctrl_ctx->add_flags = cpu_to_le32(SLOT_FLAG);
 	}
 	return ret;
 }
@@ -1303,6 +1304,7 @@ int xhci_drop_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
 	struct xhci_ep_ctx *ep_ctx;
 	u32 drop_flag;
 	u32 new_add_flags, new_drop_flags, new_slot_info;
+	u32 f;
 	int ret;
 
 	ret = xhci_check_args(hcd, udev, ep, 1, true, __func__);
@@ -1326,27 +1328,33 @@ int xhci_drop_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
 	/* If the HC already knows the endpoint is disabled,
 	 * or the HCD has noted it is disabled, ignore this request
 	 */
-	if ((ep_ctx->ep_info & EP_STATE_MASK) == EP_STATE_DISABLED ||
-			ctrl_ctx->drop_flags & xhci_get_endpoint_flag(&ep->desc)) {
+	if ((le32_to_cpu(ep_ctx->ep_info) & EP_STATE_MASK) ==
+	    EP_STATE_DISABLED ||
+	    le32_to_cpu(ctrl_ctx->drop_flags) &
+	    xhci_get_endpoint_flag(&ep->desc)) {
 		xhci_warn(xhci, "xHCI %s called with disabled ep %p\n",
 				__func__, ep);
 		return 0;
 	}
 
-	ctrl_ctx->drop_flags |= drop_flag;
-	new_drop_flags = ctrl_ctx->drop_flags;
+	f = le32_to_cpu(ctrl_ctx->drop_flags) | drop_flag;
+	ctrl_ctx->drop_flags = cpu_to_le32(f);
+	new_drop_flags = f;
 
-	ctrl_ctx->add_flags &= ~drop_flag;
-	new_add_flags = ctrl_ctx->add_flags;
+	f = le32_to_cpu(ctrl_ctx->add_flags) & ~drop_flag;
+	ctrl_ctx->add_flags = cpu_to_le32(f);
+	new_add_flags = f;
 
-	last_ctx = xhci_last_valid_endpoint(ctrl_ctx->add_flags);
+	last_ctx = xhci_last_valid_endpoint(f);
 	slot_ctx = xhci_get_slot_ctx(xhci, in_ctx);
 	/* Update the last valid endpoint context, if we deleted the last one */
-	if ((slot_ctx->dev_info & LAST_CTX_MASK) > LAST_CTX(last_ctx)) {
-		slot_ctx->dev_info &= ~LAST_CTX_MASK;
-		slot_ctx->dev_info |= LAST_CTX(last_ctx);
+	f = le32_to_cpu(slot_ctx->dev_info);
+	if ((f & LAST_CTX_MASK) > LAST_CTX(last_ctx)) {
+		f &= ~LAST_CTX_MASK;
+		f |= LAST_CTX(last_ctx);
+		slot_ctx->dev_info = cpu_to_le32(f);
 	}
-	new_slot_info = slot_ctx->dev_info;
+	new_slot_info = le32_to_cpu(slot_ctx->dev_info);
 
 	xhci_endpoint_zero(xhci, xhci->devs[udev->slot_id], ep);
 
@@ -1385,6 +1393,7 @@ int xhci_add_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
 	unsigned int last_ctx;
 	u32 new_add_flags, new_drop_flags, new_slot_info;
 	int ret = 0;
+	u32 f;
 
 	ret = xhci_check_args(hcd, udev, ep, 1, true, __func__);
 	if (ret <= 0) {
@@ -1414,7 +1423,8 @@ int xhci_add_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
 	/* If the HCD has already noted the endpoint is enabled,
 	 * ignore this request.
 	 */
-	if (ctrl_ctx->add_flags & xhci_get_endpoint_flag(&ep->desc)) {
+	if (le32_to_cpu(ctrl_ctx->add_flags) &
+	    xhci_get_endpoint_flag(&ep->desc)) {
 		xhci_warn(xhci, "xHCI %s called with enabled ep %p\n",
 				__func__, ep);
 		return 0;
@@ -1432,8 +1442,9 @@ int xhci_add_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
 		return -ENOMEM;
 	}
 
-	ctrl_ctx->add_flags |= added_ctxs;
-	new_add_flags = ctrl_ctx->add_flags;
+	f = le32_to_cpu(ctrl_ctx->add_flags) | added_ctxs;
+	ctrl_ctx->add_flags = cpu_to_le32(f);
+	new_add_flags = f;
 
 	/* If xhci_endpoint_disable() was called for this endpoint, but the
 	 * xHC hasn't been notified yet through the check_bandwidth() call,
@@ -1441,15 +1452,17 @@ int xhci_add_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
 	 * descriptors.  We must drop and re-add this endpoint, so we leave the
 	 * drop flags alone.
 	 */
-	new_drop_flags = ctrl_ctx->drop_flags;
+	new_drop_flags = le32_to_cpu(ctrl_ctx->drop_flags);
 
 	slot_ctx = xhci_get_slot_ctx(xhci, in_ctx);
+	f = le32_to_cpu(slot_ctx->dev_info);
 	/* Update the last valid endpoint context, if we just added one past */
-	if ((slot_ctx->dev_info & LAST_CTX_MASK) < LAST_CTX(last_ctx)) {
-		slot_ctx->dev_info &= ~LAST_CTX_MASK;
-		slot_ctx->dev_info |= LAST_CTX(last_ctx);
+	if ((f & LAST_CTX_MASK) < LAST_CTX(last_ctx)) {
+		f &= ~LAST_CTX_MASK;
+		f |= LAST_CTX(last_ctx);
+		slot_ctx->dev_info = cpu_to_le32(f);
 	}
-	new_slot_info = slot_ctx->dev_info;
+	new_slot_info = f;
 
 	/* Store the usb_device pointer for later use */
 	ep->hcpriv = udev;
@@ -1469,6 +1482,7 @@ static void xhci_zero_in_ctx(struct xhci_hcd *xhci, struct xhci_virt_device *vir
 	struct xhci_ep_ctx *ep_ctx;
 	struct xhci_slot_ctx *slot_ctx;
 	int i;
+	u32 di;
 
 	/* When a device's add flag and drop flag are zero, any subsequent
 	 * configure endpoint command will leave that endpoint's state
@@ -1479,9 +1493,9 @@ static void xhci_zero_in_ctx(struct xhci_hcd *xhci, struct xhci_virt_device *vir
 	ctrl_ctx->drop_flags = 0;
 	ctrl_ctx->add_flags = 0;
 	slot_ctx = xhci_get_slot_ctx(xhci, virt_dev->in_ctx);
-	slot_ctx->dev_info &= ~LAST_CTX_MASK;
+	di = le32_to_cpu(slot_ctx->dev_info) & ~LAST_CTX_MASK;
 	/* Endpoint 0 is always valid */
-	slot_ctx->dev_info |= LAST_CTX(1);
+	slot_ctx->dev_info = cpu_to_le32(di |= LAST_CTX(1));
 	for (i = 1; i < 31; ++i) {
 		ep_ctx = xhci_get_ep_ctx(xhci, virt_dev->in_ctx, i);
 		ep_ctx->ep_info = 0;
@@ -1576,7 +1590,7 @@ static int xhci_configure_endpoint(struct xhci_hcd *xhci,
 	unsigned long flags;
 	struct xhci_container_ctx *in_ctx;
 	struct completion *cmd_completion;
-	int *cmd_status;
+	u32 *cmd_status;
 	struct xhci_virt_device *virt_dev;
 
 	spin_lock_irqsave(&xhci->lock, flags);
@@ -1590,8 +1604,8 @@ static int xhci_configure_endpoint(struct xhci_hcd *xhci,
 		/* Enqueue pointer can be left pointing to the link TRB,
 		 * we must handle that
 		 */
-		if ((command->command_trb->link.control & TRB_TYPE_BITMASK)
-				== TRB_TYPE(TRB_LINK))
+		if ((le32_to_cpu(command->command_trb->link.control)
+		     & TRB_TYPE_BITMASK) == TRB_TYPE(TRB_LINK))
 			command->command_trb =
 				xhci->cmd_ring->enq_seg->next->trbs;
 
@@ -1667,14 +1681,13 @@ int xhci_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 
 	/* See section 4.6.6 - A0 = 1; A1 = D0 = D1 = 0 */
 	ctrl_ctx = xhci_get_input_control_ctx(xhci, virt_dev->in_ctx);
-	ctrl_ctx->add_flags |= SLOT_FLAG;
-	ctrl_ctx->add_flags &= ~EP0_FLAG;
-	ctrl_ctx->drop_flags &= ~SLOT_FLAG;
-	ctrl_ctx->drop_flags &= ~EP0_FLAG;
+	ctrl_ctx->add_flags |= cpu_to_le32(SLOT_FLAG);
+	ctrl_ctx->add_flags &= cpu_to_le32(~EP0_FLAG);
+	ctrl_ctx->drop_flags &= cpu_to_le32(~(SLOT_FLAG | EP0_FLAG));
 	xhci_dbg(xhci, "New Input Control Context:\n");
 	slot_ctx = xhci_get_slot_ctx(xhci, virt_dev->in_ctx);
 	xhci_dbg_ctx(xhci, virt_dev->in_ctx,
-			LAST_CTX_TO_EP_NUM(slot_ctx->dev_info));
+		     LAST_CTX_TO_EP_NUM(le32_to_cpu(slot_ctx->dev_info)));
 
 	ret = xhci_configure_endpoint(xhci, udev, NULL,
 			false, false);
@@ -1685,7 +1698,7 @@ int xhci_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 
 	xhci_dbg(xhci, "Output context after successful config ep cmd:\n");
 	xhci_dbg_ctx(xhci, virt_dev->out_ctx,
-			LAST_CTX_TO_EP_NUM(slot_ctx->dev_info));
+		     LAST_CTX_TO_EP_NUM(le32_to_cpu(slot_ctx->dev_info)));
 
 	xhci_zero_in_ctx(xhci, virt_dev);
 	/* Install new rings and free or cache any old rings */
@@ -1735,10 +1748,10 @@ static void xhci_setup_input_ctx_for_config_ep(struct xhci_hcd *xhci,
 {
 	struct xhci_input_control_ctx *ctrl_ctx;
 	ctrl_ctx = xhci_get_input_control_ctx(xhci, in_ctx);
-	ctrl_ctx->add_flags = add_flags;
-	ctrl_ctx->drop_flags = drop_flags;
+	ctrl_ctx->add_flags = cpu_to_le32(add_flags);
+	ctrl_ctx->drop_flags = cpu_to_le32(drop_flags);
 	xhci_slot_copy(xhci, in_ctx, out_ctx);
-	ctrl_ctx->add_flags |= SLOT_FLAG;
+	ctrl_ctx->add_flags |= cpu_to_le32(SLOT_FLAG);
 
 	xhci_dbg(xhci, "Input Context:\n");
 	xhci_dbg_ctx(xhci, in_ctx, xhci_last_valid_endpoint(add_flags));
@@ -1767,7 +1780,7 @@ static void xhci_setup_input_ctx_for_quirk(struct xhci_hcd *xhci,
 				deq_state->new_deq_ptr);
 		return;
 	}
-	ep_ctx->deq = addr | deq_state->new_cycle_state;
+	ep_ctx->deq = cpu_to_le64(addr | deq_state->new_cycle_state);
 
 	added_ctxs = xhci_get_endpoint_flag_from_index(ep_index);
 	xhci_setup_input_ctx_for_config_ep(xhci, xhci->devs[slot_id]->in_ctx,
@@ -2322,8 +2335,8 @@ int xhci_discover_or_reset_device(struct usb_hcd *hcd, struct usb_device *udev)
 	/* Enqueue pointer can be left pointing to the link TRB,
 	 * we must handle that
 	 */
-	if ((reset_device_cmd->command_trb->link.control & TRB_TYPE_BITMASK)
-			== TRB_TYPE(TRB_LINK))
+	if ((le32_to_cpu(reset_device_cmd->command_trb->link.control)
+	     & TRB_TYPE_BITMASK) == TRB_TYPE(TRB_LINK))
 		reset_device_cmd->command_trb =
 			xhci->cmd_ring->enq_seg->next->trbs;
 
@@ -2596,10 +2609,10 @@ int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev)
 	temp_64 = xhci_read_64(xhci, &xhci->op_regs->dcbaa_ptr);
 	xhci_dbg(xhci, "Op regs DCBAA ptr = %#016llx\n", temp_64);
 	xhci_dbg(xhci, "Slot ID %d dcbaa entry @%p = %#016llx\n",
-			udev->slot_id,
-			&xhci->dcbaa->dev_context_ptrs[udev->slot_id],
-			(unsigned long long)
-				xhci->dcbaa->dev_context_ptrs[udev->slot_id]);
+		 udev->slot_id,
+		 &xhci->dcbaa->dev_context_ptrs[udev->slot_id],
+		 (unsigned long long)
+		 le64_to_cpu(xhci->dcbaa->dev_context_ptrs[udev->slot_id]));
 	xhci_dbg(xhci, "Output Context DMA address = %#08llx\n",
 			(unsigned long long)virt_dev->out_ctx->dma);
 	xhci_dbg(xhci, "Slot ID %d Input Context:\n", udev->slot_id);
@@ -2613,7 +2626,8 @@ int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev)
 	slot_ctx = xhci_get_slot_ctx(xhci, virt_dev->out_ctx);
 	/* Use kernel assigned address for devices; store xHC assigned
 	 * address locally. */
-	virt_dev->address = (slot_ctx->dev_state & DEV_ADDR_MASK) + 1;
+	virt_dev->address = (le32_to_cpu(slot_ctx->dev_state) & DEV_ADDR_MASK)
+		+ 1;
 	/* Zero the input context control for later use */
 	ctrl_ctx = xhci_get_input_control_ctx(xhci, virt_dev->in_ctx);
 	ctrl_ctx->add_flags = 0;
@@ -2657,16 +2671,16 @@ int xhci_update_hub_device(struct usb_hcd *hcd, struct usb_device *hdev,
 	spin_lock_irqsave(&xhci->lock, flags);
 	xhci_slot_copy(xhci, config_cmd->in_ctx, vdev->out_ctx);
 	ctrl_ctx = xhci_get_input_control_ctx(xhci, config_cmd->in_ctx);
-	ctrl_ctx->add_flags |= SLOT_FLAG;
+	ctrl_ctx->add_flags |= cpu_to_le32(SLOT_FLAG);
 	slot_ctx = xhci_get_slot_ctx(xhci, config_cmd->in_ctx);
-	slot_ctx->dev_info |= DEV_HUB;
+	slot_ctx->dev_info |= cpu_to_le32(DEV_HUB);
 	if (tt->multi)
-		slot_ctx->dev_info |= DEV_MTT;
+		slot_ctx->dev_info |= cpu_to_le32(DEV_MTT);
 	if (xhci->hci_version > 0x95) {
 		xhci_dbg(xhci, "xHCI version %x needs hub "
 				"TT think time and number of ports\n",
 				(unsigned int) xhci->hci_version);
-		slot_ctx->dev_info2 |= XHCI_MAX_PORTS(hdev->maxchild);
+		slot_ctx->dev_info2 |= cpu_to_le32(XHCI_MAX_PORTS(hdev->maxchild));
 		/* Set TT think time - convert from ns to FS bit times.
 		 * 0 = 8 FS bit times, 1 = 16 FS bit times,
 		 * 2 = 24 FS bit times, 3 = 32 FS bit times.
@@ -2674,7 +2688,7 @@ int xhci_update_hub_device(struct usb_hcd *hcd, struct usb_device *hdev,
 		think_time = tt->think_time;
 		if (think_time != 0)
 			think_time = (think_time / 666) - 1;
-		slot_ctx->tt_info |= TT_THINK_TIME(think_time);
+		slot_ctx->tt_info |= cpu_to_le32(TT_THINK_TIME(think_time));
 	} else {
 		xhci_dbg(xhci, "xHCI version %x doesn't need hub "
 				"TT think time or number of ports\n",
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 711de25..7970f6b 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -56,13 +56,13 @@
  * @run_regs_off:	RTSOFF - Runtime register space offset
  */
 struct xhci_cap_regs {
-	u32	hc_capbase;
-	u32	hcs_params1;
-	u32	hcs_params2;
-	u32	hcs_params3;
-	u32	hcc_params;
-	u32	db_off;
-	u32	run_regs_off;
+	__le32	hc_capbase;
+	__le32	hcs_params1;
+	__le32	hcs_params2;
+	__le32	hcs_params3;
+	__le32	hcc_params;
+	__le32	db_off;
+	__le32	run_regs_off;
 	/* Reserved up to (CAPLENGTH - 0x1C) */
 };
 
@@ -154,26 +154,26 @@ struct xhci_cap_regs {
  * 			devices.
  */
 struct xhci_op_regs {
-	u32	command;
-	u32	status;
-	u32	page_size;
-	u32	reserved1;
-	u32	reserved2;
-	u32	dev_notification;
-	u64	cmd_ring;
+	__le32	command;
+	__le32	status;
+	__le32	page_size;
+	__le32	reserved1;
+	__le32	reserved2;
+	__le32	dev_notification;
+	__le64	cmd_ring;
 	/* rsvd: offset 0x20-2F */
-	u32	reserved3[4];
-	u64	dcbaa_ptr;
-	u32	config_reg;
+	__le32	reserved3[4];
+	__le64	dcbaa_ptr;
+	__le32	config_reg;
 	/* rsvd: offset 0x3C-3FF */
-	u32	reserved4[241];
+	__le32	reserved4[241];
 	/* port 1 registers, which serve as a base address for other ports */
-	u32	port_status_base;
-	u32	port_power_base;
-	u32	port_link_base;
-	u32	reserved5;
+	__le32	port_status_base;
+	__le32	port_power_base;
+	__le32	port_link_base;
+	__le32	reserved5;
 	/* registers for ports 2-255 */
-	u32	reserved6[NUM_PORT_REGS*254];
+	__le32	reserved6[NUM_PORT_REGS*254];
 };
 
 /* USBCMD - USB command - command bitmasks */
@@ -378,12 +378,12 @@ struct xhci_op_regs {
  * updates the dequeue pointer.
  */
 struct xhci_intr_reg {
-	u32	irq_pending;
-	u32	irq_control;
-	u32	erst_size;
-	u32	rsvd;
-	u64	erst_base;
-	u64	erst_dequeue;
+	__le32	irq_pending;
+	__le32	irq_control;
+	__le32	erst_size;
+	__le32	rsvd;
+	__le64	erst_base;
+	__le64	erst_dequeue;
 };
 
 /* irq_pending bitmasks */
@@ -428,8 +428,8 @@ struct xhci_intr_reg {
  * or larger accesses"
  */
 struct xhci_run_regs {
-	u32			microframe_index;
-	u32			rsvd[7];
+	__le32			microframe_index;
+	__le32			rsvd[7];
 	struct xhci_intr_reg	ir_set[128];
 };
 
@@ -443,7 +443,7 @@ struct xhci_run_regs {
  * Section 5.6
  */
 struct xhci_doorbell_array {
-	u32	doorbell[256];
+	__le32	doorbell[256];
 };
 
 #define DB_VALUE(ep, stream)	((((ep) + 1) & 0xff) | ((stream) << 16))
@@ -500,12 +500,12 @@ struct xhci_container_ctx {
  * reserved at the end of the slot context for HC internal use.
  */
 struct xhci_slot_ctx {
-	u32	dev_info;
-	u32	dev_info2;
-	u32	tt_info;
-	u32	dev_state;
+	__le32	dev_info;
+	__le32	dev_info2;
+	__le32	tt_info;
+	__le32	dev_state;
 	/* offset 0x10 to 0x1f reserved for HC internal use */
-	u32	reserved[4];
+	__le32	reserved[4];
 };
 
 /* dev_info bitmasks */
@@ -576,12 +576,12 @@ struct xhci_slot_ctx {
  * reserved at the end of the endpoint context for HC internal use.
  */
 struct xhci_ep_ctx {
-	u32	ep_info;
-	u32	ep_info2;
-	u64	deq;
-	u32	tx_info;
+	__le32	ep_info;
+	__le32	ep_info2;
+	__le64	deq;
+	__le32	tx_info;
 	/* offset 0x14 - 0x1f reserved for HC internal use */
-	u32	reserved[3];
+	__le32	reserved[3];
 };
 
 /* ep_info bitmasks */
@@ -656,9 +656,9 @@ struct xhci_ep_ctx {
  * @add_context:	set the bit of the endpoint context you want to enable
  */
 struct xhci_input_control_ctx {
-	u32	drop_flags;
-	u32	add_flags;
-	u32	rsvd2[6];
+	__le32	drop_flags;
+	__le32	add_flags;
+	__le32	rsvd2[6];
 };
 
 /* Represents everything that is needed to issue a command on the command ring.
@@ -684,9 +684,9 @@ struct xhci_command {
 
 struct xhci_stream_ctx {
 	/* 64-bit stream ring address, cycle state, and stream type */
-	u64	stream_ring;
+	__le64	stream_ring;
 	/* offset 0x14 - 0x1f reserved for HC internal use */
-	u32	reserved[2];
+	__le32	reserved[2];
 };
 
 /* Stream Context Types (section 6.4.1) - bits 3:1 of stream ctx deq ptr */
@@ -799,7 +799,7 @@ struct xhci_virt_device {
  */
 struct xhci_device_context_array {
 	/* 64-bit device addresses; we only write 32-bit addresses */
-	u64			dev_context_ptrs[MAX_HC_SLOTS];
+	__le64			dev_context_ptrs[MAX_HC_SLOTS];
 	/* private xHCD pointers */
 	dma_addr_t	dma;
 };
@@ -812,10 +812,10 @@ struct xhci_device_context_array {
 
 struct xhci_transfer_event {
 	/* 64-bit buffer address, or immediate data */
-	u64	buffer;
-	u32	transfer_len;
+	__le64	buffer;
+	__le32	transfer_len;
 	/* This field is interpreted differently based on the type of TRB */
-	u32	flags;
+	__le32	flags;
 };
 
 /** Transfer Event bit fields **/
@@ -894,9 +894,9 @@ struct xhci_transfer_event {
 
 struct xhci_link_trb {
 	/* 64-bit segment pointer*/
-	u64 segment_ptr;
-	u32 intr_target;
-	u32 control;
+	__le64 segment_ptr;
+	__le32 intr_target;
+	__le32 control;
 };
 
 /* control bitfields */
@@ -905,9 +905,9 @@ struct xhci_link_trb {
 /* Command completion event TRB */
 struct xhci_event_cmd {
 	/* Pointer to command TRB, or the value passed by the event data trb */
-	u64 cmd_trb;
-	u32 status;
-	u32 flags;
+	__le64 cmd_trb;
+	__le32 status;
+	__le32 flags;
 };
 
 /* flags bitmasks */
@@ -966,7 +966,7 @@ struct xhci_event_cmd {
 #define TRB_SIA			(1<<31)
 
 struct xhci_generic_trb {
-	u32 field[4];
+	__le32 field[4];
 };
 
 union xhci_trb {
@@ -1114,10 +1114,10 @@ struct xhci_ring {
 
 struct xhci_erst_entry {
 	/* 64-bit event ring segment address */
-	u64	seg_addr;
-	u32	seg_size;
+	__le64	seg_addr;
+	__le32	seg_size;
 	/* Set to zero */
-	u32	rsvd;
+	__le32	rsvd;
 };
 
 struct xhci_erst {
@@ -1281,10 +1281,10 @@ struct xhci_hcd {
 	/* Is each xHCI roothub port a USB 3.0, USB 2.0, or USB 1.1 port? */
 	u8			*port_array;
 	/* Array of pointers to USB 3.0 PORTSC registers */
-	u32 __iomem		**usb3_ports;
+	__le32 __iomem		**usb3_ports;
 	unsigned int		num_usb3_ports;
 	/* Array of pointers to USB 2.0 PORTSC registers */
-	u32 __iomem		**usb2_ports;
+	__le32 __iomem		**usb2_ports;
 	unsigned int		num_usb2_ports;
 };
 
@@ -1317,12 +1317,12 @@ static inline struct usb_hcd *xhci_to_hcd(struct xhci_hcd *xhci)
 /* TODO: copied from ehci.h - can be refactored? */
 /* xHCI spec says all registers are little endian */
 static inline unsigned int xhci_readl(const struct xhci_hcd *xhci,
-		__u32 __iomem *regs)
+		__le32 __iomem *regs)
 {
 	return readl(regs);
 }
 static inline void xhci_writel(struct xhci_hcd *xhci,
-		const unsigned int val, __u32 __iomem *regs)
+		const unsigned int val, __le32 __iomem *regs)
 {
 	xhci_dbg(xhci,
 			"`MEM_WRITE_DWORD(3'b000, 32'h%p, 32'h%0x, 4'hf);\n",
@@ -1340,7 +1340,7 @@ static inline void xhci_writel(struct xhci_hcd *xhci,
  * the high dword, and write order is irrelevant.
  */
 static inline u64 xhci_read_64(const struct xhci_hcd *xhci,
-		__u64 __iomem *regs)
+		__le64 __iomem *regs)
 {
 	__u32 __iomem *ptr = (__u32 __iomem *) regs;
 	u64 val_lo = readl(ptr);
@@ -1348,7 +1348,7 @@ static inline u64 xhci_read_64(const struct xhci_hcd *xhci,
 	return val_lo + (val_hi << 32);
 }
 static inline void xhci_write_64(struct xhci_hcd *xhci,
-		const u64 val, __u64 __iomem *regs)
+				 const u64 val, __le64 __iomem *regs)
 {
 	__u32 __iomem *ptr = (__u32 __iomem *) regs;
 	u32 val_lo = lower_32_bits(val);
-- 
1.7.0.4
