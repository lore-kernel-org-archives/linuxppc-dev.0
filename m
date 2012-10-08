Return-Path: <R1AAHA@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 23E642C0316
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2012 08:49:53 +1100 (EST)
Date: Mon, 8 Oct 2012 16:47:31 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-usb@vger.kernel.org>
Subject: [PATCH] powerpc/usb: fix build warning
Message-ID: <20121008164731.75483b961a01e824731c552b@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 3735ba8db8e6ea22ad3ff524328926d8d780a884 "powerpc/usb: fix bug of
CPU hang when missing USB PHY clock" introduced a new build warning:

In file included from linux/drivers/usb/host/ehci-hcd.c:1208:0:
linux/drivers/usb/host/ehci-fsl.c: In function 'ehci_fsl_setup_phy':
linux/drivers/usb/host/ehci-fsl.c:225:3: warning: 'return' with no value, in function returning non-void [-Wreturn-type]

this fixes it.

Cc: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 drivers/usb/host/ehci-fsl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 9bfde82..968f751 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -222,7 +222,7 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
 
 	if (pdata->controller_ver < 0) {
 		dev_warn(hcd->self.controller, "Could not get controller version\n");
-		return;
+		return -EINVAL;
 	}
 
 	portsc = ehci_readl(ehci, &ehci->regs->port_status[port_offset]);
-- 
1.7.12.2
