Return-Path: <Horia.Geanta@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0101.outbound.protection.outlook.com [157.56.110.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0964E1A09A6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2015 04:59:18 +1100 (AEDT)
Message-ID: <55086B5F.9080906@freescale.com>
Date: Tue, 17 Mar 2015 19:58:55 +0200
From: =?UTF-8?B?SG9yaWEgR2VhbnTEgw==?= <horia.geanta@freescale.com>
MIME-Version: 1.0
To: Kim Phillips <kim.phillips@freescale.com>, "David S. Miller"
 <davem@davemloft.net>
Subject: Re: [PATCH v2 5/5] crypto: talitos: Add software backlog queue
 handling
References: <1425388897-5434-1-git-send-email-mort@bork.org>
 <1425388897-5434-6-git-send-email-mort@bork.org>
 <20150303182332.546523088b5891a776880c0f@freescale.com>
 <5506AA4B.303@freescale.com>
 <20150316191935.81f89e0dafebbbe76ffcb0c0@freescale.com>
In-Reply-To: <20150316191935.81f89e0dafebbbe76ffcb0c0@freescale.com>
Content-Type: text/plain; charset="utf-8"
Cc: Scott Wood <scottwood@freescale.com>, Martin Hicks <mort@bork.org>,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3/17/2015 2:19 AM, Kim Phillips wrote:
> On Mon, 16 Mar 2015 12:02:51 +0200
> Horia Geantă <horia.geanta@freescale.com> wrote:
> 
>> On 3/4/2015 2:23 AM, Kim Phillips wrote:
>>> Only potential problem is getting the crypto API to set the GFP_DMA
>>> flag in the allocation request, but presumably a
>>> CRYPTO_TFM_REQ_DMA crt_flag can be made to handle that.
>>
>> Seems there are quite a few places that do not use the
>> {aead,ablkcipher_ahash}_request_alloc() API to allocate crypto requests.
>> Among them, IPsec and dm-crypt.
>> I've looked at the code and I don't think it can be converted to use
>> crypto API.
> 
> why not?

It would imply having 2 memory allocations, one for crypto request and
the other for the rest of the data bundled with the request (for IPsec
that would be ESN + space for IV + sg entries for authenticated-only
data and sk_buff extension, if needed).

Trying to have a single allocation by making ESN, IV etc. part of the
request private context requires modifying tfm.reqsize on the fly.
This won't work without adding some kind of locking for the tfm.

> 
>> This means that the CRYPTO_TFM_REQ_DMA would be visible to all of these
>> places. Some of the maintainers do not agree, as you've seen.
> 
> would modifying the crypto API to either have a different
> *_request_alloc() API, and/or adding calls to negotiate the GFP mask
> between crypto users and drivers, e.g., get/set_gfp_mask, work?

I think what DaveM asked for was the change to be transparent.

Besides converting to *_request_alloc(), seems that all other options
require some extra awareness from the user.
Could you elaborate on the idea above?

> 
>> An alternative would be for talitos to use the page allocator to get 1 /
>> 2 pages at probe time (4 channels x 32 entries/channel x 64B/descriptor
>> = 8 kB), dma_map_page the area and manage it internally for talitos_desc
>> hw descriptors.
>> What do you think?
> 
> There's a comment in esp_alloc_tmp(): "Use spare space in skb for
> this where possible," which is ideally where we'd want to be (esp.

Ok, I'll check that. But note the "where possible" - finding room in the
skb to avoid the allocation won't always be the case, and then we're
back to square one.

> because that memory could already be DMA-able).  Your above
> suggestion would be in the opposite direction of that.

The proposal:
-removes dma (un)mapping on the fast path
-avoids requesting dma mappable memory for more than it's actually
needed (CRYPTO_TFM_REQ_DMA forces entire request to be mappable, not
only its private context)
-for caam it has the added benefit of speeding the below search for the
offending descriptor in the SW ring from O(n) to O(1):
for (i = 0; CIRC_CNT(head, tail + i, JOBR_DEPTH) >= 1; i++) {
	sw_idx = (tail + i) & (JOBR_DEPTH - 1);

	if (jrp->outring[hw_idx].desc ==
	    jrp->entinfo[sw_idx].desc_addr_dma)
		break; /* found */
}
(drivers/crypto/caam/jr.c - caam_dequeue)

Horia
