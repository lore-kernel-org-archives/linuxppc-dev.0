Return-Path: <eric.dumazet@gmail.com>
Received: from mail-bk0-f42.google.com (mail-bk0-f42.google.com
 [209.85.214.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1D87E2C00D2
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2012 17:04:45 +1100 (EST)
Received: by mail-bk0-f42.google.com with SMTP id j5so2059245bkw.15
 for <linuxppc-dev@ozlabs.org>; Mon, 08 Oct 2012 23:04:42 -0700 (PDT)
Subject: Re: net: fix typo in freescale/ucc_geth.c
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <23452.1349740345@neuling.org>
References: <20121008173653.1d17895964980c98af59c8ea@canb.auug.org.au>
 <23452.1349740345@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 09 Oct 2012 08:04:39 +0200
Message-ID: <1349762679.21172.3842.camel@edumazet-glaptop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
 Eric Dumazet <edumazet@google.com>, linux-next@vger.kernel.org,
 Maxime Bizon <mbizon@freebox.fr>, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-10-09 at 10:52 +1100, Michael Neuling wrote:
> The following patch: 
>   acb600d net: remove skb recycling
> added dev_free_skb() to drivers/net/ethernet/freescale/ucc_geth.c
> 
> This is a typo and should be dev_kfree_skb().  This fixes this.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> This hit as a compile error in next-20121008 with mpc85xx_defconfig.
> 
> diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
> index dfa0aaa..0a70bb5 100644
> --- a/drivers/net/ethernet/freescale/ucc_geth.c
> +++ b/drivers/net/ethernet/freescale/ucc_geth.c
> @@ -3268,7 +3268,7 @@ static int ucc_geth_rx(struct ucc_geth_private *ugeth, u8 rxQ, int rx_work_limit
>  			if (netif_msg_rx_err(ugeth))
>  				ugeth_err("%s, %d: ERROR!!! skb - 0x%08x",
>  					   __func__, __LINE__, (u32) skb);
> -			dev_free_skb(skb);
> +			dev_kfree_skb(skb);
>  
>  			ugeth->rx_skbuff[rxQ][ugeth->skb_currx[rxQ]] = NULL;
>  

Oops, thanks Michael !
