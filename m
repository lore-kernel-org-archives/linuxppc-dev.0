Message-ID: <3BD517E5.5090204@elsoft.ch>
Date: Tue, 23 Oct 2001 09:10:29 +0200
From: "David =?ISO-8859-1?Q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Additional IRQ handlers in ppc4xx_init_IRQ()
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello

I have a question regarding the registration of additional IRQ handlers
for a PPC405GP based board. The board uses the PIC inside the PIIX4 too,
so i have set NR_BOARD_IRQ to 16 in my board specific include file and
extended ppc4xx_init_IRQ as follows:

static void __init
ppc4xx_init_IRQ(void)
{
	int i;

	ppc4xx_pic_init();

#if !defined(CONFIG_PIP405) && !defined(CONFIG_MIP405)
	for (i = 0; i < NR_IRQS; i++)
		irq_desc[i].handler = ppc4xx_pic;
#else
/* MPL PIP405 / MIP405 uses PIIX4 PIC too */
	for (i = 0; i < NR_AIC_IRQS; i++)
		irq_desc[i].handler = ppc4xx_pic;
	for (i = NR_AIC_IRQS; i < NR_IRQS; i++)
		irq_desc[i].handler = &i8259_pic;

	i8259_pic_irq_offset = NR_AIC_IRQS;
	i8259_init();
	request_irq(ISA_BRIDGE_INT, pip405_mip405_i8259_action, 0,
		    "i8259 cascade", NULL);
#endif
	return;
}


Perhaps something like the following would be a better solution:

static void __init
ppc4xx_init_IRQ(void)
{
	int i;

	ppc4xx_pic_init();

	for (i = 0; i < NR_IRQS; i++)
		irq_desc[i].handler = ppc4xx_pic;
#if defined(CONFIG_IRQ_FIXUP)
         board_fixup_irq();
#endif

	return;
}

Which is the way to go?


Dave


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
