Message-ID: <39D423DB.E94D625E@mvista.com>
Date: Fri, 29 Sep 2000 01:08:43 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
References: <Pine.LNX.4.10.10009281150130.3468-100000@cassiopeia.home> <19340823125112.7591@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> That mean that you intend to feed a physical address to ioportremap and
> not an IO address ? Hrm... that mean we need to have the physical address
> in the device IO resources instead of the content of the IO BAR.

Don't confuse the contents of pci_dev->resource[].start with the value
of a BAR you get using a PCI configuration cycle.  These are not likely
to be the same.  The platform dependent PCI "fixup" functions are going
to munge the pci_dev->resource[].start with knowledge of bridge mapping
and potentially processor mapping.  I don't understand why we don't just
finish the job of adding _IO_BASE to this and be done with it, then we
don't require different in/out macros for the different platforms
(except
x86).

> The more I think about it, the more I want to separate legacy IO macros
> and PCI IO macros :)

This is just an example that illustrates we need to know more about
the resource utilization and mapping of devices within the software
that uses these devices.  Using separate macros is just implicitly
providing information we should have passed as a more flexible
parameter,
which is the bus mapping knowledge.

> AFAIK, this scheme should be able to handle pretty much all kind of PCI/
> ISA busses out there, including multiple hosts with PCI mem at different
> locations, etc...

Just keep in mind that the address mapping of the processor to the
bus is the easy part.  There are also interrupt routing and other
attributes
that have to be considered (prefetch, pipelines, etc.).  To further
complicate the issue, high performance embedded systems will also
employ inter-device DMA, so you need to be able to understand the views
of the bus from their perspective so a driver can instruct devices
to perform these functions.

	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
