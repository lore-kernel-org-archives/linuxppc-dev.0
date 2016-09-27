Return-Path: <jstancek@redhat.com>
Received: from mx3-phx2.redhat.com (mx3-phx2.redhat.com [209.132.183.24])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjvvn3WBVzDrVJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 19:01:25 +1000 (AEST)
Date: Tue, 27 Sep 2016 05:01:03 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Marcelo Cerri <marcelo.cerri@canonical.com>,
 rui y wang <rui.y.wang@intel.com>, mhcerri@linux.vnet.ibm.com,
 leosilva@linux.vnet.ibm.com, pfsmorigo@linux.vnet.ibm.com,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Message-ID: <346154437.225735.1474966863173.JavaMail.zimbra@redhat.com>
In-Reply-To: <20160927030826.GB8579@gondor.apana.org.au>
References: <450861381.1559123.1474673197124.JavaMail.zimbra@redhat.com>
 <1655600242.1561022.1474676547316.JavaMail.zimbra@redhat.com>
 <20160926145934.GA5520@gondor.apana.org.au>
 <20160926174317.GA21317@gallifrey>
 <20160927030826.GB8579@gondor.apana.org.au>
Subject: Re: [bug] crypto/vmx/p8_ghash memory corruption in 4.8-rc7
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>





----- Original Message -----
> From: "Herbert Xu" <herbert@gondor.apana.org.au>
> To: "Marcelo Cerri" <marcelo.cerri@canonical.com>
> Cc: "Jan Stancek" <jstancek@redhat.com>, "rui y wang" <rui.y.wang@intel.com>, mhcerri@linux.vnet.ibm.com,
> leosilva@linux.vnet.ibm.com, pfsmorigo@linux.vnet.ibm.com, linux-crypto@vger.kernel.org,
> linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
> Sent: Tuesday, 27 September, 2016 5:08:26 AM
> Subject: Re: [bug] crypto/vmx/p8_ghash memory corruption in 4.8-rc7
> 
> On Mon, Sep 26, 2016 at 02:43:17PM -0300, Marcelo Cerri wrote:
> > 
> > Wouldn't be enough to provide a pair of import/export functions as the
> > padlock-sha driver does?
> 
> I don't think that will help as ultimately you need to call the
> export function on the fallback and that's what requires the extra
> memory.  In fact very operation involving the fallback will need
> that extra memory too.

So, if we extended p8_ghash_desc_ctx to accommodate fallback_desc's ctx
and then provided statesize/import/export, would that be acceptable?

struct p8_ghash_desc_ctx {
        ...
        struct shash_desc fallback_desc;
+       char fallback_ctx[sizeof(struct ghash_desc_ctx)];


Also, does that mean that padlock_sha has similar problem?
It does not seem to reserve any space for fallback __ctx and it calls
init()/update()/export() with padlock_sha_desc's fallback:

struct padlock_sha_desc {
        struct shash_desc fallback;
};

static struct shash_alg sha1_alg = {
        .descsize       =       sizeof(struct padlock_sha_desc),

Regards,
Jan

> 
> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> 
