From: benh@kernel.crashing.org
To: <mlan@cpu.lu>
Cc: <dan_bethe@yahoo.com>, <nicoya@apia.dhs.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: 9600 maturity?
Date: Tue, 16 Apr 2002 01:54:25 +0100
Message-Id: <20020416005425.14127@mailhost.mipsys.com>
In-Reply-To: <E16xLzp-00008q-00@piglet.grunz.lu>
References: <E16xLzp-00008q-00@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>But is there something in place now in the PCI code to handle the IO
>space of multiple host bridges now? When I was working on the chaos PCI
>code, you had plans to implement that part...
>
>IIRC, you wanted to move both IO spaces into a continous segment and
>provide some way to find the ber-bus base of IO space...

it is implemented in 2.4, but a bit differently. Each host has it's own
IO space ioremapped separately. One is picked up as the "primary" IO space
and gets all 0-based IOs (basically it's where _IO_BASE points to).
Then, IO resources of PCI devies on other busses are fixed up by the
kernel to be offseted by (io_bus_virt - _IO_BASE) (that is the virtual
address of the IO space of this bus minus the virtual address of IO space
of the primary bus), thus allowing inx/outx functions to work.

That means though that there isn't a convenient way to access fixed
(ie. legacy) IO locations on other busses, except by using platform
specific routines to find out the real bus virtual IO base. But at
least, IO resources provided by BARs will work on other busses provided
that the driver uses the pci_dev->resource fields properly.

However, I haven't yet verified if it works properly for busses like
bandit that don's issue a 0-based (bus view) IO range, but an "offseted"
one like it is, I think, the case for second bandit. On UniNorth, each
host has a 0 based 0...16Mb IO space.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
