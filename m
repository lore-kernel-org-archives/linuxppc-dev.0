Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 619A5B718D
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Sep 2010 07:12:25 +1000 (EST)
Date: Thu, 2 Sep 2010 14:12:22 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Where to put board-specific drivers
Message-ID: <20100902211221.GD24861@ovro.caltech.edu>
References: <20100902200434.GC24861@ovro.caltech.edu>
	<320E0907-436B-42B8-9E85-EABF481FE04C@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <320E0907-436B-42B8-9E85-EABF481FE04C@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 02, 2010 at 03:17:52PM -0500, Kumar Gala wrote:
> 
> On Sep 2, 2010, at 3:04 PM, Ira W. Snyder wrote:
> 
> > Hello all,
> > 
> > I've written several drivers for a custom board. The board is basically
> > an mpc8349_mds board with some extra FPGAs for data processing.
> > 
> > All of the drivers were written to interface with a custom system
> > controller FPGA, which handles things like LED control, FPGA
> > programming, and fast data dumping from the data processing FPGAs.
> > 
> > I'd like to start pushing some of these drivers into mainline, but I
> > don't know where to put them. I don't think drivers/ is appropriate:
> > these are highly board specific. Does arch/powerpc/ have a recommended
> > place for board-specific drivers? I was thinking about
> > arch/powerpc/drivers/, however that doesn't exist.
> 
> If we decide to put them under arch/powerpc I'd suggest arch/powerpc/platform/83xx/BOARDNAME/
> 
> However I'm not sure I think this is a good idea.  We specifically moved drivers out of arch/ppc land so they would get proper review via the proper subsystem maintainers.  So if its truly unique / simple board drivers than the location I suggested is probably fine.  If its something that a subsystem exists than I do think it should be down in the subsystem driver dir.
> 

Thanks for replying Kumar.

These drivers are very board specific, though they are not all extremely
simple. Two of the four are ~1200 lines each. Not huge, but not trivial
either.

To give you three example drivers:
1) Data processing FPGA access driver

This driver provides a simple character device to userspace which
exposes one function: mmap. With it, you can mmap the entire data
processing FPGA memory window into your process. With this, I provide
non-realtime FPGA control to userspace applications.

2) Data processing FPGA capture driver

This driver provides a simple character device to userspace which
supports one function: read. Internally, it maintains a list of buffers
which hold capture data. When the FPGA's are processing data, they dump
data at 64Hz (every 15.625ms). If the data is not copied off the chips
before the next dump, data is lost.

DMA is required to move the data volume off the FPGAs fast enough to
keep timing. Therefore this really does need to be in-kernel.

3) Data processing FPGA programmer

The system controller has a hardware controlled FPGA programmer. It is
required to use this programmer to program a new configuration into the
data processing FPGAs. Their programming sequence has timing
requirements that can only be met in hardware. It requires that the FPGA
bitfile is in DMA-capabable memory.

I used a char device for this too: write the bitfile to the device (it
is buffered in-kernel), then give it the ioctl() to program the FPGAs.



AFAIK, there is nothing like this in the kernel at the moment. That's
why I asked if there is a better place to put this.

Thanks,
Ira
