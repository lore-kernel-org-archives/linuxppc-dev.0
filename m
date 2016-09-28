Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skdMv2p94zDrMD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 23:09:47 +1000 (AEST)
Date: Wed, 28 Sep 2016 21:09:13 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Marcelo Cerri <marcelo.cerri@canonical.com>
Cc: Jan Stancek <jstancek@redhat.com>, rui y wang <rui.y.wang@intel.com>,
 mhcerri@linux.vnet.ibm.com, leosilva@linux.vnet.ibm.com,
 pfsmorigo@linux.vnet.ibm.com, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [bug] crypto/vmx/p8_ghash memory corruption in 4.8-rc7
Message-ID: <20160928130913.GA21123@gondor.apana.org.au>
References: <20160927030826.GB8579@gondor.apana.org.au>
 <346154437.225735.1474966863173.JavaMail.zimbra@redhat.com>
 <20160927120414.GC21317@gallifrey>
 <20160927194644.GB15729@gallifrey>
 <20160928024549.GB14034@gondor.apana.org.au>
 <1597189480.51836.1475048451846.JavaMail.zimbra@redhat.com>
 <20160928122935.GA20839@gondor.apana.org.au>
 <20160928123841.GD15729@gallifrey>
 <20160928124452.GA21011@gondor.apana.org.au>
 <20160928125558.GE15729@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160928125558.GE15729@gallifrey>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 28, 2016 at 09:55:58AM -0300, Marcelo Cerri wrote:
> 
> Great! If we check the descsize every time a fallback tfm is allocated
> that should be enough to prevent bigger problems such as memory
> corruptions.

Yes a check wouldn't hurt.
 
> Can I move ghash_desc_ctx to a header file under include/crypto/? Or do
> you do you prefer to do that?

No you can go ahead and do the move.

> Maybe include/crypto/internal/hash.h or a new header file
> include/crypto/internal/ghash.h ?

Let's put it in include/crypto/ghash.h.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
