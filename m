Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 880EC1A008C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 14:37:03 +1000 (EST)
Message-ID: <1407213410.19150.65.camel@pasglop>
Subject: Re: [PATCH 2/2] powerpc/nohash: Split __early_init_mmu() into boot
 and secondary
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Tue, 05 Aug 2014 14:36:50 +1000
In-Reply-To: <1406948861-11322-2-git-send-email-scottwood@freescale.com>
References: <1406948861-11322-1-git-send-email-scottwood@freescale.com>
 <1406948861-11322-2-git-send-email-scottwood@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-08-01 at 22:07 -0500, Scott Wood wrote:

>  
> -void __init early_init_mmu(void)
> -{
> -	__early_init_mmu(1);
> -}
> -
>  void early_init_mmu_secondary(void)
>  {
> -	__early_init_mmu(0);
> +	early_init_mmu_allcpus();
>  }

Small nit, it took me 30s too long to figure out what you were doing due
to the naming above :)

Call the latter early_init_this_mmu() and keep the global one separate
such that early_init_mmu() does:

	early_init_mmu_common();
	early_init_this_mmu();

Cheers,
Ben.
