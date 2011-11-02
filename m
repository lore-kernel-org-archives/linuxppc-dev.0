Return-Path: <B21989@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
 [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 8D373B6F6B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2011 19:21:44 +1100 (EST)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/usb: use ioremap instead of base plus offset to
 access regs
Date: Wed, 2 Nov 2011 15:08:28 +0800
Message-ID: <1320217708-32658-1-git-send-email-Shaohui.Xie@freescale.com>
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

these codes work in 32-bit, but in 64-bit, accessing members of 'usb_sys_regs'
will cause call trace like below:

Unable to handle kernel paging request for data at address 0x8817a500
Faulting instruction address: 0x800000000011bae8
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=2 P5020 DS
Modules linked in: fsl_usb2_udc(+)
NIP: 800000000011bae8 LR: 800000000011efb8 CTR: c0000000000ef500
REGS: c0000000f3e2f350 TRAP: 0300   Not tainted  (3.0.6-00001-g0700776)
MSR: 0000000080029000 <EE,ME,CE>  CR: 24000222  XER: 00000000
DEAR: 000000008817a500, ESR: 0000000000000000
TASK = c0000000fb3b8840[3466] 'insmod' THREAD: c0000000f3e2c000 CPU: 1
GPR00: 0000000000000002 c0000000f3e2f5d0 80000000001286b8 c0000000fb2e7c00
GPR04: 00000000000000d0 0000000000000000 c0000000f8b026c0 0000000000000041
GPR08: 0000000000000000 000000008817a400 c000000007653d28 0000000000000000
GPR12: 800000000011f3a8 c00000000ffff400 0000000000000000 0000000000000000
GPR16: 0000000000000000 000000007ff9eee4 0000000000000000 0000000000000000
GPR20: 0000000000000000 00000000100e2645 0000000000000001 0000000000000000
GPR24: c0000000f8b72c10 80000000001208e8 c0000000fb2e7c00 0000000000000000
GPR28: 0000000000000000 c0000000fb2e7c00 8000000000128198 80000000001208e8
NIP [800000000011bae8] .dr_controller_setup+0x318/0x360 [fsl_usb2_udc]
LR [800000000011efb8] .fsl_udc_probe+0x3b4/0x630 [fsl_usb2_udc]
Call Trace:
[c0000000f3e2f5d0] [c0000000f3e2f660] 0xc0000000f3e2f660 (unreliable)
[c0000000f3e2f660] [800000000011efb8] .fsl_udc_probe+0x3b4/0x630 [fsl_usb2_udc]
[c0000000f3e2f730] [c0000000002f2960] .platform_drv_probe+0x30/0x50
[c0000000f3e2f7a0] [c0000000002f0df0] .driver_probe_device+0xe0/0x230
[c0000000f3e2f840] [c0000000002f104c] .__driver_attach+0x10c/0x110
[c0000000f3e2f8d0] [c0000000002ef83c] .bus_for_each_dev+0x7c/0xd0
[c0000000f3e2f970] [c0000000002f08c8] .driver_attach+0x28/0x40
[c0000000f3e2f9f0] [c0000000002f02c0] .bus_add_driver+0xd0/0x310
[c0000000f3e2faa0] [c0000000002f15dc] .driver_register+0x9c/0x1a0
[c0000000f3e2fb40] [c0000000002f2dc0] .platform_driver_register+0x60/0x80
[c0000000f3e2fbc0] [c0000000002f2e14] .platform_driver_probe+0x34/0xf0
[c0000000f3e2fc50] [800000000011f26c] .udc_init+0x38/0x894 [fsl_usb2_udc]
[c0000000f3e2fcd0] [c000000000000eb0] .do_one_initcall+0x60/0x1e0
[c0000000f3e2fd90] [c00000000008a7b0] .SyS_init_module+0xd0/0x220
[c0000000f3e2fe30] [c0000000000005a0] syscall_exit+0x0/0x2c
Instruction dump:
eba1ffe8 ebc1fff0 ebe1fff8 7c0803a6 4e800020 6529c000 793c0020 4bfffdac
65291000 793c0020 e93f0010 7c0004ac
 0c000000 4c00012c 60000204
 ---[ end trace d152129396f60c53 ]---

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
---
 drivers/usb/gadget/fsl_udc_core.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index c81fbad..c656d2c 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -263,9 +263,11 @@ static int dr_controller_setup(struct fsl_udc *udc)
 		/* fall through */
 	case FSL_USB2_PHY_UTMI:
 #ifdef CONFIG_FSL_SOC_BOOKE
+	if (udc->pdata->have_sysif_regs) {
 		setbits32(&usb_sys_regs->control, USB_CTRL_UTMI_PHY_EN |
 			       USB_CTRL_USB_EN);
 		udelay(10*1000);  /* delay for PHY clk to ready */
+	}
 #endif
 		portctrl |= PORTSCX_PTS_UTMI;
 		break;
@@ -986,7 +988,7 @@ static int fsl_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 					queue);
 
 			/* Point the QH to the first TD of next request */
-			fsl_writel((u32) next_req->head, &qh->curr_dtd_ptr);
+			fsl_writel(*(u32 *) next_req->head, &qh->curr_dtd_ptr);
 		}
 
 		/* The request hasn't been processed, patch up the TD chain */
@@ -2497,8 +2499,8 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 
 #ifndef CONFIG_ARCH_MXC
 	if (pdata->have_sysif_regs)
-		usb_sys_regs = (struct usb_sys_interface *)
-				((u32)dr_regs + USB_DR_SYS_OFFSET);
+		usb_sys_regs = ioremap(res->start + USB_DR_SYS_OFFSET,
+				sizeof(struct usb_sys_interface)/sizeof(int));
 #endif
 
 	/* Initialize USB clocks */
-- 
1.6.4
