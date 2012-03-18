Return-Path: <eric.dumazet@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6FAE6B6F13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2012 08:55:45 +1100 (EST)
Received: by dady9 with SMTP id y9so10749592dad.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2012 14:55:43 -0700 (PDT)
Subject: Re: [PATCH net-next 4/4] gianfar: use netif_tx_queue_stopped
 instead of __netif_subqueue_stopped
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <1332106761-18293-5-git-send-email-paul.gortmaker@windriver.com>
References: <1332089787-24086-1-git-send-email-paul.gortmaker@windriver.com>
 <1332106761-18293-1-git-send-email-paul.gortmaker@windriver.com>
 <1332106761-18293-5-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 18 Mar 2012 14:55:41 -0700
Message-ID: <1332107741.9397.27.camel@edumazet-glaptop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 therbert@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2012-03-18 at 17:39 -0400, Paul Gortmaker wrote:
> The __netif_subqueue_stopped() just does the following:
> 
>         struct netdev_queue *txq = netdev_get_tx_queue(dev, queue_index);
>         return netif_tx_queue_stopped(txq);
> 
> and since we already have the txq in scope, we can just call that
> directly in this case.
> 
> Suggested-by: Eric Dumazet <eric.dumazet@gmail.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/net/ethernet/freescale/gianfar.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
> index 6e66cc3..d9428f0 100644
> --- a/drivers/net/ethernet/freescale/gianfar.c
> +++ b/drivers/net/ethernet/freescale/gianfar.c
> @@ -2565,7 +2565,7 @@ static int gfar_clean_tx_ring(struct gfar_priv_tx_q *tx_queue)
>  	}
>  
>  	/* If we freed a buffer, we can restart transmission, if necessary */
> -	if (__netif_subqueue_stopped(dev, tqi) && tx_queue->num_txbdfree)
> +	if (netif_tx_queue_stopped(txq) && tx_queue->num_txbdfree)
>  		netif_wake_subqueue(dev, tqi);
>  
>  	/* Update dirty indicators */

Please change netif_wake_subqueue() as well ;)
