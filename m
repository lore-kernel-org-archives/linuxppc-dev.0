Date: Sun, 18 Jan 2004 23:33:19 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040118223319.GA11956@iliana>
References: <20040118144412.GA6897@iliana> <1074503490.4547.52.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1074503490.4547.52.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 19, 2004 at 08:11:31PM +1100, Benjamin Herrenschmidt wrote:
>
> > .../...
>
> The code you posted is awfully ugly...

Comes from multiple testing and such, once it find the final one, i will
do some cleanup or something. That said, it is not all that more ugly as
the stuff in indirect_pci.c i used as example.

> I'll look at it in detail later.
>
> > I am returning 0 for all of function 0. I dropped the whole struct
> > pci_dev ressource thingy, and they are well nullified. My limited
> > understanding of those pci issues let me make a guess though. I think
> > that either the stuff in the struct pci_dev is set later on (the BARs
> > are modifiable i think), or those values are read from the struct
> > pci_dev before i nullify them.
>
> pci_dev resources are read from the BARs and the sizing mecanism
> uses the BARs too (you should filter out writes too btw). If you
> properly filter things out, there should be no problem.

The BARs are the ones at address 0x10 to 0x27 of the pci config space,
right ? Only 0 is read back when looking at them.

> > > > Finally, X works, altough DRI freezes after a second or two with my
> > > > radeon 9200SE, while it works for a Radeon 7500, but this is probably a
> > > > DRI issue.
> > >
> > > Which version of DRI ? Do you have the interrupt routing working
> > > properly ?
> >
> > Mmm, maybe i should also allow to read (and write ?) the config 32-bit
> > word at 0x3c, those include the Interrupt Line and Pin, as well as the
> > Max_lat and Min_Gnt.
>
> Interrupt pin is mostly useless. You may want to fill interrupt line
> of the PCI cards with the value assigned by OF (or in any case, at
> least make sure pci_dev->irq is properly filled).

Ok.

> > Maybe some of the first 16 bytes would also need to be modifiable, and
> > there should be no harm in allowing read of the subsytem id and vendor
> > id ?
>
> Of what ? the bridge ? You surely need to let the system access the AGP
> portion of it btw...

There is no AGP portion of it, it is a plain pci bus with some config
space reading magic i don't know the details, and a AGP (3.3V)
connector.

> > As for the DRI version, i use the drm module from the linuxppc-2.4 tree,
> > using the v2.4.24 TAG to checkout, and the rest of the XFree86 stuff,
> > including the mesa libraries, from the 4.3.0-0pre1v5 experimental
> > package, rebuild with the Radeon 9200SE patch from Michel Daenzer.
>
> Use the DRM module from Michel snapshot, might help...

Will try tomorrow. But then, it seems that the default for debian will
be to use the kernel included DRM.

> > The freeze happens when i first launch glxinfo, or when i first start
> > moving a window around (using a debian/unstable default gnome desktop).
> > I don't remember well, but i think it would also freeze when let running
> > for a time, but i am not sure. The box is still available trough ssh,
> > but killing the X server doesn't restore the fbdev console, and freeze
> > the box.
>
> Could be irq not working...

Which would make sense with the above remarq of the interrupt line.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
