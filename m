Return-Path: <eric.dumazet@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4188gd4V3vzF0jD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 08:54:52 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id a22-v6so7209662pfo.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jun 2018 15:54:52 -0700 (PDT)
Subject: Re: [PATCH] Revert "net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are
 friends"
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Mathieu Malaterre <malat@debian.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Christophe LEROY <christophe.leroy@c-s.fr>, Meelis Roos <mroos@linux.ee>,
 netdev@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20180615185645.8921-1-malat@debian.org>
 <fbb95c11-240c-1a11-0a62-0483908c577e@gmail.com>
 <CA+7wUsysaip70ARGQ7Byg1Zktfg0Y1esjEc9HxBGU4sKL8crhg@mail.gmail.com>
 <9d88677a-f2be-2089-79df-15df4e9a5dd6@gmail.com>
 <m2tvq1672p.fsf@linux-m68k.org>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <e1a9b126-3226-72d0-82b2-b69ca5f59ccb@gmail.com>
Date: Sun, 17 Jun 2018 15:54:48 -0700
MIME-Version: 1.0
In-Reply-To: <m2tvq1672p.fsf@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/17/2018 03:27 AM, Andreas Schwab wrote:

> 
> That doesn't change anything.

OK, thanks !

Oh this is silly, please try :

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c642304f178ce0a4e1358d59e45032a39f76fb3f..54dd9c18ecad817812898d6f335e1794a07dabbe 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1845,10 +1845,9 @@ EXPORT_SYMBOL(___pskb_trim);
 int pskb_trim_rcsum_slow(struct sk_buff *skb, unsigned int len)
 {
        if (skb->ip_summed == CHECKSUM_COMPLETE) {
-               int delta = skb->len - len;
+               __wsum csumdiff = skb_checksum(skb, len, skb->len - len, 0);
 
-               skb->csum = csum_sub(skb->csum,
-                                    skb_checksum(skb, len, delta, 0));
+               skb->csum = csum_block_sub(skb->csum, csumdiff, len);
        }
        return __pskb_trim(skb, len);
 }
