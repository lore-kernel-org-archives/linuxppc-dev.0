Message-ID: <3E67A891.4010909@ecubics.com>
Date: Thu, 06 Mar 2003 12:59:13 -0700
From: emanuel stiebler <emu@ecubics.com>
MIME-Version: 1.0
To: linux-emb <linuxppc-embedded@lists.linuxppc.org>
Subject: EPIC_SERIAL_MODE, openpic_initsenses
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I'm using the serial mode on the EPIC, MPC8245. Some questions about the
inittialisation, because it seems, that I'm the only one who doesn't use
it in the IRQ direct mode. My "ttt_openpic_initsenses" table looks like:
(The DUART interrupts are in twice, for the sake of discussion)

static u_char ttt_openpic_initsenses[] __initdata = {
(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* EPIC IRQ 0, ETH1 */
(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* EPIC IRQ 1, ETH2  */
(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* EPIC IRQ 2, IDE */
(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* EPIC IRQ 3, FM */
(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* EPIC IRQ 4, CF */
(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* EPIC IRQ 5, RTC */
(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* EPIC IRQ 6, DUART */
(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* EPIC IRQ 7, CAN */
(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* EPIC IRQ 8, CPCI_INTA /
(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* EPIC IRQ 9, CPCI_INTB */
(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* EPIC IRQ 10, CPCI_INTC */
(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* EPIC IRQ 11, CPCI_INTD */
0,	/* EPIC IRQ 12, not used */
0,	/* EPIC IRQ 13, not used */
0,	/* EPIC IRQ 14, not used */
0,	/* EPIC IRQ 15, not used */
0,	/* EPIC IRQ 16, I2C */
0,	/* EPIC IRQ 17, DMA CH0 */
0,	/* EPIC IRQ 18, DMA CH1 */
0,	/* EPIC IRQ 19, I2O */
(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* EPIC IRQ 20, DUART 0 */
(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),/* EPIC IRQ 21, DUART 1 */
0,0,0,0,0,0,0,0,0,0,		 /* 22 - 31  */
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* 32 - 63  */
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* 64 - 95  */
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, /* 96 - 127 */
0, 	/* 128, reserved, not used */
0, 	/* 129, I2C, not used */
0, 	/* 130, DMA CH0 not used */
0, 	/* 131, DMA CH1 not used */
0, 	/* 132, reserved, not used */
0, 	/* 133, reserved, not used */
0, 	/* 134, not used */
0, 	/* 135, not used */
0, 	/* 136, not used */
1, 	/* 137, DUART 0 */
1 	/* 138, DUART 1 */
};

the ttt_init_IRQ looks like:
{
	OpenPIC_InitSenses = ttt_openpic_initsenses;
	OpenPIC_NumInitSenses = sizeof(ttt_openpic_initsenses);
   	openpic_init(0);
}

Questions:

a.) in the openpic_init source, I found that in the EPIC_SERIAL_MODE,
the counting starts at the first address of the Interrupt table, so do I
need to have 5 "not used" entries at the beginning of the table for the
direct Interrupts ?

b.) reading some old email from last year, somebody (Jim Thompson ?)
suggested to put the interrupts of the MPC8245 in entries 137 & 137.
Where are they in the EPIC_SERIAL_MODE ?  Still on 137 or on 137-5 ?

Thanks in advance


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
