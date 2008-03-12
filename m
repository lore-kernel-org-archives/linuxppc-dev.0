Return-Path: <r.buergel@unicontrol.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.190])
	by ozlabs.org (Postfix) with ESMTP id 37BB6DDF06
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 06:06:04 +1100 (EST)
Received: from obelix.unicontrol.de
	(pd907c61f.dip0.t-ipconnect.de [217.7.198.31])
	by post.webmailer.de (fruni mo45) (RZmta 16.10)
	with ESMTP id 60509dk2CHIOTw for <linuxppc-dev@ozlabs.org>;
	Wed, 12 Mar 2008 19:54:10 +0100 (MET)
	(envelope-from: <r.buergel@unicontrol.de>)
Received: from localhost (localhost [127.0.0.1])
	by obelix.unicontrol.de (Postfix on SuSE Linux 8.1 (i386)) with ESMTP
	id 2446C17DFC
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 19:54:02 +0100 (CET)
Received: from [192.168.1.55] (unknown [192.168.1.55])
	by obelix.unicontrol.de (Postfix on SuSE Linux 8.1 (i386)) with ESMTP
	id EC85717DF9
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 19:53:57 +0100 (CET)
Message-ID: <47D827A5.8040701@unicontrol.de>
Date: Wed, 12 Mar 2008 19:57:41 +0100
From: =?ISO-8859-15?Q?Ren=E9_B=FCrgel?= <r.buergel@unicontrol.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Linux >=2.6.24 support for FEC on MPC5200 (not B!)
Content-Type: multipart/mixed; boundary="------------030507030907080301050403"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030507030907080301050403
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Here is a patch for the lite5200 to get the FEC working again for kernel 
 >=2.6.24. It was created against Linux 2.6.24.

The FEC driver is also compatible with the MPC5200, not only with the 
MPC5200B, so an according entry was added to the drivers matching list.
Furthermore the settings for the PHY were entered in the dts file for 
the Lite5200. Note, that this is not exactly the same as in the 
Lite5200B, because the PHY is located at f0003000:01 for the 5200, and 
at :00 for the 5200B. I could test the patch on a Lite5200 and a 
Lite5200B, both booted a kernel via tftp and mounted the root via nfs 
successfully.
I hope, you can include the patch into the official tree.


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


--------------030507030907080301050403
Content-Type: text/plain;
 name="lite5200_fec_on_linux_2.6.24.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lite5200_fec_on_linux_2.6.24.patch"

--- ../kernel/current/arch/powerpc/boot/dts/lite5200.dts	2008-03-12 18:26:02.000000000 +0100
+++ linux-2.6.24-uc/arch/powerpc/boot/dts/lite5200.dts	2008-03-12 17:44:06.000000000 +0100
@@ -273,6 +273,22 @@
 			mac-address = [ 02 03 04 05 06 07 ]; // Bad!
 			interrupts = <2 5 0>;
 			interrupt-parent = <&mpc5200_pic>;
+			phy-handle = <&phy0>;
+		};
+
+		mdio@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "mdio";
+			compatible = "mpc5200-fec-phy";
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
--- ../kernel/linux-2.6.24-uc/drivers/net/fec_mpc52xx.c	2008-03-12 15:25:27.000000000 +0100
+++ linux-2.6.24-uc/drivers/net/fec_mpc52xx.c	2008-03-12 18:39:30.000000000 +0100
@@ -1059,6 +1059,10 @@
 static struct of_device_id mpc52xx_fec_match[] = {
 	{
 		.type		= "network",
+		.compatible	= "mpc5200b-fec",
+	},
+	{
+		.type		= "network",
 		.compatible	= "mpc5200-fec",
 	},
 	{ }
--- ../kernel/linux-2.6.24-uc/drivers/net/fec_mpc52xx_phy.c	2008-03-12 15:12:11.000000000 +0100
+++ linux-2.6.24-uc/drivers/net/fec_mpc52xx_phy.c	2008-03-12 19:47:39.000000000 +0100
@@ -181,6 +181,10 @@
 		.type = "mdio",
 		.compatible = "mpc5200b-fec-phy",
 	},
+	{
+		.type = "mdio",
+		.compatible = "mpc5200-fec-phy",
+	},
 	{},
 };
 

--------------030507030907080301050403--
