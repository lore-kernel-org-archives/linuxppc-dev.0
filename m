Date: Mon, 19 Jan 2004 13:03:47 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040119120347.GC18112@iliana>
References: <20040118144412.GA6897@iliana> <1074503490.4547.52.camel@gaston> <Pine.GSO.4.58.0401191108100.6038@waterleaf.sonytel.be> <1074512479.12326.18.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1074512479.12326.18.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 19, 2004 at 10:41:19PM +1100, Benjamin Herrenschmidt wrote:
>
> On Mon, 2004-01-19 at 21:08, Geert Uytterhoeven wrote:
> > On Mon, 19 Jan 2004, Benjamin Herrenschmidt wrote:
> > > > I am returning 0 for all of function 0. I dropped the whole struct
> > > > pci_dev ressource thingy, and they are well nullified. My limited
> > > > understanding of those pci issues let me make a guess though. I think
> > > > that either the stuff in the struct pci_dev is set later on (the BARs
> > > > are modifiable i think), or those values are read from the struct
> > > > pci_dev before i nullify them.
> > >
> > > pci_dev resources are read from the BARs and the sizing mecanism
> > > uses the BARs too (you should filter out writes too btw). If you
> > > properly filter things out, there should be no problem.
> >
> > So shouldn't reads from the BAR return -1 instead of 0, and writes be ignored?
>
> Writes have to be ignored, I don't remember if an unused BAR should
> return 0xffffffff or 0 (check the spec). (The call shall not fail,
> the BAR space has to be implemented).

Mmm, should it also be needed to put 0 in the Memory Space and IO space
bits of the Command register ?

Also, about the Interrupt line, i believe that there is no interrupt
used by the northbridge at this time. We were not speaking about the pci
config space of the graphic card, but of the bridge, so it should have
no influence with DRI or anything else, right ?

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
