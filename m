Date: Tue, 23 Dec 2003 08:51:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Josh Boyer <jwboyer@charter.net>
Cc: linuxppc-dev@lists.linuxppc.org,
	linuxpcc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] 2.6.0 compile fix for non 6xx machines
Message-ID: <20031223155134.GD26574@stop.crashing.org>
References: <1071790169.26979.18.camel@yoda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1071790169.26979.18.camel@yoda>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Dec 18, 2003 at 06:27:12PM -0600, Josh Boyer wrote:

>
> Hi,
>
> Don't know if this is fixed in the ppc trees or not so I'll send my
> patch anyway.  I got a link error when compiling the 2.6.0 kernel for
> the PPC 405 walnut board.  It appears it's because
> arch/ppc/kernel/ppc_ksyms.c does:
>
> extern long mol_trampoline;
> EXPORT_SYMBOL(mol_trampoline);
>
> mol_trampoline is only defined in arch/ppc/kernel/head.S.  Since the
> other head_Nxx.S files are used for non-6xx compiles it can't link.
> Below is a patch to fix the compile failure.
>
> Josh
>
> diff -Naur linux-2.6.0.orig/arch/ppc/kernel/ppc_ksyms.c
> linux-2.6.0/arch/ppc/kernel/ppc_ksyms.c
> --- linux-2.6.0.orig/arch/ppc/kernel/ppc_ksyms.c	2003-12-17
> 20:59:37.000000000 -0600
> +++ linux-2.6.0/arch/ppc/kernel/ppc_ksyms.c	2003-12-18
> 17:21:52.000000000 -0600
> @@ -367,8 +367,10 @@
>  EXPORT_SYMBOL(set_context);
>  EXPORT_SYMBOL(handle_mm_fault); /* For MOL */
>  EXPORT_SYMBOL_NOVERS(disarm_decr);
> +#ifdef CONFIG_6xx
>  extern long mol_trampoline;
>  EXPORT_SYMBOL(mol_trampoline); /* For MOL */
> +#endif
>  #ifdef CONFIG_PPC_STD_MMU
>  EXPORT_SYMBOL(flush_hash_pages); /* For MOL */
>  #ifdef CONFIG_SMP

It should actually go under PPC_STD_MMU, and I've got this fixed over in
http://stop.crashing.org:16080/~trini/, hopefully I can get some of
these patches into -mm now.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
