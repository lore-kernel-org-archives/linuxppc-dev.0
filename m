From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15368.891.368917.13579@argo.ozlabs.ibm.com>
Date: Sat, 1 Dec 2001 09:08:59 +1100 (EST)
To: "Ralph Blach" <rcblach@us.ibm.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: include/asm-ppc/platforms/
In-Reply-To: <OF04BCE99E.8AF57CF2-ON85256B14.00425D94@raleigh.ibm.com >
References: <OF04BCE99E.8AF57CF2-ON85256B14.00425D94@raleigh.ibm.com >
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ralph Blach writes:

> This does not take into account the embedded world at all.
> The correct form of the file should be asm-ppc/core/chip/revsion/board
>
> This is because the IBM Core Connect and the Motorola OCEAN internal
> interconnect systems.
>
> These allow for a 405/book E/Mot processor cores to be customized around a
> large set of
> customized on chip perphials.  It will make the availabily of a large
> number different
> customized chips with different on chip perphials available.
>
> Thats my justification for core/chip

How is the kernel supposed to know what on-chip peripherals exist?
By the CPU version/revision numbers?  Are you *always* going to change
the cpu revision number when you change the set of on-chip
peripherals?  Or will the kernel have to "just know" what on-chip
peripherals there are?

The scenario you outline leads me to think that we should flatten the
structure, rather than making a very deep hierarchical structure as
you suggest.  What I mean is that we should structure things so that
we have a collection of device drivers for various on-chip devices, a
collection of PCI host bridge drivers, a collection of interrupt
controller drivers, etc.  And these drivers should not make any
assumptions about addresses etc.

Then for each platform we have a device tree, or some similar kind of
database, that tells us what devices are where and how they are
connected.  We could consider using such a database at config time as
well as at run-time.  The database could be supplied statically by the
board support package or it could be supplied at runtime by the boot
loader.

Basically I want the knowledge that "because this is a 405gp chip we
must have an XYZ ethernet controller at address FOO using interrupt
N" to be concentrated in one place, not spread out through the
code.  Then when IBM brings out a 405gp-A that has two XYZ's (neither
of which are at the same address as in the 405gp) there is just one
place that we have to change.

> This is my justification for Revision, because different Chip Revision will
> Have differnet Expansion
> instruction sets.  The following statements have HUGE implecation on
> Libraries, because the loader will have to load correct library
> according to Chip Revision.

It's more a problem for the distributions - they will need to make
sure the correct libraries get installed.  My guess is that most
libraries will end up not using the extra instructions.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
