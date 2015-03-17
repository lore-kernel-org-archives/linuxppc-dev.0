Return-Path: <Kim.Phillips@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0126.outbound.protection.outlook.com [65.55.169.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 78E5A1A09AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2015 09:08:47 +1100 (AEDT)
Date: Tue, 17 Mar 2015 17:03:19 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Horia =?UTF-8?B?R2VhbnTEgw==?= <horia.geanta@freescale.com>
Subject: Re: [PATCH v2 5/5] crypto: talitos: Add software backlog queue
 handling
Message-ID: <20150317170319.1e4cd2b1d1450b442a3b3b36@freescale.com>
In-Reply-To: <55086B5F.9080906@freescale.com>
References: <1425388897-5434-1-git-send-email-mort@bork.org>
 <1425388897-5434-6-git-send-email-mort@bork.org>
 <20150303182332.546523088b5891a776880c0f@freescale.com>
 <5506AA4B.303@freescale.com>
 <20150316191935.81f89e0dafebbbe76ffcb0c0@freescale.com>
 <55086B5F.9080906@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Martin Hicks <mort@bork.org>, linux-crypto@vger.kernel.org,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 17 Mar 2015 19:58:55 +0200
Horia Geantă <horia.geanta@freescale.com> wrote:

> On 3/17/2015 2:19 AM, Kim Phillips wrote:
> > On Mon, 16 Mar 2015 12:02:51 +0200
> > Horia Geantă <horia.geanta@freescale.com> wrote:
> > 
> >> On 3/4/2015 2:23 AM, Kim Phillips wrote:
> >>> Only potential problem is getting the crypto API to set the GFP_DMA
> >>> flag in the allocation request, but presumably a
> >>> CRYPTO_TFM_REQ_DMA crt_flag can be made to handle that.
> >>
> >> Seems there are quite a few places that do not use the
> >> {aead,ablkcipher_ahash}_request_alloc() API to allocate crypto requests.
> >> Among them, IPsec and dm-crypt.
> >> I've looked at the code and I don't think it can be converted to use
> >> crypto API.
> > 
> > why not?
> 
> It would imply having 2 memory allocations, one for crypto request and
> the other for the rest of the data bundled with the request (for IPsec
> that would be ESN + space for IV + sg entries for authenticated-only
> data and sk_buff extension, if needed).
> 
> Trying to have a single allocation by making ESN, IV etc. part of the
> request private context requires modifying tfm.reqsize on the fly.
> This won't work without adding some kind of locking for the tfm.

can't a common minimum tfm.reqsize be co-established up front, at
least for the fast path?

> >> This means that the CRYPTO_TFM_REQ_DMA would be visible to all of these
> >> places. Some of the maintainers do not agree, as you've seen.
> > 
> > would modifying the crypto API to either have a different
> > *_request_alloc() API, and/or adding calls to negotiate the GFP mask
> > between crypto users and drivers, e.g., get/set_gfp_mask, work?
> 
> I think what DaveM asked for was the change to be transparent.
> 
> Besides converting to *_request_alloc(), seems that all other options
> require some extra awareness from the user.
> Could you elaborate on the idea above?

was merely suggesting communicating GFP flags anonymously across the
API, i.e., GFP_DMA wouldn't appear in user code.

> >> An alternative would be for talitos to use the page allocator to get 1 /
> >> 2 pages at probe time (4 channels x 32 entries/channel x 64B/descriptor
> >> = 8 kB), dma_map_page the area and manage it internally for talitos_desc
> >> hw descriptors.
> >> What do you think?
> > 
> > There's a comment in esp_alloc_tmp(): "Use spare space in skb for
> > this where possible," which is ideally where we'd want to be (esp.
> 
> Ok, I'll check that. But note the "where possible" - finding room in the
> skb to avoid the allocation won't always be the case, and then we're
> back to square one.
> 
> > because that memory could already be DMA-able).  Your above
> > suggestion would be in the opposite direction of that.
> 
> The proposal:
> -removes dma (un)mapping on the fast path

sure, but at the expense of additional complexity.

> -avoids requesting dma mappable memory for more than it's actually
> needed (CRYPTO_TFM_REQ_DMA forces entire request to be mappable, not
> only its private context)

compared to the payload?  Plus, we have plenty of DMA space these
days.

> -for caam it has the added benefit of speeding the below search for the
> offending descriptor in the SW ring from O(n) to O(1):
> for (i = 0; CIRC_CNT(head, tail + i, JOBR_DEPTH) >= 1; i++) {
> 	sw_idx = (tail + i) & (JOBR_DEPTH - 1);
> 
> 	if (jrp->outring[hw_idx].desc ==
> 	    jrp->entinfo[sw_idx].desc_addr_dma)
> 		break; /* found */
> }
> (drivers/crypto/caam/jr.c - caam_dequeue)

how?  The job ring h/w will still be spitting things out
out-of-order.

Plus, like I said, it's taking the problem in the wrong direction:
we need to strive to merge the allocation and mapping with the upper
layers as much as possible.

Kim
