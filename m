Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de
	(static-ip-62-75-166-246.inaddr.intergenia.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 253C5DDE03
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Nov 2007 05:56:28 +1100 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: radeon boot "hot-crash"
Date: Fri, 2 Nov 2007 19:55:49 +0100
MIME-Version: 1.0
Message-Id: <200711021955.49169.mb@bu3sch.de>
Content-Type: text/plain;
  charset="us-ascii"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm wondering how we are finally going to fix my radeon
"hot-crash" issue.
Fact is, applying the patch below fixes the issue.
Though, I see that this is not the correct patch to fix it.
Other devices might need the register write which is removed here.
So what about the following:
We add a specialcase for the exact type (and revision and so on)
for my chip here.
How do  find out what's my chiprevision?
What exactly should be checked for here, so that only this chip
is affected by the workaround?



Index: wireless-2.6/drivers/video/aty/radeon_i2c.c
===================================================================
--- wireless-2.6.orig/drivers/video/aty/radeon_i2c.c	2007-10-17 18:03:10.000000000 +0200
+++ wireless-2.6/drivers/video/aty/radeon_i2c.c	2007-10-17 18:18:52.000000000 +0200
@@ -137,13 +137,7 @@ void radeon_delete_i2c_busses(struct rad
 int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn,
 			       u8 **out_edid)
 {
-	u32 reg = rinfo->i2c[conn-1].ddc_reg;
-	u8 *edid;
-
-	OUTREG(reg, INREG(reg) &
-			~(VGA_DDC_DATA_OUTPUT | VGA_DDC_CLK_OUTPUT));
-
-	edid = fb_ddc_read(&rinfo->i2c[conn-1].adapter);
+	u8 *edid = fb_ddc_read(&rinfo->i2c[conn-1].adapter);
 
 	if (out_edid)
 		*out_edid = edid;

-- 
Greetings Michael.
