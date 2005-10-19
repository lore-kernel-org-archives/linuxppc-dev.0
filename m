Return-Path: <kalle.pokki@iki.fi>
Received: from smtp2.song.fi (smtp2.song.fi [194.100.2.122])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AE40D685D9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Oct 2005 16:37:45 +1000 (EST)
Message-ID: <4355E9B5.30106@iki.fi>
Date: Wed, 19 Oct 2005 08:37:41 +0200
From: Kalle Pokki <kalle.pokki@iki.fi>
MIME-Version: 1.0
To: "David H. Lynch Jr" <dhlii@comcast.net>
References: <4354AC78.5080206@comcast.net> <4354B707.6060002@iki.fi>
	<435549C2.1000106@dlasys.net> <435557A0.8090505@iki.fi>
	<4355D6C1.4030004@comcast.net>
In-Reply-To: <4355D6C1.4030004@comcast.net>
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

David H. Lynch Jr wrote:

> Alright I have RAM at physical 0x0 now.  I throw a copy of a 
> compressed linux image into RAM (anywhere special ?) load the assorted 
> registers with the appropriate values, fill the board info struct., 
> and just jump to the start of the image and pray that load text starts 
> coming out my serial port ?

Basically, but the exact thing to do depends which image you take. The 
build process results in a few different image files. I usually just 
take the vmlinux ELF file, and then my own scripts objcopy it to binary, 
compress, objcopy to an object file, and link the compressed image 
directly to the boot loader. The boot loader is then, of course, 
responsible of uncompressing the image to RAM to 0x00000000.

I think the kernel build can also create some "self-extracting" images, 
but I have never tried those. Maybe they don't even work anymore, as 
many (most?)  people just use the U-boot images.
