Subject: Re: multiple separate pci bridges ...
From: Marcus Barrow <mbarrow@sangate.com>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20040105164038.GA16158@iliana>
References: <20040101181145.GA27294@iliana>
	<1073016223.1502.179.camel@gaston> <20040102074049.GA2032@iliana>
	<1073029796.1501.228.camel@gaston> <20040104210335.GA858@iliana>
	<1073252724.780.5.camel@gaston> <20040104220608.GA1667@iliana>
	<20040105164038.GA16158@iliana>
Content-Type: text/plain
Date: 05 Jan 2004 16:38:50 -0500
Message-Id: <1073338730.9456.2487.camel@boat.sangate.com>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi Sven:

	I think there is some basic brokeness in the Discovery
	specific code. I've been meaning to go and look at some
	of the original code, to see if some stuff was left on
	the floor.

	On our evalution boards the P2P registers are not set
	up. So you indeed have two PCI bus 0. The P2P register
	for PCI bus 1 should be initialized to identify it as
	bus 1, or whatever the right value is considering
	any more bridges found on bus 0.

	If you insert pci cards which contain bridges on them,
	they only work on the bus 0 slots...

	Do you have something like ppcboot or uboot starting
	your system or just a kernel? If you are using a real
	boot rom, you could try initializing the p2p registers
	by hand, then booting...

	I'm hoping to work on this in the next few days.

				Regards, Marcus Barrow




On Mon, 2004-01-05 at 11:40, Sven Luther wrote:
>
> On Sun, Jan 04, 2004 at 11:06:08PM +0100, Sven Luther wrote:
> >
> > On Mon, Jan 05, 2004 at 08:45:24AM +1100, Benjamin Herrenschmidt wrote:
> > >
> > >
> > > > PCI: Probing PCI hardware
> > > > Scanning bus 00
> > > > Found 00:00 [11ab/6460] 000600 00
> > > > Found 00:08 [1106/3044] 000c00 00
> > > > Found 00:28 [1000/0001] 000100 00
> > > > Found 00:60 [1106/8231] 000601 00
> > > > Found 00:61 [1106/0571] 000101 00
> > > > Found 00:62 [1106/3038] 000c03 00
> > > > Found 00:63 [1106/3038] 000c03 00
> > > > Found 00:64 [1106/8235] 000000 00
> > > > Found 00:65 [1106/3058] 000401 00
> > > > Found 00:66 [1106/3068] 000780 00
> > > > Found 00:68 [1106/3065] 000200 00
> > > > Fixups for bus 00
> > > > Bus scan for 00 returning with max=00
> > > > Scanning bus 10
> > > > Fixups for bus 10
> > > > Bus scan for 10 returning with max=10
> > > > PCI: Cannot allocate resource region 4 of device 00:00.0
> > > >
> > > > So, the 0x10 incrementation is fine, but the agp bus is not working
> > > > correctly, and thus the agp graphic card not recognized (and thus no
> > > > radeonfb).
> > > >
> > > > That said, i believe the 00:00.0 (should that not be 10:00.0 because of
> > > > the renumbering) is the Marvell Discovery II pci controller, and the
> > > > actual agp card should be found just behind.
> > >
> > > What video card is this ?
> >
> > A Radeon 9200 SE 64M, from Xpert Vision. The kernel is patched for
> > Radeon 9200 SE support. (Both i have are Yd models).
>
> Ok, i got it to work finally, at least upto asking me for a root
> filesystem, which i don't yet have on this harddisk.
>
> Now, I have some technical questions about how to best do a few things.
>
> I was recommended to set the ppc_md.pci_exclude_device so that the
> device 0 (the marvell bridge itself) is not seen by linux. I did this by
> following the 4xx example, which should be ok.
>
> But, i have to do access some address which i need to ioremap. I created
> a hose->cfg_peg2_magic to to put this ioremapped address in. I guess
> this is not the most clean way of doing this or something, any hint on
> how to best do it ? I need to set this in chrp_find_bridges or something
> such, and use the address in the read/write_config functions.
>
> Also, i had to manually set hose->bus_offset = 0x10, since that didn't
> seem to be set automatically. I don't know why though.
>
> And finally, about the stuff which blocked me most, i am somewhat
> bewildered. I use this :
>
>         data = 0x80000000 | ((dev->bus->number - hose->bus_offset) << 16)
> 		| (dev->devfn << 8) | (offset & 0xff);
>
> As the address to write to, but the indirect pci stuff uses offset &
> 0xfc, which blanks bits 0 & 1 for pci config type selection. What am i
> misunderstanding or doing wrong here ?
>
> A, and a last question to Rob Baxter, did you manage to get the builtin
> gigabyte ethernet port to work, and if yes, with which code, an
> existing driver or some home built driver. Can you eventually share the
> code or something such ?
>
> Anyway, thanks for your help.
>
> Friendly,
>
> Sven Luther
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
