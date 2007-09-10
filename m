Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D097DDDE2E
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 05:43:35 +1000 (EST)
In-Reply-To: <20070905192910.GA32462@ld0162-tx32.am.freescale.net>
References: <20070905192910.GA32462@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EDF5D1CF-E423-449F-A435-9BD044206F4F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 02/10] cpm2: Fix off-by-one error in setbrg().
Date: Mon, 10 Sep 2007 14:46:21 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 5, 2007, at 2:29 PM, Scott Wood wrote:

> The hardware adds one to the BRG value to get the divider, so it must
> be subtracted by software.  Without this patch, characters will  
> occasionally
> be corrupted.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/sysdev/cpm2_common.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

What was this patch against?

I ended up applying it by hand for 2.6.23 since its fixing a bug..   
But, I'm wondering if there was a base set of changes this patchset  
was against?

- k

> diff --git a/arch/powerpc/sysdev/cpm2_common.c b/arch/powerpc/ 
> sysdev/cpm2_common.c
> index dbef50c..99ad1ed 100644
> --- a/arch/powerpc/sysdev/cpm2_common.c
> +++ b/arch/powerpc/sysdev/cpm2_common.c
> @@ -102,7 +102,7 @@ cpm_setbrg(uint brg, uint rate)
>  		brg -= 4;
>  	}
>  	bp += brg;
> -	out_be32(bp, ((BRG_UART_CLK / rate) << 1) | CPM_BRG_EN);
> +	out_be32(bp, (((BRG_UART_CLK / rate) - 1) << 1) | CPM_BRG_EN);
>
>  	cpm2_unmap(bp);
>  }
> -- 
> 1.5.3
