Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.varma-el.com",
	Issuer "mail.varma-el.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3AD2D6875C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Nov 2005 05:54:37 +1100 (EST)
Message-ID: <437A2EE8.4050404@varma-el.com>
Date: Tue, 15 Nov 2005 21:54:32 +0300
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
Content-Type: multipart/mixed; boundary="------------030104070109080504070906"
Cc: linux-kernel@vger.kernel.org,
	ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 1/1 kernel 2.6.15-rc1] Fix copy-paste bug after _Convert
 platform drivers to use_ (again)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030104070109080504070906
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit

Hello Russell,

I fear it is not a last patch of such kind :(.
Please recheck places where you are changed
pdev<->dev.

-- 
Regards
Andrey Volkov


--------------030104070109080504070906
Content-Type: text/plain;
 name="ohci-ohci-ppc-soc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ohci-ohci-ppc-soc.diff"

Fix copy-paste bug in ohci-ppc-soc.c(ohci_hcd_ppc_soc_drv_remove)

Sign-off-by: Andrey Volkov <avolkov@varma-el.com>
---

diff --git a/drivers/usb/host/ohci-ppc-soc.c b/drivers/usb/host/ohci-ppc-soc.c
index 1875576..2ec6a78 100644
--- a/drivers/usb/host/ohci-ppc-soc.c
+++ b/drivers/usb/host/ohci-ppc-soc.c
@@ -185,7 +185,7 @@ static int ohci_hcd_ppc_soc_drv_probe(st
 
 static int ohci_hcd_ppc_soc_drv_remove(struct platform_device *pdev)
 {
-	struct usb_hcd *hcd = platform_get_drvdata(dev);
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 
 	usb_hcd_ppc_soc_remove(hcd, pdev);
 	return 0;

--------------030104070109080504070906--
