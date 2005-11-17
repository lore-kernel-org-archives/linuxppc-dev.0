Return-Path: <dave@cray.com>
Received: from mail1.cray.com (mail1.cray.com [136.162.0.111])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail1.cray.com", Issuer "Cray Inc" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 77F6168775
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Nov 2005 08:58:05 +1100 (EST)
Received: from beaver.us.cray.com (beaver.us.cray.com [172.30.74.51])
	by mail1.cray.com (8.13.3/8.13.3/gw-5323) with ESMTP id jAHLs3VS019737
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Nov 2005 15:54:04 -0600 (CST)
Received: from orchid.us.cray.com (orchid.us.cray.com [172.30.27.91])
	by beaver.us.cray.com (8.13.4/8.13.3/hub-5273) with ESMTP id
	jAHLs3Zs030960
	for <linuxppc-embedded@ozlabs.org>; Thu, 17 Nov 2005 15:54:03 -0600
Received: from [127.0.0.1] (relay6-internal [192.168.234.20])
	by orchid.us.cray.com (8.13.1/8.12.10/irix-ham-1.4) with ESMTP id
	jAHLs2q11570640 for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Nov 2005 15:54:02 -0600 (CST)
Message-ID: <437CFBF9.70505@cray.com>
Date: Thu, 17 Nov 2005 15:54:01 -0600
From: David Updegraff <dave@cray.com>
MIME-Version: 1.0
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: multipart/mixed; boundary="------------060108000103020609060804"
Subject: PVR wrong for mpc8343 chips.
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
--------------060108000103020609060804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

The PVRs are wrongly enumerated for the 8343/8343e chips.

-dbu

--------------060108000103020609060804
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

diff --git a/arch/ppc/syslib/mpc83xx_sys.c b/arch/ppc/syslib/mpc83xx_sys.c
index 29aa633..556b233 100644
--- a/arch/ppc/syslib/mpc83xx_sys.c
+++ b/arch/ppc/syslib/mpc83xx_sys.c
@@ -69,29 +69,53 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 		},
 	},
 	{
-		.ppc_sys_name	= "8343E",
+		.ppc_sys_name	= "8347E",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80540000,
-		.num_devices	= 7,
+		.num_devices	= 8,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
 			MPC83xx_IIC2, MPC83xx_DUART, MPC83xx_SEC2,
-			MPC83xx_USB2_DR,
+			MPC83xx_USB2_DR, MPC83xx_USB2_MPH
 		},
 	},
 	{
-		.ppc_sys_name	= "8343",
+		.ppc_sys_name	= "8347",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80550000,
-		.num_devices	= 6,
+		.num_devices	= 7,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
 			MPC83xx_IIC2, MPC83xx_DUART,
-			MPC83xx_USB2_DR,
+			MPC83xx_USB2_DR, MPC83xx_USB2_MPH
 		},
 	},
+	{
+		.ppc_sys_name	= "8343E",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80560000,
+		.num_devices	= 7,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
+			MPC83xx_IIC2, MPC83xx_DUART, MPC83xx_SEC2,
+			MPC83xx_USB2_DR
+		}
+	},
+	{
+		.ppc_sys_name	= "8343",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80570000,
+		.num_devices	= 6,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
+			MPC83xx_IIC2, MPC83xx_DUART,
+			MPC83xx_USB2_DR
+		}
+	},
 	{	/* default match */
 		.ppc_sys_name	= "",
 		.mask 		= 0x00000000,

--------------060108000103020609060804--
