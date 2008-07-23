Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 84C51DDF00
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 00:29:40 +1000 (EST)
Date: Wed, 23 Jul 2008 16:23:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Luis Machado <luisgpm@linux.vnet.ibm.com>
Subject: Re: [RFC] 4xx hardware watchpoint support
Message-ID: <20080723142335.GA22767@lst.de>
References: <1211391577.6232.15.camel@gargoyle>
	<18484.60888.981390.893747@cargo.ozlabs.ibm.com>
	<1213992894.6635.41.camel@gargoyle>
	<20080719093752.5aada45c@zod.rchland.ibm.com>
	<1216658194.5727.36.camel@gargoyle>
	<20080721130551.23a06006@zod.rchland.ibm.com>
	<1216777678.5727.82.camel@gargoyle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1216777678.5727.82.camel@gargoyle>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 22, 2008 at 10:47:58PM -0300, Luis Machado wrote:
> +void do_dabr(struct pt_regs *regs, unsigned long address,
> +		    unsigned long error_code)
> +{
> +	siginfo_t info;
> +
> +#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
> +	if (notify_die(DIE_DABR_MATCH, "dabr_match", regs, error_code,
> +			11, SIGSEGV) == NOTIFY_STOP)
> +		return;
> +
> +	if (debugger_dabr_match(regs))
> +		return;
> +
> +	/* Clear the DAC and struct entries.  One shot trigger.  */
> +#else /* (defined(CONFIG_4xx) || defined(CONFIG_BOOKE)) */
> +	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~(DBSR_DAC1R | DBSR_DAC1W
> +							| DBCR0_IDM));
> +#endif

Some comment, first the above negate conditional
looks rather ugly, I'd rather do a

#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
	dbcr0 case
#else
	dabr case
#endif

second I wonder why we have the notify_die only for one case, that seems
rather odd.  Looking further the notify_die is even more odd because
DIE_DABR_MATCH doesn't actually appear anywhere else in the kernel.
I'd suggest simply removing it.

> +	/* For processors using DABR (i.e. 970), the bottom 3 bits are flags.
> +	   It was assumed, on previous implementations, that 3 bits were
> +	   passed together with the data address, fitting the design of the
> +	   DABR register, as follows:
> +
> +	   bit 0: Read flag
> +	   bit 1: Write flag
> +	   bit 2: Breakpoint translation
> +
> +	   Thus, we use them here as so.  */

Can you redo this in the normal Linux comment style, ala:

	/*
	 * For processors using DABR (i.e. 970), the bottom 3 bits are flags.
	 *  It was assumed, on previous implementations, that 3 bits were
	 *  passed together with the data address, fitting the design of the
	 *  DABR register, as follows:
	 *
	 *  bit 0: Read flag
	 *  bit 1: Write flag
	 *  bit 2: Breakpoint translation
	 *
	 *  Thus, we use them here as so.
	 */

and similar in few other places.
