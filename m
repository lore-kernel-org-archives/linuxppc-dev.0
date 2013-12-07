Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp02.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 433AC2C00C7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Dec 2013 22:58:43 +1100 (EST)
Received: from /spool/local
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Sat, 7 Dec 2013 09:58:38 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id F0BF1352006A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Dec 2013 06:58:31 -0500 (EST)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay02.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rB7BwED645940880
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 7 Dec 2013 09:58:15 -0200
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rB7BwVZq001748
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 7 Dec 2013 09:58:31 -0200
Date: Sat, 7 Dec 2013 09:58:29 -0200
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH] powernv: fix VFIO support with PHB3
Message-ID: <20131207115829.GA32319@oc0268524204.ibm.com>
References: <1386332504-18339-1-git-send-email-cascardo@linux.vnet.ibm.com>
 <52A272C4.1060303@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52A272C4.1060303@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, shangw@linux.vnet.ibm.com, paulus@samba.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Dec 07, 2013 at 11:58:44AM +1100, Alexey Kardashevskiy wrote:
> On 12/06/2013 11:21 PM, Thadeu Lima de Souza Cascardo wrote:
> > I have recently found out that no iommu_groups could be found under
> > /sys/ on a P8. That prevents PCI passthrough from working.
> > 
> > During my investigation, I found out there seems to be a missing
> > iommu_register_group for PHB3. The following patch seems to fix the
> > problem. After applying it, I see iommu_groups under
> > /sys/kernel/iommu_groups/, and can also bind vfio-pci to an adapter,
> > which gives me a device at /dev/vfio/.
> > 
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/platforms/powernv/pci-ioda.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> > index 084cdfa..2c6d173 100644
> > --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > @@ -720,6 +720,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
> >  		tbl->it_type = TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE;
> >  	}
> >  	iommu_init_table(tbl, phb->hose->node);
> > +	iommu_register_group(tbl, pci_domain_nr(pe->pbus), pe->pe_number);
> >  
> >  	if (pe->pdev)
> >  		set_iommu_table_base(&pe->pdev->dev, tbl);
> 
> 
> This does not seem absolutely right - normally set_iommu_table_base() is
> replaced with set_iommu_table_base_and_group() or you will not see some
> devices in a group and this may make VFIO unhappy.

Alexey,

Your patch "[PATCH v9] PPC: POWERNV: move iommu_add_device earlier" is
not upstream yet. It calls set_iommu_table_base_and_group properly.
However, without calling iommu_register_group, there is no group to add
the device to.

Compare to pnv_pci_ioda_setup_dma_pe which calls iommu_register_group
too. My patch fixes this discrepancy between IODA and IODA2.

Regards.
Cascardo.

> 
> But - if every single device gets assigned to some group, then we can push
> this to Frobisher and let people test in on power8.
> 
> 
> 
> -- 
> Alexey
