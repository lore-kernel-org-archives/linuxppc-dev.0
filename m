Return-Path: <ddstreet@gmail.com>
Received: from mail-ig0-x232.google.com (mail-ig0-x232.google.com
 [IPv6:2607:f8b0:4001:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B0C451A0332
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 00:28:47 +1000 (AEST)
Received: by igbqf9 with SMTP id qf9so39596748igb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2015 07:28:44 -0700 (PDT)
MIME-Version: 1.0
Sender: ddstreet@gmail.com
In-Reply-To: <20150408141600.GA30338@gondor.apana.org.au>
References: <1428428070-17803-1-git-send-email-ddstreet@ieee.org>
 <1428428070-17803-10-git-send-email-ddstreet@ieee.org>
 <20150408141600.GA30338@gondor.apana.org.au>
From: Dan Streetman <ddstreet@ieee.org>
Date: Wed, 8 Apr 2015 10:28:23 -0400
Message-ID: <CALZtONC0WWkfaRs+0SNHaDQ1DhT+1ekgk0YXsQBi_2NRoP1e8Q@mail.gmail.com>
Subject: Re: [PATCH 09/11] crypto: remove LZO fallback from crypto 842
To: Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8
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

On Wed, Apr 8, 2015 at 10:16 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Tue, Apr 07, 2015 at 01:34:28PM -0400, Dan Streetman wrote:
>> Update the crypto 842 driver to no longer fallback to LZO if the 842
>> hardware is unavailable.  Simplify the crpypto 842 driver to remove all
>> headers indicating 842/lzo.
>>
>> The crypto 842 driver should do 842-format compression and decompression
>> only.  It should not fallback to LZO compression/decompression.  The
>> user of the crypto 842 driver can fallback to another format if desired.
>>
>> Signed-off-by: Dan Streetman <ddstreet@ieee.org>
>
> Thanks for the series.  I don't know how I missed it when it was
> merged originally but crypto/842.c needs to be moved over to
> drivers/crypto.  Your software implementation should take its
> places as the reference implementation.

So, the sw implementation is only for decompression; there's no sw
compression implementation in these patches.

The hw 842 driver is currently at drivers/crypto/nx, and the
crypto/842 driver just calls the hw driver (after correctly
aligning/sizing the provided buffers to what the hw driver expects),
and falls back to the sw decompression if the hw decompression fails
(there is no compression fallback, a failure is reported to the
caller).

Is that setup ok?  If users had to directly call the hw driver,
instead of using the generic crypto_comp interface, it would
complicate things, e.g. in zswap it only expects to call
crypto_comp_compress()/decompress(), not call the 842 hw driver
directly.


>
> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
