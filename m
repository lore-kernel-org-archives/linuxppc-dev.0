Date: Tue, 8 May 2001 01:06:32 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Eli Chen <eli@routefree.com>
Cc: Dan Malek <dan@mvista.com>, brian.kuschak@skystream.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()
In-Reply-To: <032e01c0d73f$58022160$4b00000a@foolio1>
Message-ID: <Pine.HPX.4.10.10105072359470.22253-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 7 May 2001, Eli Chen wrote:

>
> > What version of silicon do you have, and what platform are you using?
>
> I am using the 405GP core, rev D.  My tree is based off of the February 26th
> source from MontaVista.
>
> > Is there some simple test I can use to trigger this problem?
>
> Besides Brian's one-liner test, you can try flood pinging your 405GP.  I
> have been consistently receiving these error messages after letting it run a
> while:
>
> Freeing alive device (cxxxxxxx), ethx
>
> and
>
> Attempt to release alive inet socket cxxxxxxx
>
> I have also occasionaly received other messages, which I have yet to receive
> after changing atomic.h.

Hmm, consider what happens if a down_trylock in an interrupt handler
fails. Actually dec_if_positive will leave a dangling reservation, since
it will skip the stwcx. instruction.

I had not looked at the code for very long, so I may misss something or be
completely wrong but I see a stwcx. instruction in transfer_to_handler
which I think is useless since the handler will always execute a lwarx
before attempting a stwcx., thereby making the state of the reservation at
the interrupt enty irrelevant.

On the other hand, when an interrupt handler dows a down_trylock and
then returns because it failed, it will leave the reservation active
until returing to the caller (once again if I did not miss anything in the
return path).

So the sequence of events which can cause corruption is the following:

1) lwarx atomic_var,
   reservation set
2) interrrupt taken,
   reservation set
3) stwcx. in interrupt prologue (transfer_to_handler),
    reservation cleared
4) interrupt handler executes, talks to hardware
5) interupt handler modifies atomic_var,
   reservation set and cleared (hence step 3 was not necessary)
6) down_trylock() fails,
   reservation set
8) interrupt handler returns,
   reservation still set
9) interrupt epilogue restores state and returns between lwarx and stwcx.,
   reservation is still set!
10) swtcx. atomic_var, succeeds, but the variable has been modified in the
   meantime, chaos ensues

In short, I think that step 3) should be moved to the epilogue(s),
ret_from_intercept, etc... Note that spin_trylock() could produce the same
effect in step 6), but it's SMP only.

What do you think, am I completely off base ?

I try to avoid looking at entry.S/head.S/misc.S and had not done it for a
long time since I think it's dangerous for my mental health, so, once
again, I might be completely wrong.

So I'd suggest the following one liner:

===== arch/ppc/kernel/entry.S 1.7 vs edited =====
--- 1.7/arch/ppc/kernel/entry.S	Fri Apr 13 20:44:42 2001
+++ edited/arch/ppc/kernel/entry.S	Tue May  8 01:02:47 2001
@@ -382,6 +382,7 @@
 	CLR_TOP32(r8)
 	mtspr	SPRG2,r8		/* phys exception stack pointer */
 1:
+	stwcx.	r0,0,r1			/* Clear reservation - Gabriel. */
 	lwz	r3,_CTR(r1)
 	lwz	r0,_LINK(r1)
 	mtctr	r3

You can also try to remove the

	li r22,RESULT
	stwcx. r22,r22,r21

or similar lines in head.S, head_4xx.S, and head_8xx.S to check that my
theory is correct.

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
