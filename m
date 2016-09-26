Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjRwX5xdQzDrRW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 01:00:28 +1000 (AEST)
Date: Mon, 26 Sep 2016 22:59:34 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jan Stancek <jstancek@redhat.com>
Cc: rui.y.wang@intel.com, mhcerri@linux.vnet.ibm.com,
 leosilva@linux.vnet.ibm.com, pfsmorigo@linux.vnet.ibm.com,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [bug] crypto/vmx/p8_ghash memory corruption in 4.8-rc7
Message-ID: <20160926145934.GA5520@gondor.apana.org.au>
References: <450861381.1559123.1474673197124.JavaMail.zimbra@redhat.com>
 <1655600242.1561022.1474676547316.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1655600242.1561022.1474676547316.JavaMail.zimbra@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 23, 2016 at 08:22:27PM -0400, Jan Stancek wrote:
>
> This seems to directly correspond with:
>   p8_ghash_alg.descsize = sizeof(struct p8_ghash_desc_ctx) == 56
>   shash_tfm->descsize = sizeof(struct p8_ghash_desc_ctx) + crypto_shash_descsize(fallback) == 56 + 20
> where 20 is presumably coming from "ghash_alg.descsize".
> 
> My gut feeling was that these 2 should match, but I'd love to hear
> what crypto people think.

Indeed.  The vmx driver is broken.  It is allocating a fallback
but is not providing any space for the state of the fallback.

Unfortunately our interface doesn't really provide a way to provide
the state size dynamically.  So what I'd suggest is to fix the
fallback to the generic ghash implementation and export its state
size like we do for md5/sha.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
