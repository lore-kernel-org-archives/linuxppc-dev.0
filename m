Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpNt43xjCzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 19:59:56 +1000 (AEST)
Date: Mon, 18 Apr 2016 17:59:39 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: crash in ppc4xx-rng on canyonland
Message-ID: <20160418095939.GA18915@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2508973.j7LtCUZRGZ@debian64>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christian Lamparter <chunkeey@googlemail.com> wrote:
> 
> I tried to move ppc4xx-rng into crypto4xx (see attachment - patch #1).
> The driver works as is. But I can't come up with a way to attach the
> crypto4xx driver to the ppc4xx-rng OF node cleanly. Basically,
> I'm looking for a way to have one driver (with one context) be 
> in charge of two different OF nodes (ppc4xx-rng and ppc4xx-crypto).
> Is there any solution to this? Because otherwise, I would add a

Is it possible to have an RNG unit without the crypto unit? If not
then your first patch should be OK, provided that you add some error
handling when the RNG probe fails.  For example, if the RNG probe
fails we should probably not call remove on it later.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
