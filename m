Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 30328DDF1C
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 02:41:02 +1100 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp07.au.ibm.com (8.13.1/8.13.1) with ESMTP id n13Ff0ST030016
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Feb 2009 02:41:00 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n13FfImZ331978
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Feb 2009 02:41:18 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n13Ff0Hw030089
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Feb 2009 02:41:00 +1100
Message-ID: <4988658A.1060306@in.ibm.com>
Date: Tue, 03 Feb 2009 21:10:58 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Willy Tarreau <w@1wt.eu>
Subject: [Patch] fix lcd panel driver build failure
References: <49885F9A.6040703@in.ibm.com> <20090203152502.GC12398@1wt.eu>
In-Reply-To: <20090203152502.GC12398@1wt.eu>
Content-Type: multipart/mixed; boundary="------------020403050308040603070309"
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org, greg@kroah.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020403050308040603070309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

* Fix build break for lcd panel driver.

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
---



--------------020403050308040603070309
Content-Type: text/x-patch;
 name="staging-panel-build-break-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="staging-panel-build-break-fix.patch"

* Fix build break for lcd panel driver.

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
---

diff -Naurp a/drivers/staging/panel/panel.c b/drivers/staging/panel/panel.c
--- a/drivers/staging/panel/panel.c	2009-02-03 23:34:18.000000000 +0530
+++ b/drivers/staging/panel/panel.c	2009-02-03 23:33:16.000000000 +0530
@@ -622,7 +622,7 @@ static int set_ctrl_bits(void)
 }
 
 /* sets ctrl & data port bits according to current signals values */
-static void set_bits(void)
+static void panel_set_bits(void)
 {
 	set_data_bits();
 	set_ctrl_bits();
@@ -707,12 +707,12 @@ static void lcd_send_serial(int byte)
 	 */
 	for (bit = 0; bit < 8; bit++) {
 		bits.cl = BIT_CLR;	/* CLK low */
-		set_bits();
+		panel_set_bits();
 		bits.da = byte & 1;
-		set_bits();
+		panel_set_bits();
 		udelay(2);	/* maintain the data during 2 us before CLK up */
 		bits.cl = BIT_SET;	/* CLK high */
-		set_bits();
+		panel_set_bits();
 		udelay(1);	/* maintain the strobe during 1 us */
 		byte >>= 1;
 	}
@@ -727,7 +727,7 @@ static void lcd_backlight(int on)
 	/* The backlight is activated by seting the AUTOFEED line to +5V  */
 	spin_lock(&pprt_lock);
 	bits.bl = on;
-	set_bits();
+	panel_set_bits();
 	spin_unlock(&pprt_lock);
 }
 

--------------020403050308040603070309--
