Return-Path: <rbrito@ime.usp.br>
Received: from nm9-vm0.bullet.mail.bf1.yahoo.com
 (nm9-vm0.bullet.mail.bf1.yahoo.com [98.139.213.154])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 06C021A001E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2015 08:55:33 +1000 (AEST)
Date: Thu, 16 Apr 2015 19:55:26 -0300
From: =?utf-8?Q?Rog=C3=A9rio?= Brito <rbrito@ime.usp.br>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Old regression with MTD devices disappearing from a Kurobox HD/HG
Message-ID: <20150416225526.GB3373@ime.usp.br>
References: <20150407235812.GA3443@ime.usp.br>
 <1428451332.22867.490.camel@freescale.com>
 <20150408003638.GA5170@ime.usp.br>
 <1428454204.22867.497.camel@freescale.com>
 <20150408011300.GA6395@ime.usp.br>
 <1428456423.22867.501.camel@freescale.com>
 <20150408015649.GA11297@ime.usp.br>
 <20150409215418.GC22595@ime.usp.br>
 <1428618510.22867.548.camel@freescale.com>
 <20150409231250.GA23450@ime.usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20150409231250.GA23450@ime.usp.br>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Scott and others.

On Apr 09 2015, Rogério Brito wrote:
> On Apr 09 2015, Scott Wood wrote:
> > On Thu, 2015-04-09 at 18:54 -0300, Rogério Brito wrote:
> > >     mtdparts=myflash:4096k(allflash),3072k(firmimg),448k@3072k(bootcode),64k@3520k(status),512k@3584k(conf)
> > 
> > What is "myflash"?  You need to match the device name that the kernel
> > uses.
> 
> From the documentation that I read, it *seemed* to be an arbitrary name and,
> to be screamingly different from anything else, I just picked "myflash".
> So, in my case (see dmesg snippet below), I would use "physmap-flash.0",
> right? Or would that be "physmap-flash"? Or something else entirely?

Is there any "proper" way for me to discover what device name the kernel
uses? I have tried the following command lines without success:

1 - mtdparts=myflash:4096k(allflash),3072k(firmimg),448k@3072k(bootcode),64k@3520k(status),512k@3584k(conf)
2 - mtdparts=physmap-flash:3072k(firmimg),448k@3072k(bootcode),64k@3520k(status),512k@3584k(conf)
3 - mtdparts=cfi_cmdset_0002:3072k(firmimg),448k@3072k(bootcode),64k@3520k(status),512k@3584k(conf)

The first one is the one from my previous post. The next ones had the name
of the device changed *and* the 4MB at the start removed.

Do you want my config file? Do you want any dmesg output?  Anything else
that I can provide?

> > What is "allflash"?  If the flash is only 4 MiB and you're trying to
> > make the first partition refer to the entire flash, it won't work.
> > It'll see that 4 MiB partition and ignore the rest as being beyond the
> > end of the device.
> 
> OK, I was just trying to mimic the layout that you can see here:
> 
>     http://buffalo.nas-central.org/wiki/Flash_ROM#Checking_the_layout_.28with_kernel_2.6.x.29

I have removed that parameter from the command line.


Thanks a lot for your help,

-- 
Rogério Brito : rbrito@{ime.usp.br,gmail.com} : GPG key 4096R/BCFCAAAA
http://cynic.cc/blog/ : github.com/rbrito : profiles.google.com/rbrito
DebianQA: http://qa.debian.org/developer.php?login=rbrito%40ime.usp.br
