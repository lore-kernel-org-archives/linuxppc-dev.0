Date: Wed, 20 Jan 1999 11:28:21 -0800 (PST)
From: Ranjit Deshpande <ranjitd@sco.COM>
To: linuxppc-dev@lists.linuxppc.org
Subject: PCI-PCI bridges
Message-ID: <Pine.SCO.3.96.990120111039.13973A-100000@mammoth.sco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all,

I've been trying to get my ethernet card on work on my Starmax 5500. The
card is a Znyx 345 which has the DEC (Now Intel) 21140 chipset.

After some investigation I've found that the card which is on bus #1 is
not seen by the kernel because support of PCI-PCI bridges has been
omitted in the 2.1.125 kernel.

Specifically the pci_*_config_* routines do not use the bus number when
reading from config space. So I went and looked at the 2.1.24 kernel and
changed the following in arch/ppc/kernel/pmac_pci.c in the above mentioned
routines...

out_le32(bp->cfg_addr, (bus << 16) + (dev_fn << 8) + (offset & ~3) +1);
                       ^^^^^^^^^^^
That seemed to make the kernel see my ethernet card.

Now the pcibios_fixup code was not fixing the card's interrupt so I looked
into that as well. The problem there was that the fixup code searches
through the device tree looking for the OF device node at only the fist
level. So if this is the arrangement...

/bandit
	/ohare
	/ATY,RAGEII_M
	/pci-bridge
		/pci1011,9 (my ethernet card)


then the fixup code only looks at the top-level children of bandit(ohare,
the ATI card and the pci-bridge) and misses my ethernet card. 

So I changed the code to search children of nodes called "pci-bridge".

That seemed to fix the interrupt correctly.

Now the problem is that the tulip code cannot read the EEPROM from the
card.  I've checked the DEC (Intel) 21140 datasheet and spec on how to
read the EEPROM and of course Donald Becker's tulip driver is spot on. But
somehow I'm reading a string of 0xff's from the EEPROM. 


Now my questions are...

1. Are the changes I made valid ? I don't claim to be an expert on PPC
   hardware. And this was my first hack of the Linux kernel on any
   architecture.

2. Is there a reason for PCI-PCI bridges not being supported by the newer  
   kernels ?

3. Why is the tulip code not reading the EEROM ? I'm using the standard
   drivers/net/tulip.c. Does it require any PMAC specific changes ?

I could move the card ahead of the PCI bridge but that just wouldn't be
any fun would it ? :-)

Anyone care to answer ? Paul ? Cort ?

Thanks,

Ranjit


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
