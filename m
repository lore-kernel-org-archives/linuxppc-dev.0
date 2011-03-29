Return-Path: <matt@ozlabs.org>
Message-ID: <4D9146B8.10701@ozlabs.org>
Date: Tue, 29 Mar 2011 13:40:56 +1100
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: [PATCH v3 3/4] xhci: Add an assertion to check for virt_dev=0 bug.
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

During a "plug-unplug" stress test on an NEC xHCI card, a null pointer
dereference was observed.  xhci_address_device() dereferenced a null
virt_dev (possibly an erroneous udev->slot_id?); this patch adds a WARN_ON &
message to aid debug if it can be recreated.

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 drivers/usb/host/xhci.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 3a9f931..d145fa3 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -2533,6 +2533,17 @@ int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev)
 
 	virt_dev = xhci->devs[udev->slot_id];
 
+	if (WARN_ON(!virt_dev)) {
+		/*
+		 * In plug/unplug torture test with an NEC controller,
+		 * a zero-dereference was observed once due to virt_dev = 0.
+		 * Print useful debug rather than crash if it is observed again!
+		 */
+		xhci_warn(xhci, "Virt dev invalid for slot_id 0x%x!\n",
+			udev->slot_id);
+		return -EINVAL;
+	}
+
 	slot_ctx = xhci_get_slot_ctx(xhci, virt_dev->in_ctx);
 	/*
 	 * If this is the first Set Address since device plug-in or
-- 
1.7.0.4
