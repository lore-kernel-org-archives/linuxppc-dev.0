Subject: Re: multiple separate pci bridges ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040102074049.GA2032@iliana>
References: <20040101181145.GA27294@iliana>
	 <1073016223.1502.179.camel@gaston>  <20040102074049.GA2032@iliana>
Content-Type: text/plain
Message-Id: <1073029796.1501.228.camel@gaston>
Mime-Version: 1.0
Date: Fri, 02 Jan 2004 18:49:56 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> There is some extra magic that needs to be done. In particular
> interrupts need to be disabled before being able to write to the config
> space of the agp bridge.

That can be completely local to the config ops. of that pci_controller
instance.

> > What do you mean ? config ops ? You can have different ops per host,
> > again, look at what pmac_pci.c does
>
> Yep, that i did already. And that is what i did, i used the indirect pci
> ops for the first bus, but specialized stuff for the second bus, due to
> the above mentioned stuff.

Good.

> Mmm, since these are two CPU<->PCI bridges, i don't care about that,
> right. PCI<->PCI bridges are ones which stand behind a PCI<->PCI bridge,
> right ?

No, no, ... PCI<->PCI bridges can happen still... some PCI cards can
have one on-board for example.

> > You trigger the proper renumbering code by setting pci_assign_all_busses
> > to 1.
>
> Ok. This must have been the magic bit i was searching for.

Probably :)

> > So basically, what we do is, we keep a "next_busno" variable which is
> > 0 at first. When probing a host, we assign it that bus number (0 for
> > the first host typically). Then, we call pci_scan_bus(). This one will
> > do the renumbering for P2P bridges when pci_assign_all_busses is true.
> > It will also tell us what was the "last" bus number found on the host.
> > We use that+1 to get the new next_busno and start again for the next
> > host.
>
> Ok. Need to look again though to find the place where the arch specific
> place is to modify this. As i remember, pci_scan_bus is called from
> drivers/pci/pci.c, and i shouldn't need to modify this.

No, look what I do when setting up uninorth in pmac_pci.c

> > On your side, you don't have much else to do that set
> > pci_assign_all_busses to 1, and create 2 pci_controller structures with
> > different config cycle ops.
>
> Yep. I guess the pci_assign_all_busses can be set in chrp_find_bridges,
> in the pegasos2 special case. The rest i have already handled.

Yes.

> > Note that in 2.4, there is a small risk when doing bus renumbering with
> > PCI-PCI bridges that you can get temporarily overlapping bus numbers
> > during the probe, thus screwing it up. this typically happens on
>
> Not a problem in this case though, right ? There is only one bus for
> each controller, and the controller are sitting directly after the CPU.

And ? You can still have P2P bridges sitting on one of your PCI busses.

> > Xserves. The problem is when scanning a given segment with P2P bridges,
> > when old & new numbers overlap, a not-yet scanned bridge may be set to
> > the same number as one we are currently scanning after having renumbered
>
> Ok, do we need to detect this, or will it just fail or something ?

It will do random crap on PCI probe

> > it, thus screwing things up. I think 2.6 is protected against this
> > problem. For 2.4, what I do is hack to force a 0x10 bus number offset
> > between hosts.
>
> Mmm. Will look into that.
>
> Anyway, i will not be able to implement it until sunday at the earliest.
>
> Friendly,
>
> Sven Luther
--
Benjamin Herrenschmidt <benh@kernel.crashing.org>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
