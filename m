Return-Path: <r.baldyga@samsung.com>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 23D131A081F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 16:33:06 +1000 (AEST)
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NRI01H5SNJ3WQ80@mailout1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Wed, 15 Jul 2015 15:33:03 +0900 (KST)
From: Robert Baldyga <r.baldyga@samsung.com>
To: gregkh@linuxfoundation.org, balbi@ti.com
Cc: Peter.Chen@freescale.com, johnyoun@synopsys.com, dahlmann.thomas@arcor.de,
 nicolas.ferre@atmel.com, cernekee@gmail.com, leoli@freescale.com,
 daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
 michal.simek@xilinx.com, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-geode@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 andrzej.p@samsung.com, m.szyprowski@samsung.com,
 Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v3 01/46] usb: gadget: encapsulate endpoint claiming mechanism
Date: Wed, 15 Jul 2015 08:31:48 +0200
Message-id: <1436941953-1327-2-git-send-email-r.baldyga@samsung.com>
In-reply-to: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
References: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So far it was necessary for usb functions to set ep->driver_data in
endpoint obtained from autoconfig to non-null value, to indicate that
endpoint is claimed by function (in autoconfig it was checked if endpoint
has set this field to non-null value, and if it has, it was assumed that
it is claimed). It could cause bugs becouse if some function doesn't
set this field autoconfig could return the same endpoint more than one
time.

To help to avoid such bugs this patch adds claimed flag to struct usb_ep,
and  encapsulates endpoint claiming mechanism inside usb_ep_autoconfig_ss()
and usb_ep_autoconfig_reset(), so now usb functions don't need to perform
any additional actions to mark endpoint obtained from autoconfig as claimed.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/epautoconf.c | 11 ++++++-----
 include/linux/usb/gadget.h      |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 919cdfd..8e00ca7 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -53,7 +53,7 @@ ep_matches (
 	int		num_req_streams = 0;
 
 	/* endpoint already claimed? */
-	if (NULL != ep->driver_data)
+	if (ep->claimed)
 		return 0;
 
 	/* only support ep0 for portable CONTROL traffic */
@@ -240,7 +240,7 @@ find_ep (struct usb_gadget *gadget, const char *name)
  * updated with the assigned number of streams if it is
  * different from the original value. To prevent the endpoint
  * from being returned by a later autoconfig call, claim it by
- * assigning ep->driver_data to some non-null value.
+ * assigning ep->claimed to true.
  *
  * On failure, this returns a null endpoint descriptor.
  */
@@ -323,6 +323,7 @@ struct usb_ep *usb_ep_autoconfig_ss(
 found_ep:
 	ep->desc = NULL;
 	ep->comp_desc = NULL;
+	ep->claimed = true;
 	return ep;
 }
 EXPORT_SYMBOL_GPL(usb_ep_autoconfig_ss);
@@ -354,7 +355,7 @@ EXPORT_SYMBOL_GPL(usb_ep_autoconfig_ss);
  * descriptor bEndpointAddress.  For bulk endpoints, the wMaxPacket value
  * is initialized as if the endpoint were used at full speed.  To prevent
  * the endpoint from being returned by a later autoconfig call, claim it
- * by assigning ep->driver_data to some non-null value.
+ * by assigning ep->claimed to true.
  *
  * On failure, this returns a null endpoint descriptor.
  */
@@ -373,7 +374,7 @@ EXPORT_SYMBOL_GPL(usb_ep_autoconfig);
  *
  * Use this for devices where one configuration may need to assign
  * endpoint resources very differently from the next one.  It clears
- * state such as ep->driver_data and the record of assigned endpoints
+ * state such as ep->claimed and the record of assigned endpoints
  * used by usb_ep_autoconfig().
  */
 void usb_ep_autoconfig_reset (struct usb_gadget *gadget)
@@ -381,7 +382,7 @@ void usb_ep_autoconfig_reset (struct usb_gadget *gadget)
 	struct usb_ep	*ep;
 
 	list_for_each_entry (ep, &gadget->ep_list, ep_list) {
-		ep->driver_data = NULL;
+		ep->claimed = false;
 	}
 	gadget->in_epnum = 0;
 	gadget->out_epnum = 0;
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 4f3dfb7..fcb0a4e 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -173,6 +173,7 @@ struct usb_ep {
 	const char		*name;
 	const struct usb_ep_ops	*ops;
 	struct list_head	ep_list;
+	bool			claimed;
 	unsigned		maxpacket:16;
 	unsigned		maxpacket_limit:16;
 	unsigned		max_streams:16;
-- 
1.9.1
