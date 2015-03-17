Return-Path: <Kim.Phillips@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6352B1A0299
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 11:25:00 +1100 (AEDT)
Date: Mon, 16 Mar 2015 19:19:35 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Horia =?UTF-8?B?R2VhbnTEgw==?= <horia.geanta@freescale.com>
Subject: Re: [PATCH v2 5/5] crypto: talitos: Add software backlog queue
 handling
Message-ID: <20150316191935.81f89e0dafebbbe76ffcb0c0@freescale.com>
In-Reply-To: <5506AA4B.303@freescale.com>
References: <1425388897-5434-1-git-send-email-mort@bork.org>
 <1425388897-5434-6-git-send-email-mort@bork.org>
 <20150303182332.546523088b5891a776880c0f@freescale.com>
 <5506AA4B.303@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 16 Mar 2015 12:02:51 +0200
Horia Geantă <horia.geanta@freescale.com> wrote:

> On 3/4/2015 2:23 AM, Kim Phillips wrote:
> > Only potential problem is getting the crypto API to set the GFP_DMA
> > flag in the allocation request, but presumably a
> > CRYPTO_TFM_REQ_DMA crt_flag can be made to handle that.
> 
> Seems there are quite a few places that do not use the
> {aead,ablkcipher_ahash}_request_alloc() API to allocate crypto requests.
> Among them, IPsec and dm-crypt.
> I've looked at the code and I don't think it can be converted to use
> crypto API.

why not?

> This means that the CRYPTO_TFM_REQ_DMA would be visible to all of these
> places. Some of the maintainers do not agree, as you've seen.

would modifying the crypto API to either have a different
*_request_alloc() API, and/or adding calls to negotiate the GFP mask
between crypto users and drivers, e.g., get/set_gfp_mask, work?

> An alternative would be for talitos to use the page allocator to get 1 /
> 2 pages at probe time (4 channels x 32 entries/channel x 64B/descriptor
> = 8 kB), dma_map_page the area and manage it internally for talitos_desc
> hw descriptors.
> What do you think?

There's a comment in esp_alloc_tmp(): "Use spare space in skb for
this where possible," which is ideally where we'd want to be (esp.
because that memory could already be DMA-able).  Your above
suggestion would be in the opposite direction of that.

Kim
