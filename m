Return-Path: <ncase@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 16AC3DF3E6
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 07:28:30 +1000 (EST)
Subject: [PATCH 1/2] USB: isp1760: Assign resource fields before adding hcd
From: Nate Case <ncase@xes-inc.com>
To: Sebastian Siewior <bigeasy@linutronix.de>
Content-Type: text/plain
Date: Wed, 21 May 2008 16:28:20 -0500
Message-Id: <1211405300.13845.627.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Greg Kroah-Hartman <gregkh@suse.de>,
	linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This fixes the bogus "io mem 0x00000000" message printed
during driver init due to hcd->rsrc_start being assigned after
the call to usb_add_hcd().

Signed-off-by: Nate Case <ncase@xes-inc.com>
---
 drivers/usb/host/isp1760-hcd.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/isp1760-hcd.c b/drivers/usb/host/isp1760-hcd.c
index c9cec87..65aa5ec 100644
--- a/drivers/usb/host/isp1760-hcd.c
+++ b/drivers/usb/host/isp1760-hcd.c
@@ -2207,14 +2207,14 @@ struct usb_hcd *isp1760_register(u64 res_start, u64 res_len, int irq,
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
-- 
1.5.4.4
