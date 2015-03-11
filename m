Return-Path: <bhelgaas@google.com>
Received: from mail-oi0-x231.google.com (mail-oi0-x231.google.com
 [IPv6:2607:f8b0:4003:c06::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB8841A0631
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 13:47:42 +1100 (AEDT)
Received: by oifz81 with SMTP id z81so5420316oif.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 19:47:40 -0700 (PDT)
Date: Tue, 10 Mar 2015 21:47:37 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH v12 14/21] powerpc/powernv: Allocate struct pnv_ioda_pe
 iommu_table dynamically
Message-ID: <20150311024737.GB10994@google.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224083435.32124.65099.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224084653.GI6220@google.com> <20150302075036.GH21571@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150302075036.GH21571@richard>
Cc: linux-pci@vger.kernel.org, benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 02, 2015 at 03:50:37PM +0800, Wei Yang wrote:
> On Tue, Feb 24, 2015 at 02:46:53AM -0600, Bjorn Helgaas wrote:
> >On Tue, Feb 24, 2015 at 02:34:35AM -0600, Bjorn Helgaas wrote:
> >> From: Wei Yang <weiyang@linux.vnet.ibm.com>
> >> 
> >> Current iommu_table of a PE is a static field.  This will have a problem
> >> when iommu_free_table() is called.
> >> 
> >> Allocate iommu_table dynamically.
> >
> >I'd like a little more explanation about why we're calling
> >iommu_free_table() now when we didn't call it before.  Maybe this happens
> >when we disable SR-IOV and the VFs go away?
> 
> Yes, it is called in disable path.
> 
> pcibios_sriov_disable
>     pnv_pci_sriov_disable
>         pnv_ioda_release_vf_PE
> 	    pnv_pci_ioda2_release_dma_pe
> 	        iommu_free_table            <--- here it is invoked
> 
> 
> >
> >Is there a hotplug remove path where we should also be calling
> >iommu_free_table()?
> 
> When VF is not introduced, no one calls this on powernv platform.
> 
> Each PCI bus is a PE and it has its own iommu table, even a device is
> hotpluged, the iommu table will not be released.

None of this explanation made it into the v13 patch.  And I don't quite
understand it anyway.

Something like "Previously the iommu_table had the same lifetime as a
struct pnv_ioda_pe and was embedded in it.  The pnv_ioda_pe was allocated
when XXX and freed when YYY.  This no longer works: we can't allocate the
iommu_table at the same time as the pnv_ioda_pe because XXX, so we allocate
it when XXX and free it when YYY."

Bjorn
