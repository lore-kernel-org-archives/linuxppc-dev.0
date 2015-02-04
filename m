Return-Path: <bhelgaas@google.com>
Received: from mail-oi0-x232.google.com (mail-oi0-x232.google.com
 [IPv6:2607:f8b0:4003:c06::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4EF0B1A0A25
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 07:53:18 +1100 (AEDT)
Received: by mail-oi0-f50.google.com with SMTP id h136so3278402oig.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Feb 2015 12:53:16 -0800 (PST)
Date: Wed, 4 Feb 2015 14:53:13 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: make sure the IOV BAR will not exceed
 limit after shifting
Message-ID: <20150204205313.GA11271@google.com>
References: <20150130230803.GA6795@google.com>
 <1422946903-12958-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150204001926.GA19540@google.com>
 <20150204033409.GA11577@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150204033409.GA11577@richard>
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

On Wed, Feb 04, 2015 at 11:34:09AM +0800, Wei Yang wrote:
> On Tue, Feb 03, 2015 at 06:19:26PM -0600, Bjorn Helgaas wrote:
> >On Tue, Feb 03, 2015 at 03:01:43PM +0800, Wei Yang wrote:
> >> The actual IOV BAR range is determined by the start address and the actual
> >> size for vf_num VFs BAR. After shifting the IOV BAR, there would be a
> >> chance the actual end address exceed the limit and overlap with other
> >> devices.
> >> 
> >> This patch adds a check to make sure after shifting, the range will not
> >> overlap with other devices.
> >
> >I folded this into the previous patch (the one that adds
> >pnv_pci_vf_resource_shift()).  And I think that needs to be folded together
> >with the following one ("powerpc/powernv: Allocate VF PE") because this one
> >references pdn->vf_pes, which is added by "Allocate VF PE".
> >
> 
> Yes. Both need this.
> 
> >> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> >> ---
> >>  arch/powerpc/platforms/powernv/pci-ioda.c |   53 ++++++++++++++++++++++++++---
> >>  1 file changed, 48 insertions(+), 5 deletions(-)
> >> 
> >> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> >> index 8456ae8..1a1e74b 100644
> >> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> >> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> >> @@ -854,16 +854,18 @@ static unsigned int pnv_ioda_dma_weight(struct pci_dev *dev)
> >>  }
> >>  
> >>  #ifdef CONFIG_PCI_IOV
> >> -static void pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
> >> +static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
> >>  {
> >>  	struct pci_dn *pdn = pci_get_pdn(dev);
> >>  	int i;
> >>  	struct resource *res;
> >>  	resource_size_t size;
> >> +	u16 vf_num;
> >>  
> >>  	if (!dev->is_physfn)
> >> -		return;
> >> +		return -EINVAL;
> >>  
> >> +	vf_num = pdn->vf_pes;
> >
> >I can't actually build this, but I don't think pdn->vf_pes is defined yet.
> >
> 
> The pdn->vf_pes is defined in the next patch, it is not defined yet.
> 
> I thought the incremental patch means a patch on top of the current patch set,
> so it is defined as the last patch.
> 
> >>  	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++) {
> >>  		res = &dev->resource[i];
> >>  		if (!res->flags || !res->parent)
> >> @@ -875,11 +877,49 @@ static void pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
> >>  		dev_info(&dev->dev, " Shifting VF BAR %pR to\n", res);
> >>  		size = pci_iov_resource_size(dev, i);
> >>  		res->start += size*offset;
> >> -
> >>  		dev_info(&dev->dev, "                 %pR\n", res);
> >> +
> >> +		/*
> >> +		 * The actual IOV BAR range is determined by the start address
> >> +		 * and the actual size for vf_num VFs BAR. The check here is
> >> +		 * to make sure after shifting, the range will not overlap
> >> +		 * with other device.
> >> +		 */
> >> +		if ((res->start + (size * vf_num)) > res->end) {
> >> +			dev_err(&dev->dev, "VF BAR%d: %pR will conflict with"
> >> +					" other device after shift\n");
> >
> >sriov_init() sets up "res" with enough space to contain TotalVF copies
> >of the VF BAR.  By the time we get here, that "res" is in the resource
> >tree, and you should be able to see it in /proc/iomem.
> >
> >For example, if TotalVFs is 128 and VF BAR0 is 1MB in size, the
> >resource size would be 128 * 1MB = 0x800_0000.  If the VF BAR0 in the
> >SR-IOV Capability contains a base address of 0x8000_0000, the resource
> >would be:
> >
> >  [mem 0x8000_0000-0x87ff_ffff]
> >
> >We have to assume there's another resource starting immediately after
> >this one, i.e., at 0x8800_0000, and we have to make sure that when we
> >change this resource and turn on SR-IOV, we don't overlap with it.
> >
> >The shifted resource will start at 0x8000_0000 + 1MB * "offset".  The
> >hardware will respond to a range whose size is 1MB * NumVFs (NumVFs
> >may be smaller than TotalVFs).
> >
> >If we enable 16 VFs and shift by 23, we set VF BAR0 to 0x8000_0000 +
> >1MB * 23 = 0x8170_0000, and the size is 1MB * 16 = 0x100_0000, so the
> >new resource will be:
> >
> >  [mem 0x8170_0000-0x826f_ffff]
> >
> >That's fine; it doesn't extend past the original end of 0x87ff_ffff.
> >But if we enable those same 16 VFs with a shift of 120, we set VF BAR0
> >to 0x8000_0000 + 1MB * 120 = 0x8780_0000, and the size stays the same,
> >so the new resource will be:
> >
> >  [mem 0x8780_0000-0x887f_ffff]
> >
> >and that's a problem because we have two devices responding at
> >0x8800_0000.
> >
> >Your test of "res->start + (size * vf_num)) > res->end" is not strict
> >enough to catch this problem.
> >
> 
> Yep, you are right.
> 
> >I think we need something like the patch below.  I restructured it so
> >we don't have to back out any resource changes if we fail.
> >
> >This shifting strategy seems to imply that the closer NumVFs is to
> >TotalVFs, the less flexibility you have to assign PEs, e.g., if NumVFs
> >== TotalVFs, you wouldn't be able to shift at all.  In this example,
> >you could shift by anything from 0 to 128 - 16 = 112, but if you
> >wanted NumVFs = 64, you could only shift by 0 to 64.  Is that true?
> >
> >I think your M64 BAR gets split into 256 segments, regardless of what
> >TotalVFs is, so if you expanded the resource to 256 * 1MB for this
> >example, you would be able to shift by up to 256 - NumVFs.  Do you
> >actually do this somewhere?
> >
> 
> Yes, after expanding the resource to 256 * 1MB, it is able to shift up to 
> 256 - NumVFs. 

Oh, I see where the expansion happens.  We started in sriov_init() with:

  res->end = res->start + resource_size(res) * total - 1;

where "total" is TotalVFs, and you expand it to the maximum number of PEs
in pnv_pci_ioda_fixup_iov_resources():

  res->end = res->start + size * phb->ioda.total_pe - 1;

in this path:

  pcibios_scan_phb
    pci_create_root_bus
    pci_scan_child_bus
      ...
        sriov_init
	  res->end = res->start + ...	# as above
    ppc_md.pcibios_fixup_sriov		# pnv_pci_ioda_fixup_sriov
    pnv_pci_ioda_fixup_sriov(bus)
      list_for_each_entry(dev, &bus->devices, ...)
        if (dev->subordinate)
	  pnv_pci_ioda_fixup_sriov(dev->subordinate)	# recurse
        pnv_pci_ioda_fixup_iov_resources(dev)
	  res->end = res->start + ...	# fixup

I think this will be cleaner if you add an arch interface for use by
sriov_init(), e.g.,

  resource_size_t __weak pcibios_iov_size(struct pci_dev *dev, int resno)
  {
    struct resource *res = &dev->resource[resno + PCI_IOV_RESOURCES];

    return resource_size(res) * dev->iov->total_VFs;
  }

  static int sriov_int(...)
  {
    ...
    res->end = res->start + pcibios_iov_size(dev, i) - 1;
    ...
  }

and powerpc could override this.  That way we would set the size once and
we wouldn't need a fixup pass, which will keep the pcibios_scan_phb() code
similar to the common path in pci_scan_root_bus().

> But currently, on my system, I don't see one case really do
> this.
> 
> On my system, there is an Emulex card with 4 PFs.
> 
> 0006:01:00.0 Ethernet controller: Emulex Corporation OneConnect NIC (Lancer) (rev 10)
> 0006:01:00.1 Ethernet controller: Emulex Corporation OneConnect NIC (Lancer) (rev 10)
> 0006:01:00.2 Ethernet controller: Emulex Corporation OneConnect NIC (Lancer) (rev 10)
> 0006:01:00.3 Ethernet controller: Emulex Corporation OneConnect NIC (Lancer) (rev 10)
> 
> The max VFs for them are 80, 80, 20, 20, with total number of 200 VFs.
> 
> be2net 0006:01:00.0:  Shifting VF BAR [mem 0x3d40 1000 0000 - 0x3d40 10ff ffff 64bit pref] to 256 segs
> be2net 0006:01:00.0:                  [mem 0x3d40 1003 0000 - 0x3d40 10ff ffff 64bit pref]    253 segs offset 3
> PE range [3 - 82]
> be2net 0006:01:00.1:  Shifting VF BAR [mem 0x3d40 1100 0000 - 0x3d40 11ff ffff 64bit pref] to 256 segs
> be2net 0006:01:00.1:                  [mem 0x3d40 1153 0000 - 0x3d40 11ff ffff 64bit pref]    173 segs offset 83
> PE range [83 - 162]
> be2net 0006:01:00.2:  Shifting VF BAR [mem 0x3d40 1200 0000 - 0x3d40 12ff ffff 64bit pref] to 256 segs
> be2net 0006:01:00.2:                  [mem 0x3d40 12a3 0000 - 0x3d40 12ff ffff 64bit pref]    93  segs offset 163
> PE range [163 - 182]
> be2net 0006:01:00.3:  Shifting VF BAR [mem 0x3d40 1300 0000 - 0x3d40 13ff ffff 64bit pref] to 256 segs
> be2net 0006:01:00.3:                  [mem 0x3d40 13b7 0000 - 0x3d40 13ff ffff 64bit pref]    73  segs offset 183
> PE range [183 - 202]
> 
> After enable the max number of VFs, even the last VF still has 73 number VF
> BAR size. So this not trigger the limit, but proves the shift offset could be
> larger than (TotalVFs - NumVFs).

You expanded the overall resource from "TotalVFs * size" to "256 * size".
So the offset can be larger than "TotalVFs - NumVFs" but it still cannot be
larger than "256 - NumVFs".  The point is that the range claimed by the
hardware cannot extend past the range we told the resource tree about.
That's what the "if (res2.end > res->end)" test is checking.

Normally we compute res->end based on TotalVFs.  For PHB3, you compute
res->end based on 256.  Either way, we need to make sure we don't program
the BAR with an address that causes the hardware to respond to addresses
past res->end.

Bjorn

> >+		/*
> >+		 * The actual IOV BAR range is determined by the start address
> >+		 * and the actual size for vf_num VFs BAR.  This check is to
> >+		 * make sure that after shifting, the range will not overlap
> >+		 * with another device.
> >+		 */
> >+		size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
> >+		res2.flags = res->flags;
> >+		res2.start = res->start + (size * offset);
> >+		res2.end = res2.start + (size * vf_num) - 1;
> >+
> >+		if (res2.end > res->end) {
> >+			dev_err(&dev->dev, "VF BAR%d: %pR would extend past %pR (trying to enable %d VFs shifted by %d)\n",
> >+				i, &res2, res, vf_num, offset);
> >+			return -EBUSY;
> >+		}
