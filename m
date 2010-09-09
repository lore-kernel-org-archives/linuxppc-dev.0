Return-Path: <grant.likely@secretlab.ca>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id C5F83B6EF2
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Sep 2010 04:28:46 +1000 (EST)
Received: by eyg24 with SMTP id 24so1323297eyg.15
	for <linuxppc-dev@ozlabs.org>; Thu, 09 Sep 2010 11:28:44 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
References: <1283502979.17812.22.camel@swa-m460>
	<20100903120858.GA19380@oksana.dev.rtsoft.ru>
	<4C84D334.6060008@matrix-vision.de>
In-Reply-To: <4C84D334.6060008@matrix-vision.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: How to define an I2C-to-SPI bridge device ?
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 09 Sep 2010 12:23:14 -0600
To: Andre Schwarz <andre.schwarz@matrix-vision.de>,
	Anton Vorontsov <cbouatmailru@gmail.com>
Message-ID: <c843f864-2a5a-4146-bd95-13c2fb91f430@email.android.com>
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



"Andre Schwarz" <andre.schwarz@matrix-vision.de> wrote:

>  Anton,
>
>> we're about to get new MPC8377 based hardware with various peripherals.
>>> There are two I2C-to-SPI bridge devices (NXP SC18IS602) and I'm not sure
>>> how to define a proper dts...
>>>
>>> Of course it's an easy thing creating 2 child nodes on the CPU's I2C
>>> device - but how can I represent the created SPI bus ?
>> Um.. the same as the other SPI buses? I.e.
>>
>> i2c-controller {  /* SOC I2C controller */
>> 	spi-controller {  /* The I2C-to-SPI bridge */
>> 		spi-device@0 {
>> 		};
>> 		spi-device@1 {
>> 		};
>> 	};
>> };
>>
>ok , thanks - looks straight forward.
>Is this any more than plain definition, i.e. will this trigger any I2C 
>or SPI device registration/linking ?
>>> Is the (possibly) required driver (of_sc18is60x_spi ?) supposed to be an
>>> I2C slave or an SPI host driver ?
>> It should be an I2C driver that registers an SPI master (i.e.
>> calls spi_alloc_master() and spi_register_master()).
>hmm - ok. Will have to do it manually then ...

Yes, but this is the case for non-of drivers too.  The i2c to spi device driver must always create (and trigger population of) the spi bus instance.

>
>I still wonder how to make the driver arch-generic *and* of-capable.
>Do we need a generic I2C slave driver that can be probed along with an 
>"of glue driver" or should the of-binding be part of a single device 
>driver ?

There is no longer any need for separate of and non-of drivers for the same hardware.  Any device may have the of_node pointer in struct device set, and drivers can use the pointer as an alternative to platform_data to get information about the hardware configuration.

Just read the data out of the node in the driver's probe hook.

For i2c and (soon) spi, the core code will even register child devices for you.

g.

>
>Sorry for the dumb questions - looks like I expected a little too much 
>functionality already existing.
>
>
>Regards,
>André
>
>
>MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
>Registergericht: Amtsgericht Stuttgart, HRB 271090
>Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner, Hans-Joachim Reich
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev
-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
