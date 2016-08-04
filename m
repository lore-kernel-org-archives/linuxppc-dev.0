Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s51qT3YlzzDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 06:33:40 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, zajec5@gmail.com,
 leoli@freescale.com, qiang.zhao@freescale.com, viresh.kumar@linaro.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 scottwood@freescale.com, akpm@linux-foundation.org, linux@roeck-us.net
Subject: Re: [v5.1] ucc_fast: Fix to avoid IS_ERR_VALUE abuses and dead code
 on 64bit systems.
Date: Thu, 04 Aug 2016 22:31:30 +0200
Message-ID: <2376517.GXv6XVOdDd@wuerfel>
In-Reply-To: <1470329563-5464-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1470329563-5464-1-git-send-email-arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday, August 4, 2016 10:22:43 PM CEST Arvind Yadav wrote:
> index df8ea79..ada9070 100644
> --- a/include/soc/fsl/qe/ucc_fast.h
> +++ b/include/soc/fsl/qe/ucc_fast.h
> @@ -165,10 +165,12 @@ struct ucc_fast_private {
>         int stopped_tx;         /* Whether channel has been stopped for Tx
>                                    (STOP_TX, etc.) */
>         int stopped_rx;         /* Whether channel has been stopped for Rx */
> -       u32 ucc_fast_tx_virtual_fifo_base_offset;/* pointer to base of Tx
> -                                                   virtual fifo */
> -       u32 ucc_fast_rx_virtual_fifo_base_offset;/* pointer to base of Rx
> -                                                   virtual fifo */
> +       unsigned long ucc_fast_tx_virtual_fifo_base_offset;/* pointer to base of
> +                                                           * Tx virtual fifo
> +                                                           */
> +       unsigned long ucc_fast_rx_virtual_fifo_base_offset;/* pointer to base of
> +                                                           * Rx virtual fifo
> +                                                           */
>  #ifdef STATISTICS
>         u32 tx_frames;          /* Transmitted frames counter. */
>         u32 rx_frames;          /* Received frames counter (only frames
> 

This change seems ok, but what about the other u32 variables in ucc_geth.c
that get checked for IS_ERR_VALUE?

	Arnd
