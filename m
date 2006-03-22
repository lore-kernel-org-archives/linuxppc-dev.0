Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 03DA3679F8
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Mar 2006 04:20:39 +1100 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FM70b-0001I4-5U
	for linuxppc-embedded@ozlabs.org; Wed, 22 Mar 2006 18:20:33 +0100
Received: from mail.toimi.com ([208.45.127.50])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 22 Mar 2006 18:20:33 +0100
Received: from dave by mail.toimi.com with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 22 Mar 2006 18:20:33 +0100
To: linuxppc-embedded@ozlabs.org
From: David Updegraff <dave@cray.com>
Subject: reset mpc83xx plaform.
Date: Wed, 22 Mar 2006 11:20:08 -0600
Message-ID: <dvs108$8d8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010607080508000409060800"
Sender: news <news@sea.gmane.org>
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
--------------010607080508000409060800
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi.

I think there's some typo-errs. in arch/powerpc/platforms/83xx/misc.c.
In my case, these result in board lockup at 'reboot' instead of reset.

By my reading of the PDF, it needs to be patched thusly.

-dbu.

--------------010607080508000409060800
Content-Type: text/plain;
 name="resetpatch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="resetpatch"

diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index 0eb3d99..d918d45 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -24,6 +24,7 @@ void mpc83xx_restart(char *cmd)
 #define RST_OFFSET	0x00000900
 #define RST_PROT_REG	0x00000018
 #define RST_CTRL_REG	0x0000001c
+#define RST_ENBL_REG	0x00000020
 	__be32 __iomem *reg;
 
 	/* map reset register space */
@@ -34,8 +35,12 @@ void mpc83xx_restart(char *cmd)
 	/* enable software reset "RSTE" */
 	out_be32(reg + (RST_PROT_REG >> 2), 0x52535445);
 
+	/* wait for reset to get enabled */
+	while ((in_be32 (reg + (RST_ENBL_REG >> 2)) & 1) == 0 )
+		;
+
 	/* set software hard reset */
-	out_be32(reg + (RST_CTRL_REG >> 2), 0x52535445);
+	out_be32(reg + (RST_CTRL_REG >> 2), 3);
 	for (;;) ;
 }
 

--------------010607080508000409060800--
