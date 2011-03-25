Return-Path: <matt@ozlabs.org>
Message-ID: <4D8C47D8.4020901@ozlabs.org>
Date: Fri, 25 Mar 2011 18:44:24 +1100
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: sarah.a.sharp@linux.intel.com
Subject: [PATCH 5/5] xhci: Remove recursive call to xhci_handle_event
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

Make the caller loop while there are events to handle, instead.

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 drivers/usb/host/xhci-ring.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index b46efd9..97bedd6 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2131,7 +2131,7 @@ cleanup:
  * This function handles all OS-owned events on the event ring.  It may drop
  * xhci->lock between event processing (e.g. to pass up port status changes).
  */
-static void xhci_handle_event(struct xhci_hcd *xhci)
+static int xhci_handle_event(struct xhci_hcd *xhci)
 {
 	union xhci_trb *event;
 	int update_ptrs = 1;
@@ -2140,7 +2140,7 @@ static void xhci_handle_event(struct xhci_hcd *xhci)
 	xhci_dbg(xhci, "In %s\n", __func__);
 	if (!xhci->event_ring || !xhci->event_ring->dequeue) {
 		xhci->error_bitmask |= 1 << 1;
-		return;
+		return 0;
 	}
 
 	event = xhci->event_ring->dequeue;
@@ -2148,7 +2148,7 @@ static void xhci_handle_event(struct xhci_hcd *xhci)
 	if ((le32_to_cpu(event->event_cmd.flags) & TRB_CYCLE) !=
 	    xhci->event_ring->cycle_state) {
 		xhci->error_bitmask |= 1 << 2;
-		return;
+		return 0;
 	}
 	xhci_dbg(xhci, "%s - OS owns TRB\n", __func__);
 	rmb();
@@ -2187,15 +2187,17 @@ static void xhci_handle_event(struct xhci_hcd *xhci)
 	if (xhci->xhc_state & XHCI_STATE_DYING) {
 		xhci_dbg(xhci, "xHCI host dying, returning from "
 				"event handler.\n");
-		return;
+		return 0;
 	}
 
 	if (update_ptrs)
 		/* Update SW event ring dequeue pointer */
 		inc_deq(xhci, xhci->event_ring, true);
 
-	/* Are there more items on the event ring? */
-	xhci_handle_event(xhci);
+	/* Are there more items on the event ring?  Caller will call us again to
+	 * check.
+	 */
+	return 1;
 }
 
 /*
@@ -2277,7 +2279,7 @@ hw_died:
 	/* FIXME this should be a delayed service routine
 	 * that clears the EHB.
 	 */
-	xhci_handle_event(xhci);
+	while (xhci_handle_event(xhci)) {};
 
 	temp_64 = xhci_read_64(xhci, &xhci->ir_set->erst_dequeue);
 	/* If necessary, update the HW's version of the event ring deq ptr. */
-- 
1.7.0.4
