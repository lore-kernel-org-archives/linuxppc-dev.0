Date: Sun, 4 Jan 2004 23:06:08 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040104220608.GA1667@iliana>
References: <20040101181145.GA27294@iliana> <1073016223.1502.179.camel@gaston> <20040102074049.GA2032@iliana> <1073029796.1501.228.camel@gaston> <20040104210335.GA858@iliana> <1073252724.780.5.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1073252724.780.5.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 05, 2004 at 08:45:24AM +1100, Benjamin Herrenschmidt wrote:
>
>
> > PCI: Probing PCI hardware
> > Scanning bus 00
> > Found 00:00 [11ab/6460] 000600 00
> > Found 00:08 [1106/3044] 000c00 00
> > Found 00:28 [1000/0001] 000100 00
> > Found 00:60 [1106/8231] 000601 00
> > Found 00:61 [1106/0571] 000101 00
> > Found 00:62 [1106/3038] 000c03 00
> > Found 00:63 [1106/3038] 000c03 00
> > Found 00:64 [1106/8235] 000000 00
> > Found 00:65 [1106/3058] 000401 00
> > Found 00:66 [1106/3068] 000780 00
> > Found 00:68 [1106/3065] 000200 00
> > Fixups for bus 00
> > Bus scan for 00 returning with max=00
> > Scanning bus 10
> > Fixups for bus 10
> > Bus scan for 10 returning with max=10
> > PCI: Cannot allocate resource region 4 of device 00:00.0
> >
> > So, the 0x10 incrementation is fine, but the agp bus is not working
> > correctly, and thus the agp graphic card not recognized (and thus no
> > radeonfb).
> >
> > That said, i believe the 00:00.0 (should that not be 10:00.0 because of
> > the renumbering) is the Marvell Discovery II pci controller, and the
> > actual agp card should be found just behind.
>
> What video card is this ?

A Radeon 9200 SE 64M, from Xpert Vision. The kernel is patched for
Radeon 9200 SE support. (Both i have are Yd models).

> It's possible that your config ops for the AGP don't work properly. Make
> sure you are really generating type 0 config cycles.

Ok, i will check again, altough no more tonight.

> Also, this "cannot allocate resource region" smells bad. Can
> you check what the BARs of the host bridge are supposed to mean ?

Ok, will do.

> I hope it's not yet another brain dead bridge that puts the system memory
> in a BAR... in which case we'll have to "hide" it from linux PCI subsystem.

Mmm, seems  Rob Baxter from Synergy Microsystems are already running
linux on systems with the Discovery II north bridge, so i don't think
this is it. I will check this tomorrow though.

Thanks again for your help,

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
