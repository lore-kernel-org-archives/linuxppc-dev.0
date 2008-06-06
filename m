Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 28E87DDEFF
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 08:57:58 +1000 (EST)
Subject: patch usb-isp1760-assign-resource-fields-before-adding-hcd.patch
	added to gregkh-2.6 tree
To: ncase@xes-inc.com, bigeasy@linutronix.de, gregkh@suse.de,
	linuxppc-dev@ozlabs.org
From: <gregkh@suse.de>
Date: Fri, 06 Jun 2008 15:52:15 -0700
In-Reply-To: <1211405300.13845.627.camel@localhost.localdomain>
Message-ID: <12127927354068@kroah.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

     Subject: USB: isp1760: Assign resource fields before adding hcd

to my gregkh-2.6 tree.  Its filename is

     usb-isp1760-assign-resource-fields-before-adding-hcd.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From ncase@xes-inc.com  Fri Jun  6 15:07:08 2008
From: Nate Case <ncase@xes-inc.com>
Date: Wed, 21 May 2008 16:28:20 -0500
Subject: USB: isp1760: Assign resource fields before adding hcd
To: Sebastian Siewior <bigeasy@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org, linuxppc-dev <linuxppc-dev@ozlabs.org>
Message-ID: <1211405300.13845.627.camel@localhost.localdomain>


This fixes the bogus "io mem 0x00000000" message printed
during driver init due to hcd->rsrc_start being assigned after
the call to usb_add_hcd().

Signed-off-by: Nate Case <ncase@xes-inc.com>
Acked-by: Sebastian Siewior <bigeasy@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/host/isp1760-hcd.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/usb/host/isp1760-hcd.c
+++ b/drivers/usb/host/isp1760-hcd.c
@@ -2207,14 +2207,14 @@ struct usb_hcd *isp1760_register(u64 res
 		goto err_put;
 	}
 
-	ret = usb_add_hcd(hcd, irq, irqflags);
-	if (ret)
-		goto err_unmap;
-
 	hcd->irq = irq;
 	hcd->rsrc_start = res_start;
 	hcd->rsrc_len = res_len;
 
+	ret = usb_add_hcd(hcd, irq, irqflags);
+	if (ret)
+		goto err_unmap;
+
 	return hcd;
 
 err_unmap:


Patches currently in gregkh-2.6 which might be from ncase@xes-inc.com are

usb.current/usb-isp1760-assign-resource-fields-before-adding-hcd.patch
