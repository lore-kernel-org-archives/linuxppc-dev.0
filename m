Return-Path: <mhcerri@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp02.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DDEF02C009C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Aug 2013 00:32:50 +1000 (EST)
Received: from /spool/local
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mhcerri@linux.vnet.ibm.com>;
 Thu, 29 Aug 2013 11:32:43 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 352DA3520060
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 10:32:41 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay02.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7TEUwTt42664108
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 11:30:58 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7TEWe98008007
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 11:32:40 -0300
Date: Thu, 29 Aug 2013 11:32:36 -0300
From: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 03/10] crypto: nx - fix limits to sg lists for AES-CBC
Message-ID: <20130829143235.GA31059@oc8526070481.ibm.com>
References: <1377288074-18998-1-git-send-email-mhcerri@linux.vnet.ibm.com>
 <1377288074-18998-4-git-send-email-mhcerri@linux.vnet.ibm.com>
 <20130829044221.GA25208@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130829044221.GA25208@gondor.apana.org.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 29, 2013 at 02:42:22PM +1000, Herbert Xu wrote:
> On Fri, Aug 23, 2013 at 05:01:07PM -0300, Marcelo Cerri wrote:
> > This patch updates the nx-aes-cbc implementation to perform several
> > hyper calls if needed in order to always respect the length limits for
> > scatter/gather lists.
> > 
> > Two different limits are considered:
> > 
> >  - "ibm,max-sg-len": maximum number of bytes of each scatter/gather
> >    list.
> > 
> >  - "ibm,max-sync-cop":
> >     - The total number of bytes that a scatter/gather list can hold.
> >     - The maximum number of elements that a scatter/gather list can have.
> > 
> > Reviewed-by: Joy Latten <jmlatten@linux.vnet.ibm.com>
> > Signed-off-by: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>
> 
> This patch does not apply against the current cryptodev tree.
> 
> Please regenerate your pathces.

Sorry for this. I'm sending a v2 series without conflicts.

> 
> Thanks,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-crypto" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
