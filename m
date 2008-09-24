Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5A2E3DDF6F
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 00:05:08 +1000 (EST)
Message-Id: <B38CBE3A-B9DA-44BA-8646-AEE81FB82437@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1222262654.4257.4.camel@johannes.berg>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: enforce sane MAX_ORDER
Date: Wed, 24 Sep 2008 09:05:01 -0500
References: <1222262654.4257.4.camel@johannes.berg>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 24, 2008, at 8:24 AM, Johannes Berg wrote:

> powerpc uses CONFIG_FORCE_MAX_ZONEORDER, and some things depend on it
> being at least 10 when 64k pages are not configured (notably the dart
> iommu code with CONFIG_PM). The defaults are fine, but when going  
> from a
> 64K pages config to one without 64K pages, MAX_ORDER stays at 9  
> which is
> too low for 4K pages.
>
> This patch makes the Kconfig enforce at least the defaults, I used 999
> as the upper bound for no particular reason other than that it's  
> plenty.
>
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> ---
>
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -415,8 +415,11 @@ config PPC_64K_PAGES
>
> config FORCE_MAX_ZONEORDER
> 	int "Maximum zone order"
> +	range 9 999 if PPC_64K_PAGES
> 	default "9" if PPC_64K_PAGES
> +	range 13 999 if PPC64 && !PPC_64K_PAGES
> 	default "13" if PPC64 && !PPC_64K_PAGES
> +	range 11 999
> 	default "11"
> 	help
> 	  The kernel memory allocator divides physically contiguous memory

Hope about setting the upper bound to 32 or 64.  Since I believe this  
in effect 2^FORCE_MAX_ZONEORDER, so 999 is just insane.  I'd almost  
prefer something like 16 since that might still be in the realm of  
reasonable and able to work.

- k
