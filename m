Return-Path: <ddstreet@gmail.com>
Received: from mail-ig0-x22a.google.com (mail-ig0-x22a.google.com
 [IPv6:2607:f8b0:4001:c05::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ECE021A058C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 01:06:29 +1000 (AEST)
Received: by igbpi8 with SMTP id pi8so13173010igb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2015 08:06:26 -0700 (PDT)
MIME-Version: 1.0
Sender: ddstreet@gmail.com
In-Reply-To: <20150507031238.GC29395@gondor.apana.org.au>
References: <1428428070-17803-1-git-send-email-ddstreet@ieee.org>
 <1430931066-4536-1-git-send-email-ddstreet@ieee.org>
 <1430931066-4536-11-git-send-email-ddstreet@ieee.org>
 <20150507031238.GC29395@gondor.apana.org.au>
From: Dan Streetman <ddstreet@ieee.org>
Date: Thu, 7 May 2015 11:06:06 -0400
Message-ID: <CALZtONBBoy=sM8Qt43-_k8BWTwSKA3FaJg9JMfJHzJ3wh5+kvQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] drivers/crypto/nx: add hardware 842 crypto comp alg
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

On Wed, May 6, 2015 at 11:12 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Wed, May 06, 2015 at 12:51:06PM -0400, Dan Streetman wrote:
>> Add crypto compression alg for 842 hardware compression and decompression.
>>
>> This crypto compression alg is named "nx842" to indicate it uses hardware
>> to perform the compression and decompression, while the software 842
>> compression alg is named "sw842".  However, since before this split there
>> was only one 842 compression alg named "842" which only used hardware,
>> this is also aliased "842" for backwards compatibility.
>
> This should still be called 842.  You can set the driver name to
> nx842 or 842-nx.

ah, ok, will do.

So, I'm wondering about the common NX 842 frontend driver, for the
pSeries and PowerNV platform drivers.  The current setup is:

[ crypto "842-nx" driver ]
           v
[ nx-842 main driver ]
          v
[ nx-842 pSeries driver | nx-842 PowerNV driver ]

The main reason for that is that the HW has specific constraints,
specifically each input and output buffer passed to it for comp or
decomp has to:
-be located at a specific alignment
-have a length of a specific multiple
-have a length between a specific minimum and maximum

The crypto 842-nx has (significant) code in it to handle any alignment
and length input buffers, to match them to what the driver requires.
Would it be better to move that into the crypto code, so that any
crypto compression hw driver can request buffers be specifically
aligned/sized?  I did have to use a header on each compressed buffer
that needed re-alignment or re-sizing, so maybe it's not appropriate
for common crypto compression code.

Since there doesn't seem to be any other hw compression drivers (yet),
maybe it should stay in the 842-nx code, at least for now.  Hopefully
any future compression hw won't have alignment or length multiple
restrictions...

>
> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
