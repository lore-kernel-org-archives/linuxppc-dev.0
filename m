To: linuxppc-dev@lists.linuxppc.org
Subject: PCI driver porting - problem with ioremap ?
From: Olivier Aubert <Olivier.Aubert@enst-bretagne.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Date: 02 Mar 1999 17:43:15 +0100
Message-ID: <u7btibdeqk.fsf@xatard.enst-bretagne.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi.

I am trying to port an existing driver (for a FORE PCA200E ATM card)
from an existing driver for i386 & alpha to linuxppc (2.2.0 on a PReP,
Motorola board). I have some trouble with the memory mapping:

lspci -v gives
[...]
00:11.0 ATM network controller: FORE Systems Inc PCA-200E
        Flags: bus master, medium devsel, latency 100, IRQ 11
        Memory at 01e00000 (32-bit, non-prefetchable)

So it detects correctly the address region. I then try to remap it:

nodep->membase = (char*)dev->base_address[0];
(unsigned long) nodep->membase &= PCI_BASE_ADDRESS_MEM_MASK;
 if ((nodep->kernel_membase = (caddr_t) ioremap((unsigned int)nodep->membase,
                                                RAM_SIZE)) == NULL) {
                        printk("pca200e: Can't ioremap board memory for device %d\n",pci_index); return -EIO; }
#ifdef DEBUG_200E
                printk("pca200e: Board Memory mapped at 0x%p\n",nodep->kernel_me
mbase);
#endif

The remap seems to be alright, but when I access the remapped memory
area, I access a seemingly random zone of memory. A dump of the memory
area compared to the same thing (sames sources recompiled) on i386
does not give reasonable results (in general, the various addresses
which should be in the memory area are just nonsense [status
registers, etc], and there is a specific ASCII string which does not
even appear in the PPC dump).

>From what I have understood (mailing lists, linux sources), PCI
handling with PReP seems to be a kind of a mess (with relocation
happening early at boottime). I investigated problems related to
byte-order, but the PCI routines on the PPC side should handle this.

I tried to map a memory zone as large as possible and grep the
specific ASCII string from there, but I must have missed something
because it did not appear. I got some code from the ncr53c8xx.c
driver, related to address relocation, but it is now done in the
kernel setup. I checked the PCI command register, which is set to
PCI_COMMAND_MASTER|PCI_COMMAND_MEMORY, as expected.

I am now stuck with no idea of what to try next. Does anybody have a
hint?

Apart from that, LinuxPPC on a PReP board works just fine. Kudos to
all the developers!

Olivier

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
