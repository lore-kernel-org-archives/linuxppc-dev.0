Date: Tue, 2 Mar 1999 21:10:34 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Olivier Aubert <Olivier.Aubert@enst-bretagne.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI driver porting - problem with ioremap ?
In-Reply-To: <u7btibdeqk.fsf@xatard.enst-bretagne.fr>
Message-ID: <Pine.HPP.3.96.990302210215.3871m-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On 2 Mar 1999, Olivier Aubert wrote:

> 
> Hi.
> 
> I am trying to port an existing driver (for a FORE PCA200E ATM card)
> from an existing driver for i386 & alpha to linuxppc (2.2.0 on a PReP,
> Motorola board). I have some trouble with the memory mapping:
> 
> lspci -v gives
> [...]
> 00:11.0 ATM network controller: FORE Systems Inc PCA-200E
>         Flags: bus master, medium devsel, latency 100, IRQ 11
>         Memory at 01e00000 (32-bit, non-prefetchable)
> 
> So it detects correctly the address region. I then try to remap it:
> 
> nodep->membase = (char*)dev->base_address[0];
> (unsigned long) nodep->membase &= PCI_BASE_ADDRESS_MEM_MASK;
>  if ((nodep->kernel_membase = (caddr_t) ioremap((unsigned int)nodep->membase,
>                                                 RAM_SIZE)) == NULL) {
>                         printk("pca200e: Can't ioremap board memory for device %d\n",pci_index); return -EIO; }
> #ifdef DEBUG_200E
>                 printk("pca200e: Board Memory mapped at 0x%p\n",nodep->kernel_me
> mbase);
> #endif

Not surprising since on PreP PCI areas for ioremap should take into an
account the 0xC0000000 offset the the bridge subtracts from the processor
address. On my system right now, I have hacked the early boot so that
dev->base_address are processor physical address as the following example 
shows (according to Martin Mares it is the right way to do this):

[root@vcorr1 linux]# lspci -vse
00:0e.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
        Flags: bus master, medium devsel, latency 96, IRQ 18
        I/O ports at 10100
        Memory at c3f51100 (32-bit, non-prefetchable)
                  ^^^^^^^^
[root@vcorr1 linux]# lspci -vbse
00:0e.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
        Flags: bus master, medium devsel, latency 96, IRQ 10
        I/O ports at 10100
        Memory at 03f51100 (32-bit, non-prefetchable)
                  ^^^^^^^^
I hope something like this will go in the official kernel soon. Anyway 
there are also other features of PPC, namely that this area is already 
mapped permanently by a BAT at address 0xd0000000.  So as a temporary
workaround, you should remove the ioremap and replace its result by a
pointer equal to 0xd0000000+dev->base_address[0].

	Gabriel. 



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
