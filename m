Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9FDF3DDE49
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 10:04:18 +1000 (EST)
Message-ID: <464E3F18.5010700@genesi-usa.com>
Date: Sat, 19 May 2007 01:04:40 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [i2c] [PATCH 3/5] powerpc: Document device nodes for I2C devices.
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>	<FB8DD3C1-A095-4ABB-9E74-7EC66A43D983@kernel.crashing.org>	<464C800C.20400@freescale.com>	<FFBD3A3A-ADBE-4DC8-A1A1-4163367244D5@kernel.crashing.org>	<464C871C.4090300@freescale.com>	<5B363A90-5528-4441-BBF9-9C6D8833D938@kernel.crashing.org>	<20070518171555.543f9bdc@hyperion.delvare>	<D50C4D36-CEA5-4F7F-8A4C-CC747DF85865@kernel.crashing.org>	<464DD5E3.1060301@freescale.com>
	<6F8D3143-423D-45FA-9F40-00BF770831F2@kernel.crashing.org>
In-Reply-To: <6F8D3143-423D-45FA-9F40-00BF770831F2@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Kumar Gala wrote:
> On May 18, 2007, at 11:35 AM, Scott Wood wrote:
> 
>> device tree isn't worthwhile for i2c devices, why is it worthwhile  
>> for soc devices?  It seems to me that non-probable chips like i2c  
>> devices are precisely the kind of thing that the device tree is  
>> useful for.
> 
> I dont believe anyone has ever said that platform devices have to be  
> in the device tree.  We've been putting them their because we are  
> going to act as the registry for the devices.  The number of devices  
> on all the various Freescale/AMCC/IBM PPC SoCs is likely a very small  
> number compared to all I2C devices.
> 
> For I2C specifically we already have both a dynamic way (kernel cmd  
> line) and static (i2c_board_info) to specify the i2c devices, why do  
> we need yet another?

Linux doesn't but it might be nice to specify this kind of thing in a
way that other operating systems might or may support.

Essentially I think since there are a lot of ways to support I2C
(including bitbanging a GPIO pair), the only real way to support it
is to do something like;

i2c@blah {
	name = "i2c"
	compatible = "mpc52xx-i2c,someother-i2c"
	regs = "address:range"
}

The PURPOSE of this node is not to describe how the i2c controller
works, but to advertise it's presence and AUTHORIZE it's use. If a
node is not in the device tree, a driver author should probably
think twice about using it, especially on chips where pin muxing
is the modus operandii.

If it's in the device tree, then the chances of it being a wildly
crazy type of device external to the board design is probably very
low. If you have an SPI controller on - for example - an MPC52xx
chip, there are only 2 or 3 ways to have it implemented. Either
the inbuilt SPI, a PSC-based SPI, or perhaps using a bunch of GPIOs
to mimic an SPI interface very closely. The same applies to i2c.

You're not ever going to be able to specify in the device tree
exactly how to handle a driver, encompassing both implementation,
bugs in revisions, quirks of board design, but you can specify
for a driver a very accurate, very educated guess on it (any
quirks, bugs or implementation differences would be board/chip
specific, and are easily derived from the other device nodes
like the cpu node, soc node, and so on)

To carry on from the previous paragraph, with that in mind, if
it is an external device (perhaps bridged through another
chip or bus) it will be a child of the external bus. This also
gives a big clue about it's operation. If it is USB, or PCI,
or i2c based device, it will be marked with vendor/device/subsystem
ids or even an i2c slave address. Also very, very big clues.

(the only way you can accurately do all of the above and take
out all of the guesswork, is provide the driver in the firmware.
U-Boot and FDT's, you can forget it!)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
