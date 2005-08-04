Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 8E26D67EB3
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Aug 2005 18:48:40 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	j748qluM028840
	for <linuxppc-embedded@ozlabs.org>; Thu, 4 Aug 2005 01:52:47 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id j748sYaa027697
	for <linuxppc-embedded@ozlabs.org>; Thu, 4 Aug 2005 03:55:05 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467302794005@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: linux-usb-devel@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
Date: Thu, 4 Aug 2005 16:47:50 +0800 
MIME-Version: 1.0
Content-Type: text/plain
Cc: Jiang Bo-r61859 <tanya.jiang@freescale.com>
Subject: [PATCH] Fix MPC8349 USB memory mapping
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

The memory mappings for MPC8349 USB MPH and DR modules were reversed.

Signed-off-by: Li Yang <LeoLi@freescale.com>
Signed-off-by: Jiang Bo <Tanya.jiang@freescale.com>

---

--- arch/ppc/syslib/mpc83xx_devices.c.orig	2005-08-04 16:37:20.000000000 +0800
+++ arch/ppc/syslib/mpc83xx_devices.c	2005-08-04 16:38:25.000000000 +0800
@@ -191,8 +191,8 @@ struct platform_device ppc_sys_platform_
 		.num_resources	 = 2,
 		.resource = (struct resource[]) {
 			{
-				.start	= 0x22000,
-				.end	= 0x22fff,
+				.start	= 0x23000,
+				.end	= 0x23fff,
 				.flags	= IORESOURCE_MEM,
 			},
 			{
@@ -208,8 +208,8 @@ struct platform_device ppc_sys_platform_
 		.num_resources	 = 2,
 		.resource = (struct resource[]) {
 			{
-				.start	= 0x23000,
-				.end	= 0x23fff,
+				.start	= 0x22000,
+				.end	= 0x22fff,
 				.flags	= IORESOURCE_MEM,
 			},
 			{

--
Leo Li
Freescale Semiconductor
 
LeoLi@freescale.com 
 
