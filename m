Return-Path: <B21989@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 17FD5B6F18
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2011 22:11:36 +1100 (EST)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/usb: use unsigned long to type cast an address of
 ioremap
Date: Thu, 3 Nov 2011 17:58:22 +0800
Message-ID: <1320314302-7973-1-git-send-email-Shaohui.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-usb@vger.kernel.org, Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Below are codes for accessing usb sysif_regs in driver:

usb_sys_regs = (struct usb_sys_interface *)
	((u32)dr_regs + USB_DR_SYS_OFFSET);

these codes work in 32-bit, but in 64-bit, use u32 to type cast the address
of ioremap is not right, and accessing members of 'usb_sys_regs' will cause
call trace, so use unsigned long for both 32-bit and 64-bit.

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
---
 drivers/usb/gadget/fsl_udc_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index c81fbad..581b7cc 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -2498,7 +2498,7 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 #ifndef CONFIG_ARCH_MXC
 	if (pdata->have_sysif_regs)
 		usb_sys_regs = (struct usb_sys_interface *)
-				((u32)dr_regs + USB_DR_SYS_OFFSET);
+				((unsigned long)dr_regs + USB_DR_SYS_OFFSET);
 #endif
 
 	/* Initialize USB clocks */
-- 
1.6.4
