Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJvqR21KgzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2017 21:45:23 +1100 (AEDT)
Subject: Re: [PATCH 1/2] net: ethernet: ucc_geth: fix MEM_PART_MURAM mode
To: Li Yang <leoli@freescale.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 Scott Wood <oss@buserror.net>, "David S. Miller" <davem@davemloft.net>
References: <cover.1486456900.git.christophe.leroy@c-s.fr>
 <d25ee7a13b60dcd005c59169feacb18fb69a06c1.1486456900.git.christophe.leroy@c-s.fr>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <4ef41972-0cd1-525f-dbb2-95b3be007b93@c-s.fr>
Date: Thu, 9 Feb 2017 11:45:17 +0100
MIME-Version: 1.0
In-Reply-To: <d25ee7a13b60dcd005c59169feacb18fb69a06c1.1486456900.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: David S. Miller <davem@davemloft.net>

Le 07/02/2017 à 10:05, Christophe Leroy a écrit :
> Since commit 5093bb965a163 ("powerpc/QE: switch to the cpm_muram
> implementation"), muram area is not part of immrbar mapping anymore
> so immrbar_virt_to_phys() is not usable anymore.
>
> Fixes: 5093bb965a163 ("powerpc/QE: switch to the cpm_muram implementation)
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  drivers/net/ethernet/freescale/ucc_geth.c | 8 +++-----
>  include/soc/fsl/qe/qe.h                   | 1 +
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
> index 3f7ae9f..f77ba9f 100644
> --- a/drivers/net/ethernet/freescale/ucc_geth.c
> +++ b/drivers/net/ethernet/freescale/ucc_geth.c
> @@ -2594,11 +2594,10 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
>  		} else if (ugeth->ug_info->uf_info.bd_mem_part ==
>  			   MEM_PART_MURAM) {
>  			out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].bd_ring_base,
> -				 (u32) immrbar_virt_to_phys(ugeth->
> -							    p_tx_bd_ring[i]));
> +				 (u32)qe_muram_dma(ugeth->p_tx_bd_ring[i]));
>  			out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].
>  				 last_bd_completed_address,
> -				 (u32) immrbar_virt_to_phys(endOfRing));
> +				 (u32)qe_muram_dma(endOfRing));
>  		}
>  	}
>
> @@ -2844,8 +2843,7 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
>  		} else if (ugeth->ug_info->uf_info.bd_mem_part ==
>  			   MEM_PART_MURAM) {
>  			out_be32(&ugeth->p_rx_bd_qs_tbl[i].externalbdbaseptr,
> -				 (u32) immrbar_virt_to_phys(ugeth->
> -							    p_rx_bd_ring[i]));
> +				 (u32)qe_muram_dma(ugeth->p_rx_bd_ring[i]));
>  		}
>  		/* rest of fields handled by QE */
>  	}
> diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
> index 70339d7..0cd4c1147 100644
> --- a/include/soc/fsl/qe/qe.h
> +++ b/include/soc/fsl/qe/qe.h
> @@ -243,6 +243,7 @@ static inline int qe_alive_during_sleep(void)
>  #define qe_muram_free cpm_muram_free
>  #define qe_muram_addr cpm_muram_addr
>  #define qe_muram_offset cpm_muram_offset
> +#define qe_muram_dma cpm_muram_dma
>
>  #define qe_setbits32(_addr, _v) iowrite32be(ioread32be(_addr) |  (_v), (_addr))
>  #define qe_clrbits32(_addr, _v) iowrite32be(ioread32be(_addr) & ~(_v), (_addr))
>
