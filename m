Message-ID: <3B4A2FD3.DFFD9A30@aps.anl.gov>
Date: Mon, 09 Jul 2001 17:27:31 -0500
From: Andrew Johnson <anj@aps.anl.gov>
MIME-Version: 1.0
To: James F Dougherty <jfd@GigabitNetworks.COM>
Cc: dan@mvista.com, linuxppc-embedded@lists.linuxppc.org,
	cort@cs.nmt.edu
Subject: Re: ppc-linux EPIC (OpenPIC) and Interrupts on MPC8240
References: <200107092157.OAA18907@krakatoa.gigabitnetworks.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


James F Dougherty wrote:
>
> Andrew, I am using the EPIC in direct (discrete mode) as
> you are with EPIC IRQ4=SIO INTR, EPIC IRQ1=Enet Intr,
> and EPIC IRQ3=PCI slot. Are you simply defining the
> InitSenses[] array with 24 entries and the 0 sense for
> UART, 1 for PCI (makes sense since PCI is active high).

The MVME2100 uses the EPIC in serial mode not direct, so I have 16 IRQs to
deal with as well as the 16 dummy entries.

> If so, what kernel source are you using?

Hard Hat Linux 2.0 Journeyman edition from ftp://ftp.mvista.com/ which is
based on Linux 2.4.2.  I too started from the Sandpoint LSP.

Here are the interrupt parts of my mvme2100_setup.c file - not much to
this.  I think you'll need to make another openpic call to select direct
mode, but otherwise the 2.4.2 kernel makes this very easy.


static u_char mvme2100_openpic_initsenses[] __initdata = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        /* 0..15 not used by EPIC but still required */
        0,      /* 16: Not Used */
        1,      /* 17: DEC21143 */
        1,      /* 18: PMC Slot */
        1,      /* 19: PC-MIP-1 Slot 2 */
        1,      /* 20: PC-MIP-2 Slot 1 */
        1,      /* 21: PC-MIP-2 Slot 2 */
        0,      /* 22: Not Used */
        1,      /* 23: Universe-2 LINT0 */
        1,      /* 24: Universe-2 LINT1 */
        1,      /* 25: Universe-2 LINT2 */
        1,      /* 26: Universe-2 LINT3 */
        0,      /* 27: Not Used */
        0,      /* 28: Not Used */
        0,      /* 29: 16550 UART */
        0,      /* 30: Abort button */
        0,      /* 31: RTC IRQ */
};

...

/* Interrupts on the MVME2100 all come through the 8240's EPIC */
static void __init
mvme2100_init_IRQ(void)
{
        if (ppc_md.progress)
                ppc_md.progress("mvme2100_init_IRQ: enter", 0);

        OpenPIC_InitSenses = mvme2100_openpic_initsenses;
        OpenPIC_NumInitSenses = sizeof(mvme2100_openpic_initsenses);

        openpic_init(1, 0, NULL, -1);
        if (ppc_md.progress)
                ppc_md.progress("mvme2100_init_IRQ: exit", 0);
}

...

void __init
mvme2100_init(unsigned long r3, unsigned long r4, unsigned long r5,
               unsigned long r6, unsigned long r7)
{
...
        /* ppc_md.irq_cannonicalize = NULL; */
        ppc_md.init_IRQ = mvme2100_init_IRQ;
        ppc_md.get_irq = openpic_get_irq;
        /* ppc_md.post_irq = NULL; */
...
}

I also added these #ifndefs in open_pic.c - they probably don't belong
here, but the i8259 stuff should be split off as already commented below:

int
openpic_get_irq(struct pt_regs *regs)
{
#ifndef CONFIG_MVME2100
        extern int i8259_irq(int cpu);
#endif
        int irq = openpic_irq();

#ifndef CONFIG_MVME2100
        /* Management of the cascade should be moved out of here */
        if (open_pic_irq_offset && irq == open_pic_irq_offset)
        {
                /*
                 * This magic address generates a PCI IACK cycle.
                 */
                if ( chrp_int_ack_special )
                        irq = *chrp_int_ack_special;
                else
                        irq = i8259_irq( smp_processor_id() );
                openpic_eoi();
        }
#endif
        if (irq == OPENPIC_VEC_SPURIOUS + open_pic_irq_offset) {
                irq = -1;
                /* That's not SMP safe ... but who cares ? */
                ppc_spurious_interrupts++;
        }
        return irq;
}


HTH,

- Andrew
--
The world is such a cheerful place when viewed from upside-down
It makes a rise of every fall, a smile of every frown

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
