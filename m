Date: Thu, 21 Jan 1999 22:05:13 +1100
Message-Id: <199901211105.WAA06985@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: ranjitd@sco.COM
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.SCO.3.96.990120111039.13973A-100000@mammoth.sco.com>
	(message from Ranjit Deshpande on Wed, 20 Jan 1999 11:28:21 -0800
	(PST))
Subject: Re: PCI-PCI bridges
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.SCO.3.96.990120111039.13973A-100000@mammoth.sco.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ranjit Deshpande <ranjitd@sco.COM> wrote:

> Specifically the pci_*_config_* routines do not use the bus number when
> reading from config space. So I went and looked at the 2.1.24 kernel and
> changed the following in arch/ppc/kernel/pmac_pci.c in the above mentioned
> routines...
> 
> out_le32(bp->cfg_addr, (bus << 16) + (dev_fn << 8) + (offset & ~3) +1);
>                        ^^^^^^^^^^^
> That seemed to make the kernel see my ethernet card.

Your fix is correct.  As to how the (bus << 16) got lost, I don't
know, it's beyond the event horizon now :-).

> Now the pcibios_fixup code was not fixing the card's interrupt so I looked
> into that as well. The problem there was that the fixup code searches
> through the device tree looking for the OF device node at only the fist
> level. So if this is the arrangement...
> 
> /bandit
> 	/ohare
> 	/ATY,RAGEII_M
> 	/pci-bridge
> 		/pci1011,9 (my ethernet card)
> 
> 
> then the fixup code only looks at the top-level children of bandit(ohare,
> the ATI card and the pci-bridge) and misses my ethernet card. 
> 
> So I changed the code to search children of nodes called "pci-bridge".

That sounds reasonable.  A slightly better fix might be to look at the
device_type property (which is probably also "pci-bridge" or something
like that) rather than the name, or alternatively at the class-code
property, which might be better still.

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
