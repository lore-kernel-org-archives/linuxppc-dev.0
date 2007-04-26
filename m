Return-Path: <mgreer@mvista.com>
Date: Wed, 25 Apr 2007 17:58:53 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 0/13] powerpc: Add support for Marvell/mv64x60 and
	prpmc2800
Message-ID: <20070426005853.GQ4046@mag.az.mvista.com>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070426004514.GC2193@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070426004514.GC2193@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 26, 2007 at 10:45:14AM +1000, David Gibson wrote:
> On Wed, Apr 25, 2007 at 04:46:30PM -0700, Mark A. Greer wrote:
> > The following set of patches add support for the Motorola prpmc2800/f101e platform.
> > To support that platform, several other patches are required that can be grouped as
> > follows:
> > 
> > 	- 1 patch to add Makefile rules that automatically compile & wrap a dts into
> > 	  a zImage
> > 	- 1 patch to add a new interface to the dt_xlate code.
> > 	- 3 mv64x60 bootwrapper patches
> > 	- 5 mv64x60 kernel patches
> > 	- 3 prpmc2800 patches
> 
> Hrm.  This series adds an awful lot of code to the bootwrapper.  Is
> there really no reasonable way to trim it, perhaps moving some of the
> initialization to the kernel driver proper?  I can see that memory
> controller setup and serial might need to be in the wrapper, but PCI
> and I2C initialization?

Well, its not really the ctlr init.  That is done in the kernel
driver(s).  What's being set up are the windows that allow the ctlrs to
access system memory.  This should really be done the the firmware but
isn't so I think the bootwrapper is the proper place to do it.

AFA PCI, its setting up the window from cpu phys->PCI MEM & I/O,
and PCI MEM->system mem.  I think its better to not have that in the
kernel--bloats the kernel and mv64x60 with better fw (which is most of
them hopefully) don't need it.

Another thing to remember is that the marvell bridges are used on MIPS
platforms and therefore the drivers can potentially be used there too.
That makes it doubly important to not dump setup that should be done by
the fw into kernel drivers.

Mark
