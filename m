Return-Path: <rbrito@ime.usp.br>
Received: from nm34-vm2.bullet.mail.bf1.yahoo.com
 (nm34-vm2.bullet.mail.bf1.yahoo.com [72.30.239.74])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ACBA1A0030
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2015 10:01:12 +1000 (AEST)
Date: Thu, 16 Apr 2015 21:01:07 -0300
From: =?utf-8?Q?Rog=C3=A9rio?= Brito <rbrito@ime.usp.br>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Old regression with MTD devices disappearing from a Kurobox HD/HG
Message-ID: <20150417000107.GA5106@ime.usp.br>
References: <20150408003638.GA5170@ime.usp.br>
 <1428454204.22867.497.camel@freescale.com>
 <20150408011300.GA6395@ime.usp.br>
 <1428456423.22867.501.camel@freescale.com>
 <20150408015649.GA11297@ime.usp.br>
 <20150409215418.GC22595@ime.usp.br>
 <1428618510.22867.548.camel@freescale.com>
 <20150409231250.GA23450@ime.usp.br>
 <20150416225526.GB3373@ime.usp.br>
 <1429226861.32545.30.camel@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1429226861.32545.30.camel@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Scott.

On Apr 16 2015, Scott Wood wrote:
> On Thu, 2015-04-16 at 19:55 -0300, Rogério Brito wrote:
> > Is there any "proper" way for me to discover what device name the kernel
> > uses? I have tried the following command lines without success:
> > 
> > 1 - mtdparts=myflash:4096k(allflash),3072k(firmimg),448k@3072k(bootcode),64k@3520k(status),512k@3584k(conf)
> > 2 - mtdparts=physmap-flash:3072k(firmimg),448k@3072k(bootcode),64k@3520k(status),512k@3584k(conf)
> > 3 - mtdparts=cfi_cmdset_0002:3072k(firmimg),448k@3072k(bootcode),64k@3520k(status),512k@3584k(conf)
> 
> Look in sysfs.

The output that I get from sysfs is:

    # ls -l /sys/block/mtdblock0
    lrwxrwxrwx 1 root root 0 Apr 16 20:42 /sys/block/mtdblock0 -> ../devices/platform/physmap-flash.0/mtd/mtd0/mtdblock0
    # cat /sys/devices/platform/physmap-flash.0/uevent
    DRIVER=physmap-flash
    MODALIAS=platform:physmap-flash
    # cat /sys/devices/platform/physmap-flash.0/driver_override
    (null)

So, it is saying that the driver is physmap-flash, right?  I will compile
now a (new) kernel 4.0 with the parameter passed as my 2nd attempt above
(just to make sure that I have not messed up before).  Just to confirm, this
should (in theory) work, right?

Anything else that I can provide? Again, just ask me and I will do my best
to collect the needed information.


Thanks once again,

-- 
Rogério Brito : rbrito@{ime.usp.br,gmail.com} : GPG key 4096R/BCFCAAAA
http://cynic.cc/blog/ : github.com/rbrito : profiles.google.com/rbrito
DebianQA: http://qa.debian.org/developer.php?login=rbrito%40ime.usp.br
