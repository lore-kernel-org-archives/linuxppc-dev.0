Date: Thu, 9 Aug 2001 17:56:31 -0400 (EDT)
From: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: I want to break softirq.c to fix broken hardware
Message-ID: <Pine.LNX.4.33.0108091722020.11077-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Our custom 603e based board is at long last getting to the point that we
can call it working. We can now boot it, and mount a root filesystem
either via ramdisk or nfs. The board is even mostly stable.

But, I say mostly for a reason.

For those who do not remember my rants about this board, it does not
support bus snooping for the CPU. The 603e uses bus snooping to impliment
the lwarx and stwcx. instructions, which are used by the CPU to do atomic
memory functions. I have worked around this problem thusfar by simply
replacing the atomic functions with non-atomic counterparts. In other
words, the beginning of include/asm/atomic.h now looks like this:

static __inline__ int atomic_add_return(int a, atomic_t *v)
{
        int t;

#ifndef CONFIG_NO_ATOMICS
        __asm__ __volatile__("\n\
1:      lwarx   %0,0,%3\n\
        add     %0,%2,%0\n\
        stwcx.  %0,0,%3\n\
        bne-    1b"
        : "=&r" (t), "=m" (v->counter)
        : "r" (a), "r" (v), "m" (v->counter)
        : "cc");
#else
        __asm__ __volatile__("\n\
1:      lwzx    %0,0,%3\n\
        add     %0,%2,%0\n\
        stwx    %0,0,%3"
        : "=&r" (t), "=m" (v->counter)
        : "r" (a), "r" (v), "m" (v->counter)
        : "cc");
#endif /* CONFIG_NO_ATOMICS */

        return t;
}


While this has worked reasonably well for development, it does crash
regularly. More specifically, it crashes with: kernel BUG at
softirq.c:241! That is in the following section:

static void tasklet_hi_action(struct softirq_action *a)
{
        int cpu = smp_processor_id();
        struct tasklet_struct *list;

        local_irq_disable();
        list = tasklet_hi_vec[cpu].list;
        tasklet_hi_vec[cpu].list = NULL;
        local_irq_enable();

        while (list) {
                struct tasklet_struct *t = list;

                list = list->next;

237             if (!tasklet_trylock(t))
238                     BUG();
239             if (!atomic_read(&t->count)) {
240                     if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
241                             BUG();
242                     t->func(t->data);
243                     tasklet_unlock(t);
244                     continue;
                }
                tasklet_unlock(t);

                local_irq_disable();
                t->next = tasklet_hi_vec[cpu].list;
                tasklet_hi_vec[cpu].list = t;
                cpu_raise_softirq(cpu, HI_SOFTIRQ);
                local_irq_enable();
        }
}

This is obviously atomic-intensive code. My question is, therefore, what
is the best way to bypass the need for an atomic function here? Would it
work for me to replace

if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
with
while(!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state)){}

?

Any thoughts are appreciated.

Thanks,

-Gus


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
