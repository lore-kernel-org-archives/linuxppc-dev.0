Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 82B09DDEE9
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:04:30 +1100 (EST)
Message-ID: <47580F43.7020404@freescale.com>
Date: Thu, 06 Dec 2007 09:03:31 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] qe: add ability to upload QE firmware
References: <11968944871776-git-send-email-timur@freescale.com>
	<200712060056.39368.arnd@arndb.de> <47573CCE.4000606@freescale.com>
	<200712060117.14768.arnd@arndb.de>
In-Reply-To: <200712060117.14768.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Thursday 06 December 2007, Timur Tabi wrote:
>>> In that case, I think it
>>> would really be better to just put the blob into the tree and only
>>> have the fw loading code in the kernel instead of duplicating it in the boot
>>> loader.
>> That would require the firmware to present in RAM for all time, since the device 
>> tree cannot be unloaded.
> 
> Yes, that's a backdraw of my approach, but in the case of spidernet, it was only
> an insignificant amount of RAM. Don't know what sizes of RAM and QE firmware
> to expect typically on the machines you care about.

I'm only familiar with the UART microcode, which is relatively small.  I'll add 
this feature to my to-do list.

> Right, so you can't really get around having it in some boot loaders at least.
> IIRC you said that the firmware is only needed for serial output on some chips
> but not on others. What about the case where you don't need it for serial but
> still want to provide it by the firmware, and perhaps use something other than
> U-boot? Is that relevant?

In this particular case, the UART firmware is needed on some chips only because 
those chips are broken in silicon.  AFAIK, only 8323 and 8360 are affected. 
None of the 85xx chips with QE have the broken UART silicon, so they don't need 
this firmware.

The whole point behind having binary firmware blobs is so that *any* OS, 
boot-loader, or even an application can upload firmware without worrying about 
licensing issues.  The code to parse and process the blobs is open source.

There are other firmwares, such as firmware for TCP/IP interworking. 
Unfortunately, I don't have any direct experience with those firmwares, but in 
discussions with QE engineers who have, my approach works.  My hope is that 
every OS that runs on our QE-enabled parts will contain a version of 
qe_upload_firmware().

> I'm not trying to convince you of this if it's completely pointless for
> all your systems, just want to make sure you're aware of this option,
> because spending a few extra code lines on it now may save you some trouble
> if you need this later.

Um, I think I'm a little confused as to what your point is.  My code is just a 
generic QE firmware uploader.

>> Technically, the firmware could be considered a device on the QE, because it's 
>> loaded into I-RAM and it can significantly alter the behavior of the device. 
> 
> Well, it doesn't have any of the standard properties like registers or interrupts
> though.

Well, there are registers for accessing I-RAM.  It's not memory mapped - you 
have to write the I-RAM internal address to one register, and then write the 
data to another register, in order to actually write to I-RAM.

-- 
Timur Tabi
Linux kernel developer at Freescale
