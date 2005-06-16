Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id 3A26267A6F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 18:47:27 +1000 (EST)
Message-ID: <42B13C9B.1080403@anagramm.de>
Date: Thu, 16 Jun 2005 10:47:23 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Alex Zeffertt <ajz@cambridgebroadband.com>
References: <20050614104749.387910e0.ajz@cambridgebroadband.com>	<42B02AAD.6050805@anagramm.de>
	<20050615145434.315a4b94.ajz@cambridgebroadband.com>
In-Reply-To: <20050615145434.315a4b94.ajz@cambridgebroadband.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-mtd@lists.infradead.org, linuxppc-embedded@ozlabs.org
Subject: Re: sub-module loading (was: Anyone got drivers/mtd/maps/pm828.c?)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Alex...
good to know, that you made good progress. :-)

I just X-post this to linux-mtd so maybe somebody can have a look
at your issue, too.

I also experienced "problems" with sub-module-loading. Or maybe
I just missed something:
I need to load mtdchar and map_ram separately in order to be
able to probe my mminfo.ko module to access/mess some
SRAM in my FPGA on a MPC8540. I didn't care about that yet,
but maybe there are missing dependencies which can be solved
automagically here. Or is the sub-module loading supposed to
work like this (well, manual) as somebody might want to choose
in between i.e. mtdblock and/or mtdchar?

I'm talking about the Kernel 2.6.11.11 mtd subsystem.

Best greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19

Alex Zeffertt wrote:
> Hi Clemens,
> 
> Thanks for your help.  I've done it now (see attached).  The
> partitioning is specific to our application but it is easily modified.
> 
> I noticed a buggette in the mtd code while doing this.  If you build
> everything as a module then the sub-module loading doesn't work
> properly.  For example in gen_probe.c it says
> 
> #ifdef CONFIG_MTD_CFI_INTELEXT
> 	case 0x0001:
> 	case 0x0003:
> 		return cfi_cmdset_0001(map, primary);
> #endif
> 
> where it should really say
> 
> #if defined(CONFIG_MTD_CFI_INTELEXT) ||
>     defined(CONFIG_MTD_CFI_INTELEXT_MODULE)
> 	case 0x0001:
> 	case 0x0003:
> 		return cfi_cmdset_0001(map, primary);
> #endif
> 
> There are several problems like this.  In the end I gave up and just
> built everything except the actual mapping driver as kernel resident.
> 
> Alex
> 
> 
> On Wed, 15 Jun 2005 15:18:37 +0200
> Clemens Koller <clemens.koller@anagramm.de> wrote:
> 
> 
>>Hi, Alex!
>>
>>Hmm, I don't know the PM828 much in detail, but have you
>>tried the "generic" physmap driver which is in the kernel?
>>Just give it the base address and the size, and it should
>>probe the cfi and you are done (well, it was working fine
>>for me on my PM854).
>>Of course, you need to make sure, that your hardware / memory
>>mapping is initialized properly (which happens usually in the
>>boot loader). If it's not, let me know and I can give you
>>some code to mess around with the registers in a kernel module.
>>
>>Best greets,
>>
>>Clemens Koller
>>_______________________________
>>R&D Imaging Devices
>>Anagramm GmbH
>>Rupert-Mayer-Str. 45/1
>>81379 Muenchen
>>Germany
>>
>>http://www.anagramm.de
>>Phone: +49-89-741518-50
>>Fax: +49-89-741518-19
>>
>>
>>Alex Zeffertt wrote:
>>
>>>Hi there,
>>>
>>>I need to get flash partitions working on my PM828 development
>>>board. Has anybody already written a pm828.c?  If so I'd appreciate
>>>a look at it.
>>>
>>>TIA,
>>>
>>>Alex
>>>_______________________________________________
>>>Linuxppc-embedded mailing list
>>>Linuxppc-embedded@ozlabs.org
>>>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>>
