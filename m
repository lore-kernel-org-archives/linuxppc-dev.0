Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.192.123.res-cmts.eph.ptd.net
	[24.152.192.123]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 18AB3DDF82
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Jun 2007 19:39:08 +1000 (EST)
Message-ID: <4677A3D8.8000107@dlasys.net>
Date: Tue, 19 Jun 2007 05:37:28 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: "Shelley, Mike" <Mike.Shelley@viasat.com>
Subject: Re: booting zImage.elf
References: <821B2170E9E7F04FA38DF7EC21DE4871084A0ED0@VCAEXCH01.hq.corp.viasat.com>
In-Reply-To: <821B2170E9E7F04FA38DF7EC21DE4871084A0ED0@VCAEXCH01.hq.corp.viasat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    An elf file is not just a collection of bits exactly as they would
be found in memory.
    The code in it may get loaded into several distinct regions, it may
include information to allocate additional regions,
    the code may be relocatable or have relocation information.

    It is unlikely (maybe impossible) that you can create an elf file
that you can just jump into.

    There are other file formats that you can build the kernel as that
would more closely correspond to what you are after.
    Because I normally build zImage.elf files and my loader handles
them  well I am not experienced with creating other formats,
    but I think the u-boot documentation should give you some pointers.
    You do not convert the zImage.elf, you build the kernel with the
image format that you want.

    zImage.elf is actually a very simple elf file, that performs some
rudimentary initialization, and then decompresses what is really the
kernel image into memory
    and executes it. The compressed image inside the zImage.elf is
closer to what you are looking for.
   
   
   
  

Shelley, Mike wrote:
> I've been trying to read up on how elf works and how to boot the linux kernel image with a custom boot loader.  I can't seem to find anything about booting an elf image.  I'm using a PCI Express XpressFX Board (which has a Virtex4), by PLDA, with DDR2 memory.  I've got the kernel image booting using a BDI to load it. Now I need to get it to load without the BDI.
>
> The quick question is, Is it possible to load zImage.elf straight into memory, then jump to the address it was loaded to?  If not, how do I convert the elf image into just a bootable image that I can jump to?
>
> I looked at the uboot code to load elf files, and it appears to copy the sections around.  Is this necessary?
>
> Pointers on where else to look or how to do this would be greatly appreciated.
>
> Michael
>
>   
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
