Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 1CA7BDDDFB
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Oct 2007 12:59:27 +1000 (EST)
Date: Thu, 4 Oct 2007 19:59:30 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>,
	Valentine Barshak <vbarshak@ru.mvista.com>, linuxppc-dev@ozlabs.org
Subject: Re: [RFC] [PATCH] PowerPC: add more than 4MB kernel image size
	support to bootwarapper
Message-ID: <20071005025930.GA24218@mag.az.mvista.com>
References: <20070924113627.GA30504@ru.mvista.com>
	<20070925022935.GI30338@localhost.localdomain>
	<46FD0E4D.30305@ru.mvista.com>
	<20071003055005.GD18978@localhost.localdomain>
	<20071005015849.GA9862@mag.az.mvista.com>
	<20071005022554.GE25637@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071005022554.GE25637@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 05, 2007 at 12:25:54PM +1000, David Gibson wrote:
> On Thu, Oct 04, 2007 at 06:58:49PM -0700, Mark A. Greer wrote:
> > On Wed, Oct 03, 2007 at 03:50:05PM +1000, David Gibson wrote:
> > > On Fri, Sep 28, 2007 at 06:23:09PM +0400, Valentine Barshak wrote:
> > > > David Gibson wrote:
> > > > > On Mon, Sep 24, 2007 at 03:36:27PM +0400, Valentine Barshak wrote:
> > 
> > > > Looking deeper at this I've found that currently u-boot thinks that 
> > > > memory space over 8MB is not reached by Linux kernel (CFG_BOOTMAPSZ 
> > > > defined as (8 << 20)), although all physical memory is identity mapped. 
> > > > That's why it puts command line and board info structure as high as 
> > > > possible within the first 8MB. This worked fine with uImage, since 
> > > > u-boot always unpacked it to 0. Now, cuImage has to be unpacked higher 
> > > > (we need space at the start of the memory to eventually put vmlinux 
> > > > image there). So, if unpacked kernel image crosses 8MB boundary, it gets 
> > > > damaged by u-boot when it prepares cmd_line and bdinfo. The possible 
> > > > workaround for that is to always link zImage at >=8MB base or to have 
> > > > 4MB granularity like this:
> > > > 
> > > > +  . = ALIGN((_kend - _kstart + 64*1024), (4*1024*1024));
> > > > 
> > > > Reserve at least 64K for u-boot cmd_line and bdinfo.
> > > 
> > > Ah.  Right.  That makes things a bit tricky.  Even this 4MB
> > > granularity may not be enough (say, if the vmlinux is < 4MB, but the
> > > zImage has a really big initrd and is > 4MB).
> > > 
> > > Except... it shouldn't really be the link address that matters.  The
> > > zImage is relocatable, so it should only be the load address specified
> > > in the uImage header which matters.  I think that's currently derived
> > > from the link address, but it doesn't have to be.
> > 
> > Having the link address jump around depending on the size of the kernel
> > or zImage is wrong IMHO.  It just screams "weird can't boot issues."
> 
> Hrm.  Except we already have that - the zImage is linked at a fixed
> location, and will just not work if the sizes are wrong.

Yes, its an issue now (which is why we're having this discussion) but
at least its predictable ATM.  Having it jump around on you because
you happened to set/clear a CONFIG option is worse.

My point is that the address needs to be set manually--no fancy heuristics
or whatever to guess.

> > We need a way to specify exactly where we want the zImage linked no
> > matter what the kernel or zImage size.
> > 
> > Also, being able to control the link address (that is, the download
> > address with some firmwares) is not a u-boot specific issue and we
> > shouldn't make a u-boot specific solution.
> > 
> > The more general problem is that some firmwares examine the ELF header
> > and download the zImage to address it was linked at.  Some firmwares let
> > you override this but some don't and those are the problem ones.
> > 
> > We talked about this a bit back in February,
> > http://ozlabs.org/pipermail/linuxppc-dev/2007-February/031532.html
> > 
> > In that thread Geoff Levand suggested a config option and running it
> > thru a preprocessor.  David Gibson suggested making a replaceable linker
> > script.  I suggested passing the value of a config option to the wrapper
> > script which would use objcopy/whatever to change the section addresses
> > in the image (maybe this is what Geoff had in mind, I'm not sure).
> > 
> > I still like my idea best.  I haven't coded yet it so I don't have a patch
> > but this is what I mean:
> > 
> > 1) add a config option (default 4MB) for the link address
> > 2) add a parameter to the wrapper script thru which we pass the value in
> >    the config option
> > 3) the wrapper script changes the VMA/LMA to the address specified
> >    (objcopy --change-addresses=<some math to get correct incr> ?).
> > 
> > I'll code it up in the next day or two unless someone doesn't like the idea.
> 
> A config option just doesn't seem right to me, except as a
> special-circumstances hack.

Acutally, I started to hack up the patch and noticed that its already
there.  Its 'CONFIG_BOOT_LOAD' which is an "Advanced setup" option
in arch/powerpc/Kconfig (probably migrated from arch/ppc/Kconfig).
Several defconfig's have it set but its not used AFAICS.

> The zImage is already hardware and
> firmware specific;

And [potentially] firmware version and zImage size specific.

> we should be able to figure out workable link and
> load addresses for a specific zImage

I was going to argue with you here until...

> (which might need to be different
> for different zImages produced by the same config).

Oh yeah, I forgot about multiple zImages from the same config.  D*mn.
Hmm, I guess I have to think about this more then.  (and stop hacking up
the patch I was talking about).

> Of course, the same objection would apply to CONFIG_DEVICE_TREE which
> we have already.

Yep.

Mark
