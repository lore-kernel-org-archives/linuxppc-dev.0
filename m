Date: Tue, 16 Mar 2004 09:13:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Adrian Cox <adrian@humboldt.co.uk>,
	Paul Mackerras <paulus@samba.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] openpic_hookup_cascade in linuxppc_2_5
Message-ID: <20040316161329.GI14221@smtp.west.cox.net>
References: <1079446844.1677.250.camel@newt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1079446844.1677.250.camel@newt>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Mar 16, 2004 at 02:20:45PM +0000, Adrian Cox wrote:

>
> This patch ports the openpic_hookup_cascade() function from 2_4_devel,
> as it is necessary for the Sandpoint X2. In doing this I have to change
> almost every user of openpic_init.
>
> pmac needs no changes.
> chrp, lopec, mcpn765, pplus, prep, and sandpoint need simple changes.
>
> But some of the platforms don't use the new, single argument, form of
> openpic_init(). Thus, the following are already broken in 2.5: gemini,
> mvme5100, powerpmc250, prmpm750, and prpmc800. I don't have any of these
> platforms, so my patch doesn't touch them.

As an aside, either your mailer or editor (or c&p'ing :)) is giving
funky spacing on your changes, please fix.

As for openpic_hookup_cascade, when I introduced this way back when,
Paul didn't think it was the best fix for (at the time) 2.5.  Paul, what
do you think about this change ?

> diff -Nru a/arch/ppc/platforms/chrp_setup.c b/arch/ppc/platforms/chrp_setup.c
> --- a/arch/ppc/platforms/chrp_setup.c	Tue Mar 16 14:15:02 2004
> +++ b/arch/ppc/platforms/chrp_setup.c	Tue Mar 16 14:15:02 2004
> @@ -407,6 +407,7 @@
>  	OpenPIC_NumInitSenses = NR_IRQS - NUM_8259_INTERRUPTS;
>
>  	openpic_init(NUM_8259_INTERRUPTS);
> +        openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade", &i8259_irq);
>
>  	for (i = 0; i < NUM_8259_INTERRUPTS; i++)
>  		irq_desc[i].handler = &i8259_pic;
> diff -Nru a/arch/ppc/platforms/lopec_setup.c b/arch/ppc/platforms/lopec_setup.c
> --- a/arch/ppc/platforms/lopec_setup.c	Tue Mar 16 14:15:02 2004
> +++ b/arch/ppc/platforms/lopec_setup.c	Tue Mar 16 14:15:02 2004
> @@ -208,6 +208,7 @@
>  	openpic_set_sources(19, 1, OpenPIC_Addr + 0x110C0);
>
>  	openpic_init(NUM_8259_INTERRUPTS);
> +        openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade", &i8259_irq);
>
>  	/* Map i8259 interrupts */
>  	for(i = 0; i < NUM_8259_INTERRUPTS; i++)
> diff -Nru a/arch/ppc/platforms/mcpn765_setup.c b/arch/ppc/platforms/mcpn765_setup.c
> --- a/arch/ppc/platforms/mcpn765_setup.c	Tue Mar 16 14:15:02 2004
> +++ b/arch/ppc/platforms/mcpn765_setup.c	Tue Mar 16 14:15:02 2004
> @@ -247,6 +247,7 @@
>  		ppc_md.progress("init_irq: enter", 0);
>
>  	openpic_init(NUM_8259_INTERRUPTS);
> +        openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade", &i8259_irq);
>
>  	for(i=0; i < NUM_8259_INTERRUPTS; i++)
>  		irq_desc[i].handler = &i8259_pic;
> diff -Nru a/arch/ppc/platforms/pplus.c b/arch/ppc/platforms/pplus.c
> --- a/arch/ppc/platforms/pplus.c	Tue Mar 16 14:15:02 2004
> +++ b/arch/ppc/platforms/pplus.c	Tue Mar 16 14:15:02 2004
> @@ -672,6 +672,8 @@
>
>  		openpic_set_sources(0, 16, OpenPIC_Addr + 0x10000);
>  		openpic_init(NUM_8259_INTERRUPTS);
> +                openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
> +                                       &i8259_irq);
>  		ppc_md.get_irq = openpic_get_irq;
>  	}
>
> diff -Nru a/arch/ppc/platforms/prep_setup.c b/arch/ppc/platforms/prep_setup.c
> --- a/arch/ppc/platforms/prep_setup.c	Tue Mar 16 14:15:02 2004
> +++ b/arch/ppc/platforms/prep_setup.c	Tue Mar 16 14:15:02 2004
> @@ -854,8 +854,11 @@
>  	int i;
>  	unsigned int pci_viddid, pci_did;
>
> -	if (OpenPIC_Addr != NULL)
> +	if (OpenPIC_Addr != NULL) {
>  		openpic_init(NUM_8259_INTERRUPTS);
> +                openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
> +                                       &i8259_irq);
> +        }
>  	for ( i = 0 ; i < NUM_8259_INTERRUPTS ; i++ )
>  		irq_desc[i].handler = &i8259_pic;
>  	/* If we have a Raven PCI bridge or a Hawk PCI bridge / Memory
> diff -Nru a/arch/ppc/platforms/sandpoint.c b/arch/ppc/platforms/sandpoint.c
> --- a/arch/ppc/platforms/sandpoint.c	Tue Mar 16 14:15:02 2004
> +++ b/arch/ppc/platforms/sandpoint.c	Tue Mar 16 14:15:02 2004
> @@ -444,6 +444,7 @@
>  	openpic_set_sources(0, 16, OpenPIC_Addr + 0x10200);
>
>  	openpic_init(NUM_8259_INTERRUPTS);
> +        openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade", &i8259_irq);
>
>  	/*
>  	 * openpic_init() has set up irq_desc[16-31] to be openpic
> diff -Nru a/arch/ppc/syslib/open_pic.c b/arch/ppc/syslib/open_pic.c
> --- a/arch/ppc/syslib/open_pic.c	Tue Mar 16 14:15:02 2004
> +++ b/arch/ppc/syslib/open_pic.c	Tue Mar 16 14:15:02 2004
> @@ -48,6 +48,8 @@
>  static u_int NumSources;
>  static int open_pic_irq_offset;
>  static volatile OpenPIC_Source *ISR[NR_IRQS];
> +static int openpic_cascade_irq = -1;
> +static int (*openpic_cascade_fn)(struct pt_regs *);
>
>  /* Global Operations */
>  static void openpic_disable_8259_pass_through(void);
> @@ -417,12 +419,6 @@
>  	if (ppc_md.progress) ppc_md.progress("openpic: spurious",0x3bd);
>  	openpic_set_spurious(OPENPIC_VEC_SPURIOUS+offset);
>
> -	/* Initialize the cascade */
> -	if (offset) {
> -		if (request_irq(offset, no_action, SA_INTERRUPT,
> -				"82c59 cascade", NULL))
> -			printk("Unable to get OpenPIC IRQ 0 for cascade\n");
> -	}
>  	openpic_disable_8259_pass_through();
>  #ifdef CONFIG_EPIC_SERIAL_MODE
>  	openpic_eicr_set_clk(7);	/* Slowest value until we know better */
> @@ -682,6 +678,19 @@
>   *
>   */
>
> +/*
> + * Hookup a cascade to the OpenPIC.
> + */
> +void __init
> +openpic_hookup_cascade(u_int irq, char *name,
> +	int (*cascade_fn)(struct pt_regs *))
> +{
> +	openpic_cascade_irq = irq;
> +	openpic_cascade_fn = cascade_fn;
> +	if (request_irq(irq, no_action, SA_INTERRUPT, name, NULL))
> +		printk("Unable to get OpenPIC IRQ %d for cascade\n",
> +				irq - open_pic_irq_offset);
> +}
>
>  /*
>   *  Enable/disable an external interrupt source
> @@ -841,13 +850,18 @@
>  	int irq = openpic_irq();
>
>  	/*
> -	 * This needs to be cleaned up.  We don't necessarily have
> -	 * an i8259 cascaded or even a cascade.
> +	 * Check for the cascade interrupt and call the cascaded
> +	 * interrupt controller function (usually i8259_irq) if so.
> +	 * This should move to irq.c eventually.  -- paulus
>  	 */
> -	if (open_pic_irq_offset && irq == open_pic_irq_offset) {
> -		/* Get the IRQ from the cascade. */
> -		irq = i8259_irq(regs);
> -		openpic_eoi();
> +	if (irq == openpic_cascade_irq && openpic_cascade_fn != NULL) {
> +		int cirq = openpic_cascade_fn(regs);
> +
> +		/* Allow for the cascade being shared with other devices */
> +		if (cirq != -1) {
> +			irq = cirq;
> +			openpic_eoi();
> +		}
>  	} else if (irq == OPENPIC_VEC_SPURIOUS + open_pic_irq_offset)
>  		irq = -1;
>  	return irq;
> diff -Nru a/include/asm-ppc/open_pic.h b/include/asm-ppc/open_pic.h
> --- a/include/asm-ppc/open_pic.h	Tue Mar 16 14:15:02 2004
> +++ b/include/asm-ppc/open_pic.h	Tue Mar 16 14:15:02 2004
> @@ -40,6 +40,8 @@
>  /* Exported functions */
>  extern void openpic_set_sources(int first_irq, int num_irqs, void *isr);
>  extern void openpic_init(int linux_irq_offset);
> +extern void openpic_hookup_cascade(u_int irq, char *name,
> +                                   int (*cascade_fn)(struct pt_regs *));
>  extern void openpic_init_nmi_irq(u_int irq);
>  extern u_int openpic_irq(void);
>  extern void openpic_eoi(void);
>
>

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
