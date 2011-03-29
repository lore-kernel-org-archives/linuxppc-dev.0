Return-Path: <dtor@vmware.com>
Date: Tue, 29 Mar 2011 13:00:17 -0700
From: Dmitry Torokhov <dtor@vmware.com>
To: Matt Evans <matt@ozlabs.org>
Subject: Re: [PATCH v2 5/5] xhci: Remove recursive call to xhci_handle_event
Message-ID: <20110329200017.GA25480@dtor-ws.eng.vmware.com>
References: <4D8C47D8.4020901@ozlabs.org> <4D8C8F2B.9090808@ru.mvista.com>
	<4D90142C.4050206@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/Plain; charset=us-ascii
In-Reply-To: <4D90142C.4050206@ozlabs.org>
Cc: sarah.a.sharp@linux.intel.com, linuxppc-dev@ozlabs.org,
	linux-usb@vger.kernel.org, Sergei Shtylyov <sshtylyov@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sunday, March 27, 2011 09:53:00 pm Matt Evans wrote:
> @@ -2282,7 +2284,7 @@ hw_died:
>  	/* FIXME this should be a delayed service routine
>  	 * that clears the EHB.
>  	 */
> -	xhci_handle_event(xhci);
> +	while (xhci_handle_event(xhci)) {}
> 

I must admit I dislike the style with empty loop bodies, do you think
we could have something like below instead?

Thanks!

-- 
Dmitry

From: Dmitry Torokhov <dtor@vmware.com>
Subject: [PATCH] USB: xhci: avoid recursion in xhci_handle_event

Instead of having xhci_handle_event call itself if there are more
outstanding TRBs push the loop logic up one level, into xhci_irq().

xchI_handle_event() does not check for presence of event_ring
anymore since the ring is always allocated. Also, encountering
a TRB that does not belong to OS is a normal condition that
causes us to stop processing and exit ISR and so is not reported
in xhci->error_bitmask.

Also consolidate handling of the event handler busy flag in
xhci_irq().

Reported-by: Matt Evans <matt@ozlabs.org>
Signed-off-by: Dmitry Torokhov <dtor@vmware.com>
---
 drivers/usb/host/xhci-ring.c |   77 +++++++++++++++---------------------------
 1 files changed, 27 insertions(+), 50 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 0e30281..8e6d8fa 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2131,26 +2131,12 @@ cleanup:
  * This function handles all OS-owned events on the event ring.  It may drop
  * xhci->lock between event processing (e.g. to pass up port status changes).
  */
-static void xhci_handle_event(struct xhci_hcd *xhci)
+static void xhci_handle_event(struct xhci_hcd *xhci, union xhci_trb *event)
 {
-	union xhci_trb *event;
-	int update_ptrs = 1;
+	bool update_ptrs = true;
 	int ret;
 
 	xhci_dbg(xhci, "In %s\n", __func__);
-	if (!xhci->event_ring || !xhci->event_ring->dequeue) {
-		xhci->error_bitmask |= 1 << 1;
-		return;
-	}
-
-	event = xhci->event_ring->dequeue;
-	/* Does the HC or OS own the TRB? */
-	if ((event->event_cmd.flags & TRB_CYCLE) !=
-			xhci->event_ring->cycle_state) {
-		xhci->error_bitmask |= 1 << 2;
-		return;
-	}
-	xhci_dbg(xhci, "%s - OS owns TRB\n", __func__);
 
 	/* FIXME: Handle more event types. */
 	switch ((event->event_cmd.flags & TRB_TYPE_BITMASK)) {
@@ -2163,7 +2149,7 @@ static void xhci_handle_event(struct xhci_hcd *xhci)
 		xhci_dbg(xhci, "%s - calling handle_port_status\n", __func__);
 		handle_port_status(xhci, event);
 		xhci_dbg(xhci, "%s - returned from handle_port_status\n", __func__);
-		update_ptrs = 0;
+		update_ptrs = false;
 		break;
 	case TRB_TYPE(TRB_TRANSFER):
 		xhci_dbg(xhci, "%s - calling handle_tx_event\n", __func__);
@@ -2172,7 +2158,7 @@ static void xhci_handle_event(struct xhci_hcd *xhci)
 		if (ret < 0)
 			xhci->error_bitmask |= 1 << 9;
 		else
-			update_ptrs = 0;
+			update_ptrs = false;
 		break;
 	default:
 		if ((event->event_cmd.flags & TRB_TYPE_BITMASK) >= TRB_TYPE(48))
@@ -2180,21 +2166,9 @@ static void xhci_handle_event(struct xhci_hcd *xhci)
 		else
 			xhci->error_bitmask |= 1 << 3;
 	}
-	/* Any of the above functions may drop and re-acquire the lock, so check
-	 * to make sure a watchdog timer didn't mark the host as non-responsive.
-	 */
-	if (xhci->xhc_state & XHCI_STATE_DYING) {
-		xhci_dbg(xhci, "xHCI host dying, returning from "
-				"event handler.\n");
-		return;
-	}
 
 	if (update_ptrs)
-		/* Update SW event ring dequeue pointer */
 		inc_deq(xhci, xhci->event_ring, true);
-
-	/* Are there more items on the event ring? */
-	xhci_handle_event(xhci);
 }
 
 /*
@@ -2258,34 +2232,37 @@ hw_died:
 		xhci_writel(xhci, irq_pending, &xhci->ir_set->irq_pending);
 	}
 
-	if (xhci->xhc_state & XHCI_STATE_DYING) {
-		xhci_dbg(xhci, "xHCI dying, ignoring interrupt. "
-				"Shouldn't IRQs be disabled?\n");
-		/* Clear the event handler busy flag (RW1C);
-		 * the event ring should be empty.
-		 */
-		temp_64 = xhci_read_64(xhci, &xhci->ir_set->erst_dequeue);
-		xhci_write_64(xhci, temp_64 | ERST_EHB,
-				&xhci->ir_set->erst_dequeue);
-		spin_unlock(&xhci->lock);
-
-		return IRQ_HANDLED;
-	}
-
 	event_ring_deq = xhci->event_ring->dequeue;
+
 	/* FIXME this should be a delayed service routine
 	 * that clears the EHB.
 	 */
-	xhci_handle_event(xhci);
+	xhci_dbg(xhci, "%s - Begin processing TRBs\n", __func__);
+
+	while (!(xhci->xhc_state & XHCI_STATE_DYING)) {
+		union xhci_trb *event = xhci->event_ring->dequeue;
+
+		/* Does the HC or OS own the TRB? */
+		if ((event->event_cmd.flags & TRB_CYCLE) !=
+				xhci->event_ring->cycle_state) {
+			break;
+		}
+
+		xhci_dbg(xhci, "%s - OS owns TRB\n", __func__);
+		xhci_handle_event(xhci, event);
+	}
 
 	temp_64 = xhci_read_64(xhci, &xhci->ir_set->erst_dequeue);
-	/* If necessary, update the HW's version of the event ring deq ptr. */
-	if (event_ring_deq != xhci->event_ring->dequeue) {
+
+	if (unlikely(xhci->xhc_state & XHCI_STATE_DYING)) {
+		xhci_dbg(xhci, "%s: xHCI is dying, exiting ISR\n", __func__);
+	} else if (event_ring_deq != xhci->event_ring->dequeue) {
+		/* Update the HW's version of the event ring deq ptr. */
 		deq = xhci_trb_virt_to_dma(xhci->event_ring->deq_seg,
-				xhci->event_ring->dequeue);
+					xhci->event_ring->dequeue);
 		if (deq == 0)
-			xhci_warn(xhci, "WARN something wrong with SW event "
-					"ring dequeue ptr.\n");
+			xhci_warn(xhci,
+				  "WARN something wrong with SW event ring dequeue ptr.\n");
 		/* Update HC event ring dequeue pointer */
 		temp_64 &= ERST_PTR_MASK;
 		temp_64 |= ((u64) deq & (u64) ~ERST_PTR_MASK);
-- 
1.7.4.1
