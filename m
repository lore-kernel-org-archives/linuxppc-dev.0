Date: Fri, 25 Oct 2002 17:15:46 +0200
Subject: Re: PrPMC800 interrupt problem
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
To: Tom Rini <trini@kernel.crashing.org>
From: Anders Blomdell <anders.blomdell@control.lth.se>
In-Reply-To: <20021024172642.GL669@opus.bloom.county>
Message-Id: <A347A662-E82C-11D6-A4F1-0003931C2BFA@control.lth.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The problem seems to be that the UART generates an Harrier internal
interrupt. This should be handled as any other MPIC interrupt, but it isn'
t. This lack of an appropriate handler (irq_desc[16].handler == 0) makes
the Harrier chip wait forever for an EOI.

A very hacky solution to this is to modify 'prpmc800_init_IRQ' to:

static void __init
prpmc800_init_IRQ(void)
{

   openpic_init(0);
   // Handle UART interrupts as all other openpic interrupts, this is a
   // gross hack.
   openpic_set_sources(16, 1, OpenPIC_Addr + 0x10200);
   irq_desc[16].handler = irq_desc[15].handler;

#define PRIORITY	15
#define VECTOR	 	16
#define PROCESSOR	0
	/* initialize the harrier's internal interrupt priority 15, irq 1 */
	out_be32((u32 *)HARRIER_IFEVP_REG, (PRIORITY<<16) | VECTOR);
	out_be32((u32 *)HARRIER_IFEDE_REG, (1<<PROCESSOR));

	/* enable functional exceptions for uarts and abort */
	out_8((u8 *)HARRIER_FEEN_REG, (HARRIER_FE_UA0|HARRIER_FE_UA1));
	out_8((u8 *)HARRIER_FEMA_REG, ~(HARRIER_FE_UA0|HARRIER_FE_UA1));
}


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
