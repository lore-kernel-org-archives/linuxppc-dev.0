Return-Path: <Kim.Phillips@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0120.outbound.protection.outlook.com [65.55.169.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD7B31A0140
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 11:43:30 +1100 (AEDT)
Date: Tue, 3 Mar 2015 18:23:32 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Martin Hicks <mort@bork.org>
Subject: Re: [PATCH v2 5/5] crypto: talitos: Add software backlog queue
 handling
Message-ID: <20150303182332.546523088b5891a776880c0f@freescale.com>
In-Reply-To: <1425388897-5434-6-git-send-email-mort@bork.org>
References: <1425388897-5434-1-git-send-email-mort@bork.org>
 <1425388897-5434-6-git-send-email-mort@bork.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Horia =?UTF-8?Q?Geant=C4=83?= <horia.geanta@freescale.com>,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue,  3 Mar 2015 08:21:37 -0500
Martin Hicks <mort@bork.org> wrote:

> @@ -1170,6 +1237,8 @@ static struct talitos_edesc *talitos_edesc_alloc(struct device *dev,
>  						     edesc->dma_len,
>  						     DMA_BIDIRECTIONAL);
>  	edesc->req.desc = &edesc->desc;
> +	/* A copy of the crypto_async_request to use the crypto_queue backlog */
> +	memcpy(&edesc->req.base, areq, sizeof(struct crypto_async_request));

this seems backward, or, at least can be done more efficiently IMO:
talitos_cra_init should set the tfm's reqsize so the rest of
the driver can wholly embed its talitos_edesc (which should also
wholly encapsulate its talitos_request (i.e., not via a pointer))
into the crypto API's request handle allocation.  This
would absorb and eliminate the talitos_edesc kmalloc and frees, the
above memcpy, and replace the container_of after the
crypto_dequeue_request with an offset_of, right?

When scatter-gather buffers are needed, we can assume a slower-path
and make them do their own allocations, since their sizes vary
depending on each request.  Of course, a pointer to those
allocations would need to be retained somewhere in the request
handle.

Only potential problem is getting the crypto API to set the GFP_DMA
flag in the allocation request, but presumably a
CRYPTO_TFM_REQ_DMA crt_flag can be made to handle that.

Kim
