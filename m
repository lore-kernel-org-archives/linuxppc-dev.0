Return-Path: <matt@ozlabs.org>
Message-ID: <4D8C47CD.3020108@ozlabs.org>
Date: Fri, 25 Mar 2011 18:44:13 +1100
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: sarah.a.sharp@linux.intel.com
Subject: [PATCH 3/5] xhci: Add rmb() between reading event validity & event
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
 drivers/usb/host/xhci-ring.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 45f3b77..b46efd9 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2151,7 +2151,7 @@ static void xhci_handle_event(struct xhci_hcd *xhci)
 		return;
 	}
 	xhci_dbg(xhci, "%s - OS owns TRB\n", __func__);
-
+	rmb();
 	/* FIXME: Handle more event types. */
 	switch ((le32_to_cpu(event->event_cmd.flags) & TRB_TYPE_BITMASK)) {
 	case TRB_TYPE(TRB_COMPLETION):
-- 
1.7.0.4
