Date: Mon, 15 Feb 1999 10:58:32 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Paul Mackerras <paulus@cs.anu.edu.au>,
        Cort Dougan <cort@ladron.cs.nmt.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: your mail
In-Reply-To: <19990213185009.020602@mail.mipsys.com>
Message-ID: <Pine.HPP.3.96.990215103957.5352f-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Sat, 13 Feb 1999, Benjamin Herrenschmidt wrote:

> 
> Hi !
> 
> I would like your point of view about the following:
> 
> The kernel entry code starts playing with BATs as soon as it is entered.
> Isn't that dangerous ? I mean, you must have enough luck for this BAT not
> to be used at this specific time, or not overlapping another BAT setup by
> MacOS (overlapping BATs causes undefined behaviour according to the PPC
> manual) ?

One of the first steps I do in prepboot is to invalidate all the BATs and
all the TLB entries, to make sur that I start from a known state
(invalidating the BATs is a pain because it's different in 601 and
others). But then I'm quite sure I'm called with address translation
disabled, only that some FW version leave stale values in these registers. 

> I have made a test bootx that I'll upload to
> ftp.linuxppc.org/developement/users/benh later today (the archive will
> probably be called BootX_phys_test.sit). This version of BootX doesn't
> jump directly to the kernel but goes to a small piece of PPC asm that
> will cause the kernel to be entered with MMU (and interrupts) disabled. I
> beleive this should get rid of potential problems with TLB misses during
> boot too. Of course, all addresses passed to the kernel are turned into
> physical addresses (frame buffer, stack, boot_infos).

I still had problems with stale TLB entries between prepboot when the 
kernel enabled the MMU. You have to flush the TLB before starting the
kernel to be absolutely sure that there the kernel uses only translations 
it has defined (I discovered that I had added code accessing I/O 
space before the corresponding BATs were set up due to staale TLB
entries).

> This version works on my desktop G3, I didn't have time to test it on
> other machines yet.
> The bootstrap code is simple (it's entered with the same parameters as
> the kernel, but with physical addresses and with the kernel physical
> entry in r6) :
> 
>     /* switch interrupts off */
>     mfmsr   r0;
>     ori     r31,r31,MSR_EE;
>     andc    r0,r0,r31;
>     sync;
>     mtmsr   r0;
>     sync;

Wrong, what is in r31 before ? You may clear unwanted MSR bits:
	
	mfmsr	r0
	rlwinm  r0,r0,0,17,15
	mtmsr 	r0

is enough (And if you don't like using rlwinm like this, which is
guaranteed to work according to the architecture):
	
	mfmsr	r0
	ori	r0,r0,MSR_EE
	xori	r0,r0,MSR_EE
	mtmsr	r0

and you never need a sync before or after disabling interrupts. It is
different when enabling them however, because you have to make
sure that accesses to the interrupt controller have made it to the bus.  


> 
>     /* put kernel entry (phys) in ssr0 */
>     mtspr   SSR0, r6;
> 
>     /* Setup ssr1 (kernel entry MSR) */
>     ori     r31,r31,(MSR_IR|MSR_DR);
>     andc    r0,r0,r31;
>     mtspr   SSR1, r0;
> 
>     /* Branch to the kernel */
>     rfi;
> 
> Note: I wrote this little piece of asm with CodeWarrior. Since I would
> like to make a C boostrap that takes place between this and the kernel, I
> still need to figure out how to build code for this with egcs. If I could
> find the correct MakeFile options to get an output like prom.c
> (PC-relative branches, datas accessed thru a RELOC macro), I think it
> would be just fine. A better approach would be to store datas relative to
> a register that I can setup before entering the boostrap, but that means
> parsing enough of the ELF to extract the offset of the datas. I would
> appreciate if someone could give me some tips about what is usually done
> in those cases or some pointers to infos/samples.


I would recommend that you take a look at the patch files I have for
prep (only have a look at the prepboot directory): 

	ftp://vcorr1.iram.es/pub/linux-2.2/mvme2600.generic-patch-2.2.1.gz

it is even probably overkill for what you need. But the Makefile
(with -m rleocatable), the linker script (ppcboot.lds) and the
early boot (head.S) are probably good examples (and I tried to keep them
clean). 

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
