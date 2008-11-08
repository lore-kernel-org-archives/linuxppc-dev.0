Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E5110DDDFF
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Nov 2008 04:51:37 +1100 (EST)
Date: Sat, 8 Nov 2008 20:51:34 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Brownell <dbrownell@users.sourceforge.net>
Subject: [PATCH 1/2] powerpc: Update QE/CPM2 usb_ctlr structures for USB
	support
Message-ID: <20081108175134.GA6010@oksana.dev.rtsoft.ru>
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

From: Li Yang <leoli@freescale.com>

Fixes following build error:

  CC      drivers/usb/gadget/fsl_qe_udc.o
drivers/usb/gadget/fsl_qe_udc.c: In function 'qe_eprx_stall_change':
drivers/usb/gadget/fsl_qe_udc.c:156: error: 'struct usb_ctlr' has no member named 'usb_usep'
drivers/usb/gadget/fsl_qe_udc.c:163: error: 'struct usb_ctlr' has no member named 'usb_usep'
drivers/usb/gadget/fsl_qe_udc.c: In function 'qe_eptx_stall_change':
drivers/usb/gadget/fsl_qe_udc.c:173: error: 'struct usb_ctlr' has no member named 'usb_usep'
drivers/usb/gadget/fsl_qe_udc.c:180: error: 'struct usb_ctlr' has no member named 'usb_usep'
drivers/usb/gadget/fsl_qe_udc.c: In function 'qe_eprx_nack':
drivers/usb/gadget/fsl_qe_udc.c:201: error: 'struct usb_ctlr' has no member named 'usb_usep'
drivers/usb/gadget/fsl_qe_udc.c:201: error: 'struct usb_ctlr' has no member named 'usb_usep'
drivers/usb/gadget/fsl_qe_udc.c: In function 'qe_eprx_normal':
drivers/usb/gadget/fsl_qe_udc.c:218: error: 'struct usb_ctlr' has no member named 'usb_usep'
drivers/usb/gadget/fsl_qe_udc.c:218: error: 'struct usb_ctlr' has no member named 'usb_usep'
drivers/usb/gadget/fsl_qe_udc.c: In function 'qe_ep_reset':
drivers/usb/gadget/fsl_qe_udc.c:325: error: 'struct usb_ctlr' has no member named 'usb_usep'
drivers/usb/gadget/fsl_qe_udc.c:342: error: 'struct usb_ctlr' has no member named 'usb_usep'
drivers/usb/gadget/fsl_qe_udc.c: In function 'qe_ep_register_init':
drivers/usb/gadget/fsl_qe_udc.c:515: error: 'struct usb_ctlr' has no member named 'usb_usep'
drivers/usb/gadget/fsl_qe_udc.c: In function 'ch9getstatus':
drivers/usb/gadget/fsl_qe_udc.c:1981: error: 'struct usb_ctlr' has no member named 'usb_usep'
make[2]: *** [drivers/usb/gadget/fsl_qe_udc.o] Error 1

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/include/asm/immap_cpm2.h |    9 +++------
 arch/powerpc/include/asm/immap_qe.h   |    5 +----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/immap_cpm2.h b/arch/powerpc/include/asm/immap_cpm2.h
index 4080bab..d4f069b 100644
--- a/arch/powerpc/include/asm/immap_cpm2.h
+++ b/arch/powerpc/include/asm/immap_cpm2.h
@@ -554,14 +554,11 @@ typedef struct usb_ctlr {
 	u8	usb_usadr;
 	u8	usb_uscom;
 	u8	res1[1];
-	u16	usb_usep1;
-	u16	usb_usep2;
-	u16	usb_usep3;
-	u16	usb_usep4;
+	__be16  usb_usep[4];
 	u8	res2[4];
-	u16	usb_usber;
+	__be16  usb_usber;
 	u8	res3[2];
-	u16	usb_usbmr;
+	__be16  usb_usbmr;
 	u8	usb_usbs;
 	u8	res4[7];
 } usb_cpm2_t;
diff --git a/arch/powerpc/include/asm/immap_qe.h b/arch/powerpc/include/asm/immap_qe.h
index 3c2fced..c346d0b 100644
--- a/arch/powerpc/include/asm/immap_qe.h
+++ b/arch/powerpc/include/asm/immap_qe.h
@@ -215,10 +215,7 @@ struct usb_ctlr {
 	u8	usb_usadr;
 	u8	usb_uscom;
 	u8	res1[1];
-	__be16	usb_usep1;
-	__be16	usb_usep2;
-	__be16	usb_usep3;
-	__be16	usb_usep4;
+	__be16  usb_usep[4];
 	u8	res2[4];
 	__be16	usb_usber;
 	u8	res3[2];
-- 
1.5.6.3
