Message-ID: <3AEE21DF.6C289B1C@mvista.com>
Date: Mon, 30 Apr 2001 22:39:27 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Denton Gentry <denny@dominetsystems.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405gp PCI?
References: <3AEE0E5C.955341B3@dominetsystems.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Denton Gentry wrote:

> ....I'm using a kernel compiled from the fsmlabs source
> as of last Tuesday (I have not pulled over new code since the
> boot reorganization was done, I want to get this working first).

Hmmm...I know it works with PCI slave devices, but I don't know
if it will for masters.  I know the Linux support functions for
virt_to_bus and friends will provide the proper addresses.  Sounds
like there is some missing 405 register initialization.  Are you
doing this on a custom board, or in the Walnut eval board?  I
suspect on the Walnut we rely on the boot rom for some of this
405 PCI initialization.

>   Also, though I'm certain that this problem is not caused by
> stale data, one of the next things I'll need to tackle is cache
> coherency.

I have just recently finished the pci_consistent_* functions and
software cache mangement functions so they will do the right thing
on the IBM4xx and MPC8xx processors.  Assuming the driver has these
functions in place, they are either no-ops on a cache coherent
processor or provide the proper function on a non-coherent
processor.  The eepro-100 driver used to work with some hacks, and
I'm going to ensure it works without them :-).  It's in the update
patch back to FSM Labs, so it should be there soon.  We are also
adding the PCI auto-probe so we don't rely on the boot rom for
any of the PCI initialization.

The on-board 405 Ethernet driver is an example of how to use the
consistent_* functions for memory management and the cache management
functions.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
