Return-Path: <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] ppc: ioremap() on PPC44x platforms now accepts 64bit
	addresses
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200701190906.09112.sr@denx.de>
References: <200701190906.09112.sr@denx.de>
Content-Type: text/plain
Date: Fri, 19 Jan 2007 05:57:25 -0600
Message-Id: <1169207845.28708.2.camel@crusty.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-01-19 at 09:05 +0100, Stefan Roese wrote:
> [PATCH] ppc: ioremap() on PPC44x platforms now accepts 64bit addresses
> 
> On systems that supply a real 64bit address (with
> CONFIG_RESOURCES_64BIT enabled), don't use the fixup function. This
> allows us to use the fixup function when no ERPN is specified and use
> the 64 bit address when the ERPN is supplied.

Good idea.



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
> +	if ((unsigned long long)addr && 0xffffffff00000000ULL)
> +		return ioremap64(addr, size);

Erm... don't you want:

addr & 0xffffffff00000000ULL

What you have now is a logical and that will likely result in it always
being true...

josh
