Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BFFFF67FB8
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Aug 2005 00:52:40 +1000 (EST)
Message-ID: <43034F31.3090002@varma-el.com>
Date: Wed, 17 Aug 2005 18:52:33 +0400
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Clemens Koller <clemens.koller@anagramm.de>
References: <20050816194825.A62AC353AB5@atlas.denx.de>	<43030D41.3000508@varma-el.com>	<Pine.LNX.4.62.0508171317540.6073@numbat.sonytel.be>	<43032A76.6080104@varma-el.com>
	<Pine.LNX.4.62.0508171439060.6073@numbat.sonytel.be>
	<43034A59.6000008@anagramm.de>
In-Reply-To: <43034A59.6000008@anagramm.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>, surendra.yadav@softdel.com
Subject: Re: [F]Framebuffer driver using SM501 hardware.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Clemens Koller wrote:
> Hi Geert, Andrey and friends...
> 
> I am working on ppc, MPC8540, SM501 on PCI,
> drivers=voyagerfb-0.2.tar.gz from last post.
> on linux-2.6
> 
> Geert wrote:
> 
>> Sorry, I cannot follow.
>>
>>  1. If it's a palette issue, your setcolreg() routine doesn't fill in
>> correctly
>>     the pseudo palette,
>>  2. If it's a RGB565 vs. BGR565 issue, you don't fill in correctly the
>> offsets
>>     in the color bitfields in fb_var_screeninfo,
>>  3. If it's an endian issue, it's RRRRRGGGGGGBBBBB vs.GGBBBBBRRRRGGGG,
>> right?
>>     And then there's no much we can do...
> 
> 
> It looks for me like 3. = bytes are flipped = an endian issue:
> In 32 (RGBAlpha) mode (the one we want to use) the colors appear
> wrong. I get my /dev/fb0 appear as
> BB GG RR aa BB GG RR aa BB GG RR aa ...
> 
> In the 
> great 
You're forget qutation here :)

SM501 Databook Version 1.02, Page 2-39, it says:
> Configuration 2, Endian Control at MMIO_base+0x00005c:
> write 0x00000000 for little endian or
> write 0xffffffff for big endian
> into this register before touching any other register of the sm501.
> I've tried that, but it didn't change anything on my system. :-(
> (Well, we can flip the DAC outputs in our hw design ;-)
As I understand, but I'm not sure, LE/BE controlled only by some GPIO
pin (GPIO4 was on rev A/B). I try write to this reg too, with same result.

> 
> Best greets,
> 
> Clemens
> _______________________________
> R&D Imaging Devices
> Anagramm GmbH
> Rupert-Mayer-Str. 45/1
> 81379 Muenchen
> Germany
> 
> http://www.anagramm.de
> Phone: +49-89-741518-50
> Fax: +49-89-741518-19
> 
> ------------------------------------------------
> details:
> 
> $ cp red /dev/fb0 gives me a some red color...
> $ bvi red
> 00000000  00 00 FF 00 00 00 FF 00 00 00 FF 00 00 00 FF 00 ................
> 00000010  00 00 FF 00 00 00 FF 00 00 00 FF 00 00 00 FF 00 ................
> 00000020  00 00 FF 00 00 00 FF 00 00 00 FF 00 00 00 FF 00 ................
> ...
> $ cp green /dev/fb0 gives me a some green color...
> 00 FF 00 00 00 FF 00 00 00 FF 00 00 00 FF 00 00
> ...
> $ cp blue /dev/fb0
> well... blue
> FF 00 00 00 FF 00 00 00 FF 00 00 00 FF 00 00 00
> 

-- 
Regards
Andrey Volkov
