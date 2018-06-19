Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419N4m2WfwzF0fX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 08:32:22 +1000 (AEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Mathieu Malaterre <malat@debian.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Christophe LEROY <christophe.leroy@c-s.fr>, Meelis Roos <mroos@linux.ee>,
 netdev@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] Revert "net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are
 friends"
References: <20180615185645.8921-1-malat@debian.org>
 <fbb95c11-240c-1a11-0a62-0483908c577e@gmail.com>
 <CA+7wUsysaip70ARGQ7Byg1Zktfg0Y1esjEc9HxBGU4sKL8crhg@mail.gmail.com>
 <9d88677a-f2be-2089-79df-15df4e9a5dd6@gmail.com>
 <m2tvq1672p.fsf@linux-m68k.org>
 <e1a9b126-3226-72d0-82b2-b69ca5f59ccb@gmail.com>
 <87o9g8geu0.fsf@igel.home>
 <816ef746-5278-1d51-1d9d-55593e377681@gmail.com>
 <CA+7wUszG3Tmq5qT7o7w7ttAU+bzyJfRORL_Qzk4wUG6y2gZUuw@mail.gmail.com>
 <21523399-92ee-f8da-1a3e-0561f62850b7@gmail.com>
 <dd6f13bc-c5f2-85f8-c08d-837bc024fc7c@gmail.com>
 <87po0mvbgl.fsf@igel.home>
 <e1790720-911b-4d04-2215-752ec612e3d7@gmail.com>
 <05645b90-d3bc-466d-116f-548f3ee39de9@gmail.com>
Date: Wed, 20 Jun 2018 00:32:13 +0200
In-Reply-To: <05645b90-d3bc-466d-116f-548f3ee39de9@gmail.com> (Eric Dumazet's
 message of "Tue, 19 Jun 2018 15:10:14 -0700")
Message-ID: <87lgbav24y.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Jun 19 2018, Eric Dumazet <eric.dumazet@gmail.com> wrote:

> diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
> index 7a16d40a72d13cf1d522e8a3a396c826fe76f9b9..672d6748ab44f0890e92d5ca55d6ff6834c20dc9 100644
> --- a/drivers/net/ethernet/sun/sungem.c
> +++ b/drivers/net/ethernet/sun/sungem.c
> @@ -60,8 +60,7 @@
>  #include <linux/sungem_phy.h>
>  #include "sungem.h"
>  
> -/* Stripping FCS is causing problems, disabled for now */
> -#undef STRIP_FCS
> +#define STRIP_FCS
>  
>  #define DEFAULT_MSG    (NETIF_MSG_DRV          | \
>                          NETIF_MSG_PROBE        | \
> @@ -435,7 +434,7 @@ static int gem_rxmac_reset(struct gem *gp)
>         writel(desc_dma & 0xffffffff, gp->regs + RXDMA_DBLOW);
>         writel(RX_RING_SIZE - 4, gp->regs + RXDMA_KICK);
>         val = (RXDMA_CFG_BASE | (RX_OFFSET << 10) |
> -              ((14 / 2) << 13) | RXDMA_CFG_FTHRESH_128);
> +              (ETH_HLEN << 13) | RXDMA_CFG_FTHRESH_128);
>         writel(val, gp->regs + RXDMA_CFG);
>         if (readl(gp->regs + GREG_BIFCFG) & GREG_BIFCFG_M66EN)
>                 writel(((5 & RXDMA_BLANK_IPKTS) |
> @@ -857,6 +856,14 @@ static int gem_rx(struct gem *gp, int work_to_do)
>  
>                 csum = (__force __sum16)htons((status & RXDCTRL_TCPCSUM) ^ 0xffff);
>                 skb->csum = csum_unfold(csum);
> +               {
> +               __wsum rsum = csum_partial(skb->data + ETH_HLEN, len - ETH_HLEN, 0);
> +               if (csum != csum_fold(rsum) && net_ratelimit())
> +                       pr_err("sungem wrong csum : %x/%x, len %u bytes\n",
> +                               csum, csum_fold(rsum), len);
> +                       print_hex_dump(KERN_ERR, "raw data: ", DUMP_PREFIX_OFFSET,
> +                                           16, 1, skb->data, len, true);
> +               }
>                 skb->ip_summed = CHECKSUM_COMPLETE;
>                 skb->protocol = eth_type_trans(skb, gp->dev);
>  
> @@ -1761,7 +1768,7 @@ static void gem_init_dma(struct gem *gp)
>         writel(0, gp->regs + TXDMA_KICK);
>  
>         val = (RXDMA_CFG_BASE | (RX_OFFSET << 10) |
> -              ((14 / 2) << 13) | RXDMA_CFG_FTHRESH_128);
> +              (ETH_HLEN << 13) | RXDMA_CFG_FTHRESH_128);
>         writel(val, gp->regs + RXDMA_CFG);
>  
>         writel(desc_dma >> 32, gp->regs + RXDMA_DBHI);

With that patch I still get the wrong csum messages, but no longer the
hw csum failure messages (tested on a PowerMac G5).

[  662.659767] sungem: sungem wrong csum : 8359/7ca6, len 86 bytes, c0000001fee9cc02
[  662.659775] raw data: 00000000: 00 0d 93 43 81 62 d4 3d 7e 4c 48 b7 86 dd 61 01  ...C.b.=~LH...a.
[  662.659778] raw data: 00000010: 1c 1e 00 20 06 40 20 01 0a 62 17 11 88 01 00 00  ... .@ ..b......
[  662.659780] raw data: 00000020: 00 00 00 00 0a 38 20 01 0a 62 17 11 88 01 00 00  .....8 ..b......
[  662.659783] raw data: 00000030: 00 00 00 00 00 07 9a 18 00 16 c1 9a 7e ea ea 44  ............~..D
[  662.659785] raw data: 00000040: fb 4a 80 10 05 93 44 08 00 00 01 01 08 0a 59 68  .J....D.......Yh
[  662.659788] raw data: 00000050: ba e2 0e bb ac ae                                ......

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
