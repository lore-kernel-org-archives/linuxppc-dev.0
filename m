Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B32C0474DB
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Dec 2008 01:15:14 +1100 (EST)
Date: Thu, 25 Dec 2008 17:15:11 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Greg Kroah-Hartman <greg@kroah.com>
Subject: [PATCH 5/6] USB: fsl_qe_udc: Fix muram corruption by disabled
	endpoints
Message-ID: <20081225141511.GE6786@oksana.dev.rtsoft.ru>
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

Before freeing an endpoint's muram memory, we should stop all activity
of the endpoint, otherwise the QE UDC controller might do nasty things
with the muram memory that isn't belong to that endpoint anymore.

The qe_ep_reset() effectively flushes the hardware fifos, finishes all
late transaction and thus prevents the corruption.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Acked-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/usb/gadget/fsl_qe_udc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
index 4726582..ea42088 100644
--- a/drivers/usb/gadget/fsl_qe_udc.c
+++ b/drivers/usb/gadget/fsl_qe_udc.c
@@ -1622,6 +1622,7 @@ static int qe_ep_disable(struct usb_ep *_ep)
 	nuke(ep, -ESHUTDOWN);
 	ep->desc = NULL;
 	ep->stopped = 1;
+	qe_ep_reset(udc, ep->epnum);
 	spin_unlock_irqrestore(&udc->lock, flags);
 
 	cpm_muram_free(cpm_muram_offset(ep->rxbase));
-- 
1.5.6.5
