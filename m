Subject: Re: Pegasos 2 support patch ...
From: Adrian Cox <adrian@humboldt.co.uk>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20040630093030.GA24283@pegasos>
References: <20040629165029.GA13468@pegasos>
	 <1088587090.28598.3.camel@localhost>  <20040630093030.GA24283@pegasos>
Content-Type: text/plain
Message-Id: <1088588447.28598.13.camel@localhost>
Mime-Version: 1.0
Date: Wed, 30 Jun 2004 10:40:47 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2004-06-30 at 10:30, Sven Luther wrote:
> On Wed, Jun 30, 2004 at 10:18:10AM +0100, Adrian Cox wrote:
> > On Tue, 2004-06-29 at 17:50, Sven Luther wrote:
> > > The remaining problem for the pegasos 2 is with the via82cxxx ide
> > > driver, which needs to support a different irq for both channels, thus
> > > breakign when a device is present on the second ide channel. [snip]

> > My current idea is to add an extra flag to the ide_pci_device_t to
> > indicate that the device defaults to ports 14 and 15, then modify
> > ide_hwif_configure() to use this flag.
>
> Ok, sounds nice, do you plan to write this patch anytime soon, or should
> i go forward and implement this idea ?

I've got a few other things to get into the kernel before this, so
please don't wait for me. If you make a patch I'll test it.

In my case, the initial setup is that the device has been assigned I/O
space address in the 0xfe00 range, and no PCI IRQ.  This confuses the
PCI IDE code, because it assumes that the device must be an add-in card
if it is not on the legacy ports.

- Adrian Cox
Humboldt Solutions Ltd.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
