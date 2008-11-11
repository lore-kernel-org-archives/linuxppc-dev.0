Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 77916474E1
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 03:03:49 +1100 (EST)
Date: Tue, 11 Nov 2008 19:03:44 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Brownell <dbrownell@users.sourceforge.net>
Subject: [PATCH 6/6] usb/fsl_qe_udc: Fix stalled TX requests bug
Message-ID: <20081111160344.GF24699@oksana.dev.rtsoft.ru>
References: <20081111160153.GA12783@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20081111160153.GA12783@oksana.dev.rtsoft.ru>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Li Yang <leoli@freescale.com>,
	linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

While disabling an endpoint the driver nuking any pending requests,
thus completing them with -ESHUTDOWN status. But the driver doesn't
clear the tx_req, which means that a next TX request (after
ep_enable), might get stalled, since the driver won't queue the new
reqests.

This fixes a bug I'm observing with ethernet gadget while playing
with ifconfig usb0 up/down (the up/down sequence disables and
enables `in' and `out' endpoints).

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/usb/gadget/fsl_qe_udc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
index cb47337..37c8575 100644
--- a/drivers/usb/gadget/fsl_qe_udc.c
+++ b/drivers/usb/gadget/fsl_qe_udc.c
@@ -1622,6 +1622,7 @@ static int qe_ep_disable(struct usb_ep *_ep)
 	nuke(ep, -ESHUTDOWN);
 	ep->desc = NULL;
 	ep->stopped = 1;
+	ep->tx_req = NULL;
 	qe_ep_reset(udc, ep->epnum);
 	spin_unlock_irqrestore(&udc->lock, flags);
 
-- 
1.5.6.3
