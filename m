Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkS9F0VnMzDqry
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 01:14:41 +1000 (AEST)
Date: Tue, 5 Jul 2016 23:14:15 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Anton Blanchard <anton@ozlabs.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 davem@davemloft.net, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH 2/2] crypto: powerpc: Add POWER8 optimised crc32c
Message-ID: <20160705151415.GA8117@gondor.apana.org.au>
References: <1467325185-21091-1-git-send-email-anton@ozlabs.org>
 <1467325185-21091-2-git-send-email-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467325185-21091-2-git-send-email-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 01, 2016 at 08:19:45AM +1000, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> Use the vector polynomial multiply-sum instructions in POWER8 to
> speed up crc32c.
> 
> This is just over 41x faster than the slice-by-8 method that it
> replaces. Measurements on a 4.1 GHz POWER8 show it sustaining
> 52 GiB/sec.
> 
> A simple btrfs write performance test:
> 
>     dd if=/dev/zero of=/mnt/tmpfile bs=1M count=4096
>     sync
> 
> is over 3.7x faster.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Both patches applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
