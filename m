Message-ID: <3B017286.CC313C9C@mandrakesoft.com>
Date: Tue, 15 May 2001 14:16:38 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Cc: Amelia De Vivo <amelia.devivo@roma.quadrics.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Addressing PCI memory
References: <Pine.HPX.4.10.10105151859290.1451-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:
>
> On Tue, 15 May 2001, Amelia De Vivo wrote:
>
> >
> > Hi all, I'm trying to write a driver for a 64 bit PCI device. Something like
> > this works well under i386 Linux, but it doesn't work at all for Linux
> > 2.2.15 by Yellow Dog:
> >
> >     struct pci_dev *dev = NULL;
> >     dev = pci_find_device(vendor, device, dev);
> >     pci_read_config_dword(dev, PCI_BASE_ADDRESS_0, &cards[0].addr0);
>
> First, use the resource in the dev structure, they do not necessarily
> correspond to the value read from the base, even on Intel BTW.
>
>         cards[0].addr0 = dev->resources[0].start
>
> don't even need to mask the address bits...

correct.

Though note it is highly encouraged to use
pci_resource_{start,end,len,flags} helpers.  That makes it transparent
to port code to earlier kernels, and IMHO makes the code easier to read.

--
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
