Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C3B071A0725
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Sep 2015 19:57:16 +1000 (AEST)
Message-ID: <1441360635.3777.1.camel@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc/powernv/pci-ioda: fix 32-bit TCE table init
 in kdump kernel
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Hari Bathini
 <hbathini@linux.vnet.ibm.com>, Gavin Shan <gwshan@linux.vnet.ibm.com>, Ben
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>, Wei Yang
 <weiyang@linux.vnet.ibm.com>,  linuxppc-dev@lists.ozlabs.org
Date: Fri, 04 Sep 2015 19:57:15 +1000
In-Reply-To: <20150903155944.GD47557@linux.vnet.ibm.com>
References: <20150902011123.GA47557@linux.vnet.ibm.com>
 <55E6BAAF.9090502@ozlabs.ru> <20150902153928.GB47557@linux.vnet.ibm.com>
 <1441274333.26379.4.camel@ellerman.id.au>
 <20150903155944.GD47557@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-09-03 at 08:59 -0700, Nishanth Aravamudan wrote:
> On 03.09.2015 [19:58:53 +1000], Michael Ellerman wrote:
> > On Wed, 2015-09-02 at 08:39 -0700, Nishanth Aravamudan wrote:
> > > On 02.09.2015 [19:00:31 +1000], Alexey Kardashevskiy wrote:
> > > > On 09/02/2015 11:11 AM, Nishanth Aravamudan wrote:
> > > > >diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> > > > >index 85cbc96eff6c..0d7967e31169 100644
> > > > >--- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > > > >+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > > > >@@ -2077,10 +2077,17 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
> > > > >  {
> > > > >  	struct iommu_table *tbl = NULL;
> > > > >  	long rc;
> > > > >+	/*
> > > > >+	 * In memory constrained environments, e.g. kdump kernel, the
> > > > >+	 * DMA window can be larger than available memory, which will
> > > > >+	 * cause errors later.
> > > > >+	 */
> > > > >+	__u64 window_size =
> > > > 
> > > > I asked for "const __u64" ;)
> > > 
> > > I knew I'd forget something!
> > 
> > Nish! In future please send a reply with the above comment, and then
> > the v2 as a separate mail, otherwise I have to manually edit out your
> > comment when applying.
> 
> Sorry! Will amend my practices in the future.

Thanks.

I concede none of this is documented anywhere, maybe one day I'll have the time
to do that :)

> > > Fixes: aca6913f5551 ("powerpc/powernv/ioda2: Introduce helpers to allocate TCE pages")
> > 
> > That went into 4.2, so should this have a:
> > 
> > Cc: stable@vger.kernel.org # 4.2
> 
> Grr, another mess-up, you're right, it should. Can you amend on your
> end? Sorry, I was in too much of a hurry to get the fixlet out.

That's OK, I'll fix it up.

cheers
