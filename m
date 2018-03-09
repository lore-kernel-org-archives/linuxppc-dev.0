Return-Path: <herbert@gondor.apana.org.au>
Received: from deadmen.hmeau.com (orcrist.hmeau.com [104.223.48.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zyWGv3wM1zF1rZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Mar 2018 02:18:13 +1100 (AEDT)
Date: Fri, 9 Mar 2018 23:17:52 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: "David S. Miller" <davem@davemloft.net>,
 Horia Geanta <horia.geanta@nxp.com>, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH  1/2] crypto: talitos - don't persistently map
 req_ctx->hw_context and req_ctx->buf
Message-ID: <20180309151751.GC13567@gondor.apana.org.au>
References: <7c934f0788d60bd82fb1cb51d712c9ab1ea7fcb4.1519660621.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7c934f0788d60bd82fb1cb51d712c9ab1ea7fcb4.1519660621.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 26, 2018 at 05:40:04PM +0100, Christophe Leroy wrote:
> Commit 49f9783b0cea ("crypto: talitos - do hw_context DMA mapping
> outside the requests") introduced a persistent dma mapping of
> req_ctx->hw_context
> Commit 37b5e8897eb5 ("crypto: talitos - chain in buffered data for ahash
> on SEC1") introduced a persistent dma mapping of req_ctx->buf
> 
> As there is no destructor for req_ctx (the request context), the
> associated dma handlers where set in ctx (the tfm context). This is
> wrong as several hash operations can run with the same ctx.
> 
> This patch removes this persistent mapping.
> 
> Reported-by: Horia Geanta <horia.geanta@nxp.com>
> Fixes: 49f9783b0cea ("crypto: talitos - do hw_context DMA mapping outside the requests")
> Fixes: 37b5e8897eb5 ("crypto: talitos - chain in buffered data for ahash on SEC1")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
