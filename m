Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D5B101A240C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Sep 2015 01:59:52 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 3 Sep 2015 11:59:50 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 25EC36E8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2015 11:51:30 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t83FxjrI65011904
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Sep 2015 15:59:45 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t83Fxj9C007406
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Sep 2015 11:59:45 -0400
Date: Thu, 3 Sep 2015 08:59:44 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Ben Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/powernv/pci-ioda: fix 32-bit TCE table init
 in kdump kernel
Message-ID: <20150903155944.GD47557@linux.vnet.ibm.com>
References: <20150902011123.GA47557@linux.vnet.ibm.com>
 <55E6BAAF.9090502@ozlabs.ru>
 <20150902153928.GB47557@linux.vnet.ibm.com>
 <1441274333.26379.4.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441274333.26379.4.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03.09.2015 [19:58:53 +1000], Michael Ellerman wrote:
> On Wed, 2015-09-02 at 08:39 -0700, Nishanth Aravamudan wrote:
> > On 02.09.2015 [19:00:31 +1000], Alexey Kardashevskiy wrote:
> > > On 09/02/2015 11:11 AM, Nishanth Aravamudan wrote:
> > > >diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> > > >index 85cbc96eff6c..0d7967e31169 100644
> > > >--- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > > >+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > > >@@ -2077,10 +2077,17 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
> > > >  {
> > > >  	struct iommu_table *tbl = NULL;
> > > >  	long rc;
> > > >+	/*
> > > >+	 * In memory constrained environments, e.g. kdump kernel, the
> > > >+	 * DMA window can be larger than available memory, which will
> > > >+	 * cause errors later.
> > > >+	 */
> > > >+	__u64 window_size =
> > > 
> > > I asked for "const __u64" ;)
> > 
> > I knew I'd forget something!
> 
> Nish! In future please send a reply with the above comment, and then
> the v2 as a separate mail, otherwise I have to manually edit out your
> comment when applying.

Sorry! Will amend my practices in the future.

<snip>

> > Fixes: aca6913f5551 ("powerpc/powernv/ioda2: Introduce helpers to allocate TCE pages")
> 
> That went into 4.2, so should this have a:
> 
> Cc: stable@vger.kernel.org # 4.2

Grr, another mess-up, you're right, it should. Can you amend on your
end? Sorry, I was in too much of a hurry to get the fixlet out.

-Nish
