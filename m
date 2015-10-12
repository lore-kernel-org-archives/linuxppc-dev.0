Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F1E21A018C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 03:04:02 +1100 (AEDT)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Mon, 12 Oct 2015 10:03:58 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 97EDC3E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 10:03:55 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9CG2tR811600368
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 09:02:55 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9CG3rWO013178
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 10:03:55 -0600
Date: Mon, 12 Oct 2015 09:03:52 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Matthew Wilcox <willy@linux.intel.com>,
 Keith Busch <keith.busch@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/iommu: expose IOMMU page shift
Message-ID: <20151012160352.GA24212@linux.vnet.ibm.com>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002171800.GB41011@linux.vnet.ibm.com>
 <20151006031943.GC3861@voom.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151006031943.GC3861@voom.fritz.box>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06.10.2015 [14:19:43 +1100], David Gibson wrote:
> On Fri, Oct 02, 2015 at 10:18:00AM -0700, Nishanth Aravamudan wrote:
> > We will leverage this macro in the NVMe driver, which needs to know the
> > configured IOMMU page shift to properly configure its device's page
> > size.
> > 
> > Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> > 
> > ---
> > Given this is available, it seems reasonable to expose -- and it doesn't
> > really make sense to make the driver do a log2 call on the existing
> > IOMMU_PAGE_SIZE() value.
> > 
> > diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
> > index ca18cff..6fdf857 100644
> > --- a/arch/powerpc/include/asm/iommu.h
> > +++ b/arch/powerpc/include/asm/iommu.h
> > @@ -36,6 +36,7 @@
> >  #define IOMMU_PAGE_MASK_4K       (~((1 << IOMMU_PAGE_SHIFT_4K) - 1))
> >  #define IOMMU_PAGE_ALIGN_4K(addr) _ALIGN_UP(addr, IOMMU_PAGE_SIZE_4K)
> >  
> > +#define IOMMU_PAGE_SHIFT(tblptr) (tblptr)->it_page_shift
> >  #define IOMMU_PAGE_SIZE(tblptr) (ASM_CONST(1) << (tblptr)->it_page_shift)
> 
> Seems like it would be a touch safer to alter IOMMU_PAGE_SIZE so it
> uses the new IOMMU_PAGE_SHIFT macro.

Yes absolutely! Sorry, I initially didn't add the first macro, so didn't
think that through. Will update.

-Nish
