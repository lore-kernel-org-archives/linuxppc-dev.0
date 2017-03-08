Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.apana.org.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdRww4B8WzDqYd
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 19:47:28 +1100 (AEDT)
Date: Wed, 8 Mar 2017 16:47:10 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 anton@samba.org, dja@axtens.net
Subject: Re: [PATCH] crypto: powerpc - Fix initialisation of crc32c context
Message-ID: <20170308084710.GA4867@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170303065655.7317-1-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Daniel Axtens <dja@axtens.net> wrote:
> Turning on crypto self-tests on a POWER8 shows:
> 
>    alg: hash: Test 1 failed for crc32c-vpmsum
>    00000000: ff ff ff ff
> 
> Comparing the code with the Intel CRC32c implementation on which
> ours is based shows that we are doing an init with 0, not ~0
> as CRC32c requires.
> 
> This probably wasn't caught because btrfs does its own weird
> open-coded initialisation.
> 
> Initialise our internal context to ~0 on init.
> 
> This makes the self-tests pass, and btrfs continues to work.
> 
> Fixes: 6dd7a82cc54e ("crypto: powerpc - Add POWER8 optimised crc32c")
> Cc: Anton Blanchard <anton@samba.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
