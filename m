From: "Taylor Holliday" <wtholliday@ucdavis.edu>
To: "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Subject: state of SMP on daystar quad-604 board
Date: Fri, 12 Jan 2001 19:22:31 -0800
Message-ID: <BHEOKMKGNHLELMKKJJIGCEBNCAAA.wtholliday@ucdavis.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all

/arch/ppc/kernel/smp.c from a rsync of the paulus tree has (preliminary)
support for the daystar quad 604 cards. I have been unable to get this to
work on my machine, a daystar genesis mp 600. Now according to
quad.macdiscussion.com, this is possible. So is there a new version that
I havn't found - hopefully there is some source tree out there that
I don't know about.

Now I don't know the first thing about debugging the kernel the proper
way - so I added a bunch of printk calls to get some debugging
output. What's happening, for those who care, follows:

Control reaches this function...

arch/ppc/kernel/smp.c:217
/*
 * Determine a quad card presence. We read the board ID register, we
 * for the data bus to change to something else, and we read it again.
 * It it's stable, then the register probably exist (ugh !)
 */
static int __init psurge_quad_probe(void)
{
        int type;
        unsigned int i;

        type = PSURGE_QUAD_IN(PSURGE_QUAD_BOARD_ID);
        if (type < PSURGE_QUAD_OKEE || type > PSURGE_QUAD_ICEGRASS
            || type != PSURGE_QUAD_IN(PSURGE_QUAD_BOARD_ID))
                return PSURGE_DUAL;		<--------- AND EXITS HERE <------------

        /* looks OK, try a slightly more rigorous test */
        /* bogus is not necessarily cacheline-aligned,
           though I don't suppose that really matters.  -- paulus */
        for (i = 0; i < 100; i++) {
                volatile u32 bogus[8];
                bogus[(0+i)%8] = 0x00000000;
                bogus[(1+i)%8] = 0x55555555;
                bogus[(2+i)%8] = 0xFFFFFFFF;
                bogus[(3+i)%8] = 0xAAAAAAAA;
                bogus[(4+i)%8] = 0x33333333;
                bogus[(5+i)%8] = 0xCCCCCCCC;
                bogus[(6+i)%8] = 0xCCCCCCCC;
                bogus[(7+i)%8] = 0x33333333;
                wmb();
                asm volatile("dcbf 0,%0" : : "r" (bogus) : "memory");
                mb();
                if (type != PSURGE_QUAD_IN(PSURGE_QUAD_BOARD_ID))
                        return PSURGE_DUAL;
        }
        return type;
}

so that function returns PSURGE_DUAL ... and its called from here
arch/ppc/kernel/smp.c:278
static int __init smp_psurge_probe(void)
{
        int i, ncpus;

        /* We don't do SMP on the PPC601 -- paulus */
        if ((_get_PVR() >> 16) == 1)
                return 1;

        /*
         * The powersurge cpu board can be used in the generation
         * of powermacs that have a socket for an upgradeable cpu card,
         * including the 7500, 8500, 9500, 9600.
         * The device tree doesn't tell you if you have 2 cpus because
         * OF doesn't know anything about the 2nd processor.
         * Instead we look for magic bits in magic registers,
         * in the hammerhead memory controller in the case of the
         * dual-cpu powersurge board.  -- paulus.
         */
        if (find_devices("hammerhead") == NULL)
                return 1;

        hhead_base = ioremap(HAMMERHEAD_BASE, 0x800);
        quad_base = ioremap(PSURGE_QUAD_REG_ADDR, 1024);
        psurge_sec_intr = hhead_base + HHEAD_SEC_INTR;

        psurge_type = psurge_quad_probe();
        if (psurge_type != PSURGE_DUAL) {
                psurge_quad_init();
                /* I believe we could "count" CPUs by counting 1 bits
                 * in procbits on a quad board. For now, we assume 4,
                 * non-present CPUs will just be seen as "stuck".
                 * (hope they are the higher-numbered ones -- paulus)
                 */
                ncpus = 4;
        } else {
                iounmap((void *) quad_base);
                if ((in_8(hhead_base + HHEAD_CONFIG) & 0x02) == 0) {
                        /* not a dual-cpu card */
                        iounmap((void *) hhead_base);
                        return 1;  <----- and we arrive here, returning 1
cpu :-(
                }
                ncpus = 2;
        }

        psurge_start = ioremap(PSURGE_START, 4);
        psurge_pri_intr = ioremap(PSURGE_PRI_INTR, 4);

        /* this is not actually strictly necessary -- paulus. */
        for (i = 1; i < ncpus; ++i)
                smp_hw_index[i] = i;

        if (ppc_md.progress) ppc_md.progress("smp_psurge_probe - done",
0x352);

        return ncpus;
}

So I'm not even getting to the "processor 1 stuck" problem others have had
in the past -- the dmesg just prints "Entering SMP mode" and then continues
booting,
no other processors detected.

Oh and as noted in the comment in the above function (smp.c:306 "I believe
we could "count" CPU's ....") -- I tried printing out procbits like this:

procbits = ~PSURGE_QUAD_IN(PSURGE_QUAD_WHICH_CPU);
printk("  procbits = %x \n",procbits);

and all I get is procbits = 0xffffffff.

Furthermore, commenting out the first test in psurge_quad_probe to get
directly
to the "more rigorous test" still results in a return of PSURGE_DUAL, from
the
end of the function (not within the loop) -- so the type is stable for the
100
times it is polled.

I've tried the bk tree too but its smp.c seems synced with the paulus
tree (correct me if I'm wrong). And the official linux 2.4.0 seems to have
an older version of smp.c - so I guess it wasn't merged as I thought it
would be.

Also, could somone point me in the right direction regarding the how to
debug
this stuff (beyond what the typical book-about-kernel will tell me)?
Scouring the web revealed almost no usefull docs on the quad boards.

thanks
- Taylor


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
