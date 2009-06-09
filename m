Return-Path: <dmitch71@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E08FEB707D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Jun 2009 09:48:08 +1000 (EST)
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 2D561DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 09:48:07 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so154110ywt.39
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Jun 2009 16:48:06 -0700 (PDT)
Sender: David Mitchell <dmitch71@gmail.com>
From: Dave Mitchell <dmitchell@amcc.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] of_serial: Add UPF_FIXED_TYPE flag
Date: Tue,  9 Jun 2009 18:39:47 -0500
Message-Id: <1244590787-13716-1-git-send-email-dmitchell@amcc.com>
Cc: arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds the UPF_FIXED_TYPE flag which will bypass the
8250's autoconfig probe for uart type. The uart type identified
by the of_serial's parse of the flat device tree will be utilized
as defined.

Signed-off-by: Dave Mitchell <dmitchell@amcc.com>
---
 drivers/serial/of_serial.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
index 14f8fa9..3f2027c 100644
--- a/drivers/serial/of_serial.c
+++ b/drivers/serial/of_serial.c
@@ -67,7 +67,7 @@ static int __devinit of_platform_serial_setup(struct of_device *ofdev,
 	port->type = type;
 	port->uartclk = *clk;
 	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
-		| UPF_FIXED_PORT;
+		| UPF_FIXED_PORT | UPF_FIXED_TYPE;
 	port->dev = &ofdev->dev;
 	/* If current-speed was set, then try not to change it. */
 	if (spd)
-- 
1.6.3.2
