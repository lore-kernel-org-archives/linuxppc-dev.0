Subject: Re: Oops when inserting PCMCIA flash card (IDE)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: mlan@cpu.lu
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <E18nL1U-0007Ag-00@piglet.grunz.lu>
References: <E18nL1U-0007Ag-00@piglet.grunz.lu>
Content-Type: text/plain
Message-Id: <1046108448.12533.204.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 24 Feb 2003 18:40:48 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2003-02-24 at 17:00, Michel Lanners wrote:

> The NIP in the oops points to ide_mm_inb(); it's trying to read from the
> IDE ports. However, the port the new IDE interface got assinged seems to
> be 0x100 (see r3: 0x107, which is port_base + IDE_STATUS_OFFSET). This
> is of course outside of the range the PCMCIA controller has:
>
> pooh:/etc/ppp# cat /proc/ioports
> 00000000-007fffff : /pci@f2000000
>   00001000-00008fff : PCI CardBus #11
>   00009000-000090ff : PCI CardBus #11
> 00802000-01001fff : /pci@f0000000
>   00802400-008024ff : ATI Technologies Inc Rage Mobility M3 AGP 2x
> ff7fe000-ffffdfff : /pci@f4000000
>
> So the problem seems to be the PCMCIA code gets the wrong ports for the
> PCMCIA card?

No, the ranges above are for cardbus, not pcmcia. pcmcia usually
assign resources outside of this range, and 0x100 looks like a
correct port. I'm not sure what is wrong, I'd say ide_mm_inb is
the wrong set of iops, it should be ide_inb instead (it's IO
port access, not MMIO), now we have to figure out why ide_mm_inb
got a assigned, I suspect ide_cs actually tried to re-use an IDE
slot that was initialized for ide-pmac (which is mmio).

There are various breakage with IDE in pre4, which is why I don't
quite suggest using my bk tree for now, I'm waiting for Alan &
Marcelo to sync all of Alan recent fixes before I really look into
debugging these.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
