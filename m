Return-Path: <bhelgaas@google.com>
Received: from mail-oi0-x233.google.com (mail-oi0-x233.google.com
 [IPv6:2607:f8b0:4003:c06::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E3E811A00B6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Feb 2015 11:19:31 +1100 (AEDT)
Received: by mail-oi0-f51.google.com with SMTP id x69so51928869oia.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Feb 2015 16:19:29 -0800 (PST)
Date: Tue, 3 Feb 2015 18:19:26 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: make sure the IOV BAR will not exceed
 limit after shifting
Message-ID: <20150204001926.GA19540@google.com>
References: <20150130230803.GA6795@google.com>
 <1422946903-12958-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422946903-12958-1-git-send-email-weiyang@linux.vnet.ibm.com>
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

On Tue, Feb 03, 2015 at 03:01:43PM +0800, Wei Yang wrote:
> The actual IOV BAR range is determined by the start address and the actual
> size for vf_num VFs BAR. After shifting the IOV BAR, there would be a
> chance the actual end address exceed the limit and overlap with other
> devices.
> 
> This patch adds a check to make sure after shifting, the range will not
> overlap with other devices.

I folded this into the previous patch (the one that adds
pnv_pci_vf_resource_shift()).  And I think that needs to be folded together
with the following one ("powerpc/powernv: Allocate VF PE") because this one
references pdn->vf_pes, which is added by "Allocate VF PE".

> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c |   53 ++++++++++++++++++++++++++---
>  1 file changed, 48 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 8456ae8..1a1e74b 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -854,16 +854,18 @@ static unsigned int pnv_ioda_dma_weight(struct pci_dev *dev)
>  }
>  
>  #ifdef CONFIG_PCI_IOV
> -static void pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
> +static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
>  {
>  	struct pci_dn *pdn = pci_get_pdn(dev);
>  	int i;
>  	struct resource *res;
>  	resource_size_t size;
> +	u16 vf_num;
>  
>  	if (!dev->is_physfn)
> -		return;
> +		return -EINVAL;
>  
> +	vf_num = pdn->vf_pes;

I can't actually build this, but I don't think pdn->vf_pes is defined yet.

>  	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++) {
>  		res = &dev->resource[i];
>  		if (!res->flags || !res->parent)
> @@ -875,11 +877,49 @@ static void pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
>  		dev_info(&dev->dev, " Shifting VF BAR %pR to\n", res);
>  		size = pci_iov_resource_size(dev, i);
>  		res->start += size*offset;
> -
>  		dev_info(&dev->dev, "                 %pR\n", res);
> +
> +		/*
> +		 * The actual IOV BAR range is determined by the start address
> +		 * and the actual size for vf_num VFs BAR. The check here is
> +		 * to make sure after shifting, the range will not overlap
> +		 * with other device.
> +		 */
> +		if ((res->start + (size * vf_num)) > res->end) {
> +			dev_err(&dev->dev, "VF BAR%d: %pR will conflict with"
> +					" other device after shift\n");

sriov_init() sets up "res" with enough space to contain TotalVF copies
of the VF BAR.  By the time we get here, that "res" is in the resource
tree, and you should be able to see it in /proc/iomem.

For example, if TotalVFs is 128 and VF BAR0 is 1MB in size, the
resource size would be 128 * 1MB = 0x800_0000.  If the VF BAR0 in the
SR-IOV Capability contains a base address of 0x8000_0000, the resource
would be:

  [mem 0x8000_0000-0x87ff_ffff]

We have to assume there's another resource starting immediately after
this one, i.e., at 0x8800_0000, and we have to make sure that when we
change this resource and turn on SR-IOV, we don't overlap with it.

The shifted resource will start at 0x8000_0000 + 1MB * "offset".  The
hardware will respond to a range whose size is 1MB * NumVFs (NumVFs
may be smaller than TotalVFs).

If we enable 16 VFs and shift by 23, we set VF BAR0 to 0x8000_0000 +
1MB * 23 = 0x8170_0000, and the size is 1MB * 16 = 0x100_0000, so the
new resource will be:

  [mem 0x8170_0000-0x826f_ffff]

That's fine; it doesn't extend past the original end of 0x87ff_ffff.
But if we enable those same 16 VFs with a shift of 120, we set VF BAR0
to 0x8000_0000 + 1MB * 120 = 0x8780_0000, and the size stays the same,
so the new resource will be:

  [mem 0x8780_0000-0x887f_ffff]

and that's a problem because we have two devices responding at
0x8800_0000.

Your test of "res->start + (size * vf_num)) > res->end" is not strict
enough to catch this problem.

I think we need something like the patch below.  I restructured it so
we don't have to back out any resource changes if we fail.

This shifting strategy seems to imply that the closer NumVFs is to
TotalVFs, the less flexibility you have to assign PEs, e.g., if NumVFs
== TotalVFs, you wouldn't be able to shift at all.  In this example,
you could shift by anything from 0 to 128 - 16 = 112, but if you
wanted NumVFs = 64, you could only shift by 0 to 64.  Is that true?

I think your M64 BAR gets split into 256 segments, regardless of what
TotalVFs is, so if you expanded the resource to 256 * 1MB for this
example, you would be able to shift by up to 256 - NumVFs.  Do you
actually do this somewhere?

I pushed an updated pci/virtualization branch with these updates.  I
think there's also a leak that needs to be fixed that Dan Carpenter
pointed out.

Bjorn

> +			goto failed;
> +		}
> +	}
> +
> +	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++) {
> +		res = &dev->resource[i];
> +		if (!res->flags || !res->parent)
> +			continue;
> +
> +		if (!pnv_pci_is_mem_pref_64(res->flags))
> +			continue;
> +
>  		pci_update_resource(dev, i);
>  	}
>  	pdn->max_vfs -= offset;
> +	return 0;
> +
> +failed:
> +	for (; i >= PCI_IOV_RESOURCES; i--) {
> +		res = &dev->resource[i];
> +		if (!res->flags || !res->parent)
> +			continue;
> +
> +		if (!pnv_pci_is_mem_pref_64(res->flags))
> +			continue;
> +
> +		dev_info(&dev->dev, " Shifting VF BAR %pR to\n", res);
> +		size = pci_iov_resource_size(dev, i);
> +		res->start += size*(-offset);
> +		dev_info(&dev->dev, "                 %pR\n", res);
> +	}
> +	return -EBUSY;
>  }
>  #endif /* CONFIG_PCI_IOV */
>  
> @@ -1480,8 +1520,11 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 vf_num)
>  		}
>  
>  		/* Do some magic shift */
> -		if (pdn->m64_per_iov == 1)
> -			pnv_pci_vf_resource_shift(pdev, pdn->offset);
> +		if (pdn->m64_per_iov == 1) {
> +			ret = pnv_pci_vf_resource_shift(pdev, pdn->offset);
> +			if (ret)
> +				goto m64_failed;
> +		}
>  	}
>  
>  	/* Setup VF PEs */

commit 9849fc0c807d3544dbd682354325b2454f139ca4
Author: Wei Yang <weiyang@linux.vnet.ibm.com>
Date:   Tue Feb 3 13:09:30 2015 -0600

    powerpc/powernv: Shift VF resource with an offset
    
    On PowerNV platform, resource position in M64 implies the PE# the resource
    belongs to.  In some cases, adjustment of a resource is necessary to locate
    it to a correct position in M64.
    
    Add pnv_pci_vf_resource_shift() to shift the 'real' PF IOV BAR address
    according to an offset.
    
    [bhelgaas: rework loops, rework overlap check, index resource[]
    conventionally, remove pci_regs.h include]
    Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 74de05e58e1d..6ffedcc291a8 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -749,6 +749,74 @@ static unsigned int pnv_ioda_dma_weight(struct pci_dev *dev)
 	return 10;
 }
 
+#ifdef CONFIG_PCI_IOV
+static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
+{
+	struct pci_dn *pdn = pci_get_pdn(dev);
+	int i;
+	struct resource *res, res2;
+	resource_size_t size, end;
+	u16 vf_num;
+
+	if (!dev->is_physfn)
+		return -EINVAL;
+
+	/*
+	 * "offset" is in VFs.  The M64 BARs are sized so that when they
+	 * are segmented, each segment is the same size as the IOV BAR.
+	 * Each segment is in a separate PE, and the high order bits of the
+	 * address are the PE number.  Therefore, each VF's BAR is in a
+	 * separate PE, and changing the IOV BAR start address changes the
+	 * range of PEs the VFs are in.
+	 */
+	vf_num = pdn->vf_pes;		// FIXME not defined yet
+	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
+		res = &dev->resource[i + PCI_IOV_RESOURCES];
+		if (!res->flags || !res->parent)
+			continue;
+
+		if (!pnv_pci_is_mem_pref_64(res->flags))
+			continue;
+
+		/*
+		 * The actual IOV BAR range is determined by the start address
+		 * and the actual size for vf_num VFs BAR.  This check is to
+		 * make sure that after shifting, the range will not overlap
+		 * with another device.
+		 */
+		size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
+		res2.flags = res->flags;
+		res2.start = res->start + (size * offset);
+		res2.end = res2.start + (size * vf_num) - 1;
+
+		if (res2.end > res->end) {
+			dev_err(&dev->dev, "VF BAR%d: %pR would extend past %pR (trying to enable %d VFs shifted by %d)\n",
+				i, &res2, res, vf_num, offset);
+			return -EBUSY;
+		}
+	}
+
+	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
+		res = &dev->resource[i + PCI_IOV_RESOURCES];
+		if (!res->flags || !res->parent)
+			continue;
+
+		if (!pnv_pci_is_mem_pref_64(res->flags))
+			continue;
+
+		size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
+		res2 = *res;
+		res->start += size * offset;
+
+		dev_info(&dev->dev, "VF BAR%d: %pR shifted to %pR (enabling %d VFs shifted by %d)\n",
+			 i, &res2, res, vf_num, offset);
+		pci_update_resource(dev, i + PCI_IOV_RESOURCES);
+	}
+	pdn->max_vfs -= offset;
+	return 0;
+}
+#endif /* CONFIG_PCI_IOV */
+
 #if 0
 static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
 {
