To: paubert@iram.es
Cc: roikawa@rr.iij4u.or.jp, Paul.Mackerras@cs.anu.edu.au, bh40@calva.net,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Blue G3 and machine check
In-Reply-To: Your message of "Wed, 31 Mar 1999 20:39:53 +0200 (METDST)"
	<Pine.HPP.3.96.990331194357.1043L-100000@gra-ux1.iram.es>
References: <Pine.HPP.3.96.990331194357.1043L-100000@gra-ux1.iram.es>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <19990406013647R.roikawa@rr.iij4u.or.jp>
Date: Tue, 06 Apr 1999 01:36:47 +0900
From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,
> Can you first confirm that it is a machine check ? The code
> is quite explicit in traps.c:
> 
>                 switch( regs->msr & 0x0000F000)
>                 {
>                 case (1<<12) :
>                         printk("Machine check signal - probably due to mm fault\n"
>                                 "with mmu off\n");
>                         break;
>                 case (1<<13) :
>                         printk("Transfer error ack signal\n");
>                         break;
>                 case (1<<14) :
>                         printk("Data parity signal\n");
>                         break;
>                 case (1<<15) :
>                         printk("Address parity signal\n");
>                         break;
>                 default:
>                         printk("Unknown values in msr\n");
                          ^^^^^^^^^^^^^^^^
                     It was reached here. Isn't it a machine check?

Before I try to do your suggesion, I'd like to confirm a few things
for my understandig. MPC106 user's manual says,
"The SERR signal is used to report PCI address parity errors, 
PCI data parity errors on a special-cycle command, target-abort,
or any other errors where the result is potentially catastrophic.
The SERR signal is also asserted for master-abort, except if it
happens for a PCI configuration access or special-cycle transaction. "

Because MPC106 cannot master abort as far as P2P bridges are acting
normally, P2P bridges have to report master abort to the host bridge.
According DEC21154 user's manual it forwards a master abort as a target
abort when master abort mode bit in bridge control register is set 1,
except special-cycle transaction. Therefore, in this case scanning PCI
devices with configuration reads must cause master abort, forwarded as
a target abort and then MPC106 asserts SERR. We cannot know if it is
really a target abort until we check the status register of the nearst
P2P bridge to the target device.

Therefore the ways work through this problem may be, from easiest way
to difficult,
 a) Disable master abort fowarding for all P2P bridges, which I tried,
    but this also disables master abort forwarding for usual R/W
    transactions.
 b) Disable master abort fowarding for all P2P bridges walking through
    PCI device tree from the top to the target device before starting
    configuration transactions, and restore after the transactions
    are terminated.
 c) Always enable master abort fowarding for all P2P bridges and exception
    handler recovers system error if
      - exception is caused by PCI configration transaction,
      - host bridge recieved a target abort,
      - status register of the nearst P2P bridge to the target device
        shows master abort (how to know the target device?)
    and sets pcibios_config_read_xx() return value to ~0 (how?).
    We also have to rewrite pcibios_config_xx() as machine check exception
    safe. That's along your suggestion, I think.
Can I assume this, or not?
 
Probably I can try this config read function,
> int grackle_pcibios_read_config_byte(unsigned char bus, unsigned char dev_fn,
> 				     unsigned char offset, unsigned char *val)
> {
> 	struct bridge_data *bp;
> 
> 	if (bus > max_bus || (bp = bridges[bus]) == 0)
> 		return PCIBIOS_DEVICE_NOT_FOUND;
> 	out_be32(bp->cfg_addr, GRACKLE_CFA(bus, dev_fn, offset));
> +	expect_machine_check = 1;
> +	mb();
> 	*val = in_8(bp->cfg_data + (offset & 3));
> +	mb();
> +	expect_machine_check = 0;	
> 	return PCIBIOS_SUCCESSFUL;
> }
> however this won't work because the SRR0 on the machine check might point
> to the load instruction of in_8, leading to an infinite machine check
> loop. So you have to go the harder way:
> 
> replacing the in_8 with something like:
> 
> asm volatile(
> 	"sync; "
> "1: 	lbzx %0,%1,%2;"
> "2:	sync;"
> "3:	isync;"
> "4:	;"
> "	.section .fixup;"
> "5:	li %0,-1;"
> "	b 4b;"
> "	.previous;"
> "	.section __ex_table;"
> "	.long 1b,5b,2b,5b,3b,5b;"	
> "	.previous;" 
> 	: "r" (val) 
> 	: "b" (bp->cfg_data), "r" (offset & 3))
> )

  
but it is beyond my understanding from the next. I don't believe I can
write correct exception handler which seems very complicated. But it may
be worth to try. Anyway it'll be next or after next weekend. I'll have to
read more kernel code and PPC documents.
> and I've still probably forgotten something. I would also like to know
> at which instruction SRR0 points when we have a machine check. The
> architecture description deliberately gives a lot of latitude to the chip
> designers, it might even be necessary to perform some lengthy operation to
> make sure that this works because the machine check might be delayed
> enough clocks to let the processor proceed past the isync. 
> 
> Then you have to modify the machine check handler to use the fixup table
> as in arch/ppc/mm/fault.c:
> 
>         /* Are we prepared to handle this fault?  */
>         if ((fixup = search_exception_table(regs->nip)) != 0) {
>                 regs->nip = fixup;
>                 return;
>         }


Thank you for your advice.

Ryuichi Oikawa
roikawa@rr.iij4u.or.jp


ps. In order to run Linux on BlueG3, pci-ide driver(UltraATA controller,
CMD646)have to be modified for PPC. Anyone try this?

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
