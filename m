Date: Mon, 22 Feb 1999 21:03:34 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Cort Dougan <cort@persephone.cs.nmt.edu>
cc: Jesper Skov <jskov@cygnus.co.uk>,
        Christian Zankel <zankel@tarantel.rz.fh-muenchen.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Restructuring Efforts
In-Reply-To: <Pine.LNX.3.96.990218100142.6024A-100000@persephone.cs.nmt.edu>
Message-ID: <Pine.HPP.3.96.990222204844.3871F-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 18 Feb 1999, Cort Dougan wrote:

> 
> I was just trying this out with tlbia: Use real tlbias in the kernel even
> on chips that don't do tlbia.  When on a chip that doesn't have the tlbia
> instruction take the trap and fix the code up in the trap handler (put in
> a bl soft_tlbia instead of a tlbia).  We could do something like this per
> architecture.  When doing an arch specific function trap, take the trap
> and fix it up.  The problem with that is keeping track of the myriad of
> functions we need to keep track of.

I was thinking along different lines: add a linker section called
.apus_fixups or so in which I would keep the addresses of all the
in[wl]/out[wl] instructions and patch very early in the boot
according to the following rules: 

	lhbrx  -> lhzx
	lwbrx  -> lwzx
	sthbrx -> sthx
	stwbrx -> stwbrx

between these pairs of instructions only the extended part of the opcode
is different, it would not work the other way around since non byte
swapping instructions have more addressing modes. I once asked on an egcs
list if it would be possible to add a constraint for "x" addressing mode
only because it would make some things simpler (and Altivec only has this
addressing mode): the answer was no, unfortunately. 
    
Of course this section would be freed up and the space reclaimed. The
macros would not be much more complex than they are now: 

asm("1: 	lhbrx %0,0,%1;\t"
	"	.section .apus_fixups,ar;\t"
	"	.long 1b;\t"
	"	.previous"
 

Same idea could perhaps be applied for tlbia to avoid adding runtime
exception handler code and overhead.

	Regards,
	Gabriel.  


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
