Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8303D47549
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Dec 2008 01:15:16 +1100 (EST)
Date: Thu, 25 Dec 2008 17:15:14 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Greg Kroah-Hartman <greg@kroah.com>
Subject: [PATCH 6/6] USB: fsl_qe_udc: Fix stalled TX requests bug
Message-ID: <20081225141514.GF6786@oksana.dev.rtsoft.ru>
References: <20081225141402.GA30689@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081225141402.GA30689@oksana.dev.rtsoft.ru>
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
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

This patch fixes a bug I'm observing with ethernet gadget while
playing with ifconfig usb0 up/down (the up/down sequence disables
and enables `in' and `out' endpoints).

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Acked-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/usb/gadget/fsl_qe_udc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
index ea42088..69ccbeb 100644
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
1.5.6.5
