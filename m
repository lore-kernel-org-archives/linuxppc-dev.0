Return-Path: <pfsmorigo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skdgL0SrMzDrLP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 23:23:09 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8SDN6Uq057674
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 09:23:07 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25r89h2je5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 09:23:07 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pfsmorigo@linux.vnet.ibm.com>;
 Wed, 28 Sep 2016 10:23:03 -0300
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 670F93520074
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 09:22:36 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8SDN0DQ33226972
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 10:23:00 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8SDN0pL001378
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 10:23:00 -0300
Date: Wed, 28 Sep 2016 10:22:51 -0300
From: Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Marcelo Cerri <marcelo.cerri@canonical.com>,
 Jan Stancek <jstancek@redhat.com>, rui y wang <rui.y.wang@intel.com>,
 mhcerri@linux.vnet.ibm.com, leosilva@linux.vnet.ibm.com,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [bug] crypto/vmx/p8_ghash memory corruption in 4.8-rc7
References: <1655600242.1561022.1474676547316.JavaMail.zimbra@redhat.com>
 <20160926145934.GA5520@gondor.apana.org.au>
 <20160926174317.GA21317@gallifrey>
 <20160927030826.GB8579@gondor.apana.org.au>
 <346154437.225735.1474966863173.JavaMail.zimbra@redhat.com>
 <20160927120414.GC21317@gallifrey>
 <20160927194644.GB15729@gallifrey>
 <20160928024549.GB14034@gondor.apana.org.au>
 <20160928122844.GC15729@gallifrey>
 <20160928123318.GB20839@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160928123318.GB20839@gondor.apana.org.au>
Message-Id: <20160928132251.GB5010@dublin>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wed, Sep 28, 2016 at 08:33:18PM +0800, Herbert Xu wrote:
> On Wed, Sep 28, 2016 at 09:28:44AM -0300, Marcelo Cerri wrote:
> >
> > The big difference between p8_ghash and padlock_sha1 is that
> > padlock_sha1 defines alg->statesize as sizeof(struct sha1_state), which
> > is the descsize value used by sha1_generic. This probably works but
> > it's also wrong because the padlock_sha1 driver does not ensures that
> > sha1_generic is always used.
> 
> It should work because all our SHA implementations use the same
> export format.  This is not necessarily the case for GHASH though.
> 
> > So, one solution is to hardcode ghash-generic as the fallback algorithm
> > and update the descsize direct in its shash_alg structure. There's only
> > one problem with that. ghash-generic desc type (struct ghash_desc_ctx)
> > is not available for vmx_crypto at compile type, the type is defined
> > directly in crypto/ghash-generic.c. That's the reason I added a function
> > to get the fallback desc size at runtime in the patch I wrote as a prove
> > of concept.
> 
> The problem with your patch is that there is no guarantee that
> you will get the same algorithm every time you allocate a fallback.
> Someone may have loaded a new module for example.
> 
> So I think the safe approach is to stick with ghash-generic and
> expose its state data structure in a header file.

Since generic is the only posible fallback for ppc, I think that's a
good solution. :)

> 
> Thanks,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> 

-- 
Paulo Flabiano Smorigo
IBM Linux Technology Center
