Subject: Re: multiple separate pci bridges ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Rob Baxter <robb@synergymicro.com>
In-Reply-To: <20040105164038.GA16158@iliana>
References: <20040101181145.GA27294@iliana>
	 <1073016223.1502.179.camel@gaston> <20040102074049.GA2032@iliana>
	 <1073029796.1501.228.camel@gaston> <20040104210335.GA858@iliana>
	 <1073252724.780.5.camel@gaston> <20040104220608.GA1667@iliana>
	 <20040105164038.GA16158@iliana>
Content-Type: text/plain
Message-Id: <1073338095.9497.70.camel@gaston>
Mime-Version: 1.0
Date: Tue, 06 Jan 2004 08:28:15 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Ok, i got it to work finally, at least upto asking me for a root
> filesystem, which i don't yet have on this harddisk.
>
> Now, I have some technical questions about how to best do a few things.
>
> I was recommended to set the ppc_md.pci_exclude_device so that the
> device 0 (the marvell bridge itself) is not seen by linux. I did this by
> following the 4xx example, which should be ok.

Actually, just hiding the BARs with a quirk should be enough (what
I do for the CPC710)...

> But, i have to do access some address which i need to ioremap. I created
> a hose->cfg_peg2_magic to to put this ioremapped address in. I guess
> this is not the most clean way of doing this or something, any hint on
> how to best do it ? I need to set this in chrp_find_bridges or something
> such, and use the address in the read/write_config functions.

What for ? you can eventually ioremap some lower address in
host->cfg_addr or cfg_data and then use offsets from these addresses,
though it's not recommended to ioremap too large spaces. You can also
just ioremap that in a global once... I do that for a few things in
pmac_feature.c, like the northbridge registers.

> Also, i had to manually set hose->bus_offset = 0x10, since that didn't
> seem to be set automatically. I don't know why though.

Why do you need hose->bus_offset ? For indirect_pci ? Well... that's
a kludge, you should rather fix indirect_pci to use first_busno
instead... I don't know where this bus_offset comes from in the first
place, it's defined in pci_controller but not used at all in 2.6...

(BTW. You should really work on 2.6, not 2.4...)

> And finally, about the stuff which blocked me most, i am somewhat
> bewildered. I use this :
>
>         data = 0x80000000 | ((dev->bus->number - hose->bus_offset) << 16)
> 		| (dev->devfn << 8) | (offset & 0xff);
>
> As the address to write to, but the indirect pci stuff uses offset &
> 0xfc, which blanks bits 0 & 1 for pci config type selection. What am i
> misunderstanding or doing wrong here ?

Normally, you write the offset 32 bits aligned, and then you add those
2 missing bits to the cycle used to actually read the config space
(access to the data register).

But then... read your bridge spec.

> A, and a last question to Rob Baxter, did you manage to get the builtin
> gigabyte ethernet port to work, and if yes, with which code, an

gigabit you mean ? :) gigabyte would be nice though...

> existing driver or some home built driver. Can you eventually share the
> code or something such ?

What cell is it ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
