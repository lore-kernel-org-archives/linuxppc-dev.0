Message-ID: <3AFAE7A0.AE936C64@mvista.com>
Date: Thu, 10 May 2001 12:10:24 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Cc: frowand@mvista.com, Brian Kuschak <brian.kuschak@skystream.com>,
	"'Dan Malek'" <dan@mvista.com>, Eli Chen <eli@routefree.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()
References: <Pine.HPX.4.10.10105102042500.29518-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Gabriel Paubert wrote:
>
> On Thu, 10 May 2001, Frank Rowand wrote:
>
> > Gabriel Paubert wrote:
> > >
> > > On Wed, 9 May 2001, Brian Kuschak wrote:
> >
> >
> > > >
> > > > static __inline__ void atomic_set(atomic_t *v, int a)
> > > > {
> > > > c004f9e8:       38 00 00 01     li      r0,1
> > > >         int t;
> > > >
> > > >         __asm__ __volatile__("\n\
> > > > c004f9ec:       7d 60 f8 28     lwarx   r11,r0,r31
> > > > c004f9f0:       60 0b 00 00     ori     r11,r0,0
> > > > c004f9f4:       7d 60 f9 2d     stwcx.  r11,r0,r31
> > > > c004f9f8:       40 a2 ff f4     bne-    c004f9ec <d_alloc+0x90>
> > > >
> > > >         atomic_set(&dentry->d_count, 1);
> > >
> > > Is there any reason for atomic_set to use this sequence. I believe that a
> > > simple store (stw in this case) would be ok. This looks like a very
> > > convoluted and bloated way to set a variable. An aligned stw is guaranteed
> > > to set the variable atomically wrt all other processors.
> >
> > Sorry I wasn't around for the beginning of this discussion (I was off with
> > visiting family...), but I'll jump in now.
> >
> > I put this version of atomic_set() into Brian's source.  It is one of the
> > things that helped reduce the severity of the dcache symptoms.  You can't
> > just use a stw in atomic_set(), because the other atomic operations depend
> > upon the stwcx.
>
> Why not ? I'd like to find an explanation of a possible failure mode.
> All PPC systems have always used a simple store for atomic_set. If it does
> not work, there is something seriously wrong, perhaps even a hardware bug.
>
> This is especially true on a UP system. Whatever value is stored by a stw
> should be seen by any following lwarx/stwcx., on SMP you may need an
> eieio. But on UP I can't see how it can affect anything.

>From the "PowerPC 405GP Embedded Processor User's Manual", in the "Instruction
Set" chapter (which describes each instruction), the Programming Note for lwarx
says:

  lwarx and the stwcx. instruction should be paired in a loop, as shown in the
  following example, to create the effect of an atomic operation to a memory
  area used as a semaphore between asynchronous processes.  Only lwarx can set
  the reservation bit to 1.  stwcx. sets the reservation bit to 0 upon its
  completion, whether or not stwcx. sent (RS) to memory.  CR[CR0]EQ must be
  examined to determine whether (RS) was sent to memory.

    loop: lwarx  # read the semaphore from memory; set reservation
    "alter"      # change the semaphore bits in register as required
    stwcx.       # attempt to store semaphore; reset reservation
    bne loop     # an asynchronous process has intervened; try again

  If the asynchronous process in the code example had paired lwarx with a
  store other than stwcx., the reservation bit would not have been cleared
  in the asynchronous process, and the code example would have overwritten
  the semaphore.



So if the lwarx occurs,

then an interrupt alters the flow of execution,
and the interrupt handler uses a stw to implement atomic_set(),

then the interrupt handler returns to the original flow of execution,

then the stwcx. succeeds, even though the value of the semaphore was
altered by the atomic_set().


> Did it actually have any effect on Brian's system ?

Changing atomic_set() to use lwarx / stwcx. instead of stw had an
effect on my 405GP systems here (including the Walnut and also
the same custom board that Brian is using).


-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
