Message-ID: <3AB65FCD.44826199@mvista.com>
Date: Mon, 19 Mar 2001 14:36:45 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Ralph Blach <rcblach@raleigh.ibm.com>
Cc: Ralph Blach <rblach@intrex.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: es1371.o sound module on a IBM 405 walnut platform
References: <3AB4E3BA.AF71AFE6@intrex.net> <3AB52248.D2411FF2@mvista.com> <3AB65B72.F77A0760@raleigh.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ralph Blach wrote:

> Well it does.  And I recomend a new kernel interface, and Dan, I KNOW
> YOU WILL not like THE VERY IDEA,
> by here it is.

You are right, I won't :-).  Here is why.  First of all, all Linux
ports understand how to manage the little-endian PCI interface.  We
don't want help from hardware swapping bytes in the lanes because it
just complicates software with special case functions and actually
introduces more overhead instead of removing it like the design you
thought would work.  Second, I have worked with hardware like this
in the past, and have painfully learned you simply can't arbitrarily
swap the bytes in the lanes.  If you have data structures you are
trying to share, the data has to be swapped based upon the size of
the object.  The hardware has no clue what you are trying to access
and will screw it up.  Just believe me, I've been there.

> copy_from_user and copy_to_use would then do the bit to little endian
> conversions.

Nope, the sound drivers already know how to do this if necessary.

> By the same token, an interface to allocate noncached memory would be
> spiffy.

That's already been done for the 8xx and 4xx ports in the kernel
trees.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
