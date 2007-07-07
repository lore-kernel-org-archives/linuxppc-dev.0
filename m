Return-Path: <SRS0+bd14105a136047a0bf47+1413+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [209.217.80.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 78E57DE179
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 02:57:35 +1000 (EST)
Subject: [PATCH 2/2] Add 'sparse16550' support to PowerPC bootwrapper
From: David Woodhouse <dwmw2@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200707071410.14998.arnd@arndb.de>
References: <1183784308.3066.16.camel@shinybook.infradead.org>
	<200707071410.14998.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 07 Jul 2007 12:57:50 -0400
Message-Id: <1183827470.3066.73.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The bootwrapper already handles a 'reg-shift' property on serial ports
and does the right thing. However, these ports really shouldn't be
claiming to be compatible with 'ns16550'. Introduce a new 'sparse16550'
type for them instead.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
index 7fd3233..6d9f3f8 100644
--- a/arch/powerpc/boot/serial.c
+++ b/arch/powerpc/boot/serial.c
@@ -123,7 +123,7 @@ int serial_console_init(void)
 	if (getprop(devp, "compatible", compat, sizeof(compat)) < 0)
 		goto err_out;
 
-	if (!strcmp(compat, "ns16550"))
+	if (!strcmp(compat, "ns16550") || !strcmp(compat, "sparse16550"))
 		rc = ns16550_console_init(devp, &serial_cd);
 	else if (!strcmp(compat, "marvell,mpsc"))
 		rc = mpsc_console_init(devp, &serial_cd);

-- 
dwmw2
