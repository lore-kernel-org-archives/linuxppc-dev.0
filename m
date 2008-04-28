Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18453.24013.647603.723185@cargo.ozlabs.ibm.com>
Date: Mon, 28 Apr 2008 15:17:01 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Add IRQSTACKS support on ppc32
In-Reply-To: <Pine.LNX.4.64.0804240814280.29846@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0804240814280.29846@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> * Added allocation and initialization of the irq stacks.  We limit the
>   stacks to be in lowmem for ppc32.
> * Implemented ppc32 versions of call_do_softirq() and call_handle_irq()
>   to switch the stack pointers
> * Reworked how we do stack overflow detection.  We now keep around the
>   limit of the stack in the thread_struct and compare against the limit
>   to see if we've overflowed.  We can now use this on ppc64 if desired.

Mostly looks great.  One minor nit is that this ifdef could disappear
entirely now:

> @@ -352,7 +356,7 @@ void __init init_IRQ(void)
>  {
>  	if (ppc_md.init_IRQ)
>  		ppc_md.init_IRQ();
> -#ifdef CONFIG_PPC64
> +#ifdef CONFIG_IRQSTACKS
>  	irq_ctx_init();
>  #endif

Since it looks pretty much exactly like what 64-bit already does, and
it's under a config option, I withdraw my objection to it going into
2.6.26.

Paul.
