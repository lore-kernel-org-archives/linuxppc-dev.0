Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id E9CA967A67
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 May 2006 02:56:29 +1000 (EST)
Subject: I2C bus issues on MPC8248
From: Heiko Schocher <hs@denx.de>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: 
Content-Type: text/plain
Date: Fri, 19 May 2006 18:37:26 +0200
Message-Id: <1148056646.5943.20.camel@Zeus.EmbLux>
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

Hello Laurent,

on Thu, 18 May 2006 14:33:58, Laurent Pinchart wrote:
> I'm trying to use the MPC8248 hardware I2C bus in a 2.6.16 kernel. The
> mailing 
> list archives mention a driver for the MPC8260 
> (http://ozlabs.org/pipermail/linuxppc-embedded/2006-May/022837.html) which I 
> modified to reflect the memory map differences between the MPC8260 and the 
> MPC8248, as mentionned in the e-mail.
> 
> The good news is that the driver works. The bad news is that it doesn't work 

OK.

> correctly.

:-(

> The Linux I2C layer probes the I2C bus for peripherals when drivers are 
> loaded. The probing function writes a single byte with the device address and 
> check if the data is acked. I monitored the SCL and SDA lines using an 
[...]
> Using that code, no data is sent on the bus, the BD_SC_READY bit is never 
> cleared and no interrupt is generated. Once again I suspected a CPM bug when 
> writing a single byte on the bus, so I increased cbd_datlen to 2:
> 
> tbdf[0].cbd_bufaddr = __pa(tb);
> tbdf[0].cbd_datlen = 2;
> tbdf[0].cbd_sc = count ? BD_SC_READY | BD_IIC_START :
>                  BD_SC_READY | BD_IIC_START | BD_SC_INTRPT |
>                  BD_SC_LAST | BD_SC_WRAP;
> 
> This worked, and two bytes were written on the bus, leading me to believe that 
> the CPM was at fault.

I don t know, if this is a CPM Bug, but it seems so to me ...

> Has anyone noticed the same behaviour ? Is there a workaround available ? I 
> tried searching Freescale's website for CPM microcode updates but haven't 
> found anything related to the I2C controller.

Yes, Holger Speck had the same problem. He solved it by doing the following:

If the cpm_iic_write is called with count = 0. He made a read with count = 1

I think this is safer than writing 2 Bytes to the Slave.
Could you try this?

Best regards
Heiko
