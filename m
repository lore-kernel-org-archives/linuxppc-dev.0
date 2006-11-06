Return-Path: <tnt@246tNt.com>
Message-ID: <454FC6B2.10909@246tNt.com>
Date: Tue, 07 Nov 2006 00:35:14 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Nicolas DET <nd@bplan-gmbh.de>
Subject: Re: [PATCH/RFC] powerpc: Add MPC5200 Interrupt Controller support.
References: <200611061103.kA6B3ADJ023943@post.webmailer.de>
In-Reply-To: <200611061103.kA6B3ADJ023943@post.webmailer.de>
Content-Type: text/plain;
	charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +
> +	/*
> +	 * Most of ours IRQs will be level low
> +	 * Only external IRQs on some platform may be others
> +	 */
> +	type = IRQ_TYPE_LEVEL_LOW;
>   
I've been wondering : Why LEVEL_LOW ?
Aren't they LEVEL_HIGH ?
(not that it changes much here ...)


> +
> +end:
> +	of_node_put(picnode);
> +	of_node_put(sdmanode);
>   
Is of_node_put specified as resilient to NULL argument ? (in the error
path, that could happen)

Also, I think "PANIC" would be appropriate in the error path. If we
can't init
the PIC properly we may as well give up ... It's not like we're going to
do much
without it ...


> +/* HW IRQ mapping */
> +#define MPC52xx_IRQ_L1_CRIT	(0)
> +#define MPC52xx_IRQ_L1_MAIN	(1)
> +#define MPC52xx_IRQ_L1_PERP	(2)
> +#define MPC52xx_IRQ_L1_SDMA	(3)
> +
> +#define MPC52xx_IRQ_L1_OFFSET   (6)
> +#define MPC52xx_IRQ_L1_MASK     (0xc0)
> +
> +#define MPC52xx_IRQ_L2_OFFSET   (0)
> +#define MPC52xx_IRQ_L2_MASK     (0x3f)
> +
> +#define MPC52xx_IRQ_HIGHTESTHWIRQ (0xd0)
> +
> +/* Interrupt controller Register set */
> +struct mpc52xx_intr {
> +	u32 per_mask;		/* INTR + 0x00 */
> +	u32 per_pri1;		/* INTR + 0x04 */
> +	u32 per_pri2;		/* INTR + 0x08 */
> +	u32 per_pri3;		/* INTR + 0x0c */
> +	u32 ctrl;		/* INTR + 0x10 */
> +	u32 main_mask;		/* INTR + 0x14 */
> +	u32 main_pri1;		/* INTR + 0x18 */
> +	u32 main_pri2;		/* INTR + 0x1c */
> +	u32 reserved1;		/* INTR + 0x20 */
> +	u32 enc_status;		/* INTR + 0x24 */
> +	u32 crit_status;	/* INTR + 0x28 */
> +	u32 main_status;	/* INTR + 0x2c */
> +	u32 per_status;		/* INTR + 0x30 */
> +	u32 reserved2;		/* INTR + 0x34 */
> +	u32 per_error;		/* INTR + 0x38 */
> +};
>   
When I said on IRC you could remerge them, I meant a little more
smartly than just 'join' them. i.e., put the mpc52xx_intr with all the
other register set at the very least ...



    Sylvain
