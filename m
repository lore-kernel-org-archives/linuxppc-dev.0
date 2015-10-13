Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 863761A0702
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 13:30:37 +1100 (AEDT)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B1758140FDB
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 13:30:36 +1100 (AEDT)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 13 Oct 2015 08:00:34 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 6DEB2125801A
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 08:00:15 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9D2UR7u58458180
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 08:00:28 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9D2URJL023288
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 08:00:27 +0530
Date: Tue, 13 Oct 2015 10:30:25 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 aik@ozlabs.ru, linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH V5 1/6] powerpc/powernv: don't enable SRIOV when VF BAR
 has non 64bit-prefetchable BAR
Message-ID: <20151013023025.GB1437@Richards-MacBook-Pro.local>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1444358816-8163-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1444358816-8163-2-git-send-email-weiyang@linux.vnet.ibm.com>
 <1444378519.2845.14.camel@kernel.crashing.org>
 <20151012025837.GA2111@Richards-MacBook-Pro.local>
 <1444632924.2845.39.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444632924.2845.39.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 12, 2015 at 12:25:24PM +0530, Benjamin Herrenschmidt wrote:
>On Mon, 2015-10-12 at 10:58 +0800, Wei Yang wrote:
>> On Fri, Oct 09, 2015 at 07:15:19PM +1100, Benjamin Herrenschmidt wrote:
>> > On Fri, 2015-10-09 at 10:46 +0800, Wei Yang wrote:
>> > > On PHB_IODA2, we enable SRIOV devices by mapping IOV BAR with M64 BARs. If
>> > > a SRIOV device's IOV BAR is not 64bit-prefetchable, this is not assigned
>> > > from 64bit prefetchable window, which means M64 BAR can't work on it.
>> > 
>> > Won't this cause a lot of devices to become unsupported for us ? Or do
>> > all devices we care about have their BARs marked prefetchable ?
>> > 
>> 
>> You are right. After doing so, some of the devices will not be supported.
>> 
>> Hmm, I thought you know this, since this strategy, use M64 BAR to map IOV
>> BAR, is proposed by you. This patch doesn't change the function, while make it
>> more explicit.
>
>Right but we can make things better by also effectively allowing non
>-prefetch BARs to sit in the prefetchable window of a bridge.
>
>> > > The reason is PCI bridges support only 2 windows and the kernel code
>> > > programs bridges in the way that one window is 32bit-nonprefetchable and
>> > > the other one is 64bit-prefetchable. So if devices' IOV BAR is 64bit and
>> > > non-prefetchable, it will be mapped into 32bit space and therefore M64
>> > > cannot be used for it.
>> > > 
>> > > This patch makes this explicit.
>> > 
>> > So PCIe allows for non-prefetchable BARs to be put under prefetchable
>> > bridge windows as long as the mapping done by the CPU doesn't prefetch,
>> > I believe. Well it's a natural conclusion of the weird note "Additional
>> > Guidance on the Prefetchable Bit in Memory Space BARs" page 596 of PCIe
>> > spec v3.0... it also says that devices should be pretty much free to
>> > set their prefetchable bit even if they have side effects so.
>> > 
>> > So maybe we should have that option, rather than just not using the
>> > devices, allow them to be allocate via the prefetchable window...
>> > 
>> 
>> Based on current linux kernel pci core resource size/assignment algorithm,
>> when we have 64bit-prefetchable root window, only 64bit-prefetchable BAR could
>> be assigned in this region. Refer to commit 5b28541552ef "PCI: Restrict 64-bit
>> prefetchable bridge windows to 64-bit resources" for more detail.
>
>The above patch was about avoiding 32-bit prefetchable, it's not about
>64-bit non-prefetchable.
>
>> So we have two facts here:
>> 1. We want to use M64 BAR to map VFs, so that VF could be put into individual
>> PE. And the M64 BAR just map 64bit window.
>> 2. Current MMIO size/assignment algorithm in linux pci core only put
>> 64bit-prefetchable BAR into 64bit prefetchable bridge window, no other BARs.
>> 
>> Your suggestion here is to put a non-prefetchable BAR in prefetchable bridge
>> window? This would make the MMIO size/assignment algorithm more confusing.
>
>Right, in the long run, both us and x86 might need to be able to do
>that, though exclusively for PCIe. PCI/PCI-X bridges can prefetch.
>

Thanks for the proposal, this would benefit linux kernel in the long run, I
believe.
While I have some concerns to do this in this patch set:
1. I am still not very clear in which case this is allowed, so I am not
   confident to do the correct change now.
   The device type ? PCIe vs PCI/PCI-X
   The cpu address prefetchable property?
   The arch type? x86, ppc or other arch?
   Last but not the least, the rule to choose the correct bridge window for a
   BAR looks confusing to me after this change. I need some time to understand
   it.
2. Since this is a more generic code change, we need include linux-pci mail
   list.
3. Divide the problem and solve them one by one
   The main purpose of this patch set is to make each VF independent.
   We may face different problems during the evolution of linux kernel, sounds
   it is difficult to address them all in once. How about let this patch set
   address the VF independence first. And we can improve the pci core on MMIO
   assignment in another thread?
   
>Cheers,
>Ben.
>
>> > > Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> > > Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> > > Acked-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> > > ---
>> > >  arch/powerpc/platforms/powernv/pci-ioda.c | 25 +++++++++----------------
>> > >  1 file changed, 9 insertions(+), 16 deletions(-)
>> > > 
>> > > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> > > index 85cbc96..8c031b5 100644
>> > > --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> > > +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> > > @@ -908,9 +908,6 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
>> > >  > > > > 	> > > > > > > 	> > > > if (!res->flags || !res->parent)
>> > >  > > > > 	> > > > > > > 	> > > > > > > 	> > > > continue;
>> > >  
>> > > -> > > > 	> > > > > > > 	> > > > if (!pnv_pci_is_mem_pref_64(res->flags))
>> > > -> > > > 	> > > > > > > 	> > > > > > > 	> > > > continue;
>> > > -
>> > >  > > > > 	> > > > > > > 	> > > > /*
>> > >  > > > > 	> > > > > > > 	> > > >  * The actual IOV BAR range is determined by the start address
>> > >  > > > > 	> > > > > > > 	> > > >  * and the actual size for num_vfs VFs BAR.  This check is to
>> > > @@ -939,9 +936,6 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
>> > >  > > > > 	> > > > > > > 	> > > > if (!res->flags || !res->parent)
>> > >  > > > > 	> > > > > > > 	> > > > > > > 	> > > > continue;
>> > >  
>> > > -> > > > 	> > > > > > > 	> > > > if (!pnv_pci_is_mem_pref_64(res->flags))
>> > > -> > > > 	> > > > > > > 	> > > > > > > 	> > > > continue;
>> > > -
>> > >  > > > > 	> > > > > > > 	> > > > size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
>> > >  > > > > 	> > > > > > > 	> > > > res2 = *res;
>> > >  > > > > 	> > > > > > > 	> > > > res->start += size * offset;
>> > > @@ -1221,9 +1215,6 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
>> > >  > > > > 	> > > > > > > 	> > > > if (!res->flags || !res->parent)
>> > >  > > > > 	> > > > > > > 	> > > > > > > 	> > > > continue;
>> > >  
>> > > -> > > > 	> > > > > > > 	> > > > if (!pnv_pci_is_mem_pref_64(res->flags))
>> > > -> > > > 	> > > > > > > 	> > > > > > > 	> > > > continue;
>> > > -
>> > >  > > > > 	> > > > > > > 	> > > > for (j = 0; j < vf_groups; j++) {
>> > >  > > > > 	> > > > > > > 	> > > > > > > 	> > > > do {
>> > >  > > > > 	> > > > > > > 	> > > > > > > 	> > > > > > > 	> > > > win = find_next_zero_bit(&phb->ioda.m64_bar_alloc,
>> > > @@ -1510,6 +1501,12 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>> > >  > > > > 	> > > > pdn = pci_get_pdn(pdev);
>> > >  
>> > >  > > > > 	> > > > if (phb->type == PNV_PHB_IODA2) {
>> > > +> > > > 	> > > > > > > 	> > > > if (!pdn->vfs_expanded) {
>> > > +> > > > 	> > > > > > > 	> > > > > > > 	> > > > dev_info(&pdev->dev, "don't support this SRIOV device"
>> > > +> > > > 	> > > > > > > 	> > > > > > > 	> > > > > > > 	> > > > " with non 64bit-prefetchable IOV BAR\n");
>> > > +> > > > 	> > > > > > > 	> > > > > > > 	> > > > return -ENOSPC;
>> > > +> > > > 	> > > > > > > 	> > > > }
>> > > +
>> > >  > > > > 	> > > > > > > 	> > > > /* Calculate available PE for required VFs */
>> > >  > > > > 	> > > > > > > 	> > > > mutex_lock(&phb->ioda.pe_alloc_mutex);
>> > >  > > > > 	> > > > > > > 	> > > > pdn->offset = bitmap_find_next_zero_area(
>> > > @@ -2775,9 +2772,10 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>> > >  > > > > 	> > > > > > > 	> > > > if (!res->flags || res->parent)
>> > >  > > > > 	> > > > > > > 	> > > > > > > 	> > > > continue;
>> > >  > > > > 	> > > > > > > 	> > > > if (!pnv_pci_is_mem_pref_64(res->flags)) {
>> > > -> > > > 	> > > > > > > 	> > > > > > > 	> > > > dev_warn(&pdev->dev, " non M64 VF BAR%d: %pR\n",
>> > > +> > > > 	> > > > > > > 	> > > > > > > 	> > > > dev_warn(&pdev->dev, "Don't support SR-IOV with"
>> > > +> > > > 	> > > > > > > 	> > > > > > > 	> > > > > > > 	> > > > > > > 	> > > > " non M64 VF BAR%d: %pR. \n",
>> > >  > > > > 	> > > > > > > 	> > > > > > > 	> > > > > > > 	> > > >  i, res);
>> > > -> > > > 	> > > > > > > 	> > > > > > > 	> > > > continue;
>> > > +> > > > 	> > > > > > > 	> > > > > > > 	> > > > return;
>> > >  > > > > 	> > > > > > > 	> > > > }
>> > >  
>> > >  > > > > 	> > > > > > > 	> > > > size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
>> > > @@ -2796,11 +2794,6 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>> > >  > > > > 	> > > > > > > 	> > > > res = &pdev->resource[i + PCI_IOV_RESOURCES];
>> > >  > > > > 	> > > > > > > 	> > > > if (!res->flags || res->parent)
>> > >  > > > > 	> > > > > > > 	> > > > > > > 	> > > > continue;
>> > > -> > > > 	> > > > > > > 	> > > > if (!pnv_pci_is_mem_pref_64(res->flags)) {
>> > > -> > > > 	> > > > > > > 	> > > > > > > 	> > > > dev_warn(&pdev->dev, "Skipping expanding VF BAR%d: %pR\n",
>> > > -> > > > 	> > > > > > > 	> > > > > > > 	> > > > > > > 	> > > >  i, res);
>> > > -> > > > 	> > > > > > > 	> > > > > > > 	> > > > continue;
>> > > -> > > > 	> > > > > > > 	> > > > }
>> > >  
>> > >  > > > > 	> > > > > > > 	> > > > dev_dbg(&pdev->dev, " Fixing VF BAR%d: %pR to\n", i, res);
>> > >  > > > > 	> > > > > > > 	> > > > size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
>> 

-- 
Richard Yang
Help you, Help me
