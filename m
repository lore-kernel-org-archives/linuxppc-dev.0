Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 89CA8DDD01
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 08:30:41 +1100 (EST)
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id
	CD23D83395
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Dec 2008 16:30:37 -0500 (EST)
Received: from thinkcentre (unknown [67.9.156.46]) by
	a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPA id 5DCF583394
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Dec 2008 16:30:17 -0500 (EST)
Date: Mon, 1 Dec 2008 15:30:16 -0600
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: __cpu_up vs. start_secondary race?
Message-ID: <20081201213016.GC6829@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I think there may be a plausible issue here.  If not, maybe I'll get
an education :)

cpu_callin_map is used during secondary CPU bootstrap to notify the
waiting CPU that the new CPU is coming up.  __cpu_up clears
cpu_callin_map[cpu] and then polls the same location, waiting for
start_secondary to set it to 1.  But I'm wondering how safe the
current implementation is -- start_secondary doesn't have an explicit
sync following cpu_callin_map[cpu] = 1, and __cpu_up has no
synchronization instructions in its polling loop, so how can we be
sure that the waiting cpu will see the update to that location in
time?

Compare with the prom_hold_cpus/__secondary_hold_acknowledge code,
which is doing a very similar task, but it has the mb and sync (in
head_64.S at least) that seem to be missing from the case above.

Since we're not buried in "Processor X is stuck" bug reports, I must
be missing something, or there's some incidental factor that makes it
okay in practice...

Relevant code from arch/powerpc/kernel/smp.c:

static volatile unsigned int cpu_callin_map[NR_CPUS];

....

int __cpuinit __cpu_up(unsigned int cpu)
{
        int c;

        secondary_ti = current_set[cpu];
        if (!cpu_enable(cpu))
                return 0;

        if (smp_ops == NULL ||
            (smp_ops->cpu_bootable && !smp_ops->cpu_bootable(cpu)))
                return -EINVAL;

        /* Make sure callin-map entry is 0 (can be leftover a CPU
         * hotplug
         */
        cpu_callin_map[cpu] = 0;

        /* The information for processor bringup must
         * be written out to main store before we release
         * the processor.
         */
        smp_mb();

        /* wake up cpus */
        DBG("smp: kicking cpu %d\n", cpu);
        smp_ops->kick_cpu(cpu);

        /*
         * wait to see if the cpu made a callin (is actually up).
         * use this value that I found through experimentation.
         * -- Cort
         */
        if (system_state < SYSTEM_RUNNING)
                for (c = 50000; c && !cpu_callin_map[cpu]; c--)
                        udelay(100);
#ifdef CONFIG_HOTPLUG_CPU
        else
                /*
                 * CPUs can take much longer to come up in the
                 * hotplug case.  Wait five seconds.
                 */
                for (c = 25; c && !cpu_callin_map[cpu]; c--) {
                        msleep(200);
                }
#endif

        if (!cpu_callin_map[cpu]) {
                printk("Processor %u is stuck.\n", cpu);
                return -ENOENT;
        }

        printk("Processor %u found.\n", cpu);

        if (smp_ops->give_timebase)
                smp_ops->give_timebase();

        /* Wait until cpu puts itself in the online map */
        while (!cpu_online(cpu))
                cpu_relax();

        return 0;
}
....

int __devinit start_secondary(void *unused)
{
        unsigned int cpu = smp_processor_id();
        struct device_node *l2_cache;
        int i, base;

        atomic_inc(&init_mm.mm_count);
        current->active_mm = &init_mm;

        smp_store_cpu_info(cpu);
        set_dec(tb_ticks_per_jiffy);
        preempt_disable();
        cpu_callin_map[cpu] = 1;

        smp_ops->setup_cpu(cpu);
        if (smp_ops->take_timebase)
                smp_ops->take_timebase();
....
