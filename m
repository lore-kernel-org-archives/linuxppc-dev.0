Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 14AE1B7C98
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2010 13:40:13 +1100 (EST)
Subject: Re: [PATCH] powerpc/40x: Add support for PPC40x boards with >
	512MB SDRAM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <1265810099-31355-1-git-send-email-sr@denx.de>
References: <1265810099-31355-1-git-send-email-sr@denx.de>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 11 Feb 2010 13:39:56 +1100
Message-ID: <1265855996.16346.7.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-02-10 at 14:54 +0100, Stefan Roese wrote:
> This patch adds support for boards with more that 512MByte RAM. Currently
> only 512MB of memory are enabled in the DCCR/ICCR real-mode cache
> control registers. This patch now enables caching in real-mode for
> 2GByte.

Should we make that conditional to how much memory is populated ? Or it
doesn't matter ? I suppose we don't do IO accesses in real mode anyways
so no big deal...

Cheers,
Ben.

> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/40x_mmu.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/mm/40x_mmu.c b/arch/powerpc/mm/40x_mmu.c
> index 08dfa8e..65abfcf 100644
> --- a/arch/powerpc/mm/40x_mmu.c
> +++ b/arch/powerpc/mm/40x_mmu.c
> @@ -84,8 +84,8 @@ void __init MMU_init_hw(void)
>  	 * vectors and the kernel live in real-mode.
>  	 */
>  
> -        mtspr(SPRN_DCCR, 0xF0000000);	/* 512 MB of data space at 0x0. */
> -        mtspr(SPRN_ICCR, 0xF0000000);	/* 512 MB of instr. space at 0x0. */
> +        mtspr(SPRN_DCCR, 0xFFFF0000);	/* 2GByte of data space at 0x0. */
> +        mtspr(SPRN_ICCR, 0xFFFF0000);	/* 2GByte of instr. space at 0x0. */
>  }
>  
>  #define LARGE_PAGE_SIZE_16M	(1<<24)
