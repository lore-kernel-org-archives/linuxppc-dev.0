Return-Path: <matt@ozlabs.org>
Message-ID: <4D901429.5010807@ozlabs.org>
Date: Mon, 28 Mar 2011 15:52:57 +1100
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: sarah.a.sharp@linux.intel.com
Subject: [PATCH v2 3/5] xhci: Add rmb() between reading event validity & event
	data access.
References: <4D8C47CD.3020108@ozlabs.org>
	<61164.94.211.195.167.1301094709.squirrel@gate.crashing.org>
In-Reply-To: <61164.94.211.195.167.1301094709.squirrel@gate.crashing.org>
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
Segher, thanks for the comment; explanation added.

 drivers/usb/host/xhci-ring.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 45f3b77..d6aa880 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2152,6 +2152,11 @@ static void xhci_handle_event(struct xhci_hcd *xhci)
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
