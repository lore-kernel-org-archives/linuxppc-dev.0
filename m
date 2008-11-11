Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 06441474DB
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 03:03:39 +1100 (EST)
Date: Tue, 11 Nov 2008 19:03:34 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Brownell <dbrownell@users.sourceforge.net>
Subject: [PATCH 4/6] usb/fsl_qe_udc: Fix disconnects reporting during bus reset
Message-ID: <20081111160334.GD24699@oksana.dev.rtsoft.ru>
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

Freescale QE UDC controllers can't report the "port change" states,
so the only way to handle disconnects is to process bus reset
interrupts. The bus reset can take some time, that is, few irqs.
Gadgets may print the disconnection events, and this causes few
repetitive messages in the kernel log.

This patch fixes the issue by using the usb_state machine, if the
usb controller has been already reset, just quit the reset irq
early.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/usb/gadget/fsl_qe_udc.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
index 1789f65..7bb5f36 100644
--- a/drivers/usb/gadget/fsl_qe_udc.c
+++ b/drivers/usb/gadget/fsl_qe_udc.c
@@ -2161,6 +2161,9 @@ static int reset_irq(struct qe_udc *udc)
 {
 	unsigned char i;
 
+	if (udc->usb_state == USB_STATE_DEFAULT)
+		return 0;
+
 	qe_usb_disable();
 	out_8(&udc->usb_regs->usb_usadr, 0);
 
-- 
1.5.6.3
