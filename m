Message-ID: <3C750059.4080901@pacbell.net>
Date: Thu, 21 Feb 2002 14:12:41 +0000
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Patch to make ppc_md.progress useful on 4xx
References: <20020221005647.GA19976@zax> <3C740658.9060706@pacbell.net> <20020221042710.GA1658@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:
> On Wed, Feb 20, 2002 at 08:26:00PM +0000, Armin wrote:
>
>>David Gibson wrote:
>>
>>>Currently, ppc_md.progress on 4xx just does a printk(), which means
>>>its messages won't be displayed until console_init() at which point
>>>it's usually too late to be useful.
>>>
>>>The patch below changes ppc4xx_progress() to write directly to the
>>>serial port.  I'd like to get comments before pushing the change,
>>>because I don't want to break 4xx machines that I don't have (and so
>>>can't test).
>>>
>>>At the moment it should only affect 405GP.  NP405H and NP405L support
>>>should be trivial (I've only refrained from adding it because I can't
>>>test it myself).  STBxxxx should be possible but will be much
>>>yuckier.  It would be nice to have it work on all 4xx though, to get
>>>rid of the nasty #ifdef in ppc4xx_setup.c.
>>>
>>What Patch?
>>
>>I can test on some of the boards
>>
>
> Ah, crud.  Forgot to attach it.  Ok, this time for sure.
>
> diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/head_4xx.S linux-grinch/arch/ppc/kernel/head_4xx.S
> --- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/head_4xx.S	Sun Jan 27 08:21:22 2002
> +++ linux-grinch/arch/ppc/kernel/head_4xx.S	Thu Feb 21 11:48:00 2002
> @@ -1051,6 +1051,26 @@
>
>  	tlbwe	r4,r0,TLB_DATA
>  	tlbwe	r3,r0,TLB_TAG
> +
> +#if defined(CONFIG_SERIAL_TEXT_DEBUG) && defined(SERIAL_DEBUG_IO_BASE)
> +
> +	/* Load a TLB entry for the UART, so that ppc4xx_progress() can use
> +	 * the UARTs nice and early.  We use a 4k real==virtual mapping. */
> +
> +	lis	r3,SERIAL_DEBUG_IO_BASE@h
> +	ori	r3,r3,SERIAL_DEBUG_IO_BASE@l
> +	mr	r4,r3
> +	clrrwi	r4,r4,12
> +	ori	r4,r4,(TLB_WR|TLB_I|TLB_M|TLB_G)
> +
> +	clrrwi	r3,r3,12
> +	ori	r3,r3,(TLB_VALID | TLB_PAGESZ(PAGESZ_4K))
> +
> +	li	r0,0			/* TLB slot 0 */
> +	tlbwe	r4,r0,TLB_DATA
> +	tlbwe	r3,r0,TLB_TAG
> +#endif /* CONFIG_SERIAL_DEBUG_TEXT && SERIAL_DEBUG_IO_BASE */
> +
>  	isync
>
>  	/* Establish the exception vector base
> diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/ppc4xx_setup.c linux-grinch/arch/ppc/kernel/ppc4xx_setup.c
> --- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/ppc4xx_setup.c	Fri Feb  8 04:51:16 2002
> +++ linux-grinch/arch/ppc/kernel/ppc4xx_setup.c	Thu Feb 21 11:45:40 2002
> @@ -248,13 +248,36 @@
>  	mtspr(SPRN_PIT, tb_ticks_per_jiffy);
>  }
>
> -#ifdef CONFIG_DEBUG_TEXT
> +#ifdef CONFIG_SERIAL_TEXT_DEBUG
> +
> +/* We assume that the UART has already been initialized by the
> +   firmware or the boot loader */
>  static void
> -ppc4xx_progress(char *s, unsigned short hex)
> +serial_putc(u8 *com_port, unsigned char c)
>  {
> -	printk("%s\n\r", s);
> +	while ((readb(com_port + (UART_LSR)) & UART_LSR_THRE) == 0)
> +		;
> +	writeb(c, com_port);
>  }
> +
> +
> +static void
> +ppc4xx_progress(char *s, unsigned short hex)
> +{
> +	char c;
> +#ifdef SERIAL_DEBUG_IO_BASE
> +	u8 *com_port = (u8 *)SERIAL_DEBUG_IO_BASE;
> +
> +	while ((c = *s++) != '\0') {
> +		serial_putc(com_port, c);
> +	}
> +	serial_putc(com_port, '\r');
> +	serial_putc(com_port, '\n');
> +#else
> +	printk("%s\r\n");
>  #endif
> +}
> +#endif /* CONFIG_SERIAL_TEXT_DEBUG */
>
>  /*
>   * IDE stuff.
> @@ -381,7 +404,7 @@
>  	ppc_md.find_end_of_memory = ppc4xx_find_end_of_memory;
>  	ppc_md.setup_io_mappings = m4xx_map_io;
>
> -#ifdef CONFIG_DEBUG_TEXT
> +#ifdef CONFIG_SERIAL_TEXT_DEBUG
>  	ppc_md.progress = ppc4xx_progress;
>  #endif
>
> diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/ibm405gp.h linux-grinch/arch/ppc/platforms/ibm405gp.h
> --- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/platforms/ibm405gp.h	Fri Feb 15 11:27:58 2002
> +++ linux-grinch/arch/ppc/platforms/ibm405gp.h	Thu Feb 21 11:44:58 2002
> @@ -88,8 +88,8 @@
>  #define UART1_INT	1
>
>  #define PCIL0_BASE	0xEF400000
> -#define UART0_IO_BASE	(u8 *) 0xEF600300
> -#define UART1_IO_BASE	(u8 *) 0xEF600400
> +#define UART0_IO_BASE	0xEF600300
> +#define UART1_IO_BASE	0xEF600400
>  #define IIC0_BASE	0xEF600500
>  #define OPB0_BASE	0xEF600600
>  #define GPIO0_BASE	0xEF600700
> @@ -102,16 +102,18 @@
>  #define STD_UART_OP(num)					\
>  	{ 0, BASE_BAUD, 0, UART##num##_INT,			\
>  		(ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST),	\
> -		iomem_base: UART##num##_IO_BASE,		\
> +		iomem_base: (u8 *)UART##num##_IO_BASE,		\
>  		io_type: SERIAL_IO_MEM},
>
>  #if defined(CONFIG_UART0_TTYS0)
> +#define SERIAL_DEBUG_IO_BASE	UART0_IO_BASE
>  #define SERIAL_PORT_DFNS	\
>  	STD_UART_OP(0)		\
>  	STD_UART_OP(1)
>  #endif
>
>  #if defined(CONFIG_UART0_TTYS1)
> +#define SERIAL_DEBUG_IO_BASE	UART1_IO_BASE
>  #define SERIAL_PORT_DFNS	\
>  	STD_UART_OP(1)		\
>  	STD_UART_OP(0)
>
>
> --
> David Gibson			| For every complex problem there is a
> david@gibson.dropbear.id.au	| solution which is simple, neat and
> 				| wrong.  -- H.L. Mencken
> http://www.ozlabs.org/people/dgibson
>
>
>
>
>

David,

It works on a walnut, ceder & ash but not on the redwoods.it hangs.

I will look at it later

--armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
