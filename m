Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C1D71A00E9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 12:33:00 +1000 (AEST)
Date: Fri, 8 May 2015 10:32:34 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Dan Streetman <ddstreet@ieee.org>
Subject: Re: [PATCH 10/10] drivers/crypto/nx: add hardware 842 crypto comp alg
Message-ID: <20150508023234.GB7803@gondor.apana.org.au>
References: <1428428070-17803-1-git-send-email-ddstreet@ieee.org>
 <1430931066-4536-1-git-send-email-ddstreet@ieee.org>
 <1430931066-4536-11-git-send-email-ddstreet@ieee.org>
 <20150507031238.GC29395@gondor.apana.org.au>
 <CALZtONBBoy=sM8Qt43-_k8BWTwSKA3FaJg9JMfJHzJ3wh5+kvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALZtONBBoy=sM8Qt43-_k8BWTwSKA3FaJg9JMfJHzJ3wh5+kvQ@mail.gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 linux-kernel <linux-kernel@vger.kernel.org>, Robert Jennings <rob@pochix.net>,
 Paul Mackerras <paulus@samba.org>, linux-crypto@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Seth Jennings <sjennings@variantweb.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 07, 2015 at 11:06:06AM -0400, Dan Streetman wrote:
> 
> The crypto 842-nx has (significant) code in it to handle any alignment
> and length input buffers, to match them to what the driver requires.
> Would it be better to move that into the crypto code, so that any
> crypto compression hw driver can request buffers be specifically
> aligned/sized?  I did have to use a header on each compressed buffer
> that needed re-alignment or re-sizing, so maybe it's not appropriate
> for common crypto compression code.

Yes we could certainly move this logic into the crypto layer, as
we do for ciphers and hashes.

But as you say we could make the next guy who writes a comp driver
do this :)

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
