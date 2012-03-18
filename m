Return-Path: <eric.dumazet@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ABA77B6FD6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2012 07:20:39 +1100 (EST)
Received: by dady9 with SMTP id y9so10673062dad.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2012 13:20:37 -0700 (PDT)
Message-ID: <1332102032.3722.53.camel@edumazet-laptop>
Subject: Re: [PATCH net-next 1/3] gianfar: Add support for byte queue limits.
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Sun, 18 Mar 2012 13:20:32 -0700
In-Reply-To: <1332089787-24086-2-git-send-email-paul.gortmaker@windriver.com>
References: <1332089787-24086-1-git-send-email-paul.gortmaker@windriver.com>
 <1332089787-24086-2-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset="UTF-8"
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

Le dimanche 18 mars 2012 à 12:56 -0400, Paul Gortmaker a écrit :

...

>  		 * we add this skb back into the pool, if it's the right size
> @@ -2557,13 +2568,15 @@ static int gfar_clean_tx_ring(struct gfar_priv_tx_q *tx_queue)
>  	}
>  
>  	/* If we freed a buffer, we can restart transmission, if necessary */
> -	if (__netif_subqueue_stopped(dev, tx_queue->qindex) && tx_queue->num_txbdfree)
> -		netif_wake_subqueue(dev, tx_queue->qindex);
> +	if (__netif_subqueue_stopped(dev, tqi) && tx_queue->num_txbdfree)
> +		netif_wake_subqueue(dev, tqi);
>  

You can use netif_tx_queue_stopped(txq) here instead of
__netif_subqueue_stopped(dev, tqi) 

>  	/* Update dirty indicators */
>  	tx_queue->skb_dirtytx = skb_dirtytx;
>  	tx_queue->dirty_tx = bdp;
>  
> +	netdev_tx_completed_queue(txq, howmany, bytes_sent);
> +
>  	return howmany;
>  }
>  
