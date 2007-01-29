Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 07A79DE010
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 00:04:19 +1100 (EST)
Message-ID: <45BDEC5A.2020103@ru.mvista.com>
Date: Mon, 29 Jan 2007 15:45:14 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] ppc: ioremap() on PPC44x platforms now accepts 64bit
	addresses
References: <200701190906.09112.sr@denx.de>	<1169207845.28708.2.camel@crusty.rchland.ibm.com>
	<200701290942.10515.sr@denx.de>
In-Reply-To: <200701290942.10515.sr@denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Stefan Roese wrote:
> [PATCH] ppc: ioremap() on PPC44x platforms now accepts 64bit addresses

> On systems that supply a real 64bit address (with
> CONFIG_RESOURCES_64BIT enabled), don't use the fixup function. This
> allows us to use the fixup function when no ERPN is specified and use
> the 64 bit address when the ERPN is supplied.

> Signed-off-by: Stefan Roese <sr@denx.de>

[...]

> diff --git a/arch/ppc/mm/pgtable.c b/arch/ppc/mm/pgtable.c
> index 354a940..2f9a311 100644
> --- a/arch/ppc/mm/pgtable.c
> +++ b/arch/ppc/mm/pgtable.c
> @@ -156,9 +156,19 @@ ioremap64(unsigned long long addr, unsigned long size)
>  void __iomem *
>  ioremap(phys_addr_t addr, unsigned long size)
>  {
> -	phys_addr_t addr64 = fixup_bigphys_addr(addr, size);
> -
> -	return ioremap64(addr64, size);
> +	/*
> +	 * On systems that supply a real 64bit address
> +	 * (with CONFIG_RESOURCES_64BIT enabled), don't use the
> +	 * fixup function.
> +	 * This allows us to use the fixup function when no ERPN
> +	 * is specified and use the 64 bit address when the ERPN
> +	 * is suppied.
> +	 */
> +	if ((unsigned long long)addr & 0xffffffff00000000ULL)
> +		return ioremap64(addr, size);

    I'm sorry but is this actually needed? From looking at the 
arch/ppc/syslib/ibm44x_common.c and include/asm-ppc/ibm44x.h I got an 
impression that fixup_bigphys_addr() returns addresses >= 4GB intact anyway

> +	else
> +		return ioremap64(fixup_bigphys_addr(addr, size),
> +				 size);
>  }
>  #endif /* CONFIG_PHYS_64BIT */

WBR, Sergei
