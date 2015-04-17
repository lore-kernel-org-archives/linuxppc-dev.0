Return-Path: <rbrito@ime.usp.br>
Received: from nm44-vm10.bullet.mail.bf1.yahoo.com
 (nm44-vm10.bullet.mail.bf1.yahoo.com [216.109.115.46])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7867F1A0030
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2015 10:14:13 +1000 (AEST)
Date: Thu, 16 Apr 2015 21:14:09 -0300
From: =?utf-8?Q?Rog=C3=A9rio?= Brito <rbrito@ime.usp.br>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Old regression with MTD devices disappearing from a Kurobox HD/HG
Message-ID: <20150417001408.GA15983@ime.usp.br>
References: <20150408011300.GA6395@ime.usp.br>
 <1428456423.22867.501.camel@freescale.com>
 <20150408015649.GA11297@ime.usp.br>
 <20150409215418.GC22595@ime.usp.br>
 <1428618510.22867.548.camel@freescale.com>
 <20150409231250.GA23450@ime.usp.br>
 <20150416225526.GB3373@ime.usp.br>
 <1429226861.32545.30.camel@freescale.com>
 <20150417000107.GA5106@ime.usp.br>
 <1429228980.32545.31.camel@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1429228980.32545.31.camel@freescale.com>
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

On Apr 16 2015, Scott Wood wrote:
> On Thu, 2015-04-16 at 21:01 -0300, Rogério Brito wrote:
> > On Apr 16 2015, Scott Wood wrote:
> > > On Thu, 2015-04-16 at 19:55 -0300, Rogério Brito wrote:
> > > > Is there any "proper" way for me to discover what device name the kernel
> > > > uses? I have tried the following command lines without success:
> > > > 
> > > > 1 - mtdparts=myflash:4096k(allflash),3072k(firmimg),448k@3072k(bootcode),64k@3520k(status),512k@3584k(conf)
> > > > 2 - mtdparts=physmap-flash:3072k(firmimg),448k@3072k(bootcode),64k@3520k(status),512k@3584k(conf)
> > > > 3 - mtdparts=cfi_cmdset_0002:3072k(firmimg),448k@3072k(bootcode),64k@3520k(status),512k@3584k(conf)
> > > 
> > > Look in sysfs.
> > 
> > The output that I get from sysfs is:
> > 
> >     # ls -l /sys/block/mtdblock0
> >     lrwxrwxrwx 1 root root 0 Apr 16 20:42 /sys/block/mtdblock0 -> ../devices/platform/physmap-flash.0/mtd/mtd0/mtdblock0
> >     # cat /sys/devices/platform/physmap-flash.0/uevent
> >     DRIVER=physmap-flash
> >     MODALIAS=platform:physmap-flash
> >     # cat /sys/devices/platform/physmap-flash.0/driver_override
> >     (null)
> > 
> > So, it is saying that the driver is physmap-flash, right?
> 
> It looks like the device name is "physmap-flash.0".  You're partitioning
> the device, not the driver.

Sure, the device, not the driver. :) I simply thought that the trailing .0
was a way to disambiguate from multiple devices that might (perhaps) be
activated by the same driver.

Regardless, I guess that I have already tried this physmap-flash.0 thing,
but I will let you know the results in a few minutes. :) I have just
finished compiling the kernel with that (forced) command line and I'm
rebooting the system now.

----

Yay! It worked:

,----
| physmap platform flash device: 00400000 at ffc00000
| physmap-flash.0: Found 1 x16 devices at 0x0 in 8-bit bank. Manufacturer ID 0x000004 Chip ID 0x00007e
| Amd/Fujitsu Extended Query Table at 0x0040
|   Amd/Fujitsu Extended Query version 1.3.
| physmap-flash.0: Swapping erase regions for top-boot CFI table.
| number of CFI chips: 1
| 4 cmdlinepart partitions found on MTD device physmap-flash.0
| Creating 4 MTD partitions on "physmap-flash.0":
| 0x000000000000-0x000000300000 : "firmimg"
| 0x000000300000-0x000000370000 : "bootcode"
| 0x000000370000-0x000000380000 : "status"
| 0x000000380000-0x000000400000 : "conf"
`----

Now, the next step is to learn this DTS thing and send patches to two DTS
files.  :)


Thank you so very much,

-- 
Rogério Brito : rbrito@{ime.usp.br,gmail.com} : GPG key 4096R/BCFCAAAA
http://cynic.cc/blog/ : github.com/rbrito : profiles.google.com/rbrito
DebianQA: http://qa.debian.org/developer.php?login=rbrito%40ime.usp.br
