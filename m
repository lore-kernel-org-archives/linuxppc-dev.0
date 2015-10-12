Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BCF191A08C9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 08:10:27 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Mon, 12 Oct 2015 17:10:25 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id CC6706E8068
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 16:58:34 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9CLAMim51118284
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 21:10:22 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9CLALqT016630
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 17:10:22 -0400
Date: Mon, 12 Oct 2015 14:10:19 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Matthew Wilcox <willy@linux.intel.com>,
 Keith Busch <keith.busch@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/iommu: expose IOMMU page shift
Message-ID: <20151012211019.GC26702@linux.vnet.ibm.com>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002171800.GB41011@linux.vnet.ibm.com>
 <20151006031943.GC3861@voom.fritz.box>
 <20151012160352.GA24212@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151012160352.GA24212@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12.10.2015 [09:03:52 -0700], Nishanth Aravamudan wrote:
> On 06.10.2015 [14:19:43 +1100], David Gibson wrote:
> > On Fri, Oct 02, 2015 at 10:18:00AM -0700, Nishanth Aravamudan wrote:
> > > We will leverage this macro in the NVMe driver, which needs to know the
> > > configured IOMMU page shift to properly configure its device's page
> > > size.
> > > 
> > > Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> > > 
> > > ---
> > > Given this is available, it seems reasonable to expose -- and it doesn't
> > > really make sense to make the driver do a log2 call on the existing
> > > IOMMU_PAGE_SIZE() value.
> > > 
> > > diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
> > > index ca18cff..6fdf857 100644
> > > --- a/arch/powerpc/include/asm/iommu.h
> > > +++ b/arch/powerpc/include/asm/iommu.h
> > > @@ -36,6 +36,7 @@
> > >  #define IOMMU_PAGE_MASK_4K       (~((1 << IOMMU_PAGE_SHIFT_4K) - 1))
> > >  #define IOMMU_PAGE_ALIGN_4K(addr) _ALIGN_UP(addr, IOMMU_PAGE_SIZE_4K)
> > >  
> > > +#define IOMMU_PAGE_SHIFT(tblptr) (tblptr)->it_page_shift
> > >  #define IOMMU_PAGE_SIZE(tblptr) (ASM_CONST(1) << (tblptr)->it_page_shift)
> > 
> > Seems like it would be a touch safer to alter IOMMU_PAGE_SIZE so it
> > uses the new IOMMU_PAGE_SHIFT macro.
> 
> Yes absolutely! Sorry, I initially didn't add the first macro, so didn't
> think that through. Will update.

Err, replied too quickly -- just got back from vacation -- this is
from an old version of the patchset, we no longer introduce this macro.

-Nish
