Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 05DB5DDDEE
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 22:57:22 +1100 (EST)
Date: Thu, 13 Nov 2008 14:57:20 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Brownell <dbrownell@users.sourceforge.net>
Subject: [PATCH v2] usb/fsl_qe_udc: Report disconnect before unbinding
Message-ID: <20081113115720.GA28276@oksana.dev.rtsoft.ru>
References: <20081112185627.GA17699@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20081112185627.GA17699@oksana.dev.rtsoft.ru>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Li Yang <leoli@freescale.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gadgets disable endpoints in their disconnect callbacks, so
we must call disconnect before unbinding. This also fixes
muram memory leak, since we free muram in the qe_ep_disable().

But mainly the patch fixes following badness:

root@b1:~# insmod fsl_qe_udc.ko
fsl_qe_udc: Freescale QE/CPM USB Device Controller driver, 1.0
fsl_qe_udc e01006c0.usb: QE USB controller initialized as device
root@b1:~# insmod g_ether.ko
g_ether gadget: using random self ethernet address
g_ether gadget: using random host ethernet address
usb0: MAC be:2d:3c:fa:be:f0
usb0: HOST MAC 62:b8:6a:df:38:66
g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
g_ether gadget: g_ether ready
fsl_qe_udc e01006c0.usb: fsl_qe_udc bind to driver g_ether
g_ether gadget: high speed config #1: CDC Ethernet (ECM)
root@b1:~# rmmod g_ether.ko
------------[ cut here ]------------
Badness at drivers/usb/gadget/composite.c:871
[...]
NIP [d10c1374] composite_unbind+0x24/0x15c [g_ether]
LR [d10a82f4] usb_gadget_unregister_driver+0x128/0x168 [fsl_qe_udc]
Call Trace:
[cfb93e80] [cfb1f3a0] 0xcfb1f3a0 (unreliable)
[cfb93eb0] [d10a82f4] usb_gadget_unregister_driver+0x128/0x168 [fsl_qe_udc]
[cfb93ed0] [d10c2a3c] usb_composite_unregister+0x3c/0x4c [g_ether]
[cfb93ee0] [c006bde0] sys_delete_module+0x130/0x19c
[cfb93f40] [c00142d8] ret_from_syscall+0x0/0x38
[...]
fsl_qe_udc e01006c0.usb: unregistered gadget driver 'g_ether'

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

v2:
- Comment update per Alan Stern review.

replaces
usb.current/usb-fsl_qe_udc-report-disconnect-before-unbinding-fixing-oopses.patch

 drivers/usb/gadget/fsl_qe_udc.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
index 37c8575..3d6c956 100644
--- a/drivers/usb/gadget/fsl_qe_udc.c
+++ b/drivers/usb/gadget/fsl_qe_udc.c
@@ -2382,6 +2382,9 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 		nuke(loop_ep, -ESHUTDOWN);
 	spin_unlock_irqrestore(&udc_controller->lock, flags);
 
+	/* report disconnect; the controller is already quiesced */
+	driver->disconnect(&udc_controller->gadget);
+
 	/* unbind gadget and unhook driver. */
 	driver->unbind(&udc_controller->gadget);
 	udc_controller->gadget.dev.driver = NULL;
-- 
1.5.6.3
