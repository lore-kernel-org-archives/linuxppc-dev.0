Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-ot0-f195.google.com (mail-ot0-f195.google.com
 [74.125.82.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418g614tJDzF0tP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 04:46:00 +1000 (AEST)
Received: by mail-ot0-f195.google.com with SMTP id p95-v6so19669447ota.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 11:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180615185645.8921-1-malat@debian.org>
 <fbb95c11-240c-1a11-0a62-0483908c577e@gmail.com>
 <CA+7wUsysaip70ARGQ7Byg1Zktfg0Y1esjEc9HxBGU4sKL8crhg@mail.gmail.com>
 <9d88677a-f2be-2089-79df-15df4e9a5dd6@gmail.com>
 <m2tvq1672p.fsf@linux-m68k.org>
 <e1a9b126-3226-72d0-82b2-b69ca5f59ccb@gmail.com> <87o9g8geu0.fsf@igel.home>
 <816ef746-5278-1d51-1d9d-55593e377681@gmail.com>
In-Reply-To: <816ef746-5278-1d51-1d9d-55593e377681@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Mon, 18 Jun 2018 20:45:46 +0200
Message-ID: <CA+7wUszG3Tmq5qT7o7w7ttAU+bzyJfRORL_Qzk4wUG6y2gZUuw@mail.gmail.com>
Subject: Re: [PATCH] Revert "net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are
 friends"
To: eric.dumazet@gmail.com
Cc: schwab@linux-m68k.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, LKML <linux-kernel@vger.kernel.org>,
 Christophe LEROY <christophe.leroy@c-s.fr>, Meelis Roos <mroos@linux.ee>,
 netdev@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 18, 2018 at 8:18 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 06/18/2018 10:54 AM, Andreas Schwab wrote:
> > On Jun 17 2018, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> >
> >> Oh this is silly, please try :
> >>
> >> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> >> index c642304f178ce0a4e1358d59e45032a39f76fb3f..54dd9c18ecad817812898d6f335e1794a07dabbe 100644
> >> --- a/net/core/skbuff.c
> >> +++ b/net/core/skbuff.c
> >> @@ -1845,10 +1845,9 @@ EXPORT_SYMBOL(___pskb_trim);
> >>  int pskb_trim_rcsum_slow(struct sk_buff *skb, unsigned int len)
> >>  {
> >>         if (skb->ip_summed == CHECKSUM_COMPLETE) {
> >> -               int delta = skb->len - len;
> >> +               __wsum csumdiff = skb_checksum(skb, len, skb->len - len, 0);
> >>
> >> -               skb->csum = csum_sub(skb->csum,
> >> -                                    skb_checksum(skb, len, delta, 0));
> >> +               skb->csum = csum_block_sub(skb->csum, csumdiff, len);
> >>         }
> >>         return __pskb_trim(skb, len);
> >>  }
> >
> > That doesn't help either.
> >
> > Andreas.
> >
>
> Then maybe NIC provided csum is not correct.
>
> It does not compute a checksum on all the frame, but part of it.
>
> You could use this patch to double check.
>
> diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
> index 7a16d40a72d13cf1d522e8a3a396c826fe76f9b9..277859ea73e35271a10b02011120fca248ec8e71 100644
> --- a/drivers/net/ethernet/sun/sungem.c
> +++ b/drivers/net/ethernet/sun/sungem.c
> @@ -857,6 +857,11 @@ static int gem_rx(struct gem *gp, int work_to_do)
>
>                 csum = (__force __sum16)htons((status & RXDCTRL_TCPCSUM) ^ 0xffff);
>                 skb->csum = csum_unfold(csum);
> +               {
> +               __wsum rsum = csum_partial(skb->data + ETH_HLEN, len - ETH_HLEN, 0);
> +               if (csum != csum_fold(rsum))
> +                       pr_err_ratelimited("sungem wrong csum : %x/%x, len %u bytes\n", csum, csum_fold(rsum), len);
> +               }
>                 skb->ip_summed = CHECKSUM_COMPLETE;
>                 skb->protocol = eth_type_trans(skb, gp->dev);
>
>

Here is what I get on my side

[   53.628847] sungem: sungem wrong csum : 4e04/f97, len 64 bytes
[   53.667063] sungem: sungem wrong csum : eea8/6eec, len 149 bytes
[   58.648952] sungem: sungem wrong csum : 2095/3d06, len 64 bytes
[   58.669414] sungem: sungem wrong csum : 5245/b50, len 149 bytes
[   63.674451] sungem: sungem wrong csum : 2d8/5abd, len 149 bytes
[   68.678233] sungem: sungem wrong csum : b8fc/a498, len 149 bytes
[   73.685771] sungem: sungem wrong csum : 374/5a21, len 149 bytes
[   78.689089] sungem: sungem wrong csum : d81/5014, len 149 bytes
[   83.683261] sungem: sungem wrong csum : 4e04/f97, len 64 bytes
[   83.690193] sungem: sungem wrong csum : c2f7/9a9d, len 149 bytes
[   88.692511] sungem: sungem wrong csum : f4d8/68bc, len 149 bytes
[   93.699915] sungem: sungem wrong csum : 1370/4a25, len 149 bytes
[   98.703136] sungem: sungem wrong csum : e1b5/7bdf, len 149 bytes
[  103.704230] sungem: sungem wrong csum : 5321/a74, len 149 bytes
[  108.688912] sungem: sungem wrong csum : 2095/3d06, len 64 bytes
[  108.706559] sungem: sungem wrong csum : ddbc/7fd8, len 149 bytes
[  113.713189] sungem: sungem wrong csum : 5a65/330, len 149 bytes
[  113.891697] sungem: sungem wrong csum : 4e04/f97, len 64 bytes
[  118.717151] sungem: sungem wrong csum : f7c8/65cc, len 149 bytes
[  123.722680] sungem: sungem wrong csum : 3d7a/201b, len 149 bytes
[  128.726524] sungem: sungem wrong csum : c8fd/9497, len 149 bytes
[  133.732045] sungem: sungem wrong csum : de0d/7f87, len 149 bytes
[  135.529163] sungem: sungem wrong csum : 3089/b6dd, len 96 bytes
[  135.529208] eth0: hw csum failure
[  135.529220] CPU: 0 PID: 0 Comm: swapper Not tainted 4.17.0+ #7
[  135.529226] Call Trace:
[  135.529243] [dffedbe0] [c069ddac]
__skb_checksum_complete+0xf0/0x108 (unreliable)


>
>
>
