Date: Tue, 15 May 2001 11:58:58 -0500
From: Takashi Oe <toe@unlserve.unl.edu>
To: "Amelia De Vivo" <amelia.devivo@roma.quadrics.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Addressing PCI memory
Message-Id: <20010515115858.5f424092.toe@unlserve.unl.edu>
In-Reply-To: <002f01c0dd5c$f64942e0$7a00000a@roma.quadrics.com>
References: <002f01c0dd5c$f64942e0$7a00000a@roma.quadrics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 15 May 2001 18:34:50 +0200, Amelia De Vivo wrote:

>
> Hi all, I'm trying to write a driver for a 64 bit PCI device. Something
> like
> this works well under i386 Linux, but it doesn't work at all for Linux
> 2.2.15 by Yellow Dog:
>
>     struct pci_dev *dev = NULL;
>     dev = pci_find_device(vendor, device, dev);
>     pci_read_config_dword(dev, PCI_BASE_ADDRESS_0, &cards[0].addr0);
>     cards[0].vaddr = (void *) ioremap((cards[0].addr0 &
> PCI_BASE_ADDRESS_MEM_MASK), cards[0].size);
>     writeb('A',(cards[0].vaddr)+0x1000);
>
> I have a kernel panic on writeb. Has someone some suggestion?

Is PCI_COMMAND_MEMORY enabled on the device?  On Apple machines,
it's usually not enabled by default.  For 2.2.15, you'd need to
manually enable it.  [grep PCI_COMMAND_MEMORY for more info.]


Takashi Oe

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
