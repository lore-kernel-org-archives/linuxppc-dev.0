Message-ID: <3819D438.E40B0CFC@jlc.net>
Date: Fri, 29 Oct 1999 13:07:04 -0400
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>
CC: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel space question?
References: <199910291305.JAA24820@hoover.gilbarco.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Wohlgemuth, Jason wrote:


> Just a quick question... When I was working to get Linux running on a custom
> MPC860, it was necessary to move the IMMR to 0xF???????

This is the way it works on the 8xx, and is somewhat board specific......

A portion of the kernel virtual space is mapped 1:1 virtual to physical
early in the boot phase.  Physical addresses in this space must reside
in the same kernel virtual space, and further in a place that doesn't
conflict with other kernel virtual addresses.

The user application virtual space consumes the first 2 Gbytes (0 to
0x80000000).  The kernel virtual text starts at 0xc0000000, with
data following.  There is a "protection hole" between the end of kernel
data and the start of the kernel dynamically allocated space, but
this space is still within 0xcxxxxxxx.

Obviously the kernel can't map any physical addresses 1:1 in these
ranges.

Most of the 8xx boards clustered (some more than others :-) the
physical resources of the boards, like boot rom, extra flash rom,
nvram and the IMMR into the top physical address space.  It was both
easy (because of the 8xx 8Mbyte "page" option) to map all of this
above 0xfxxxxxxx.  It was also efficient because you could get all of
this space with minimal page tables.

Once the kernel maps the minimum required address space (at least
the IMMR) early in the boot phase, the remainder of the mappings
come from the dynamically allocated space.

Because of the flexibility of the 8xx memory controller and interface
units, my long term plan is to simply remove the variety of board
configurations and simply program all 8xx processors to have the
same address space.  During the early days, it was less confusing
to keep the typical board address space so when you grabbed the user
manuals the Linux map matched the documentation.  Times change....



	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
