Return-Path: <matt@ozlabs.org>
Message-ID: <4D9146B3.8070705@ozlabs.org>
Date: Tue, 29 Mar 2011 13:40:51 +1100
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: [PATCH v3 2/4] xhci: Add rmb() between reading event validity & event
	data access.
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

On weakly-ordered systems, the reading of an event's content must occur
after reading the event's validity.

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 drivers/usb/host/xhci-ring.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 1361032..86c8198 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2150,6 +2150,11 @@ static void xhci_handle_event(struct xhci_hcd *xhci)
 	}
 	xhci_dbg(xhci, "%s - OS owns TRB\n", __func__);
 
+	/*
+	 * Barrier between reading the TRB_CYCLE (valid) flag above and any
+	 * speculative reads of the event's flags/data below.
+	 */
+	rmb();
 	/* FIXME: Handle more event types. */
 	switch ((le32_to_cpu(event->event_cmd.flags) & TRB_TYPE_BITMASK)) {
 	case TRB_TYPE(TRB_COMPLETION):
-- 
1.7.0.4
