Date: Fri, 2 Feb 2001 10:14:23 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>,
        Paul Mackerras <paulus@linuxcare.com>
Subject: Re: SOLVED: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
Message-ID: <20010202101423.A26025@allspice.cs.swarthmore.edu>
References: <20010202023834.A17159@allspice.cs.swarthmore.edu> <Pine.LNX.4.30.0102021043380.15482-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.30.0102021043380.15482-100000@opal.biophys.uni-duesseldorf.de>; from schmitz@mail.biophys.uni-duesseldorf.de on Fri, Feb 02, 2001 at 01:58:44PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Feb 02, 2001 at 01:58:44PM +0100, Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de> wrote:
> > There are still some issues outstanding:
> > 1)	The same table is duplicated in five or six drivers.  I think it
> > would make lots of sense to have a macro for the case statment in just
> > one place.  Should it go in scsi.h?  Or its own new file?
>
> scsi.h is used by all drivers, and describes mostly midlevel stuff. Your
> command table is only needed by some lowlevel drivers so it should go into
> some separate header included only by those drivers.

Sounds reasonable.

> Only MHO, ask a Linux SCSI guru.

I just subscribed to linux-scsi, so I will.

> Better yet, find another way to determine which commands send data from
> the command bytes directly (what do all those drivers that don't use the
> table use instead?)

I'll ask this too.

> > 3)	It continues to be worrisome that the mesh driver doesn't handle
> > aborts right or retry lost arbitration (nor does mac53c94.)  Is there
> > anywhere that the way to do these things is documented?  I'm willing to
> > try my hand at fixing them.
>
> The SCSI specs are probably the authoritative guide here. Plus the MESH
> and 53C94 data sheets.

These would be useful things to have, but it sounds from the comments at
the top of mesh.c and mac53c94 that the interface for this with the rest
of the kernel changed somewhere in the 2.1 series.  So I'm hoping that
the drivers already support the hardware properly, and I mostly want to
know if anyone knows where it's documented how to interact with the
kernel.  I'll ask this on linux-scsi too.  Meanwhile, a patch is coming
up.

-Daniel

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
