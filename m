Date: Thu, 27 Feb 2003 14:32:20 -0700
From: Matt Porter <porter@cox.net>
To: Brian Waite <waite@skycomputers.com>
Cc: Matt Porter <porter@cox.net>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: RFC: gt64260 descriptor struct
Message-ID: <20030227143220.A16763@home.com>
References: <200302271031.27317.waite@skycomputers.com> <20030227092701.A15982@home.com> <200302271301.10667.waite@skycomputers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200302271301.10667.waite@skycomputers.com>; from waite@skycomputers.com on Thu, Feb 27, 2003 at 01:01:10PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Feb 27, 2003 at 01:01:10PM -0500, Brian Waite wrote:
> Do you have any good pointers besides code on the implementation? I am reading
> the code now to figure out how to make it work. On first look I think it will
> fit, but I am not sure. I definitely see it as solving a different problem to
> what I am trying to solve. Maybe this is due to my naivety on the OCP modle,
> but I need to pass through infomation from the FW that is not determinable by
> code. MAC addresses, for example are not stored in the GT64260. Instead, they
> are either passed on the commandline or passed via PPCBoot. The same goes
> with bus speed, the bus speed cannot be determined by any registers on the
> gt64260. I need to preserve certain peices of information for uppper level
> drivers regardless of if I am using OCP or not. I hope I am missing some on
> the details of OCP and I can overcome my problem by using the OCP layer, but
> I am not sure yet. Any thoughts?

The suggestion to use OCP was directed at the portion of your problem
that is involved in getting the information into the standalone device
drivers.  Getting the information from the boot wrapper code (which might
derive the value from i2c or some other magical place) can be accomplish
using a bd_t like lots of other platforms do.  8xx/4xx, etc.

That gets whatever board specific information (mac addresses, freqs, etc.)
into the kernel.  Then you combine that with a chipset specific
(64260, 360 x60) specific descriptor file that defines the number, irq,
base address type information for a specific system controller variant.
Then you can have an ethernet driver that written to OCP API, will
gather both chipset-specific and board-specific information in a way
that makes the driver very readable.

The bd_t structure can be defined on a per-subarch/board level to
accomodate the fields needed. See evb405ep.h, beech.h, ranier.h,
redwood6.h, etc.

The need to do this type of thing is common across CPC700,CPC710,GT64x60,
MCG Hawk, MCG Harrier,MPC10x,MPC824x, MPC8xx,MPC825x,MPC826x,MPC85xx,PPC4xx
so for readability sake we might as well all do something similar.

-Matt

> On Thursday 27 February 2003 11:27 am, Matt Porter wrote:
> > On Thu, Feb 27, 2003 at 10:31:27AM -0500, Brian Waite wrote:
> > > What we need is a global structure for gt code that will describe the
> > > features of the gt and export that to drivers that need it. What I see
> > > right now for required elements are:
> >
> > All peripherals that don't have intelligent discovery mechanisms could
> > make use of the OCP layer that 4xx uses.  gt64260, mpc10x, etc could
> > easily follow this same model that provides a standard device info.
> > discovery interface.  Of course, the OCP stuff in 2_4_devel is due
> > to be changed to match that of 2.5 is the near future...benh is
> > working on that.
> >
> > Regards,

--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
