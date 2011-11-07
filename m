Return-Path: <B21989@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id ECCCEB6F18
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2011 21:11:43 +1100 (EST)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH][v2] powerpc/usb: fix type cast for address of ioremap to
 compatible with 64-bit
Date: Mon, 7 Nov 2011 16:58:20 +0800
Message-ID: <1320656300-32360-1-git-send-email-Shaohui.Xie@freescale.com>
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
call trace, so use (void *) for both 32-bit and 64-bit.

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
---
changes for v2:
1. use (void *) instead of unsigned long and the double cast according
to Timur's comment.

 drivers/usb/gadget/fsl_udc_core.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index c81fbad..398c5e6 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -2497,8 +2497,7 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 
 #ifndef CONFIG_ARCH_MXC
 	if (pdata->have_sysif_regs)
-		usb_sys_regs = (struct usb_sys_interface *)
-				((u32)dr_regs + USB_DR_SYS_OFFSET);
+		usb_sys_regs = (void *)dr_regs + USB_DR_SYS_OFFSET;
 #endif
 
 	/* Initialize USB clocks */
-- 
1.6.4
