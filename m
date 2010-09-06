Return-Path: <andre.schwarz@matrix-vision.de>
Received: from mail1.matrix-vision.com (mail1.matrix-vision.com [78.47.19.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "localhost", Issuer "localhost" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 3B856B70E1
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Sep 2010 21:40:37 +1000 (EST)
Message-ID: <4C84D334.6060008@matrix-vision.de>
Date: Mon, 06 Sep 2010 13:40:36 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: How to define an I2C-to-SPI bridge device ?
References: <1283502979.17812.22.camel@swa-m460>
	<20100903120858.GA19380@oksana.dev.rtsoft.ru>
In-Reply-To: <20100903120858.GA19380@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: LinuxPPC List <linuxppc-dev@ozlabs.org>,
	DevTreeDiscuss <devicetree-discuss@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  Anton,

> we're about to get new MPC8377 based hardware with various peripherals.
>> There are two I2C-to-SPI bridge devices (NXP SC18IS602) and I'm not sure
>> how to define a proper dts...
>>
>> Of course it's an easy thing creating 2 child nodes on the CPU's I2C
>> device - but how can I represent the created SPI bus ?
> Um.. the same as the other SPI buses? I.e.
>
> i2c-controller {  /* SOC I2C controller */
> 	spi-controller {  /* The I2C-to-SPI bridge */
> 		spi-device@0 {
> 		};
> 		spi-device@1 {
> 		};
> 	};
> };
>
ok , thanks - looks straight forward.
Is this any more than plain definition, i.e. will this trigger any I2C 
or SPI device registration/linking ?
>> Is the (possibly) required driver (of_sc18is60x_spi ?) supposed to be an
>> I2C slave or an SPI host driver ?
> It should be an I2C driver that registers an SPI master (i.e.
> calls spi_alloc_master() and spi_register_master()).
hmm - ok. Will have to do it manually then ...

I still wonder how to make the driver arch-generic *and* of-capable.
Do we need a generic I2C slave driver that can be probed along with an 
"of glue driver" or should the of-binding be part of a single device 
driver ?

Sorry for the dumb questions - looks like I expected a little too much 
functionality already existing.


Regards,
André


MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner, Hans-Joachim Reich
