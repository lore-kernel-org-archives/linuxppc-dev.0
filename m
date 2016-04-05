Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qfT7C0m0TzDq6T
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 22:43:51 +1000 (AEST)
Date: Tue, 5 Apr 2016 20:11:19 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 jwboyer@linux.vnet.ibm.com, mpm@selenic.com
Subject: Re: crash in ppc4xx-rng on canyonland
Message-ID: <20160405121118.GA12591@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2309246.SDn0H6XuZk@debian64>
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
> The crash is caused by a bad read in ppc4xx_rng_enable [0]. From what I
> can tell, the driver is mapping the crypto control registers. The
> problem is that they are claimed by the main crypto driver: crypto4xx [1].
> 
> I'm not sure what to do in this case. In my opinion the crypto4xx driver
> should just initialize the trng [see patch]. I would like to move the
> trng into the crypto-ppc4xx, but given that this breaks some of the DTS
> out there I'm not sure.

I think you'll also need to ensure that the crypto module is
successfully loaded before the RNG is accessed.

It's probably easier to just merge the two drivers but still
maintaining the original driver names.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
