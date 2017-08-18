Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYn5Y2pvPzDrL4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Aug 2017 01:27:45 +1000 (AEST)
Date: Fri, 18 Aug 2017 10:27:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>,
 kvm@vger.kernel.org, Yongji Xie <elohimes@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, shan.gavin@gmail.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH kernel] PCI: Disable IOV before pcibios_sriov_disable()
Message-ID: <20170818152740.GL28977@bhelgaas-glaptop.roam.corp.google.com>
References: <20170811081933.17474-1-aik@ozlabs.ru>
 <2163ef83-3633-a8cf-3416-0e37a6c500db@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2163ef83-3633-a8cf-3416-0e37a6c500db@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 18, 2017 at 08:05:42AM +1000, Alexey Kardashevskiy wrote:
> On 11/08/17 18:19, Alexey Kardashevskiy wrote:
> > From: Gavin Shan <gwshan@linux.vnet.ibm.com>
> > 
> > The PowerNV platform is the only user of pcibios_sriov_disable().
> > The IOV BAR could be shifted by pci_iov_update_resource(). The
> > warning message in the function is printed if the IOV capability
> > is in enabled (PCI_SRIOV_CTRL_VFE && PCI_SRIOV_CTRL_MSE) state.
> > 
> > This is the backtrace of what is happening:
> >    pci_disable_sriov
> >    sriov_disable
> >    pnv_pci_sriov_disable
> >    pnv_pci_vf_resource_shift
> >    pci_update_resource
> >    pci_iov_update_resource
> > 
> > This fixes the issue by disabling IOV capability before calling
> > pcibios_sriov_disable(). With it, the disabling path matches
> > the enabling path: pcibios_sriov_enable() is called before the
> > IOV capability is enabled.
> > 
> > Cc: shan.gavin@gmail.com
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Reported-by: Carol L Soto <clsoto@us.ibm.com>
> > Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> > Tested-by: Carol L Soto <clsoto@us.ibm.com>
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> > 
> > This is repost. Since Gavin left the team, I am trying to push it out.
> > The previos converstion is here: https://patchwork.ozlabs.org/patch/732653/
> > 
> > Two questions were raised then. I'll try to comment on this below.
> 
> Bjorn, ping? Thanks.

Thanks for the reminder.  This is in patchwork, so it's on my to-do
list.

My last response in the thread above was:

  I'm not going to merge this without a comment in
  pnv_pci_vf_resource_shift() that addresses the two questions I
  raised in my very first response.  I don't think the existing
  comment about "After doing so, there would be a 'hole'" is
  sufficient.  If it were sufficient, I wouldn't have raised the
  questions in the first place.

The problem here is that I'm looking for a comment *in the code*, and
you and Gavin are giving responses and clarifications in email.

What we need to do is transfer this email information into something
useful when reading the code, i.e., a comment in the code.

> >> 1) "res" is already in the resource tree, so we shouldn't be changing
> >>   its start address, because that may make the tree inconsistent,
> >>   e.g., the resource may no longer be completely contained in its
> >>   parent, it may conflict with a sibling, etc.
> > 
> > We should not, yes. But...
> > 
> > At the boot time IOV BAR gets as much MMIO space as it can possibly use.
> > (Embarassingly I cannot trace where this is coming from, 8GB is selected
> > via pci_assign_unassigned_root_bus_resources() path somehow).
> > For example, it is 256*32MB=8GB where 256 is maximum PEs number and 32MB
> > is a PF/VF BAR size. Whatever shifting we do afterwards, the boudaries of
> > that 8GB area do not change and we test it in pnv_pci_vf_resource_shift():
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/platforms/powernv/pci-ioda.c#n987
> > 
> >> 2) If we update "res->start", shouldn't we update "res->end"
> >>   correspondingly?
> > 
> > We have to update the PF's IOV BAR address as we allocate PEs dynamically
> > and we do not know in advance where our VF numbers start in that
> > 8GB window. So we change IOV BASR start. Changing the end may make it
> > look more like there is a free area to use but in reality it won't be
> > usable as well as the area we "release" by shifting the start address.
> > 
> > We could probably move that M64 MMIO window by the same delta in
> > opposite direction so the IOV BAR start address would remain the same
> > but its VF#0 would be mapped to let's say PF#5. I am just afraid there
> > is an alignment requirement for these M64 window start address; and this
> > would be even more tricky to manage.
> > 
> > We could also create reserved areas for the amount of space "release" by
> > moving the start address, not sure how though.
> > 
> > So how do we proceed with this particular patch now? Thanks.
> > ---
> >  drivers/pci/iov.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > index 120485d6f352..ac41c8be9200 100644
> > --- a/drivers/pci/iov.c
> > +++ b/drivers/pci/iov.c
> > @@ -331,7 +331,6 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
> >  	while (i--)
> >  		pci_iov_remove_virtfn(dev, i, 0);
> >  
> > -	pcibios_sriov_disable(dev);
> >  err_pcibios:
> >  	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
> >  	pci_cfg_access_lock(dev);
> > @@ -339,6 +338,8 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
> >  	ssleep(1);
> >  	pci_cfg_access_unlock(dev);
> >  
> > +	pcibios_sriov_disable(dev);
> > +
> >  	if (iov->link != dev->devfn)
> >  		sysfs_remove_link(&dev->dev.kobj, "dep_link");
> >  
> > @@ -357,14 +358,14 @@ static void sriov_disable(struct pci_dev *dev)
> >  	for (i = 0; i < iov->num_VFs; i++)
> >  		pci_iov_remove_virtfn(dev, i, 0);
> >  
> > -	pcibios_sriov_disable(dev);
> > -
> >  	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
> >  	pci_cfg_access_lock(dev);
> >  	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
> >  	ssleep(1);
> >  	pci_cfg_access_unlock(dev);
> >  
> > +	pcibios_sriov_disable(dev);
> > +
> >  	if (iov->link != dev->devfn)
> >  		sysfs_remove_link(&dev->dev.kobj, "dep_link");
> >  
> > 
> 
> 
> -- 
> Alexey
