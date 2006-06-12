Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx004.isp.belgacom.be (outmx004.isp.belgacom.be
	[195.238.4.101])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6106667B1B
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Jun 2006 21:41:58 +1000 (EST)
Received: from outmx004.isp.belgacom.be (localhost [127.0.0.1])
	by outmx004.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k5CBfnHC018151
	for <linuxppc-embedded@ozlabs.org>; Mon, 12 Jun 2006 13:41:49 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: CPM_UART should allocate DPRAM for SMCx parameter RAM on MPC82xx
Date: Mon, 12 Jun 2006 13:43:37 +0200
References: <200606071434.08905.laurent.pinchart@tbox.biz>
	<200606071629.19136.laurent.pinchart@tbox.biz>
	<20060610030950.1a690abb@localhost.localdomain>
In-Reply-To: <20060610030950.1a690abb@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pNVjEIYVAolyP/+"
Message-Id: <200606121343.37972.laurent.pinchart@tbox.biz>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Boundary-00=_pNVjEIYVAolyP/+
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Vitaly,

> If and when you'll have some code that address your problem, submit it
> to me cc linuxppc-embedded, and I'll push it upstream.

here's a simple patch (against 2.6.17-rc6) that fixes the issue by modifying 
the pram addresses for SMC resources. I'm not completely satisfied, as the 
SMCx_BASE registers configuration is board-specific (must be handled in 
init_ioports as you mentionned in your previous e-mail), which will lead to 
duplicated code.

Laurent Pinchart

--Boundary-00=_pNVjEIYVAolyP/+
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="pq2_devices.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pq2_devices.diff"

diff --git a/arch/ppc/syslib/pq2_devices.c b/arch/ppc/syslib/pq2_devices.c
index fefbc21..0a7082e 100644
--- a/arch/ppc/syslib/pq2_devices.c
+++ b/arch/ppc/syslib/pq2_devices.c
@@ -289,15 +289,15 @@ struct platform_device ppc_sys_platform_
 		.num_resources	 = 3,
 		.resource = (struct resource[]) {
 			{
-				.name	= "smc_mem",
+				.name	= "regs",
 				.start	= 0x11A80,
 				.end	= 0x11A8F,
 				.flags	= IORESOURCE_MEM,
 			},
 			{
-				.name	= "smc_pram",
-				.start	= 0x87fc,
-				.end	= 0x87fd,
+				.name	= "pram",
+				.start	= 0x0000,
+				.end	= 0x003f,
 				.flags	= IORESOURCE_MEM,
 			},
 			{
@@ -313,15 +313,15 @@ struct platform_device ppc_sys_platform_
 		.num_resources	 = 3,
 		.resource = (struct resource[]) {
 			{
-				.name	= "smc_mem",
+				.name	= "regs",
 				.start	= 0x11A90,
 				.end	= 0x11A9F,
 				.flags	= IORESOURCE_MEM,
 			},
 			{
-				.name	= "smc_pram",
-				.start	= 0x88fc,
-				.end	= 0x88fd,
+				.name	= "pram",
+				.start	= 0x0040,
+				.end	= 0x007f,
 				.flags	= IORESOURCE_MEM,
 			},
 			{

--Boundary-00=_pNVjEIYVAolyP/+--
