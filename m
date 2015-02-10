Return-Path: <benh@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB8961A014C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 13:15:12 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 10 Feb 2015 12:15:11 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BC0DA2BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 13:15:08 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1A2EulB48758962
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 13:15:04 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1A2EZc2016220
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 13:14:35 +1100
Message-ID: <1423534451.4924.79.camel@au1.ibm.com>
Subject: Re: [PATCH V11 07/17] powerpc/pci: Don't unset pci resources for VFs
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Date: Tue, 10 Feb 2015 13:14:11 +1100
In-Reply-To: <20150210015123.GC6326@richard>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-8-git-send-email-weiyang@linux.vnet.ibm.com>
 <1423528584.4924.70.camel@au1.ibm.com> <20150210015123.GC6326@richard>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-02-10 at 09:51 +0800, Wei Yang wrote:
> On Tue, Feb 10, 2015 at 11:36:24AM +1100, Benjamin Herrenschmidt wrote:
> >On Thu, 2015-01-15 at 10:27 +0800, Wei Yang wrote:
> >> If we're going to reassign resources with flag PCI_REASSIGN_ALL_RSRC, all
> >> resources will be cleaned out during device header fixup time and then get
> >> reassigned by PCI core. However, the VF resources won't be reassigned and
> >> thus, we shouldn't clean them out.
> >> 
> >> This patch adds a condition. If the pci_dev is a VF, skip the resource
> >> unset process.
> >
> >I don't understand this, can you elaborate ? Why wouldn't we reassign
> >the IOV resource just like everything else ?
> 
> Sure.
> 
> VFs work a little bit different from normal devices. On powernv platform, we
> have PCI_REASSIGN_ALL_RSRC set, which means all resource retrieved from
> hardware will be cleaned and re-assigned by kernel. While VF's resources are
> calculated from PF's IOV BAR, in virtfn_add(). And after this, there is not
> re-assign process for VFs.

I still don't undertand, you mean SR-IOV is assigned before we assign
everybody else ? That doesn't make sense to me...

Ben.

> >
> >Ben.
> >
> >> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> >> ---
> >>  arch/powerpc/kernel/pci-common.c |    4 ++++
> >>  1 file changed, 4 insertions(+)
> >> 
> >> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> >> index 37d512d..889f743 100644
> >> --- a/arch/powerpc/kernel/pci-common.c
> >> +++ b/arch/powerpc/kernel/pci-common.c
> >> @@ -788,6 +788,10 @@ static void pcibios_fixup_resources(struct pci_dev *dev)
> >>  		       pci_name(dev));
> >>  		return;
> >>  	}
> >> +
> >> +	if (dev->is_virtfn)
> >> +		return;
> >> +
> >>  	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> >>  		struct resource *res = dev->resource + i;
> >>  		struct pci_bus_region reg;
> >
> 
