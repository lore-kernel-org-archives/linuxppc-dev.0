Date: Wed, 6 Jan 1999 15:45:51 +0100
To: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
CC: Paul Mackerras <paulus@cs.anu.edu.au>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Linux vs. new PowerMacs
Message-Id: <19990106154551.031473@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


For those who haven't yet read the developer note of the new machines,
here are some infos that may be of interest to get Linux running on those
new machines:

 - Grackle is still here. It's externally clocked at 66MHz using an Apple
custom-made arbitrer, but this should be configured once for all by OF,
so I don't think we have to worry about that. It's driving the
66MHz/32bits graphic PCI slot and the bridge below.

 - There's a PCI-PCI bridge between the 66MHz bus and the 33MHz 32/64
bits bus. It looks like the data patch from the CPU to this PCI is 32
bits wide. The bridge is a DEC/Intel 21154 connected to Grackle.

 - The main IC is still Paddington (like the iMac) with a slightly
improved bmac+, according to Apple it's software compatible and more
efficient. The modem is on it's SCC channel A, so I guess we should be
able to support it, it's ATA channels (ATA-3) drive the CDROM and the
ZIP, VIA and CUDA are there too for I2C, power and ADB, the NVRAM looks
similar to what it was in the iMac and the Sound is also Burgundy which
is, I think, yet another AWACS derivative.

 - There's a new PCI-based UltraDMA/33 (ATA/ATAPI-4) controller. I've not
seen any infos or spec about this, I don't know if it's a custom Apple
chip or a standard one, but there are great chances that this is a
standard one. We should be able to use it as-is in PIO mode like any ATA
controller, DMA may be a little bit more tricky.

 - FireWire is a standard PCI-based chip

 - USB is a standard PCI-based chip, I guess it's similar to the one used
in the iMac but I have not seen any more infos about it in the dev. note.

 - Video: The new ATI will probably not be supported "as-is" by atyfb,
this will probably be the "hard part". We can still use "ofonly" video in
the meantime.

Looks like there are great chances that we get Linux running on the
machine quite quickly, isn't it ? ;-)

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
