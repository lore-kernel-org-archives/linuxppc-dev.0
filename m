Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 92989DDEBD
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 10:18:25 +1000 (EST)
In-Reply-To: <464E3F18.5010700@genesi-usa.com>
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>	<FB8DD3C1-A095-4ABB-9E74-7EC66A43D983@kernel.crashing.org>	<464C800C.20400@freescale.com>	<FFBD3A3A-ADBE-4DC8-A1A1-4163367244D5@kernel.crashing.org>	<464C871C.4090300@freescale.com>	<5B363A90-5528-4441-BBF9-9C6D8833D938@kernel.crashing.org>	<20070518171555.543f9bdc@hyperion.delvare>	<D50C4D36-CEA5-4F7F-8A4C-CC747DF85865@kernel.crashing.org>	<464DD5E3.1060301@freescale.com>
	<6F8D3143-423D-45FA-9F40-00BF770831F2@kernel.crashing.org>
	<464E3F18.5010700@genesi-usa.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2087d135c4139e94e0b2c8826d808292@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [i2c] [PATCH 3/5] powerpc: Document device nodes for I2C devices.
Date: Sat, 19 May 2007 02:17:25 +0200
To: Matt Sealey <matt@genesi-usa.com>
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Linux doesn't but it might be nice to specify this kind of thing in a
> way that other operating systems might or may support.
>
> Essentially I think since there are a lot of ways to support I2C
> (including bitbanging a GPIO pair), the only real way to support it
> is to do something like;
>
> i2c@blah {
> 	name = "i2c"
> 	compatible = "mpc52xx-i2c,someother-i2c"
> 	regs = "address:range"
> }

Yes, all devices should be in the device tree.  That's
what it's for.

> You're not ever going to be able to specify in the device tree
> exactly how to handle a driver, encompassing both implementation,
> bugs in revisions, quirks of board design, but you can specify
> for a driver a very accurate, very educated guess on it (any
> quirks, bugs or implementation differences would be board/chip
> specific, and are easily derived from the other device nodes
> like the cpu node, soc node, and so on)

Actually, you can, and should.  All this information is
contained in the "compatible" and "model" properties.
"Quirks of board design" can be described too, on a case-
by-case basis.

All the knowledge about how to drive the device resides
in the kernel, but the device tree describes exactly what
device this is, so the kernel can match a driver to it
uniquely, and the driver can know exactly what revision
chip this is and what quirks to apply.


Segher
