Message-ID: <20011104150617.32124.qmail@dag.newtech.fi>
To: "Sarnath Kannan" <sparc64@rediffmail.com>
Cc: "Dag Nygren" <dag@newtech.fi>,
	linuxppc-embedded@lists.linuxppc.org, dag@newtech.fi
Subject: Re: EPIC Vs OpenPIC (RFC) 
In-Reply-To: Message from "Sarnath Kannan" <sparc64@rediffmail.com>
   of "04 Nov 2001 14:45:38 GMT." <20011104144538.9588.qmail@mailweb31.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 04 Nov 2001 17:06:17 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


BTW,

here is the corresponding routine for the xxxx_setup.c
in my port:

    /* Using MPC107(EPIC) means that the LinuxVector numbers start from 16
     * as 0-15 is reserved for the possible cascade
     * Remember that the LinuxVector of the first entry is used as an offset
     * for the Timer and IPI vectors */

static openpic_irq_def vg4_openpic_irq_defs[] __initdata = {
    /* PICirq, LinuxVector, Priority, Level/Edge, Polarity, CascadeAck */
    {  0, 16, 8, OP_IRQ_LEVEL, OP_IRQ_POS, &i8259_irq} ,    /* 8259 cascade */
    {  1, 17, 8, OP_IRQ_LEVEL, OP_IRQ_NEG, NULL      } ,    /* INT_PCI_INTA */
    {  2, 18, 8, OP_IRQ_LEVEL, OP_IRQ_NEG, NULL      } ,    /* INT_PCI_INTB */
    {  3, 19, 8, OP_IRQ_LEVEL, OP_IRQ_NEG, NULL      } ,    /* INT_PCI_INTC */
    {  4, 20, 8, OP_IRQ_LEVEL, OP_IRQ_NEG, NULL      } ,    /* INT_PCI_INTD */
    { -1, -1, 8, OP_IRQ_LEVEL, OP_IRQ_NEG, NULL      }      /* End of table
marker */
};

ALLOC_OPENPIC_DEF(vg4_openpic_def);

static void __init
vg4_init_IRQ(void)
{
    int vec;

    vg4_openpic_def.IRQdef    = vg4_openpic_irq_defs;

    /* The int:s behind the OpenPIC in MPC107 */

    openpic_init(&vg4_openpic_def);

    /* These are the ints (0-15) behind the 8259 in the ALI chip */
    for ( vec = 0 ; vec < NUM_8259_INTERRUPTS  ; vec++ )
        irq_desc[vec].handler = &i8259_pic;

    i8259_init();
}


BRGDS

Dag


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
