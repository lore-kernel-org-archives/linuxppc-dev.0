Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CCF02DDE18
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 00:04:43 +1000 (EST)
In-Reply-To: <20070913152333.GA2381@localhost.localdomain>
References: <20070912112456.GA15556@localhost.localdomain>
	<20070913152333.GA2381@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C844988E-F6B9-44B9-AB78-C44E19A2E605@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] ucc_geth: fix compilation
Date: Fri, 14 Sep 2007 09:07:34 -0500
To: Jeff Garzik <jeff@garzik.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	netdev <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 13, 2007, at 10:23 AM, Anton Vorontsov wrote:

> Currently qe_bd_t is used in the macro call -- dma_unmap_single,
> which is a no-op on PPC32, thus error is hidden today. Starting
> with 2.6.24, macro will be replaced by the empty static function,
> and erroneous use of qe_bd_t will trigger compilation error.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---

Jeff, I'm going to pick this up via the powerpc.git tree since its  
currently only broken in our for-2.6.24 branch (because of other  
changes in there).  Any issues?

- k

>
> Reposting this to include netdev in Cc.
>
>  drivers/net/ucc_geth.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
> index 12e01b2..9a38dfe 100644
> --- a/drivers/net/ucc_geth.c
> +++ b/drivers/net/ucc_geth.c
> @@ -2148,7 +2148,7 @@ static void ucc_geth_memclean(struct  
> ucc_geth_private *ugeth)
>  		for (j = 0; j < ugeth->ug_info->bdRingLenTx[i]; j++) {
>  			if (ugeth->tx_skbuff[i][j]) {
>  				dma_unmap_single(NULL,
> -						 ((qe_bd_t *)bd)->buf,
> +						 ((struct qe_bd *)bd)->buf,
>  						 (in_be32((u32 *)bd) &
>  						  BD_LENGTH_MASK),
>  						 DMA_TO_DEVICE);
> -- 
> 1.5.0.6
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
