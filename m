Subject: Re: multiple separate pci bridges ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rob Baxter <robb@synergymicro.com>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040106153305.GA6251@synergy>
References: <20040104220608.GA1667@iliana> <20040105164038.GA16158@iliana>
	 <1073338095.9497.70.camel@gaston> <20040105214239.GA20252@iliana>
	 <1073340725.9497.105.camel@gaston> <20040106073955.GF735@iliana>
	 <1073376024.26508.220.camel@gaston> <20040106081143.GA1644@iliana>
	 <Pine.GSO.4.58.0401061533510.5752@waterleaf.sonytel.be>
	 <20040106144545.GA7261@iliana>  <20040106153305.GA6251@synergy>
Content-Type: text/plain
Message-Id: <1073425055.784.3.camel@gaston>
Mime-Version: 1.0
Date: Wed, 07 Jan 2004 08:37:36 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Here's the code from our pcibios_fixup:
>
> 	dev = NULL;
> 	while ((dev = pci_find_device(PCI_VENDOR_ID_GALILEO,
> 				PCI_DEVICE_ID_GALILEO_GT64260, dev))) {
> 		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> 			dev->resource[i].flags = 0;
> 			dev->resource[i].start = 0;
> 			dev->resource[i].end = 0;
> 		}
> 	}

pcibios_fixup isn't the right place to do that ;) You should do this
from a pci quirk imho.

note that there's still a problem with XFree which will "see"  those
BARs and, according to the log posted by Sven, shoke. Sven, can you
try "hiding" the host bridge completely from the config ops and see
if that helps with XFree ? That's not a very good solution though,
we'll have to do something different about it. Now if only XFree
stopped mucking with the PCI bus...

> > BTW, is there any reason the L2 cache is disabled by default in the
> > 2.4.x kernels ?
>
> We have it initialized and enabled.

The kernel doesn't do anything to the L2 cache, it all depends what
you firmware does to it.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
