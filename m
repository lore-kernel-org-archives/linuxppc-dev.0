Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.apana.org.au (helcar.apana.org.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0927A1A0877
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jan 2015 11:18:54 +1100 (AEDT)
Date: Mon, 26 Jan 2015 11:18:43 +1100
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Markus Stockhausen <stockhausen@collogia.de>
Subject: Re: [PATCH v1 0/3] SHA256 for PPC/SPE
Message-ID: <20150126001842.GA18477@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5ad377b3-e491-4c35-8b89-de1dfd0749a6@EXCHANGE.collogia.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Markus Stockhausen <stockhausen@collogia.de> wrote:
> 
> [PATCH v1 0/3] SHA256 for PPC/SPE
> 
> The following patches add support for SIMD accelerated SHA256 
> calculation on PPC processors with SPE instruction set. The 
> implementation takes care of the following constraints:
> 
> - independant of processor endianess
> - fallback to generic code if called from interrupt context
> - disable preemtion only for short intervals

Thanks for the patch! Unfortunately the interrupt context test
is a bummer because that means your code won't be used by IPsec
at all.

Would it be possible to relax the conditions similar to sha1_ssse3
on x86? If not how about going async with cryptd?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
