From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15366.44742.923433.367449@gargle.gargle.HOWL>
Date: Fri, 30 Nov 2001 08:55:18 +1100 (EST)
To: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ide_init_hwif_ports
In-Reply-To: <0111291900.AA00593@ivan.Harhan.ORG>
References: <0111291900.AA00593@ivan.Harhan.ORG>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Sokolov writes:

> to ISA slot connectors. This is what the Adirondack does, and the result is
> that no matter what you do in the PCI domain, the primary IDE interrupt will
> always come in as IRQ 14 and the secondary IDE interrupt will always come in as
> IRQ 15.

Thanks for the explanation.  I'll ask Vojtech Pavlik and Andre Hedrick
if they can suggest a better way (drivers/ide/via82cxxx.c has
Vojtech's name on it).

Actually, I have just noticed this code in drivers/ide/ide-pci.c:

                if (IDE_PCI_DEVID_EQ(d->devid, DEVID_UM8886A) ||
                    IDE_PCI_DEVID_EQ(d->devid, DEVID_UM8886BF) ||
                    IDE_PCI_DEVID_EQ(d->devid, DEVID_UM8673F)) {
                        hwif->irq = hwif->channel ? 15 : 14;
                        goto bypass_umc_dma;
                }

We may be able to get something similar added for our case(s).

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
