Return-Path: <geoff@infradead.org>
Subject: Re: [PATCH 2/8] powerpc/ps3: Fix hcall lv1_net_stop_rx_dma
From: Geoff Levand <geoff@infradead.org>
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <a4ecc1a889c6773a8ef6fd52ba0f49a705cac6d3.1322615824.git.geoff@infradead.org>
References: <cover.1322615824.git.geoff@infradead.org>
 <a4ecc1a889c6773a8ef6fd52ba0f49a705cac6d3.1322615824.git.geoff@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 29 Nov 2011 17:50:10 -0800
Message-ID: <1322617810.3037.304.camel@gum>
MIME-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Dave, 

Unfortunately, your address got cut off for this patch.

I think Ben can merge this one through his powerpc tree since it is just
a trivial change to the ps3 gelic net driver.

Please consider.

-Geoff

On Wed, 2011-11-30 at 01:38 +0000, Geoff Levand wrote:
> The lv1_net_stop_tx_dma and net_stop_rx_dma hcalls take 2, not 3 input
> arguments.  Adjust the lv1 hcall table and all calls.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/powerpc/include/asm/lv1call.h           |    4 ++--
>  drivers/net/ethernet/toshiba/ps3_gelic_net.c |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/lv1call.h b/arch/powerpc/include/asm/lv1call.h
> index f77c708..807d895 100644
> --- a/arch/powerpc/include/asm/lv1call.h
> +++ b/arch/powerpc/include/asm/lv1call.h
> @@ -294,9 +294,9 @@ LV1_CALL(unmap_device_dma_region,                       4, 0, 177 )
>  LV1_CALL(net_add_multicast_address,                     4, 0, 185 )
>  LV1_CALL(net_remove_multicast_address,                  4, 0, 186 )
>  LV1_CALL(net_start_tx_dma,                              4, 0, 187 )
> -LV1_CALL(net_stop_tx_dma,                               3, 0, 188 )
> +LV1_CALL(net_stop_tx_dma,                               2, 0, 188 )
>  LV1_CALL(net_start_rx_dma,                              4, 0, 189 )
> -LV1_CALL(net_stop_rx_dma,                               3, 0, 190 )
> +LV1_CALL(net_stop_rx_dma,                               2, 0, 190 )
>  LV1_CALL(net_set_interrupt_status_indicator,            4, 0, 191 )
>  LV1_CALL(net_set_interrupt_mask,                        4, 0, 193 )
>  LV1_CALL(net_control,                                   6, 2, 194 )
> diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> index 7bf1e20..5ee82a7 100644
> --- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> +++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> @@ -640,7 +640,7 @@ static inline void gelic_card_disable_rxdmac(struct gelic_card *card)
>  	int status;
>  
>  	/* this hvc blocks until the DMA in progress really stopped */
> -	status = lv1_net_stop_rx_dma(bus_id(card), dev_id(card), 0);
> +	status = lv1_net_stop_rx_dma(bus_id(card), dev_id(card));
>  	if (status)
>  		dev_err(ctodev(card),
>  			"lv1_net_stop_rx_dma failed, %d\n", status);
> @@ -658,7 +658,7 @@ static inline void gelic_card_disable_txdmac(struct gelic_card *card)
>  	int status;
>  
>  	/* this hvc blocks until the DMA in progress really stopped */
> -	status = lv1_net_stop_tx_dma(bus_id(card), dev_id(card), 0);
> +	status = lv1_net_stop_tx_dma(bus_id(card), dev_id(card));
>  	if (status)
>  		dev_err(ctodev(card),
>  			"lv1_net_stop_tx_dma failed, status=%d\n", status);
