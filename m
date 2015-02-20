Return-Path: <bhelgaas@google.com>
Received: from mail-oi0-x230.google.com (mail-oi0-x230.google.com
 [IPv6:2607:f8b0:4003:c06::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 84A051A0FAB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 10:47:14 +1100 (AEDT)
Received: by mail-oi0-f48.google.com with SMTP id a3so5306225oib.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 15:47:12 -0800 (PST)
Date: Fri, 20 Feb 2015 17:47:09 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH V11 07/17] powerpc/pci: Don't unset pci resources for VFs
Message-ID: <20150220234709.GD21131@google.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-8-git-send-email-weiyang@linux.vnet.ibm.com>
 <1423528584.4924.70.camel@au1.ibm.com>
 <20150210015123.GC6326@richard>
 <1423534451.4924.79.camel@au1.ibm.com>
 <20150210062544.GB31098@richard>
 <1423556085.4924.91.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423556085.4924.91.camel@au1.ibm.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 10, 2015 at 07:14:45PM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2015-02-10 at 14:25 +0800, Wei Yang wrote:
> > PF's resource will be assigned first, including normal BARs and IOV
> > BARs.
> > 
> > Then PF's driver will create VFs, in virtfn_add(). In this function,
> > VF's
> > resources is calculated from its PF's IOV BAR.
> > 
> > If you reset VF's resource as PFs, no one will try to assign it again.
> 
> So the problem is that the flag indicating VF is lost ? IE. We should
> still mark them unset, but preserve that flag ?

I think the problem is that the normal path for PCI_REASSIGN_ALL_RSRC is
at boot-time, where we do this:

    pcibios_init
      pcibios_scan_phb
        pci_scan_child_bus
          ...
            pci_device_add
              pci_fixup_device(pci_fixup_header)
		pcibios_fixup_resources                       # header fixup
		  for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
		    dev->resource[i].start = 0
      pcibios_resource_survey
        pcibios_allocate_resources

and we assign dev->resource[] for everything in
pcibios_allocate_resources().

But VFs are enumerated later, when they are enabled by the PF driver after
boot, so we have this path:

    pci_enable_sriov
      sriov_enable
        virtfn_add(vf_id)
          for (i = 0; i < 6; i++)
            vf->resource[i].start = pf->resource[IOV + i].start + (size * vf_id)
          pci_device_add
            pci_fixup_device(pci_fixup_header)
              pcibios_fixup_resources                   # header fixup
                for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
                  vf->resource[i].start = 0

Here, we clear out vf->resource[0..5] in the header fixup, but we're not
going to call pcibios_allocate_resources() again to reassign them.

So I think the *intent* of PCI_REASSIGN_ALL_RSRC is preserved if
pcibios_fixup_resources() leaves the VF resources alone, because the VF
resources are completely determined by the PF resources, and the PF
resources have already been reassigned.

If my understanding is correct, I think the patch is reasonable, and I
would try to put some of this explanation into the changelog.

Bjorn
