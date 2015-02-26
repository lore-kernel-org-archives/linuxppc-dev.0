Return-Path: <mohicks@gmail.com>
Received: from mail-ie0-x22a.google.com (mail-ie0-x22a.google.com
 [IPv6:2607:f8b0:4001:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 88D811A0046
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 06:22:41 +1100 (AEDT)
Received: by iecrl12 with SMTP id rl12so19801443iec.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 11:22:38 -0800 (PST)
MIME-Version: 1.0
Sender: mohicks@gmail.com
In-Reply-To: <54ECC140.9090100@freescale.com>
References: <1424449276-5288-1-git-send-email-mort@bork.org>
 <1424449276-5288-6-git-send-email-mort@bork.org>
 <54ECC140.9090100@freescale.com>
Date: Thu, 26 Feb 2015 14:22:38 -0500
Message-ID: <CAJUS3X=jFNi9yoKkrHtMxir5DfLaWoCqAoVfj2a7-wHo-29woA@mail.gmail.com>
Subject: Re: [PATCH 5/5] crypto: talitos: Add software backlog queue handling
From: Martin Hicks <mort@bork.org>
To: =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Horia,

On Tue, Feb 24, 2015 at 1:21 PM, Horia Geant=C4=83
<horia.geanta@freescale.com> wrote:
> On 2/20/2015 6:21 PM, Martin Hicks wrote:
>> +     int ret =3D -EINPROGRESS;
>>
>>       spin_lock_irqsave(&priv->chan[ch].head_lock, flags);
>>
>> +     if (edesc) {
>> +             orig_request =3D &edesc->req;
>> +             crypto_enqueue_request(&priv->chan[ch].queue, &orig_reques=
t->base);
>> +     }
>
> The request goes through the SW queue even if there are empty slots in
> the HW queue, doing unnecessary crypto_queue_encrypt() and
> crypto_queue_decrypt(). Trying to use the HW queue first would be better.
>

Definitely a valid point.  In trying to reorganize this it really
complicates things.
Splitting the submit from issuing requests from the backlog seems to
make it much more straightforward.

>> @@ -1170,6 +1211,8 @@ static struct talitos_edesc *talitos_edesc_alloc(s=
truct device *dev,
>>                                                    edesc->dma_len,
>>                                                    DMA_BIDIRECTIONAL);
>>       edesc->req.desc =3D &edesc->desc;
>> +     /* A copy of the crypto_async_request to use the crypto_queue back=
log */
>> +     memcpy(&edesc->req.base, areq, sizeof(struct crypto_async_request)=
);
>
> Why not have a
> struct crypto_async_request *base;
> instead of
> struct crypto_async_request base;
> in talitos_request structure?
>
> This way:
> 1. memcopy above is avoided
> 2. talitos_request structure gets smaller - remember that
> talitos_request is now embedded in talitos_edesc structure, which gets
> kmalloc-ed for every request

The trouble I ran into was that after a request is backlogged and put
on the crypto queue, I couldn't see how else I could go from the
crypto_async_request that is pulled from the queue back to the
talitos_request that is needed in order put the pointer into the
hardware FIFO.

This is the one issue from you review that I didn't address in v2 of the pa=
tch.

Thanks for the review.  Not releasing / re-acquiring the spinlock
while trying to flush the backlog really improved performance.

mh

--=20
Martin Hicks P.Eng.      |         mort@bork.org
Bork Consulting Inc.     |   +1 (613) 266-2296
