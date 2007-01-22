Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17844.35471.554647.189851@cargo.ozlabs.ibm.com>
Date: Mon, 22 Jan 2007 20:57:35 +1100
From: Paul Mackerras <paulus@samba.org>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: [PATCH 1/5] [POWERPC] cpm2: CPM2 interrupt controller fix
In-Reply-To: <20070113004150.1224.58427.stgit@localhost.localdomain>
References: <20070113004150.1224.58427.stgit@localhost.localdomain>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vitaly Bordug writes:

> This contains important fixes for the CPM2 PIC code. Eliminated
> CPM_IRQ_OFFSET, pulling the respective interrupt numbers from the interrupt
> mapping. Updated devicetree files to reflect that. Changed direct
> IC-related IO accesses to the IO accessors. Fixed all the sense values to
> keep coherency with ipic. In the current code, CPM2 stuff will have no IRQs
> and hence could be hardly usable.

You seem to be adding significant stuff; include/asm-powerpc/mpc8260.h
is new, and there is this hunk in your patch 4/5:

> diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
> index 507d1b9..f750212 100644
> --- a/arch/powerpc/platforms/Makefile
> +++ b/arch/powerpc/platforms/Makefile
> @@ -8,6 +8,7 @@ endif
>  obj-$(CONFIG_PPC_MPC52xx)	+= 52xx/
>  obj-$(CONFIG_PPC_CHRP)		+= chrp/
>  obj-$(CONFIG_4xx)		+= 4xx/
> +obj-$(CONFIG_PPC_82xx)		+= 82xx/

Also, this stuff seems to be used on 85xx, and I have not heard from
Kumar or anyone else working on 85xx as to how these changes are going
to affect 85xx.  So I'm sorry, but I'm not pushing these changes in
for 2.6.20.

Also, with the changes like this one:

> -	irq_nr -= CPM_IRQ_OFFSET;
> +	unsigned int irq_nr = (unsigned int)irq_map[irq].hwirq;

you should probably use the virq_to_hw() function defined in
include/asm-powerpc/irq.h, and you should definitely lose the
unnecessary (unsigned int) cast.

> +#ifndef _ISA_MEM_BASE
> +#define _ISA_MEM_BASE   0
> +#endif
> +
> +#ifndef PCI_DRAM_OFFSET
> +#define PCI_DRAM_OFFSET 0
> +#endif

Why do we need to have these things defined in mpc8260.h?  Shouldn't
we get the correct definition from io.h?

Paul.
