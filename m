Return-Path: <herbert@gondor.apana.org.au>
Received: from arnor.apana.org.au (rhun.apana.org.au [64.62.148.172])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B75B9DDEE0
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 00:36:43 +1000 (EST)
From: Herbert Xu <herbert@gondor.apana.org.au>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] synchronize_irq needs a barrier
In-Reply-To: <1192675254.12879.29.camel@pasglop>
Message-Id: <E1IiWTY-0000jx-00@gondolin.me.apana.org.au>
Date: Thu, 18 Oct 2007 22:35:52 +0800
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> Note that some kind of read barrier or compiler barrier should be needed
> regardless, or we are just not sync'ing with anything at all (we may
> have loaded the value ages ago and thus operate on a totally stale
> value). I prefer a full barrier to also ensure all previous stores are
> pushed out.

We already have a compiler barrier there in the form of cpu_relax.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
