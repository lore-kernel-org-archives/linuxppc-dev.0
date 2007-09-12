Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.192.123.res-cmts.eph.ptd.net
	[24.152.192.123]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A2A75DDD01
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Sep 2007 00:17:10 +1000 (EST)
Message-ID: <46E7F492.9040509@dlasys.net>
Date: Wed, 12 Sep 2007 10:15:46 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Yoni Levin <yoni.l@slyde-tech.com>
Subject: Re: writing to flash from linux
References: <1E2D24B6DA8A4EE68CFFD33998B2BC26.MAI@mail.livedns.co.il>
In-Reply-To: <1E2D24B6DA8A4EE68CFFD33998B2BC26.MAI@mail.livedns.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Yoni Levin wrote:
> Hi , I have EN29LV640H flash (http://www.eonsdi.com/pdf/EN29LV640.pdf)
>
> On my mpc83xx board.
>
> How can I write data to flash from linux.?
>
> I guess it done with mtd , there is an example somewhere?
>
> Thanks.
>
>   
    I know nothing specific about your board or flash, but MTD is the 
proper system for handling flash.

    You need an mtd driver for your board - it is possible something 
already exists, but if not you need to write it.
    That driver may be extremely simple - if your boards flash system if 
not very complex.
   
    Some of the issues are ?
    Is your flash partitioned - are there multiple regaions of flash 
that each serve different purposes - such as a boot loader, a kernel, an 
initrd and separately a file system - or even more than one file system.
    Is your flash chip recognized by Linux (likely)
    Are there special conditions for reading/writing flash on your board 
- i.e. do you have to enable special voltages or protection bits - board 
specific protection not chips specific,
    Does your board "window" the flash such that only part of it is in 
the CPU's memory space at one time.
    Does your board have some odd quicks for accessing flash - like 
requiring a 32 bit read to get a 16bit value ?
    All of these are handled by the mtd driver

    If as an example you have a very standard CFI flash chip, that has 
no windowing, no special read/write enables, is always fully in the CPU 
memory space at the same place,
    and all the flash is going to be used for a single filesystem with 
no reserved blocks, bootloaders etc.

    The mtd driver could be trivial, there might even be something that 
can just be used as is.
>  
>
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
