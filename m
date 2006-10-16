Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7AD3267C2B
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Oct 2006 14:51:38 +1000 (EST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id k9G4xnAu025631
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Oct 2006 23:59:50 -0500
Subject: Re: [PATCH 1/5] powerpc: consolidate feature fixup code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
In-Reply-To: <1160726663.4792.222.camel@localhost.localdomain>
References: <1160726663.4792.222.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 14:51:26 +1000
Message-Id: <1160974286.22522.37.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-10-13 at 18:04 +1000, Benjamin Herrenschmidt wrote:
>  
> Index: linux-cell/include/asm-powerpc/system.h
> ===================================================================
> --- linux-cell.orig/include/asm-powerpc/system.h        2006-10-06 13:48:24.000000000 +1000
> +++ linux-cell/include/asm-powerpc/system.h     2006-10-13 16:24:45.000000000 +1000
> @@ -378,7 +378,11 @@ extern unsigned long reloc_offset(void);
>  extern unsigned long add_reloc_offset(unsigned long);
>  extern void reloc_got2(unsigned long);
>  
> +#ifdef CONFIG_PPC64
> +#define PTRRELOC(x)    x
> +#else
>  #define PTRRELOC(x)    ((typeof(x)) add_reloc_offset((unsigned long)(x)))
> +#endif
>  
>  static inline void create_instruction(unsigned long addr, unsigned int instr)
>  {

And of course that bit of the patch is a stupid "optimisation" that
breaks prom_init.c on ppc64... I'll post a new patch without it and do
more tests (damn, I tested iSeries and figured if it worked there, it
would work everywhere :)

Ben.
