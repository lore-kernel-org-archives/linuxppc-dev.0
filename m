Subject: Re: [PATCH] Fixup for DEC 21154 bridge to allow CardBus support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Roskin <proski@gnu.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.58.0405231954120.10093@portland.hansa.lan>
References: <Pine.LNX.4.58.0405231954120.10093@portland.hansa.lan>
Content-Type: text/plain
Message-Id: <1085363158.15315.11.camel@gaston>
Mime-Version: 1.0
Date: Mon, 24 May 2004 11:45:59 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2004-05-24 at 10:30, Pavel Roskin wrote:
> Hello!
>
> I'm using Blue&While G3.  I installed a CardBus bridge into a PCI slot.
> The bridge uses TI PCI1410 chip.  16-bit PCMCIA cards work fine, but
> CardBus cards don't work.  They are not shown by lspci.  I'm running
> Debian unstable with Linux 2.6.6-bk9.
>
> It turns out the PCI bridge (DEC 21154) only handles bus 1 and doesn't
> forward requests to higher buses.  The CardBus card is configured to act
> as a bridge from bus 1 to buses 2-5.  That's why requests to bus 2 don't
> go through.
>
> If I reconfigure the PCI bridge to handle buses 1-255, the CardBus cards
> start working.  The attached patch add a fixup for DEC 21154 bridge.
>
> If there are a better way to fix the problem with CardBus, I'm ready to
> test other patches.
>
> More information about the system (including kernel log) is available at
> http://www.red-bean.com/~proski/g3bw/
>
> As a side not, the kernel says that the Host bridge (Motorola MPC106
> Grackle) is configured to support buses 0 and 1.  Those values come from
> the "bus-range" property.  I believe this limitation is not enforced, or
> it would also hinder CardBus support.

It's a bit nasty right now... You may bump into other problems, the
main issue is OF not setting a proper bus range.

Anyway, you should make your patch machine specific to avoid screwing
up other possible busses... (hrm... not too sure in fact if the linux
common PCI code will properly fixup the last subordinate bus number,
you may also want to only give a range of 5 or 10 bus numbers in case
somebody plugs another PCI card with a P2P bridge on it, maybe just
read the bus number and rewrite it adding 5 or so...)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
