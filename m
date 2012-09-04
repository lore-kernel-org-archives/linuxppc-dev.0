Return-Path: <dgibson@ozlabs.org>
Date: Wed, 5 Sep 2012 08:35:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc-powernv: added tce_get callback for powernv
 platform
Message-ID: <20120904223547.GD12554@truffula.fritz.box>
References: <1346744035-31154-1-git-send-email-aik@ozlabs.ru>
 <1346744158-31190-1-git-send-email-aik@ozlabs.ru>
 <1346787702.3025.7.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346787702.3025.7.camel@pasglop>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2012 at 05:41:42AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2012-09-04 at 17:35 +1000, Alexey Kardashevskiy wrote:
> > The upcoming VFIO support requires a way to know which
> > entry in the TCE map is not empty in order to do cleanup
> > at QEMU exit/crash. This patch adds such functionality
> > to POWERNV platform code.
> > 
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> >  arch/powerpc/platforms/powernv/pci.c |    6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> > index be3cfc5..61f8068 100644
> > --- a/arch/powerpc/platforms/powernv/pci.c
> > +++ b/arch/powerpc/platforms/powernv/pci.c
> > @@ -447,6 +447,11 @@ static void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
> >  		pnv_tce_invalidate(tbl, tces, tcep - 1);
> >  }
> >  
> > +static unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
> > +{
> > +	return ((u64 *)tbl->it_base)[index - tbl->it_offset] & IOMMU_PAGE_MASK;
> > +}
> 
> Why the masking here ?

Yes.  Especially since you're masking out the permission bits which
are actually the ones you want to determine if a TCE is empty or not.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
