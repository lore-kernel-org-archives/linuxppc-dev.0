Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 30372DDE02
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 06:08:09 +1000 (EST)
Date: Thu, 30 Aug 2007 02:09:07 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/9] cpm2: Fix off-by-one error in setbrg().
Message-ID: <20070830020907.59052c67@localhost.localdomain>
In-Reply-To: <20070828201921.GB24329@ld0162-tx32.am.freescale.net>
References: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
	<20070828201921.GB24329@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 28 Aug 2007 15:19:21 -0500
Scott Wood wrote:

> The hardware adds one to the BRG value to get the divider, so it must
> be subtracted by software.

Prolly a note why it used to work, or what exactly this is resulting in the code. IIRC this was
just fw-ported so arch/ppc should have this as well.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/sysdev/cpm2_common.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/cpm2_common.c
> b/arch/powerpc/sysdev/cpm2_common.c index dbef50c..99ad1ed 100644
> --- a/arch/powerpc/sysdev/cpm2_common.c
> +++ b/arch/powerpc/sysdev/cpm2_common.c
> @@ -102,7 +102,7 @@ cpm_setbrg(uint brg, uint rate)
>  		brg -= 4;
>  	}
>  	bp += brg;
> -	out_be32(bp, ((BRG_UART_CLK / rate) << 1) | CPM_BRG_EN);
> +	out_be32(bp, (((BRG_UART_CLK / rate) - 1) << 1) |
> CPM_BRG_EN); 
>  	cpm2_unmap(bp);
>  }


-- 
Sincerely, Vitaly
