Return-Path: <rbrito@ime.usp.br>
Received: from nm4.bullet.mail.bf1.yahoo.com (nm4.bullet.mail.bf1.yahoo.com
 [98.139.212.163])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D59941A0ACC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 09:58:18 +1000 (AEST)
Date: Tue, 7 Apr 2015 20:58:12 -0300
From: =?utf-8?Q?Rog=C3=A9rio?= Brito <rbrito@ime.usp.br>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Old regression with MTD devices disappearing from a Kurobox HD/HG
Message-ID: <20150407235812.GA3443@ime.usp.br>
References: <20150404054022.GA15572@ime.usp.br>
 <1428446044.22867.475.camel@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1428446044.22867.475.camel@freescale.com>
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

First of all, thank you so very much for your reply.

On Apr 07 2015, Scott Wood wrote:
> On Sat, 2015-04-04 at 02:40 -0300, Rogério Brito wrote:
> > ,----
> > | physmap platform flash device: 00400000 at ffc00000
> > | physmap-flash.0: Found 1 x16 devices at 0x0 in 8-bit bank. Manufacturer ID 0x000004 Chip ID 0x00007e
> > | Amd/Fujitsu Extended Query Table at 0x0040
> > |   Amd/Fujitsu Extended Query version 1.3.
> > | physmap-flash.0: Swapping erase regions for top-boot CFI table.
> > | number of CFI chips: 1
> > `----
> > 
> > I note that arch/powerpc/boot/dts/kuroboxH{D,G}.dts have, as one of their
> > first lines, the following comment: [0][1]
> > 
> >     XXXX add flash parts, rtc, ??
> > 
> > [0]: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/boot/dts/kuroboxHD.dts?id=1cced5015b171415169d938fb179c44fe060dc15#n17
> > [1]: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/boot/dts/kuroboxHG.dts?id=1cced5015b171415169d938fb179c44fe060dc15#n17
> > 
> > Is this a problem that can be fixed via additions to the DTS files?  Or
> > would the problem be solved in a different way?
> 
> What are your bootargs?

My kernel command line is (specified via uboot) is the following:

,----
| root=/dev/sda1 netconsole=6666@192.168.11.150/,@192.168.11.149/ rtc-rs5c372.probe=0,0x32
`----

Only that.

> I suggest putting the flash device into the dts (instead of using
> physmap), and specifying the partitions on the command-line using
> mtdparts.

This is good to know. Is there any reasonable dts that I can copy/adapt? I
just started to read on the syntax of the dts files and I am still not
confident that I can write my own without messing everything.

Another question: would putting the description of the flash device into the
dts file be helpful to remove any code from the kernel? That would be super
nice, as the kernels with equivalent configurations are getting so much
bigger during time. The smallest one that I have here is 2.6.28 and its
uImage was 1.5MB, while kernel 4.0 is about 1.9MB with essentially
everything pruned from the kernel (only the bare minimum compiled in). :(

(Everything here is compiled with the very same compiler).

> Putting the partitions in the dts is an option as well, but less flexible
> if users may want to change the partition layout -- though that may be
> less of a concern here than with reference boards.

I think that I would go for the partitions in the dts, mainly because these
machines are not really flexible.  Furthermore, I would need the mtd devices
working so that I can use fw_setenv to change the boot options. :)

In the end, I would like (perhaps) to automate the installation/support of
such machines and offer a way to install Debian on those (or any other
distribution that is interested in these).

Once again, thank you so much for your comments and I hope that you can
guide me some more to fix this for good.


Thanks,

-- 
Rogério Brito : rbrito@{ime.usp.br,gmail.com} : GPG key 4096R/BCFCAAAA
http://cynic.cc/blog/ : github.com/rbrito : profiles.google.com/rbrito
DebianQA: http://qa.debian.org/developer.php?login=rbrito%40ime.usp.br
