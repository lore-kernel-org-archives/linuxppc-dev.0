Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3AB5CDE02E
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 05:54:03 +1100 (EST)
Date: Wed, 9 Jan 2008 12:53:49 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix handling of memreserve if the range
	lands in highmem
Message-ID: <20080109185349.GC4337@loki.buserror.net>
References: <Pine.LNX.4.64.0801091127400.8069@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0801091127400.8069@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 09, 2008 at 11:28:30AM -0600, Kumar Gala wrote:
>  	/* reserve the sections we're already using */
> -	for (i = 0; i < lmb.reserved.cnt; i++)
> -		reserve_bootmem(lmb.reserved.region[i].base,
> -				lmb_size_bytes(&lmb.reserved, i));
> +	for (i = 0; i < lmb.reserved.cnt; i++) {
> +		unsigned long addr = lmb.reserved.region[i].base +
> +				     lmb_size_bytes(&lmb.reserved, i) - 1;
> +		if (addr < total_lowmem)
> +			reserve_bootmem(lmb.reserved.region[i].base,
> +					lmb_size_bytes(&lmb.reserved, i));
> +	}

It looks like if the reserved area straddles the highmem boundary, it'll
only reserve the highmem portion.

-Scott
