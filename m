Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0136.outbound.protection.outlook.com [207.46.100.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3FABB1A0145
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 08:28:46 +1000 (AEST)
Message-ID: <1428618510.22867.548.camel@freescale.com>
Subject: Re: Old regression with MTD devices disappearing from a Kurobox HD/HG
From: Scott Wood <scottwood@freescale.com>
To: =?ISO-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Date: Thu, 9 Apr 2015 17:28:30 -0500
In-Reply-To: <20150409215418.GC22595@ime.usp.br>
References: <20150404054022.GA15572@ime.usp.br>
 <1428446044.22867.475.camel@freescale.com>
 <20150407235812.GA3443@ime.usp.br>
 <1428451332.22867.490.camel@freescale.com>
 <20150408003638.GA5170@ime.usp.br>
 <1428454204.22867.497.camel@freescale.com>
 <20150408011300.GA6395@ime.usp.br>
 <1428456423.22867.501.camel@freescale.com>
 <20150408015649.GA11297@ime.usp.br> <20150409215418.GC22595@ime.usp.br>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-04-09 at 18:54 -0300, Rogério Brito wrote:
> Dear Scott and other people,
> 
> Just for the record, I am passing now the following command line option to
> the kernel:
> 
>     mtdparts=myflash:4096k(allflash),3072k(firmimg),448k@3072k(bootcode),64k@3520k(status),512k@3584k(conf)

What is "myflash"?  You need to match the device name that the kernel
uses.

What is "allflash"?  If the flash is only 4 MiB and you're trying to
make the first partition refer to the entire flash, it won't work.
It'll see that 4 MiB partition and ignore the rest as being beyond the
end of the device.

> which is, according to my best knowledge, how the flash is laid out.
> Unfortunately, it doesn't help: I still have only /dev/mtd0. Here is what
> part of my configuration looks like:
> 
> ,----
> | # uname -r
> | 4.0.0-rc7-00016-g7b43b47
> | # grep -i mtd config-$(uname -r)
> | CONFIG_CMDLINE="netconsole=6666@192.168.11.150/,@192.168.11.149/ rtc-rs5c372.probe=0,0x32 root=/dev/sda1 mtdparts=myflash:4096k(allflash),3072k(firmimg),448k@3072k(bootcode),64k@3520k(status),512k@3584k(conf)"
> | CONFIG_MTD=y
> | # CONFIG_MTD_TESTS is not set
> | # CONFIG_MTD_REDBOOT_PARTS is not set
> | CONFIG_MTD_CMDLINE_PARTS=y
> | CONFIG_MTD_OF_PARTS=y
> | # CONFIG_MTD_AR7_PARTS is not set
> | CONFIG_MTD_BLKDEVS=y
> | CONFIG_MTD_BLOCK=y
> | (...)
> `----
> 
> Do the options CONFIG_MTD_CMDLINE_PARTS and CONFIG_MTD_OF_PARTS somehow
> "conflict" with each other?

No.  CONFIG_MTD_OF_PARTS only matters if you're describing the flash
chip in the device tree, and even then cmdline mtdparts takes precedence
if present.

-Scott
