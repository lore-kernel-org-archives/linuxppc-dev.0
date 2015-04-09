Return-Path: <rbrito@ime.usp.br>
Received: from nm38-vm9.bullet.mail.bf1.yahoo.com
 (nm38-vm9.bullet.mail.bf1.yahoo.com [72.30.239.25])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A7C171A02F4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 09:12:56 +1000 (AEST)
Date: Thu, 9 Apr 2015 20:12:50 -0300
From: =?utf-8?Q?Rog=C3=A9rio?= Brito <rbrito@ime.usp.br>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Old regression with MTD devices disappearing from a Kurobox HD/HG
Message-ID: <20150409231250.GA23450@ime.usp.br>
References: <1428446044.22867.475.camel@freescale.com>
 <20150407235812.GA3443@ime.usp.br>
 <1428451332.22867.490.camel@freescale.com>
 <20150408003638.GA5170@ime.usp.br>
 <1428454204.22867.497.camel@freescale.com>
 <20150408011300.GA6395@ime.usp.br>
 <1428456423.22867.501.camel@freescale.com>
 <20150408015649.GA11297@ime.usp.br>
 <20150409215418.GC22595@ime.usp.br>
 <1428618510.22867.548.camel@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1428618510.22867.548.camel@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Scott.

On Apr 09 2015, Scott Wood wrote:
> On Thu, 2015-04-09 at 18:54 -0300, Rogério Brito wrote:
> > Dear Scott and other people,
> > 
> > Just for the record, I am passing now the following command line option to
> > the kernel:
> > 
> >     mtdparts=myflash:4096k(allflash),3072k(firmimg),448k@3072k(bootcode),64k@3520k(status),512k@3584k(conf)
> 
> What is "myflash"?  You need to match the device name that the kernel
> uses.

>From the documentation that I read, it *seemed* to be an arbitrary name and,
to be screamingly different from anything else, I just picked "myflash".
So, in my case (see dmesg snippet below), I would use "physmap-flash.0",
right? Or would that be "physmap-flash"? Or something else entirely?

,----
| (...)
| ata1: PATA max UDMA/133 cmd 0xbffed0 ctl 0xbffed8 bmdma 0xbffef0 irq 17
| ata2: PATA max UDMA/133 cmd 0xbffee0 ctl 0xbffee8 bmdma 0xbffef8 irq 17
| physmap platform flash device: 00400000 at ffc00000
| physmap-flash.0: Found 1 x16 devices at 0x0 in 8-bit bank. Manufacturer ID 0x000004 Chip ID 0x00007e
| Amd/Fujitsu Extended Query Table at 0x0040
|   Amd/Fujitsu Extended Query version 1.3.
| physmap-flash.0: Swapping erase regions for top-boot CFI table.
| number of CFI chips: 1
| r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
| (...)
`----

> What is "allflash"?  If the flash is only 4 MiB and you're trying to
> make the first partition refer to the entire flash, it won't work.
> It'll see that 4 MiB partition and ignore the rest as being beyond the
> end of the device.

OK, I was just trying to mimic the layout that you can see here:

    http://buffalo.nas-central.org/wiki/Flash_ROM#Checking_the_layout_.28with_kernel_2.6.x.29

> > Do the options CONFIG_MTD_CMDLINE_PARTS and CONFIG_MTD_OF_PARTS somehow
> > "conflict" with each other?
> 
> No.  CONFIG_MTD_OF_PARTS only matters if you're describing the flash
> chip in the device tree, and even then cmdline mtdparts takes precedence
> if present.

Great to know. I hope that one way or another we can have these partitions
specified in the device tree so that:

* The device tree sources better reflect the reality and describe the
  hardware closer than they do today.
* I can clean up my command line.


Thanks once again,

-- 
Rogério Brito : rbrito@{ime.usp.br,gmail.com} : GPG key 4096R/BCFCAAAA
http://cynic.cc/blog/ : github.com/rbrito : profiles.google.com/rbrito
DebianQA: http://qa.debian.org/developer.php?login=rbrito%40ime.usp.br
