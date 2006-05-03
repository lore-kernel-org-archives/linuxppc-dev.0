Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 88D3167A64
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 May 2006 06:11:14 +1000 (EST)
Subject: Re: mpc8270 : i2c support
From: Heiko Schocher <hs@denx.de>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: 
Content-Type: text/plain
Date: Wed, 03 May 2006 22:11:17 +0200
Message-Id: <1146687078.5942.36.camel@Zeus.EmbLux>
Mime-Version: 1.0
Reply-To: hs@denx.de
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello jfaslist,

on Wed, 03 May 2006 14:33:37 jfaslist wrote:
> But when we try to access i2c devices from under linux 2.6 using 
> the /dev/i2c-0 special file we get an ENODEV on opening that 
> file. I think it is because we lack an adapter driver.
> 
> If I look in the official kernel, it looks like the adapter 
> driver for the mpc8270 i2c system is 
> ./drivers/i2c/busses/i2c-mpc.c. Is this correct?

No. It is for:
MODULE_DESCRIPTION
("I2C-Bus adapter for MPC107 bridge and MPC824x/85xx/52xx processors");

> In DENX ELDK there is also a i2c-mpc8260.c, but we couldn't get 
> that to work either.

OK, this was the right driver ... but it was tested on a MPC826x
Processor.

Hmmm.... I think there are differences in the memory map between
MPC826x and MPC827x ... can you try following Hack in
include/asm-ppc/cpm_8260.h?

-#define PROFF_I2C       ((16 * 1024) - 64)
+#define PROFF_I2C       ((8 * 1024) - 64)

[If it solves the problem, we must do this on a better way ;-)]

I think i had the same problem with a 2.4er Kernel ... Yes,
this is in my queue, but not merged in our official 2.4er Tree ...

Maybe you have to set other Portsettings in
drivers/i2c/busses/i2c-cpm2.c cpm2_iic_init() ... ?

> What should I do to be able to access i2c devices using the 
> /dev/i2c-0 file? I feel I need to modify the i2c adapter driver 
> to follow the driver model, but in what ways?

Bring up the driver running, and then read:
Documentation/i2c/dev-interface.

Best regards
Heiko
