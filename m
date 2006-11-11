Return-Path: <kalle.pokki@iki.fi>
Received: from host32.eke.fi (unknown [194.100.36.62])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 559D3680AC
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Nov 2006 21:09:44 +1100 (EST)
Date: Sat, 11 Nov 2006 12:09:39 +0200 (EET)
From: Kalle Pokki <kalle.pokki@iki.fi>
To: linuxppc-embedded@ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: [PATCH] 8xx: Off-by-one fixes to SCC parameter RAM definitions
Message-ID: <Pine.LNX.4.64.0611111201001.8062@host32.eke.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Paul,

Please apply this trivial fix.



The SCC parameter RAM areas are mapped wrong in MPC8xx device descriptions. All
memory areas overlap with the next one, so that I2C, SPI, SMC1 and SMC2 cannot
be enabled if the four SCCs are.

Signed-off-by: Kalle Pokki <kalle.pokki@iki.fi>
---
 arch/ppc/syslib/mpc8xx_devices.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/ppc/syslib/mpc8xx_devices.c b/arch/ppc/syslib/mpc8xx_devices.c
index cf5ab47..31fb565 100644
--- a/arch/ppc/syslib/mpc8xx_devices.c
+++ b/arch/ppc/syslib/mpc8xx_devices.c
@@ -78,7 +78,7 @@ struct platform_device ppc_sys_platform_
 			{
 				.name 	= "pram",
 				.start 	= 0x3c00,
-				.end 	= 0x3c80,
+				.end 	= 0x3c7f,
 				.flags 	= IORESOURCE_MEM,
 			},
 			{
@@ -103,7 +103,7 @@ struct platform_device ppc_sys_platform_
 			{
 				.name 	= "pram",
 				.start 	= 0x3d00,
-				.end 	= 0x3d80,
+				.end 	= 0x3d7f,
 				.flags 	= IORESOURCE_MEM,
 			},
 
@@ -129,7 +129,7 @@ struct platform_device ppc_sys_platform_
 			{
 				.name 	= "pram",
 				.start 	= 0x3e00,
-				.end 	= 0x3e80,
+				.end 	= 0x3e7f,
 				.flags 	= IORESOURCE_MEM,
 			},
 
@@ -155,7 +155,7 @@ struct platform_device ppc_sys_platform_
 			{
 				.name 	= "pram",
 				.start 	= 0x3f00,
-				.end 	= 0x3f80,
+				.end 	= 0x3f7f,
 				.flags 	= IORESOURCE_MEM,
 			},
 
-- 
1.4.1.1
