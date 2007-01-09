Return-Path: <bwarren@qstreams.com>
Received: from smtp106.biz.mail.re2.yahoo.com (smtp106.biz.mail.re2.yahoo.com
	[206.190.52.175]) by ozlabs.org (Postfix) with SMTP id C3335DDE10
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Jan 2007 10:24:01 +1100 (EST)
Subject: Using fixed_phy with gianfar
From: Ben Warren <bwarren@qstreams.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Tue, 09 Jan 2007 18:23:58 -0500
Message-Id: <1168385038.3964.44.camel@saruman.qstreams.net>
Mime-Version: 1.0
Reply-To: bwarren@qstreams.com
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

My custom board has a couple of Ethernet switches attached via RvMII to
the 'Gianfar' controllers of an MPC8349 CPU.  We're using SPI instead of
MDIO for control of the switches, and it looked like the 'fixed.c' PHY
driver was the right thing to use.  BTW, I'm using a 2.6.19 kernel.

When I 'ifconfig up' one of the interfaces, the Gianfar driver tries to
find a device on the MDIO bus of the variety bus_id:phy_id, where both
bus_id and phy_id are numeric (defined in fsl_devices.h).  The Fixed PHY
driver creates devices on the MDIO bus with a bus_id that is a string,
for example "fixed_1@100:1".  Obviously, these will never match up.  The
very crude hack I made to get things working was to modify the Gianfar
driver to match the "fixed" string.  

I'm sure I'm missing something, and am wondering what the correct way to
do this is.  Should I have board-specific code that creates PHY devices
conforming to the Gianfar expectations instead of calling
'fixed_mdio_register_device()', or something else?

thanks,
Ben 
