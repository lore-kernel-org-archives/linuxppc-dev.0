Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.varma-el.com",
	Issuer "mail.varma-el.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 58FEC68714
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 13 Nov 2005 00:27:18 +1100 (EST)
Message-ID: <4375E765.4000207@varma-el.com>
Date: Sat, 12 Nov 2005 16:00:21 +0300
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Russell King <rmk@dyn-67.arm.linux.org.uk>,
	ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: multipart/mixed; boundary="------------020507000008020400060502"
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1 kernel 2.6.15-rc1] Fix copy-paste bug in mpc52xx_uart.c
 (pdev<->dev)
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
--------------020507000008020400060502
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit

Russel, in future, please CC such patches
([DRIVER MODEL] Convert platform drivers to use struct platform_driver)
to Sylvain Munaut (as MPC52xx mainteiner) too.

---
Regards
Andrey Volkov

--------------020507000008020400060502
Content-Type: text/plain;
 name="mpc52xx_uart_copy_paste_bug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mpc52xx_uart_copy_paste_bug.diff"

Fix copy-paste bug in mpc52xx_uart.c (pdev<->dev)

Signed-off-by: Andrey Volkov <avolkov@varma-el.com>
---

 drivers/serial/mpc52xx_uart.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 5d3cb84..b8727d9 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -725,7 +725,7 @@ mpc52xx_uart_probe(struct platform_devic
 	int i, idx, ret;
 
 	/* Check validity & presence */
-	idx = pdev->id;
+	idx = dev->id;
 	if (idx < 0 || idx >= MPC52xx_PSC_MAXNUM)
 		return -EINVAL;
 
@@ -748,7 +748,7 @@ mpc52xx_uart_probe(struct platform_devic
 	port->ops	= &mpc52xx_uart_ops;
 
 	/* Search for IRQ and mapbase */
-	for (i=0 ; i<pdev->num_resources ; i++, res++) {
+	for (i=0 ; i<dev->num_resources ; i++, res++) {
 		if (res->flags & IORESOURCE_MEM)
 			port->mapbase = res->start;
 		else if (res->flags & IORESOURCE_IRQ)

--------------020507000008020400060502--
