Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 417r5y1MYhzF09q
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jun 2018 20:28:05 +1000 (AEST)
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
Date: Sun, 17 Jun 2018 12:27:58 +0200
In-Reply-To: <9d88677a-f2be-2089-79df-15df4e9a5dd6@gmail.com> (Eric Dumazet's
 message of "Sat, 16 Jun 2018 05:45:42 -0700")
Message-ID: <m2tvq1672p.fsf@linux-m68k.org>
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

On Jun 16 2018, Eric Dumazet <eric.dumazet@gmail.com> wrote:

> I would try something like :
>
> Basically do not bother using CHECKSUM_COMPLETE for small frames that might have been padded.
>
> Since we need to bring one cache line in eth_type_trans() and further header processing,
> computing the checksum in software will be almost free anyway.
>
> diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
> index 7a16d40a72d13cf1d522e8a3a396c826fe76f9b9..071039f211a8a33153e888bd4014314ba5e686a4 100644
> --- a/drivers/net/ethernet/sun/sungem.c
> +++ b/drivers/net/ethernet/sun/sungem.c
> @@ -855,9 +855,11 @@ static int gem_rx(struct gem *gp, int work_to_do)
>                         skb = copy_skb;
>                 }
>  
> -               csum = (__force __sum16)htons((status & RXDCTRL_TCPCSUM) ^ 0xffff);
> -               skb->csum = csum_unfold(csum);
> -               skb->ip_summed = CHECKSUM_COMPLETE;
> +               if (len > ETH_ZLEN) {
> +                       csum = (__force __sum16)htons((status & RXDCTRL_TCPCSUM) ^ 0xffff);
> +                       skb->csum = csum_unfold(csum);
> +                       skb->ip_summed = CHECKSUM_COMPLETE;
> +               }
>                 skb->protocol = eth_type_trans(skb, gp->dev);
>  
>                 napi_gro_receive(&gp->napi, skb);

That doesn't change anything.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
