Return-Path: <Horia.Geanta@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0115.outbound.protection.outlook.com [65.55.169.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 388BB1A06F7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 21:03:12 +1100 (AEDT)
Message-ID: <5506AA4B.303@freescale.com>
Date: Mon, 16 Mar 2015 12:02:51 +0200
From: =?UTF-8?B?SG9yaWEgR2VhbnTEgw==?= <horia.geanta@freescale.com>
MIME-Version: 1.0
To: Kim Phillips <kim.phillips@freescale.com>, Martin Hicks <mort@bork.org>
Subject: Re: [PATCH v2 5/5] crypto: talitos: Add software backlog queue
 handling
References: <1425388897-5434-1-git-send-email-mort@bork.org>
 <1425388897-5434-6-git-send-email-mort@bork.org>
 <20150303182332.546523088b5891a776880c0f@freescale.com>
In-Reply-To: <20150303182332.546523088b5891a776880c0f@freescale.com>
Content-Type: text/plain; charset="UTF-8"
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

On 3/4/2015 2:23 AM, Kim Phillips wrote:
> Only potential problem is getting the crypto API to set the GFP_DMA
> flag in the allocation request, but presumably a
> CRYPTO_TFM_REQ_DMA crt_flag can be made to handle that.

Seems there are quite a few places that do not use the
{aead,ablkcipher_ahash}_request_alloc() API to allocate crypto requests.
Among them, IPsec and dm-crypt.
I've looked at the code and I don't think it can be converted to use
crypto API.

This means that the CRYPTO_TFM_REQ_DMA would be visible to all of these
places. Some of the maintainers do not agree, as you've seen.

An alternative would be for talitos to use the page allocator to get 1 /
2 pages at probe time (4 channels x 32 entries/channel x 64B/descriptor
= 8 kB), dma_map_page the area and manage it internally for talitos_desc
hw descriptors.
What do you think?

Thanks,
Horia
