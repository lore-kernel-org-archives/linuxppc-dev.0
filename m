Message-ID: <38BCC721.2EA651F1@mpifr-bonn.mpg.de>
Date: Wed, 01 Mar 2000 08:30:41 +0100
From: Albrecht Dre_ <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
CC: linuxppc-dev@lists.linuxppc.org, Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: FireWire + Apple PB G3: some success
References: <38BA7122.44C833A9@mpifr-bonn.mpg.de> <20000301010720K.roikawa@rr.iij4u.or.jp>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ryuichi Oikawa wrote:
> Have you checked if the patch you used is really working correctly?
> It setups CardBus bridge's interrupt routing for only TI1130(0xac12)
> and TI1131(0xac15) (see the patch to arch/ppc/kernel/pmac_pci.c).
> You will have to add support for your CardBus bridge(ID 0xac1e)
> referring the document from TI.

I also found that problem as I could not see the pcibios_fixup kernel message in
the logs...

As Ben already said, it it TI's PCI1211.  Although the data sheet states that
the two registers you alter with your patch (0x91 and 0x91) are "...provided for
PCI1130 campatibility", just adding the signature to activate the setup does not
work.

Unfortunately I do not have a card for which I know for sure that it will work
with LinuxPPC.  In the meantime I tested so many different combinations of
with/without your patch, with/without the PCMCIA package ver. 3.0.something/
3.1.something enables/diabled and an Adaptec SCSI CardBus Card/FireWire2Go
CardBus card (and got all sorts of nasty reactions like freezes and panics) that
I am a litte confused now.  I am afraid I have to try a more systematic
approach, and to read TI's docs first.

Anyway, thanks a lot for your help!

Yours, Albrecht.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
