Date: Tue, 8 Feb 2000 18:09:30 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Retrace
In-Reply-To: <Pine.LNX.4.05.10002081749540.27293-100000@callisto.of.borg>
Message-ID: <Pine.HPX.4.10.10002081756400.1866-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 8 Feb 2000, Geert Uytterhoeven wrote:

> The BAR values in PCI config space may be the same, but the BAR values in
> struct pci_dev can be made different by the machine-specific fixup code.

Yes, but it becomes a mess when you try to call alloc_resource if you need
to: you would like to directly write the values returned by
alloc_resource innto the registers for hotplugging and whatnots (I know a
device, namely the Universe PCI<->VME bridge which has additional BAR not
in the standard PCI header for very good reasons:

- there are 9 such regions (and 2 in the standard header space), 11
regions are somewhat hard to shoehorn in 6 BARs...

- 8 of these 9 regions have a variable (actually programmable) size which
is not even necessarily a power of 2.

so I would have to know the offset in the host bridge if
pci_alloc_resource returned values as seen from the processors. I prefer
the solution I've suggested in another post (fill the resource with hte
return value, write it into the register and then access it with
ioremap(ioremap_ptr(resource)) or better define a function called
ioremap_resource(resource) which hides all these ugly details and walks
the resource tree to do its job.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
