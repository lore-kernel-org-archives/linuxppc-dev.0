Message-ID: <3B799791.2CEAFCC0@mvista.com>
Date: Tue, 14 Aug 2001 17:26:41 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Peter Desnoyers <pdesnoyers@chinook.com>
Cc: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>,
	Daris A Nevil <dnevil@snmc.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Non-cacheable memory
References: <Pine.LNX.4.33.0108091838380.11077-100000@localhost.localdomain> <3B72E40D.3080600@chinook.com> <3B74AADC.C2CE7B89@mvista.com> <3B77F684.415638E8@chinook.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Peter Desnoyers wrote:

> This seems like another case of either too little abstraction, or too
> much.  An embedded PPC system with PCI basically has two buses, with
> different DMA addressing, and there's no way to tell consistent_alloc(),
> etc. about that.

Well, if you are using PCI devices, you should be calling the pci_*
versions of these functions.  Those include a pci_dev structure, so
you can get the information you need to do this correctly, and seems
like the solution (more discussion later in the message).

> If you wouldn't mind, could you give me a pointer to the discussion of
> this phase-out?

I hear it from other folks on ppc-dev or something.  There are too many
lists for me to read and find this information first hand :-).


> I wonder if the proper thing to do is to enhance consistent_alloc to
> take an argument indicating the bus type?

Yep.  Like I said above, you should be using the pci_* versions of
these functions.  We can extract information from the pci_dev and pass
it along to consistent_alloc.  The local, internal peripherals can just
pass a NULL or zero or something, whatever this parameter is supposed to
mean.  Or, perhaps the pci_* functions fix up the information returned
from consistent_alloc.

> ....  There are more elegant ways
> of doing things, but this wouldn't involve changes to a lot of code.

This seems elegant enough to me :-).


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
