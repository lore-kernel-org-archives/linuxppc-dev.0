Date: Tue, 15 May 2001 19:02:28 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Amelia De Vivo <amelia.devivo@roma.quadrics.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Addressing PCI memory
In-Reply-To: <002f01c0dd5c$f64942e0$7a00000a@roma.quadrics.com>
Message-ID: <Pine.HPX.4.10.10105151859290.1451-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 15 May 2001, Amelia De Vivo wrote:

>
> Hi all, I'm trying to write a driver for a 64 bit PCI device. Something like
> this works well under i386 Linux, but it doesn't work at all for Linux
> 2.2.15 by Yellow Dog:
>
>     struct pci_dev *dev = NULL;
>     dev = pci_find_device(vendor, device, dev);
>     pci_read_config_dword(dev, PCI_BASE_ADDRESS_0, &cards[0].addr0);

First, use the resource in the dev structure, they do not necessarily
correspond to the value read from the base, even on Intel BTW.

	cards[0].addr0 = dev->resources[0].start

don't even need to mask the address bits...

Report again if the problems  persist.

>     cards[0].vaddr = (void *) ioremap((cards[0].addr0 &
> PCI_BASE_ADDRESS_MEM_MASK), cards[0].size);
>     writeb('A',(cards[0].vaddr)+0x1000);
>
> I have a kernel panic on writeb. Has someone some suggestion?

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
