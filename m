Return-Path: <horia.geanta@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0073.outbound.protection.outlook.com [104.47.1.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ztHdG66WTzF1pv
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Mar 2018 05:19:29 +1100 (AEDT)
From: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
CC: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 1/2] crypto: talitos - don't persistently map
 req_ctx->hw_context and req_ctx->buf
Date: Fri, 2 Mar 2018 18:19:23 +0000
Message-ID: <VI1PR0402MB3342DC809DACC396FAA21A4698C50@VI1PR0402MB3342.eurprd04.prod.outlook.com>
References: <7c934f0788d60bd82fb1cb51d712c9ab1ea7fcb4.1519660621.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/26/2018 6:40 PM, Christophe Leroy wrote:=0A=
> Commit 49f9783b0cea ("crypto: talitos - do hw_context DMA mapping=0A=
> outside the requests") introduced a persistent dma mapping of=0A=
> req_ctx->hw_context=0A=
> Commit 37b5e8897eb5 ("crypto: talitos - chain in buffered data for ahash=
=0A=
> on SEC1") introduced a persistent dma mapping of req_ctx->buf=0A=
> =0A=
> As there is no destructor for req_ctx (the request context), the=0A=
> associated dma handlers where set in ctx (the tfm context). This is=0A=
> wrong as several hash operations can run with the same ctx.=0A=
> =0A=
> This patch removes this persistent mapping.=0A=
> =0A=
> Reported-by: Horia Geanta <horia.geanta@nxp.com>=0A=
> Fixes: 49f9783b0cea ("crypto: talitos - do hw_context DMA mapping outside=
 the requests")=0A=
> Fixes: 37b5e8897eb5 ("crypto: talitos - chain in buffered data for ahash =
on SEC1")=0A=
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>=0A=
Tested-by: Horia Geant=E3 <horia.geanta@nxp.com>=0A=
=0A=
Please add this to 4.15.y -stable tree.=0A=
=0A=
Thanks,=0A=
Horia=0A=
