Return-Path: <eric.dumazet@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418fVg11WhzF09q
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 04:18:50 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id a12-v6so8588481pfi.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 11:18:50 -0700 (PDT)
Subject: Re: [PATCH] Revert "net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are
 friends"
To: Andreas Schwab <schwab@linux-m68k.org>,
 Eric Dumazet <eric.dumazet@gmail.com>
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
 <e1a9b126-3226-72d0-82b2-b69ca5f59ccb@gmail.com> <87o9g8geu0.fsf@igel.home>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <816ef746-5278-1d51-1d9d-55593e377681@gmail.com>
Date: Mon, 18 Jun 2018 11:18:46 -0700
MIME-Version: 1.0
In-Reply-To: <87o9g8geu0.fsf@igel.home>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/18/2018 10:54 AM, Andreas Schwab wrote:
> On Jun 17 2018, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> 
>> Oh this is silly, please try :
>>
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index c642304f178ce0a4e1358d59e45032a39f76fb3f..54dd9c18ecad817812898d6f335e1794a07dabbe 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -1845,10 +1845,9 @@ EXPORT_SYMBOL(___pskb_trim);
>>  int pskb_trim_rcsum_slow(struct sk_buff *skb, unsigned int len)
>>  {
>>         if (skb->ip_summed == CHECKSUM_COMPLETE) {
>> -               int delta = skb->len - len;
>> +               __wsum csumdiff = skb_checksum(skb, len, skb->len - len, 0);
>>  
>> -               skb->csum = csum_sub(skb->csum,
>> -                                    skb_checksum(skb, len, delta, 0));
>> +               skb->csum = csum_block_sub(skb->csum, csumdiff, len);
>>         }
>>         return __pskb_trim(skb, len);
>>  }
> 
> That doesn't help either.
> 
> Andreas.
> 

Then maybe NIC provided csum is not correct.

It does not compute a checksum on all the frame, but part of it.

You could use this patch to double check.

diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index 7a16d40a72d13cf1d522e8a3a396c826fe76f9b9..277859ea73e35271a10b02011120fca248ec8e71 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -857,6 +857,11 @@ static int gem_rx(struct gem *gp, int work_to_do)
 
                csum = (__force __sum16)htons((status & RXDCTRL_TCPCSUM) ^ 0xffff);
                skb->csum = csum_unfold(csum);
+               {
+               __wsum rsum = csum_partial(skb->data + ETH_HLEN, len - ETH_HLEN, 0);
+               if (csum != csum_fold(rsum))
+                       pr_err_ratelimited("sungem wrong csum : %x/%x, len %u bytes\n", csum, csum_fold(rsum), len);
+               }
                skb->ip_summed = CHECKSUM_COMPLETE;
                skb->protocol = eth_type_trans(skb, gp->dev);
 
