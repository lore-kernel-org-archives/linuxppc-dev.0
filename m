Date: Mon, 11 Feb 2002 23:37:30 +0100
From: Werner Almesberger <wa@almesberger.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: performance monitor exceptions
Message-ID: <20020211233730.E5079@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm banging my head at a problem with exceptions. What I want to
do is to get the performance monitor to give me exceptions at
roughly 1 kHz, to drive the kernel profiler. The problem is that
my changes usually kill the system within a few minutes :-(

I'm quite new to the PPC, so I'll include a bit more details, in
case I made some trivial mistake. My kernel is 2.4.17, my CPU is a
MPC7410.

First of all, I changed the vector to:

        . = 0xf00
        b       PerformanceMonitor

Then, I added a tiny little handler that does nothing but re-enable
the PE exception. For getting a register, I mimicked EXCEPTION_PROLOG:

PerformanceMonitor:
        // 955 is SIAR
        mtspr   955,r20
        mfspr   r20,SPRN_MMCR0
        oris    r20,r20,MMCR0_PMXE@h
        mtspr   SPRN_MMCR0,r20
        mfspr   r20,955
        SYNC
        RFI

And then I added of course a bit of code to enable all this:

int __init setup_perf_mon(void)
{
        unsigned long flags;

        local_irq_save(flags);
        local_irq_disable();
        /* ca. 3 kHz */
        mtspr(SPRN_MMCR0,(mfspr(SPRN_MMCR0) & ~MMCR0_TBSEL_MASK) |
          MMCR0_PMXE | (MMCR0_TBSEL_TBL15 << MMCR0_TBSEL_SHIFT) | MMCR0_TBEE);
        local_irq_restore(flags);
        return 0;
}

It seems to work (I had a handler there that does something a little
more useful), but when I start kernel builds, I get a dead system
(rebooted by hardware watchdog) within a few minutes.

Instead of SIAR, I also tried SPRG0 and SPRG1, but got exactly the
same behaviour. Time to crash varies from one to ten minutes. The
time increases proportionally if I use TLB[19] (~200 Hz) instead.

Any ideas of what I could be trampling over (or be trampled over
by) ? This code seems rather bullet-proof to me, and I don't think
anything else is using SIAR, or could change it while I'm using it.

Thanks,
- Werner

--
  _________________________________________________________________________
 / Werner Almesberger, Lausanne, CH                    wa@almesberger.net /
/_http://icawww.epfl.ch/almesberger/_____________________________________/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
