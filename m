Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx024.isp.belgacom.be (outmx024.isp.belgacom.be
	[195.238.4.128])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E79A067B69
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Jun 2006 21:57:37 +1000 (EST)
Received: from outmx024.isp.belgacom.be (localhost [127.0.0.1])
	by outmx024.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k5FBvFvD007638
	for <linuxppc-embedded@ozlabs.org>; Thu, 15 Jun 2006 13:57:16 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx024.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k5FBv8f6007551
	for <linuxppc-embedded@ozlabs.org>; Thu, 15 Jun 2006 13:57:09 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Binding FCC interfaces to device names in reverse order
Date: Thu, 15 Jun 2006 13:59:02 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200606151359.02966.laurent.pinchart@tbox.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I'm trying to change the order in which the MPC8248 FCC devices are bound to 
network interface names.

The current behaviour is to handle FCC1, FCC2 and FCC3 in that order. FCC1 is 
thus mapped to eth0 and FCC2 to eth1 (FCC3 is unused in my design).

For some reason I'd like to map FCC2 to eth0 and FCC1 to eth1. Interface names 
are allocated as devices are registered, so I thought I could change the 
detection order by modifying the ppc_sys_platform_devices array:

        ppc_sys_platform_devices[MPC82xx_CPM_FCC1].id = 2;
        ppc_sys_platform_devices[MPC82xx_CPM_FCC2].id = 1;

FCC devices detection is indeed reversed, and FCC2 is mapped to eth0. Plugging 
a cable into the FCC2 socket prints a message referencing eth0, and ifconfig 
confirms that eth0 is running.

Unfortunately, that's where things stop working. I can't ping FCC1 or FCC2, no 
data is received by the kernel.

Does anyone know why changing the device ids breaks the fs_enet driver ?

Laurent Pinchart
