Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E7A68DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 06:29:54 +1100 (EST)
Date: Wed, 12 Nov 2008 22:29:53 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Brownell <dbrownell@users.sourceforge.net>
Subject: [PATCH] usb/fsl_usb2_udc: Report disconnect before unbinding
Message-ID: <20081112192953.GA25565@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
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

Gadgets disable endpoints in their disconnect callbacks, so
we must call disconnect before unbinding.

The patch fixes following badness:

root@b1:~# insmod fsl_usb2_udc.ko
Freescale High-Speed USB SOC Device Controller driver (Apr 20, 2007)
root@b1:~# insmod g_ether.ko
g_ether gadget: using random self ethernet address
g_ether gadget: using random host ethernet address
usb0: MAC 26:07:ba:c0:44:33
usb0: HOST MAC 96:81:0c:05:4d:e3
g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
g_ether gadget: g_ether ready
fsl-usb2-udc: bind to driver g_ether
g_ether gadget: high speed config #1: CDC Ethernet (ECM)
root@b1:~# rmmod g_ether.ko
------------[ cut here ]------------
Badness at drivers/usb/gadget/composite.c:871
[...]
NIP [e10c3454] composite_unbind+0x24/0x15c [g_ether]
LR [e10aa454] usb_gadget_unregister_driver+0x13c/0x164 [fsl_usb2_udc]
Call Trace:
[df145e80] [ffffff94] 0xffffff94 (unreliable)
[df145eb0] [e10aa454] usb_gadget_unregister_driver+0x13c/0x164 [fsl_usb2_udc]
[df145ed0] [e10c4c40] usb_composite_unregister+0x3c/0x4c [g_ether]
[df145ee0] [c006bcc0] sys_delete_module+0x130/0x19c
[df145f40] [c00142d8] ret_from_syscall+0x0/0x38
[...]
unregistered gadget driver 'g_ether'

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

This is not a duplicate email, this patch is for other driver. ;-)

 drivers/usb/gadget/fsl_usb2_udc.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/fsl_usb2_udc.c b/drivers/usb/gadget/fsl_usb2_udc.c
index 091bb55..b4cd017 100644
--- a/drivers/usb/gadget/fsl_usb2_udc.c
+++ b/drivers/usb/gadget/fsl_usb2_udc.c
@@ -1836,6 +1836,9 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 		nuke(loop_ep, -ESHUTDOWN);
 	spin_unlock_irqrestore(&udc_controller->lock, flags);
 
+	/* report disconnect; the driver is already quiesced */
+	driver->disconnect(&udc_controller->gadget);
+
 	/* unbind gadget and unhook driver. */
 	driver->unbind(&udc_controller->gadget);
 	udc_controller->gadget.dev.driver = NULL;
-- 
1.5.6.3
