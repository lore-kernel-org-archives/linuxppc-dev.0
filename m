Date: Thu, 9 Aug 2001 18:32:17 -0400 (EDT)
From: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: I want to break softirq.c to fix broken hardware
In-Reply-To: <3B72D188.4080902@humboldt.co.uk>
Message-ID: <Pine.LNX.4.33.0108091826180.11077-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 9 Aug 2001, Adrian Cox wrote:

>
> Justin (Gus) Hurwitz wrote:
>
>  > #else
>  >         __asm__ __volatile__("\n\
>  > 1:      lwzx    %0,0,%3\n\
>  >         add     %0,%2,%0\n\
>  >         stwx    %0,0,%3"
>  >         : "=&r" (t), "=m" (v->counter)
>  >         : "r" (a), "r" (v), "m" (v->counter)
>  >         : "cc");
>  > #endif /* CONFIG_NO_ATOMICS */
>
> Last time this came up I pointed out that lwarx/stwcx are for locking
> against interrupts as well as against other CPUs. You don't seem to have
> anything in your atomic routine to prevent interrupts occurring between
> the load and the store.
>
> --
> Adrian Cox   http://www.humboldt.co.uk/

Indeed- you are right (and that is, I'm 99% sure, the cause of the crash
when it happens).

I presume that it would be terrible ineffecient to turn off interrupts
throughout all of the tasklet_hi_action() function (though they are off
for most of it). Since this is the only function that I have ever had a
crash in, I would rather not add local_irq_disable()/local_irq_enable() to
each of the atomic functions, as that seems to be ineffecient overkill
(though it might be the proper thing to do?).

Right now I am compiling a kernel with local_irq_disable()/local_irq_enable()
around the
if (!atomic_read(&t->count)) {
                        if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
                                BUG();
                        t->func(t->data);
                        tasklet_unlock(t);
                        continue;
                }
statement. Hopefully that will work.

When I get this working, would it be worthwhile to send a patch to the
list? I don't know if anyone else needs this kind of fix. If others would
like it, I'll try to do this a more generically "right" way.

Thanks again,
--Gus


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
