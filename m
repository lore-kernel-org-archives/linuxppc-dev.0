Return-Path: <akonovalov@ru.mvista.com>
Received: from localhost.localdomain (83-102-234-29.broadband.corbina.ru
	[83.102.234.29])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AF895685ED
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Oct 2005 02:05:24 +1000 (EST)
Message-ID: <43561EF0.6040305@ru.mvista.com>
Date: Wed, 19 Oct 2005 14:24:48 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Kalle Pokki <kalle.pokki@iki.fi>, "David H. Lynch Jr" <dhlii@comcast.net>
References: <4354AC78.5080206@comcast.net>
	<4354B707.6060002@iki.fi>	<435549C2.1000106@dlasys.net>
	<435557A0.8090505@iki.fi>	<4355D6C1.4030004@comcast.net>
	<4355E9B5.30106@iki.fi>
In-Reply-To: <4355E9B5.30106@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Need help Understanding initial memory conditions.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kalle Pokki wrote:
> David H. Lynch Jr wrote:
> 
>> Alright I have RAM at physical 0x0 now.  I throw a copy of a 
>> compressed linux image into RAM (anywhere special ?) load the assorted 
>> registers with the appropriate values, fill the board info struct., 
>> and just jump to the start of the image and pray that load text starts 
>> coming out my serial port ?
> 
> Basically, but the exact thing to do depends which image you take. The 
> build process results in a few different image files. I usually just 
> take the vmlinux ELF file, and then my own scripts objcopy it to binary, 
> compress, objcopy to an object file, and link the compressed image 
> directly to the boot loader. The boot loader is then, of course, 
> responsible of uncompressing the image to RAM to 0x00000000.
> 
> I think the kernel build can also create some "self-extracting" images, 
> but I have never tried those.

Yes, this is exactly the way ML300 is booted (as regards to the code
currently in www.kernel.org's 2.6 tree).
Use 'make zImage' or 'make zImage.initrd' to get zImage.elf or zImage.initrd.elf.

> Maybe they don't even work anymore, as 
> many (most?)  people just use the U-boot images.

There is U-Boot port for ML300 by Peter Ryser from Xilinx,
but I haven't tried using it (yet). IIRC there is an appnote
on Xilinx web site that describes how to boot the 2.4 kernel
with U-Boot (few modifications need to be done to the kernel).


Best regards,
Andrei
