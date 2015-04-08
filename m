Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0147.outbound.protection.outlook.com [207.46.100.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B2E501A0058
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 10:02:27 +1000 (AEST)
Message-ID: <1428451332.22867.490.camel@freescale.com>
Subject: Re: Old regression with MTD devices disappearing from a Kurobox HD/HG
From: Scott Wood <scottwood@freescale.com>
To: =?ISO-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Date: Tue, 7 Apr 2015 19:02:12 -0500
In-Reply-To: <20150407235812.GA3443@ime.usp.br>
References: <20150404054022.GA15572@ime.usp.br>
 <1428446044.22867.475.camel@freescale.com>
 <20150407235812.GA3443@ime.usp.br>
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

On Tue, 2015-04-07 at 20:58 -0300, Rogério Brito wrote:
> Dear Scott.
> 
> First of all, thank you so very much for your reply.
> 
> On Apr 07 2015, Scott Wood wrote:
> > On Sat, 2015-04-04 at 02:40 -0300, Rogério Brito wrote:
> > > ,----
> > > | physmap platform flash device: 00400000 at ffc00000
> > > | physmap-flash.0: Found 1 x16 devices at 0x0 in 8-bit bank. Manufacturer ID 0x000004 Chip ID 0x00007e
> > > | Amd/Fujitsu Extended Query Table at 0x0040
> > > |   Amd/Fujitsu Extended Query version 1.3.
> > > | physmap-flash.0: Swapping erase regions for top-boot CFI table.
> > > | number of CFI chips: 1
> > > `----
> > > 
> > > I note that arch/powerpc/boot/dts/kuroboxH{D,G}.dts have, as one of their
> > > first lines, the following comment: [0][1]
> > > 
> > >     XXXX add flash parts, rtc, ??
> > > 
> > > [0]: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/boot/dts/kuroboxHD.dts?id=1cced5015b171415169d938fb179c44fe060dc15#n17
> > > [1]: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/boot/dts/kuroboxHG.dts?id=1cced5015b171415169d938fb179c44fe060dc15#n17
> > > 
> > > Is this a problem that can be fixed via additions to the DTS files?  Or
> > > would the problem be solved in a different way?
> > 
> > What are your bootargs?
> 
> My kernel command line is (specified via uboot) is the following:
> 
> ,----
> | root=/dev/sda1 netconsole=6666@192.168.11.150/,@192.168.11.149/ rtc-rs5c372.probe=0,0x32
> `----
> 
> Only that.
> 
> > I suggest putting the flash device into the dts (instead of using
> > physmap), and specifying the partitions on the command-line using
> > mtdparts.
> 
> This is good to know. Is there any reasonable dts that I can copy/adapt?

I'm not familiar with how flash is connected on this chip, so I don't
have a specific recommendation other than to read the binding and look
at several examples.

>  I just started to read on the syntax of the dts files and I am still
> not confident that I can write my own without messing everything.
> 
> Another question: would putting the description of the flash device into the
> dts file be helpful to remove any code from the kernel?

If you currently have a custom flash map driver, you could get rid of
that, but I suspect that's already gone away due to the fact that it's
no longer working.

-Scott
