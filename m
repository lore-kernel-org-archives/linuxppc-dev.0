Message-ID: <38B49A0B.92CEC283@netx4.com>
Date: Wed, 23 Feb 2000 21:40:11 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Greg Johnson <gjohnson@research.canon.com.au>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC860 Embedded Planet IDMA Support
References: <20000224002220.90CE07C8@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greg Johnson wrote:


> Kernel 2.2.13 that we are using on the MPC860 does not have support
> for IDMA which we need.

I haven't and don't know of anyone that has.  Providing the
software is the easy part, just use existing CPM DPRAM allocation
functions for the BDs and either overload or create new BD
structures in commproc.h.

The harder part is the hardware interface.  The /DREQx and /RTSx
multiplex on the same pin, which prohibits cool protocols like
Ethernet on the SCC ports when using IDMA.

The IDMA isn't terribly efficient, so it either runs in "background"
mode or at a high priority.  If you are using the CPM for other
tasks, the IDMA may not move much data for you in background
mode, or will starve other communication tasks when run at
a higher priority.  Make sure you calculate CPM loading and
everything fits.

In the complete system architecture, it is more efficient to
program the UPM to control the device and use burst mode programmed
I/O cycles from the PPC core.  The IDMA cycles are long, even
with devices that can respond quickly, and you tie up the
System bus, U bus, internal RISC bus, effectively eliminating
any overlapped processing by any functional unit within the part.
At least with programmed I/O, the CPM can still do its
communication thing.

Also, since no one uses IDMA (there may be a lesson here :-) the
CPM microcode patches remap parameter spaces into the IDMA
locations.  Sometimes this is selectable, and you may have to
chase down places where this is done and customize to suit
your application.

It may work for you.  Just make sure you consider all of the
alternatives.


	-- Dan

P.S.  Have you signed up with Embedded Planet and received their
expansion guidelines?  Lots of technical tidbits there that can
make your life more enjoyable.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
