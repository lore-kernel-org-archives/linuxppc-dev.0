Return-Path: <ricardo.ribalda@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8A18EB7110
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 06:56:41 +1000 (EST)
Received: from mail-ew0-f215.google.com (mail-ew0-f215.google.com
	[209.85.219.215]) by ozlabs.org (Postfix) with ESMTP id 37466DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 06:56:38 +1000 (EST)
Received: by ewy11 with SMTP id 11so2244069ewy.9
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 13:56:36 -0700 (PDT)
MIME-Version: 1.0
Sender: ricardo.ribalda@gmail.com
In-Reply-To: <4A316386.4020404@missinglinkelectronics.com>
References: <1244216069.21470.12.camel@localhost>
	<aa76a2be0906111215j15933053rf128f1985a982ca0__26561.0047536486$1244748319$gmane$org@mail.gmail.com>
	<4A316386.4020404@missinglinkelectronics.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@uam.es>
Date: Thu, 11 Jun 2009 22:49:05 +0200
Message-ID: <aa76a2be0906111349s2ff947eo35149ef14e29d05a@mail.gmail.com>
Subject: Re: SD card over (xilinx_)SPI, timeout error while CID
To: Lorenz Kolb <lorenz@missinglinkelectronics.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: joachim@missinglinkelectronics.com, dbrownell@users.sourceforge.net,
	Joachim Foerster <JOFT@gmx.de>, hp@axis.com,
	linuxppc-dev@ozlabs.org, mike@steroidmicros.com,
	pierre@ossman.eu, jan.nikitenko@gmail.com, john.linn@xilinx.com,
	linuxkernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello

  Thanks for your reply

> Is the I/O logged from within the Xilinx-SPI-Driver or from within the
> mmc-spi-layer?

It is take from inside the spi driver.

>
> The response to CMD10 seems quite strange to me. The R1 answer to that
> command says that everything is OK, so what is done next is that the 0xfe
> token will be expected by the mmc-spi-layer. Obviously that one is not
> received within the proper time (assuming your data-logging was done from
> within xilinx-spi-driver). Also be aware of printk() taking milliseconds =
for
> printing to console, within time critical routines that might not be the
> best choice for debugging.

I will retry tomorrow removing all the spi debug and report what happens.

>
> What frequency does Your SPI-Bus use?
>

33Mhz.... arghh. just checked is over the standard...  Tomorrow I will
test with a slower clk

>
> Also double check to completely disable the whole
>
> =A0if (spi->master->dev.parent->dma_mask) {
> =A0 =A0...
> =A0}
>
Tomorow morning i will double check it, but it was something we
removed from the very begining (we dont have dma for the spi and we
suppose it was an error)  In my last log check:

[   48.990098] mmc_spi spi1.0: SD/MMC host mmc0, no DMA, no WP, no
poweroff, cd polling





Anyway the problem is definitely here:

[   52.094569] mmc0: starting CMD10 arg 00000000 flags 000000b5
[   52.113755] mmc0:     blksz 16 blocks 1 flags 00000200 tsac 0 ms nsac 64
[   52.134240] mmc_spi spi1.0:   mmc_spi: CMD10, resp R1
[   52.152922] Xilinx SPI: cs on
[   52.169228] Spi  Transfer at 0x8A000000
[   52.186386] Sending 9 bytes
[   52.187978] ff 4a 00 00 00 00 1b ff ff
[   52.218225] Received 9 bytes
[   52.219911] ff ff ff ff ff ff ff ff 00
[   52.249970] mmc_spi spi1.0:     mmc_spi: read block, 16 bytes
[   52.269009] Xilinx SPI: cs on
[   52.285210] Spi  Transfer at 0x8A000000
[   52.302276] Sending 1 bytes
[   52.303867] ff
[   52.332598] Received 1 bytes
[   52.334287] ff
[   52.362345] Xilinx SPI: cs on
[   52.377675] Spi  Transfer at 0x8A000000
[   52.393815] Sending 1 bytes
[   52.395408] ff
[   52.422215] Received 1 bytes
[   52.423901] ff


It tries to read the cid and the only thing it get from the sd back
are 0xff. I have made it loop without timeout and I keep receiving
0xff


Also after the cid read the sd card dont reply to any command....
weird.  lets see tomorrow with a slower clk.


         Thanks for your commends


          Best regards


--=20
Ricardo Ribalda
http://www.eps.uam.es/~rribalda/
