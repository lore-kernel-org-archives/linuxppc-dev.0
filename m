Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 54F46474D3
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 03:03:33 +1100 (EST)
Date: Tue, 11 Nov 2008 19:03:30 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Brownell <dbrownell@users.sourceforge.net>
Subject: [PATCH 3/6] usb/fsl_qe_udc: Fix QE USB controller initialization
Message-ID: <20081111160330.GC24699@oksana.dev.rtsoft.ru>
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

qe_udc_reg_init() leaves the USB controller enabled before muram memory
initialized. Sometimes the uninitialized muram memory confuses the
controller, and it start sending the busy interrupts.

Fix this by disabling the controller, it will be enabled later by
the gadget driver, at bind time.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/usb/gadget/fsl_qe_udc.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
index abcb35d..1789f65 100644
--- a/drivers/usb/gadget/fsl_qe_udc.c
+++ b/drivers/usb/gadget/fsl_qe_udc.c
@@ -2449,8 +2449,12 @@ static int __devinit qe_udc_reg_init(struct qe_udc *udc)
 	struct usb_ctlr __iomem *qe_usbregs;
 	qe_usbregs = udc->usb_regs;
 
-	/* Init the usb register */
+	/* Spec says that we must enable the USB controller to change mode. */
 	out_8(&qe_usbregs->usb_usmod, 0x01);
+	/* Mode changed, now disable it, since muram isn't initialized yet. */
+	out_8(&qe_usbregs->usb_usmod, 0x00);
+
+	/* Initialize the rest. */
 	out_be16(&qe_usbregs->usb_usbmr, 0);
 	out_8(&qe_usbregs->usb_uscom, 0);
 	out_be16(&qe_usbregs->usb_usber, USBER_ALL_CLEAR);
-- 
1.5.6.3
