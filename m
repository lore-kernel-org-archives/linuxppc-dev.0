Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B45B6DDE3F
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 01:27:46 +1100 (EST)
In-Reply-To: <45C86715.6090600@freescale.com>
References: <45C86715.6090600@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <001EB06E-FC1D-4F0A-A910-8E08EE0B8CE2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/4] ucc_geth: Change private immrbar_virt_to_phys to
	generic iopa
Date: Tue, 6 Feb 2007 08:26:50 -0600
To: Li Yang <leoli@freescale.com>
Cc: netdev@vger.kernel.org, jeff@garzik.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 6, 2007, at 5:31 AM, Li Yang wrote:

> Get rid of private immrbar_virt_to_phys() routine and
> use generic iopa().

Nack. iopa() isn't that generic, shouldn't we really be using the dma  
mapping API here?

- k

>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> drivers/net/ucc_geth.c |   29 ++++++-----------------------
> 1 files changed, 6 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
> index 7e4b23c..722a89f 100644
> --- a/drivers/net/ucc_geth.c
> +++ b/drivers/net/ucc_geth.c
> @@ -3065,21 +3065,11 @@ static int ucc_geth_startup(struct  
> ucc_geth_private *ugeth)
> 		endOfRing =
> 		    ugeth->p_tx_bd_ring[i] + (ug_info->bdRingLenTx[i] -
> 					      1) * sizeof(struct qe_bd);
> -		if (ugeth->ug_info->uf_info.bd_mem_part == MEM_PART_SYSTEM) {
> -			out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].bd_ring_base,
> -				 (u32) virt_to_phys(ugeth->p_tx_bd_ring[i]));
> -			out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].
> +		out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].bd_ring_base,
> +				iopa((unsigned long)ugeth->p_tx_bd_ring[i]));
> +		out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].
> 				 last_bd_completed_address,
> -				 (u32) virt_to_phys(endOfRing));
> -		} else if (ugeth->ug_info->uf_info.bd_mem_part ==
> -			   MEM_PART_MURAM) {
> -			out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].bd_ring_base,
> -				 (u32) immrbar_virt_to_phys(ugeth->
> -							    p_tx_bd_ring[i]));
> -			out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].
> -				 last_bd_completed_address,
> -				 (u32) immrbar_virt_to_phys(endOfRing));
> -		}
> +				iopa((unsigned long)endOfRing));
> 	}
> 	/* schedulerbasepointer */
> @@ -3331,15 +3321,8 @@ static int ucc_geth_startup(struct  
> ucc_geth_private *ugeth)
> 	/* Setup the table */
> 	/* Assume BD rings are already established */
> 	for (i = 0; i < ug_info->numQueuesRx; i++) {
> -		if (ugeth->ug_info->uf_info.bd_mem_part == MEM_PART_SYSTEM) {
> -			out_be32(&ugeth->p_rx_bd_qs_tbl[i].externalbdbaseptr,
> -				 (u32) virt_to_phys(ugeth->p_rx_bd_ring[i]));
> -		} else if (ugeth->ug_info->uf_info.bd_mem_part ==
> -			   MEM_PART_MURAM) {
> -			out_be32(&ugeth->p_rx_bd_qs_tbl[i].externalbdbaseptr,
> -				 (u32) immrbar_virt_to_phys(ugeth->
> -							    p_rx_bd_ring[i]));
> -		}
> +		out_be32(&ugeth->p_rx_bd_qs_tbl[i].externalbdbaseptr,
> +			 iopa((unsigned long)ugeth->p_rx_bd_ring[i]));
> 		/* rest of fields handled by QE */
> 	}
>
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
