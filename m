Date: Mon, 5 Apr 1999 19:11:13 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
cc: Paul.Mackerras@cs.anu.edu.au, bh40@calva.net,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Blue G3 and machine check
In-Reply-To: <19990406013647R.roikawa@rr.iij4u.or.jp>
Message-ID: <Pine.HPP.3.96.990405184338.1043P-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 6 Apr 1999, Ryuichi Oikawa wrote:

> Hello,
> >                 default:
> >                         printk("Unknown values in msr\n");
>                           ^^^^^^^^^^^^^^^^
>                      It was reached here. Isn't it a machine check?

I realize now that the code in traps.c is completely bogus. Please apply
first the following patch (it seems that he author did not realize
that bits are given in big endian ordering in PPC doc):

--- linux-2.2.4/arch/ppc/kernel/traps.c	Tue Jan  5 19:13:56 1999
+++ linux/arch/ppc/kernel/traps.c	Mon Apr  5 19:04:57 1999
@@ -104,19 +104,19 @@
 		printk("Machine check in kernel mode.\n");
 		printk("Caused by (from msr): ");
 		printk("regs %p ",regs);
-		switch( regs->msr & 0x0000F000)
+		switch( (regs->msr & 0x000F0000) >> 16 )
 		{
-		case (1<<12) :
+		case (8) :
 			printk("Machine check signal - probably due to mm fault\n"
 				"with mmu off\n");
 			break;
-		case (1<<13) :
+		case (4) :
 			printk("Transfer error ack signal\n");
 			break;
-		case (1<<14) :
+		case (2) :
 			printk("Data parity signal\n");
 			break;
-		case (1<<15) :
+		case (1) :
 			printk("Address parity signal\n");
 			break;
 		default:


> Before I try to do your suggesion, I'd like to confirm a few things
> for my understandig. MPC106 user's manual says,
> "The SERR signal is used to report PCI address parity errors, 
> PCI data parity errors on a special-cycle command, target-abort,
> or any other errors where the result is potentially catastrophic.
> The SERR signal is also asserted for master-abort, except if it
> happens for a PCI configuration access or special-cycle transaction. "

I did not know there was an exception for PCI configuration cycles (I
thought it was for sepcial cycles only which are designed to end in
master abort) and I don't like it :-( : it makes the bridges non
transparent wrt error handling. 

 > 
> Because MPC106 cannot master abort as far as P2P bridges are acting
> normally, P2P bridges have to report master abort to the host bridge.
> According DEC21154 user's manual it forwards a master abort as a target
> abort when master abort mode bit in bridge control register is set 1,
> except special-cycle transaction. Therefore, in this case scanning PCI
> devices with configuration reads must cause master abort, forwarded as
> a target abort and then MPC106 asserts SERR. We cannot know if it is
> really a target abort until we check the status register of the nearst
> P2P bridge to the target device.
> 
> Therefore the ways work through this problem may be, from easiest way
> to difficult,
>  a) Disable master abort fowarding for all P2P bridges, which I tried,
>     but this also disables master abort forwarding for usual R/W
>     transactions.

In most systems the serr signal is never signaled. This is an acceptable
workaround for now. The PCI transaction times out and nothing serious
happens. 

>  b) Disable master abort fowarding for all P2P bridges walking through
>     PCI device tree from the top to the target device before starting
>     configuration transactions, and restore after the transactions
>     are terminated.

Would result in inconsistent handling of errors on SMP, don't do that. 

>  c) Always enable master abort fowarding for all P2P bridges and exception
>     handler recovers system error if
>       - exception is caused by PCI configration transaction,
>       - host bridge recieved a target abort,
>       - status register of the nearst P2P bridge to the target device
>         shows master abort (how to know the target device?)
>     and sets pcibios_config_read_xx() return value to ~0 (how?).
>     We also have to rewrite pcibios_config_xx() as machine check exception
>     safe. That's along your suggestion, I think.

Indeed. But if may not be the simplest. So don't hold your breath. 

> Can I assume this, or not?

Yes.

> > replacing the in_8 with something like:
> > 
> > asm volatile(
> > 	"sync; "
> > "1: 	lbzx %0,%1,%2;"
> > "2:	sync;"
> > "3:	isync;"
> > "4:	;"
> > "	.section .fixup;"
> > "5:	li %0,-1;"
> > "	b 4b;"
> > "	.previous;"
> > "	.section __ex_table;"
> > "	.long 1b,5b,2b,5b,3b,5b;"	
> > "	.previous;" 
> > 	: "r" (val) 
> > 	: "b" (bp->cfg_data), "r" (offset & 3))
> > )
> 
>   
> but it is beyond my understanding from the next. I don't believe I can
> write correct exception handler which seems very complicated. But it may
> be worth to try. Anyway it'll be next or after next weekend. I'll have to
> read more kernel code and PPC documents.

Actually I think it would be easier to provide a few `machine check safe
functions' in arch/ppc/kernel/ which would be called something like
safe_{read,write}[bwl] (you are encouraged to suggest better names) and
would return a status indicating whether the operation had succeeded or
not with prototypes like: 

int safe_readb(volatile u_char *, u_char *)

int safe_writeb(u_char, volatile u_char *)

returning either 0 (success) or -ENXIO on error (would it be the right 
error code). Export these functions since they might be useful in some
other cases.  

	Regards,
	Gabriel.

P.S: the patch I've put on my ftp server for the MVME2600
(ftp://vcorr1.iram.es/pub/linux-2.2/mvem2600.generic-patch-2.2.4) includes
some modifications to the PCI code which go in the right direction.
However, it still needs some work. 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
