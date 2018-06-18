Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418dz35S9PzF09q
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 03:54:54 +1000 (AEST)
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
Date: Mon, 18 Jun 2018 19:54:47 +0200
In-Reply-To: <e1a9b126-3226-72d0-82b2-b69ca5f59ccb@gmail.com> (Eric Dumazet's
 message of "Sun, 17 Jun 2018 15:54:48 -0700")
Message-ID: <87o9g8geu0.fsf@igel.home>
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

On Jun 17 2018, Eric Dumazet <eric.dumazet@gmail.com> wrote:

> Oh this is silly, please try :
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index c642304f178ce0a4e1358d59e45032a39f76fb3f..54dd9c18ecad817812898d6f335e1794a07dabbe 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1845,10 +1845,9 @@ EXPORT_SYMBOL(___pskb_trim);
>  int pskb_trim_rcsum_slow(struct sk_buff *skb, unsigned int len)
>  {
>         if (skb->ip_summed == CHECKSUM_COMPLETE) {
> -               int delta = skb->len - len;
> +               __wsum csumdiff = skb_checksum(skb, len, skb->len - len, 0);
>  
> -               skb->csum = csum_sub(skb->csum,
> -                                    skb_checksum(skb, len, delta, 0));
> +               skb->csum = csum_block_sub(skb->csum, csumdiff, len);
>         }
>         return __pskb_trim(skb, len);
>  }

That doesn't help either.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
