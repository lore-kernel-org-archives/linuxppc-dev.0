Return-Path: <r.buergel@unicontrol.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.189])
	by ozlabs.org (Postfix) with ESMTP id 2BFA3DDDDB
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 19:34:14 +1100 (EST)
Received: from obelix.unicontrol.de
	(pd907c61f.dip0.t-ipconnect.de [217.7.198.31])
	by post.webmailer.de (fruni mo49) (RZmta 16.16)
	with ESMTP id Y0172fk335eOxn for <linuxppc-dev@ozlabs.org>;
	Thu, 3 Apr 2008 10:34:10 +0200 (MEST)
	(envelope-from: <r.buergel@unicontrol.de>)
Received: from localhost (localhost [127.0.0.1])
	by obelix.unicontrol.de (Postfix on SuSE Linux 8.1 (i386)) with ESMTP
	id 5DE5E17DFC
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 10:32:55 +0200 (CEST)
Received: from [192.168.1.55] (unknown [192.168.1.55])
	by obelix.unicontrol.de (Postfix on SuSE Linux 8.1 (i386)) with ESMTP
	id 7021017DF9
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 10:32:51 +0200 (CEST)
Message-ID: <47F49C3D.3080909@unicontrol.de>
Date: Thu, 03 Apr 2008 10:58:37 +0200
From: =?ISO-8859-15?Q?Ren=E9_B=FCrgel?= <r.buergel@unicontrol.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Linux >=2.6.24 support for FEC on MPC5200 (not B!)
Content-Type: multipart/mixed; boundary="------------040705080504040109070504"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040705080504040109070504
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Here is a patch for the lite5200 to get the FEC working again for kernel 
 >=2.6.25.

The FEC driver is also compatible with the MPC5200, not only with the 
MPC5200B, so an according entry was added to the drivers matching list.
Furthermore the settings for the PHY were entered in the dts file for 
the Lite5200. Note, that this is not exactly the same as in the 
Lite5200B, because the PHY is located at f0003000:01 for the 5200, and 
at :00 for the 5200B. I could test the patch on a Lite5200 and a 
Lite5200B, both booted a kernel via tftp and mounted the root via nfs 
successfully.
I hope, you can include the patch into the official tree.

Signed-off-by: René Bürgel <r.buergel@unicontrol.de>

Kind regards, René Bürgel

-- 
Unicontrol Systemtechnik GmbH
OT Dittersbach
Sachsenburger Weg 34
09669 Frankenberg
 
Tel.: 03 72 06/ 88 73 - 12
Fax: 03 72 06/ 88 73 - 60
E-Mail: r.buergel@unicontrol.de
Internet: www.unicontrol.de
 
Unicontrol Systemtechnik GmbH
Geschäftsführer: Dipl.-Ing. Siegfried Heinze
Sitz der Gesellschaft: Frankenberg
Registergericht: Amtsgericht Chemnitz, HRB 15 475
 
Wichtiger Hinweis: Diese E-Mail und etwaige Anlagen können Betriebs- und Geschäftsgeheimnisse, dem Anwaltsgeheimnis unterliegende oder sonstige vertrauliche Informationen 
enthalten. Sollten Sie diese E-Mail irrtümlich erhalten haben, ist Ihnen der Status dieser E-Mail bekannt. Bitte benachrichtigen Sie uns in diesem Falle sofort durch 
Antwort-Mail und löschen Sie diese E-Mail nebst etwaigen Anlagen aus Ihrem System. Ebenso dürfen Sie diese E-Mail oder ihre Anlagen nicht kopieren oder an Dritte 
weitergeben. Vielen Dank!
 
Important Note: This e-mail and any attachments are confidential, may contain trade secrets and may well also be legally privileged or otherwise protected from disclosure. 
If you have received it in error, you are on notice of its status. Please notify us immediately by reply e-mail and then delete this e-mail and any attachment from your 
system. If you are not the intended recipient please understand that you must not copy this e-mail or any attachments or disclose the contents to any other person. Thank 
you.



--------------040705080504040109070504
Content-Type: text/plain;
 name="lite5200_fec_on_linux_2.6.25.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lite5200_fec_on_linux_2.6.25.patch"

diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index 0d701c1..09b4e16 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -258,6 +258,21 @@
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <2 5 0>;
 			interrupt-parent = <&mpc5200_pic>;
+			phy-handle = <&phy0>;
+		};
+
+		mdio@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5200-mdio";
+			reg = <3000 400>;	// fec range, since we need to setup fec interrupts
+			interrupts = <2 5 0>;	// these are for "mii command finished", not link changes & co.
+			interrupt-parent = <&mpc5200_pic>;
+
+			phy0:ethernet-phy@1 {
+				device_type = "ethernet-phy";
+				reg = <1>;
+			};
 		};
 
 		ata@3a00 {
diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
index 58b71e6..fe59c27 100644
--- a/drivers/net/fec_mpc52xx.c
+++ b/drivers/net/fec_mpc52xx.c
@@ -1057,6 +1057,7 @@ static int mpc52xx_fec_of_resume(struct of_device *op)
 #endif
 
 static struct of_device_id mpc52xx_fec_match[] = {
+	{ .type = "network", .compatible = "fsl,mpc5200b-fec", },
 	{ .type = "network", .compatible = "fsl,mpc5200-fec", },
 	{ .type = "network", .compatible = "mpc5200-fec", },
 	{ }
diff --git a/drivers/net/fec_mpc52xx_phy.c b/drivers/net/fec_mpc52xx_phy.c
index 6a3ac4e..1d0cd1d 100644
--- a/drivers/net/fec_mpc52xx_phy.c
+++ b/drivers/net/fec_mpc52xx_phy.c
@@ -179,6 +179,7 @@ static int mpc52xx_fec_mdio_remove(struct of_device *of)
 
 static struct of_device_id mpc52xx_fec_mdio_match[] = {
 	{ .compatible = "fsl,mpc5200b-mdio", },
+	{ .compatible = "fsl,mpc5200-mdio", },
 	{ .compatible = "mpc5200b-fec-phy", },
 	{}
 };

--------------040705080504040109070504--
