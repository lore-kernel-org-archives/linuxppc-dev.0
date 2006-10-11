Return-Path: <michel@tungstengraphics.com>
Received: from admin.zirkelwireless.com (admin.zirkelwireless.com
	[209.216.203.65])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A062467C3A
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 23:50:03 +1000 (EST)
Subject: Re: Graphic issues (emulating VGA bios on IBM Maple)
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: jean-francois simon <jfaslist@yahoo.fr>
In-Reply-To: <20061010203620.771.qmail@web27502.mail.ukl.yahoo.com>
References: <20061010203620.771.qmail@web27502.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=utf-8
Date: Wed, 11 Oct 2006 15:49:51 +0200
Message-Id: <1160574593.23225.56.camel@thor.lorrainebruecke.local>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-10-10 at 22:36 +0200, jean-francois simon wrote:
> Hi,
> I have ported the x86emu x86 emulator to IBM PIBS firmware on a Maple 
> platform. I am now trying to emulate a PCI ATI RADEON RV100 VGA BIOS.  
> It goes all the way and seems OK.  When I boot Linux , the card is 
> recognized (it wasn't before), 

If the VGA BIOS POST works correctly, you should probably see some
output in VGA text mode. Do you?

> but the screen just flickers a couple of time.  I worry about the message:
> "radeonfb: Retrieved PLL infos from BIOS" since I don't have a BIOS.

It refers to the VGA BIOS.

> The PLL values may be bogus..

[...]

> radeonfb: Retrieved PLL infos from BIOS
> radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=150.00 Mhz, 
> System=150.00 MHz
> radeonfb:
>  PLL min 12000 max 35000

These look sane.

> radeonfb: I2C (port 3) ... found CRT display
> radeonfb: Monitor 1 type CRT found
> radeonfb: EDID probed
> radeonfb: Monitor 2 type no found

Is this correct?

> hStart = 1328, hEnd = 1440, hTotal = 1688
> vStart = 1025, vEnd = 1028, vTotal = 1066

Does the monitor support this mode?

> kobject_register failed for radeonfb (-17)
> Call Trace:
> [C000000000BFFB60] [C00000000000E97C] .show_stack+0x68/0x1b4 
> (unreliable)
> [C000000000BFFC10] [C00000000017EC54] .kobject_register+0x5c/0x8c
> [C000000000BFFCA0] [C0000000001FAAF0] .bus_add_driver+0x7c/0x1b4
> [C000000000BFFD50] [C0000000001FBDC8] .driver_register+0xac/0xc8
> [C000000000BFFDD0] [C00000000018D084] .__pci_register_driver+0x8c/0xdc
> [C000000000BFFE60] [C0000000003CCC9C] .radeonfb_old_init+0x164/0x188
> [C000000000BFFF00] [C00000000000929C] .init+0x258/0x3d0
> [C000000000BFFF90] [C00000000001E848] .kernel_thread+0x4c/0x68

Could this be the problem?


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer
