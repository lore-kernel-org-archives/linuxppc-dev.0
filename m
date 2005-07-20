Return-Path: <jotken@softadvances.com>
Received: from smtpauth01.mail.atl.earthlink.net
	(smtpauth01.mail.atl.earthlink.net [209.86.89.61])
	by ozlabs.org (Postfix) with ESMTP id 6604367CBB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Jul 2005 20:54:45 +1000 (EST)
Message-ID: <42DE2BA1.1080703@softadvances.com>
Date: Wed, 20 Jul 2005 05:46:57 -0500
From: John Otken <jotken@softadvances.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: weissg@vienna.at
Subject: [PATCH] USBcore: fix invalid function name usb_hcd_put in
	ohci-ppc-soc.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This patch corrects an invalid function name in 
drivers/usb/host/ohci-ppc-soc.c.  The correct 
function name is usb_put_hcd() not usb_hcd_put().

This patch works against 2.6.12 or 2.6.13.

Signed-off-by: John Otken <jotken@softadvances.com>

diff -up a/drivers/usb/host/ohci-ppc-soc.c b/drivers/usb/host/ohci-ppc-soc.c
--- a/drivers/usb/host/ohci-ppc-soc.c	2005-07-14 09:48:19.000000000 -0500
+++ b/drivers/usb/host/ohci-ppc-soc.c	2005-06-19 10:18:05.000000000 -0500
@@ -123,7 +123,7 @@ static void usb_hcd_ppc_soc_remove(struc
 
 	iounmap(hcd->regs);
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
-	usb_hcd_put(hcd);
+	usb_put_hcd(hcd);
 }
 
 static int __devinit
