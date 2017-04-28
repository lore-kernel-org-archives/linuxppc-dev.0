Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDkGl5GHYzDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 16:21:19 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id t7so3838271pgt.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 23:21:19 -0700 (PDT)
Date: Fri, 28 Apr 2017 16:21:10 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Michael Ellerman
 <mpe@ellerman.id.au>
Subject: Re: [PATCH kernel v2] powerpc/powernv: Check kzalloc() return value
 in pnv_pci_table_alloc
Message-ID: <20170428162110.5cab6692@aik.ozlabs.ibm.com>
In-Reply-To: <49ac3f79-6f23-f6ab-6860-8cff16faf5de@ozlabs.ru>
References: <20170327082737.14448-1-aik@ozlabs.ru>
 <49ac3f79-6f23-f6ab-6860-8cff16faf5de@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 11 Apr 2017 18:28:42 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 27/03/17 19:27, Alexey Kardashevskiy wrote:
> > pnv_pci_table_alloc() ignores possible failure from kzalloc_node(),
> > this adds a check. There are 2 callers of pnv_pci_table_alloc(),
> > one already checks for tbl!=NULL, this adds WARN_ON() to the other path
> > which only happens during boot time in IODA1 and not expected to fail.
> > 
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> > Changes:
> > v2:
> > * s/BUG_ON/WARN_ON/  
> 
> Bad/good?

Ping?


> 
> 
> > ---
> >  arch/powerpc/platforms/powernv/pci-ioda.c | 3 +++
> >  arch/powerpc/platforms/powernv/pci.c      | 3 +++
> >  2 files changed, 6 insertions(+)
> > 
> > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> > index e36738291c32..04ef03a5201b 100644
> > --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > @@ -2128,6 +2128,9 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
> >  
> >  found:
> >  	tbl = pnv_pci_table_alloc(phb->hose->node);
> > +	if (WARN_ON(!tbl))
> > +		return;
> > +
> >  	iommu_register_group(&pe->table_group, phb->hose->global_number,
> >  			pe->pe_number);
> >  	pnv_pci_link_table_and_group(phb->hose->node, 0, tbl, &pe->table_group);
> > diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> > index eb835e977e33..9acdf6889c0d 100644
> > --- a/arch/powerpc/platforms/powernv/pci.c
> > +++ b/arch/powerpc/platforms/powernv/pci.c
> > @@ -766,6 +766,9 @@ struct iommu_table *pnv_pci_table_alloc(int nid)
> >  	struct iommu_table *tbl;
> >  
> >  	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, nid);
> > +	if (!tbl)
> > +		return NULL;
> > +
> >  	INIT_LIST_HEAD_RCU(&tbl->it_group_list);
> >  
> >  	return tbl;
> >   
> 
> 



--
Alexey
