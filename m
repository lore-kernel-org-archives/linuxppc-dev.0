Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4C882DDE45
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 06:36:41 +1000 (EST)
To: Greg KH <greg@kroah.com>
From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH] [serial gadget] Disable endpoints on unload
Date: Thu, 27 Sep 2007 00:36:22 +0400
Message-ID: <20070926203622.24118.36016.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


After Serial gadget is being unloaded, neither serial itself, nor other
gadget stuff can be loaded subsequently.

Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>

---

 drivers/usb/gadget/serial.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)


diff --git a/drivers/usb/gadget/serial.c b/drivers/usb/gadget/serial.c
index ce4d2e0..594284a 100644
--- a/drivers/usb/gadget/serial.c
+++ b/drivers/usb/gadget/serial.c
@@ -1487,6 +1487,12 @@ static void /* __init_or_exit */ gs_unbind(struct usb_gadget *gadget)
 			dev->dev_ctrl_req = NULL;
 		}
 		gs_free_ports(dev);
+		if (dev->dev_notify_ep)
+			usb_ep_disable(dev->dev_notify_ep);
+		if (dev->dev_in_ep)
+			usb_ep_disable(dev->dev_in_ep);
+		if (dev->dev_out_ep)
+			usb_ep_disable(dev->dev_out_ep);
 		kfree(dev);
 		set_gadget_data(gadget, NULL);
 	}
