Subject: Re: multiple separate pci bridges ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040118144412.GA6897@iliana>
References: <20040118144412.GA6897@iliana>
Content-Type: text/plain
Message-Id: <1074503490.4547.52.camel@gaston>
Mime-Version: 1.0
Date: Mon, 19 Jan 2004 20:11:31 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> .../...

The code you posted is awfully ugly...

I'll look at it in detail later.

> I am returning 0 for all of function 0. I dropped the whole struct
> pci_dev ressource thingy, and they are well nullified. My limited
> understanding of those pci issues let me make a guess though. I think
> that either the stuff in the struct pci_dev is set later on (the BARs
> are modifiable i think), or those values are read from the struct
> pci_dev before i nullify them.

pci_dev resources are read from the BARs and the sizing mecanism
uses the BARs too (you should filter out writes too btw). If you
properly filter things out, there should be no problem.

> > > Finally, X works, altough DRI freezes after a second or two with my
> > > radeon 9200SE, while it works for a Radeon 7500, but this is probably a
> > > DRI issue.
> >
> > Which version of DRI ? Do you have the interrupt routing working
> > properly ?
>
> Mmm, maybe i should also allow to read (and write ?) the config 32-bit
> word at 0x3c, those include the Interrupt Line and Pin, as well as the
> Max_lat and Min_Gnt.

Interrupt pin is mostly useless. You may want to fill interrupt line
of the PCI cards with the value assigned by OF (or in any case, at
least make sure pci_dev->irq is properly filled).

> Maybe some of the first 16 bytes would also need to be modifiable, and
> there should be no harm in allowing read of the subsytem id and vendor
> id ?

Of what ? the bridge ? You surely need to let the system access the AGP
portion of it btw...

> As for the DRI version, i use the drm module from the linuxppc-2.4 tree,
> using the v2.4.24 TAG to checkout, and the rest of the XFree86 stuff,
> including the mesa libraries, from the 4.3.0-0pre1v5 experimental
> package, rebuild with the Radeon 9200SE patch from Michel Daenzer.

Use the DRM module from Michel snapshot, might help...

> The freeze happens when i first launch glxinfo, or when i first start
> moving a window around (using a debian/unstable default gnome desktop).
> I don't remember well, but i think it would also freeze when let running
> for a time, but i am not sure. The box is still available trough ssh,
> but killing the X server doesn't restore the fbdev console, and freeze
> the box.

Could be irq not working...

> > > What makes me wonder, is that X needs around 20 seconds to launch, which
> > > could not be something normal. It usually takes 5-8 seconds only.
> > > Something strange is going on.
> >
> > Yah, XFree log could be useful.
>
> Ok, i uploaded it at http://people.debian.org/~luther/XFree86.0.log,
> since the list was not able to cope with it. I didn't see anything anormal
> there though. Altough some of the bus ressources seem to be checked even
> if i nullified them.
>
> Friendly,
>
> Sven Luther
--
Benjamin Herrenschmidt <benh@kernel.crashing.org>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
