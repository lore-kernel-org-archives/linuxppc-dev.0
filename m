Date: Sat, 17 Aug 2002 23:44:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Matt Porter <porter@cox.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: First steps to OCP device model integration
Message-ID: <20020817134404.GB17036@zax>
References: <20020809042605.GC23642@zax> <20020813083403.A30884@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020813083403.A30884@home.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Aug 13, 2002 at 08:34:03AM -0700, Matt Porter wrote:
>
> On Fri, Aug 09, 2002 at 02:26:05PM +1000, David Gibson wrote:
> >
> > THe patch below implements the first steps in transitioning the
> > handling of 4xx OCP devices to the unfied device model (in 2.5).  So
> > far the code just registers an ocp bus and registers each device
> > described in core_ocp on that bus.  The next step is to convert the
> > actual device drivers so that that they register with the unified
> > driver tree rather than through the old ocp_register() mechanism.
>
> Hi David,
>
> I don't have any concerns about your patch as a starting point,
> but I'd like to talk about where we are going with driverfs
> integration of proprietary on-chip buses (4xx and other SoCs).
> This "first steps" patch shows you registering OCP as a bus
> with a name of "Onchip Peripheral Bus".  This seems to trivialize
> the bus hierarchy on 4xx and part of the point of driverfs is
> to see where devices are located in the physical bus structure
> (since management of them may vary based on their location).
> I would expect to see "PLB", "OPB", and "ExtBus" registered
> for 4xx for correctness.  They may all use the same bus ops
> in a reference board implementation (not making use of the EBC
> in most cases), but somebody could have some FPGA-based peripherals
> hanging from the EBC which require board-specific PM ops and thus
> it would be desirable to see and manage at least the External Bus
> separately in driverfs.

Agreed.  I see the use of a single "ocp" bus as a transitional step.
My first concern was toget something working - as a proof of concept,
and so that we can have working support for ocp devices with an
interface that is less broken that the current ocp code.

Using a single bus makes it easier to import the devices from the
existing core_ocp structure while we port the drivers to the driverfs
way of thinking.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
