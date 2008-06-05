Return-Path: <herbert@gondor.apana.org.au>
Received: from arnor.apana.org.au (rhun.apana.org.au [64.62.148.172])
	by ozlabs.org (Postfix) with ESMTP id 4D7C4DDED1
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 15:54:30 +1000 (EST)
Date: Thu, 5 Jun 2008 15:22:24 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 2/2 v2] talitos: Freescale integrated security engine
	(SEC) driver
Message-ID: <20080605052224.GA23150@gondor.apana.org.au>
References: <20080530185830.60f4e1d4.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080530185830.60f4e1d4.kim.phillips@freescale.com>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, linuxppc-dev@ozlabs.org,
	linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 30, 2008 at 06:58:30PM -0500, Kim Phillips wrote:
>
> +	/* get random IV */
> +	get_random_bytes(req->giv, crypto_aead_ivsize(authenc));

Sorry but this is unworkable given our current RNG infrastructure.
Draining 16 bytes for every packet is going to make /dev/random
unuseable (if it wasn't already :).

Perhaps just use eseqiv (it should be pretty cheap sinec it just
tacks on an extra block to the encryption) for now until we have
a PRNG?

We'll need to extend eseqiv to support AEAD first though.  Perhaps
change it so that it can be called as a library by AEAD algorithms?

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
