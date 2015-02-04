Return-Path: <bhelgaas@google.com>
Received: from mail-ob0-x229.google.com (mail-ob0-x229.google.com
 [IPv6:2607:f8b0:4003:c01::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6AB4B1A0A68
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 09:05:24 +1100 (AEDT)
Received: by mail-ob0-f169.google.com with SMTP id wp4so4006984obc.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Feb 2015 14:05:21 -0800 (PST)
Date: Wed, 4 Feb 2015 16:05:18 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH V11 16/17] powerpc/powernv: Reserve additional space for
 IOV BAR, with m64_per_iov supported
Message-ID: <20150204220518.GB20072@google.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-17-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421288887-7765-17-git-send-email-weiyang@linux.vnet.ibm.com>
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

On Thu, Jan 15, 2015 at 10:28:06AM +0800, Wei Yang wrote:
> M64 aperture size is limited on PHB3. When the IOV BAR is too big, this
> will exceed the limitation and failed to be assigned.
> 
> This patch introduce a different mechanism based on the IOV BAR size:
> 
> IOV BAR size is smaller than 64M, expand to total_pe.
> IOV BAR size is bigger than 64M, roundup power2.

Can you elaborate on this a little more?  I assume this is talking about an
M64 BAR.  What is the size limit for this?

If I understand correctly, hardware always splits an M64 BAR into 256
segments.  If you wanted each 128MB VF BAR in a separate PE, the M64 BAR
would have to be 256 * 128MB = 32GB.  So maybe the idea is that instead of
consuming 32GB of address space, you let each VF BAR span several segments.
If each 128MB VF BAR spanned 4 segments, each segment would be 32MB and the
whole M64 BAR would be 256 * 32MB = 8GB.  But you would have to use
"companion" PEs so all 4 segments would be in the same "domain," and that
would reduce the number of VFs you could support from 256 to 256/4 = 64.

If that were the intent, I would think TotalVFs would be involved, but it's
not.  For a device with TotalVFs=8 and a 128MB VF BAR, it would make sense
to dedicate 4 segments to each of those BARs because you could only use 8*4
= 32 segments total.  If the device had TotalVFs=128, your only choices
would be 1 segment per BAR (256 segments * 128MB/segment = 32GB) or 2
segments per BAR (256 segments * 64MB/segment = 16GB).

If you use 2 segments per BAR and you want NumVFs=128, you can't shift
anything, so the PE assignments are completely fixed (VF0 in PE0, VF1 in
PE1, etc.)

It seems like you'd make different choices about pdn->max_vfs for these two
devices, but currently you only look at the VF BAR size, not at TotalVFs.

> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/pci-bridge.h     |    2 ++
>  arch/powerpc/platforms/powernv/pci-ioda.c |   33 ++++++++++++++++++++++++++---
>  2 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index d61c384..7156486 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -174,6 +174,8 @@ struct pci_dn {
>  	u16     max_vfs;		/* number of VFs IOV BAR expended */
>  	u16     vf_pes;			/* VF PE# under this PF */
>  	int     offset;			/* PE# for the first VF PE */
> +#define M64_PER_IOV 4
> +	int     m64_per_iov;
>  #define IODA_INVALID_M64        (-1)
>  	int     m64_wins[PCI_SRIOV_NUM_BARS];
>  #endif /* CONFIG_PCI_IOV */
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 94fe6e1..23ea873 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2180,6 +2180,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>  	int i;
>  	resource_size_t size;
>  	struct pci_dn *pdn;
> +	int mul, total_vfs;
>  
>  	if (!pdev->is_physfn || pdev->is_added)
>  		return;
> @@ -2190,6 +2191,32 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>  	pdn = pci_get_pdn(pdev);
>  	pdn->max_vfs = 0;
>  
> +	total_vfs = pci_sriov_get_totalvfs(pdev);
> +	pdn->m64_per_iov = 1;
> +	mul = phb->ioda.total_pe;
> +
> +	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++) {
> +		res = &pdev->resource[i];
> +		if (!res->flags || res->parent)
> +			continue;
> +		if (!pnv_pci_is_mem_pref_64(res->flags)) {
> +			dev_warn(&pdev->dev, " non M64 IOV BAR %pR on %s\n",
> +					res, pci_name(pdev));
> +			continue;
> +		}
> +
> +		size = pci_iov_resource_size(pdev, i);
> +
> +		/* bigger than 64M */
> +		if (size > (1 << 26)) {
> +			dev_info(&pdev->dev, "PowerNV: VF BAR[%d] size "
> +					"is bigger than 64M, roundup power2\n", i);
> +			pdn->m64_per_iov = M64_PER_IOV;
> +			mul = __roundup_pow_of_two(total_vfs);

I think this might deserve more comment in dmesg.  "roundup power2" doesn't
really tell me anything, especially since you mention a BAR, but you're
actually rounding up total_vfs, not the BAR size.

Does this reduce the number of possible VFs?  We already can't set NumVFs
higher than TotalVFs.  Does this make it so we can't set NumVFs higher than
pdn->max_vfs?


> +			break;
> +		}
> +	}
> +
>  	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++) {
>  		res = &pdev->resource[i];
>  		if (!res->flags || res->parent)
> @@ -2202,13 +2229,13 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
>  
>  		dev_dbg(&pdev->dev, " Fixing VF BAR[%d] %pR to\n", i, res);
>  		size = pci_iov_resource_size(pdev, i);
> -		res->end = res->start + size * phb->ioda.total_pe - 1;
> +		res->end = res->start + size * mul - 1;
>  		dev_dbg(&pdev->dev, "                       %pR\n", res);
>  		dev_info(&pdev->dev, "VF BAR%d: %pR (expanded to %d VFs for PE alignment)",
>  				i - PCI_IOV_RESOURCES,
> -				res, phb->ioda.total_pe);
> +				res, mul);
>  	}
> -	pdn->max_vfs = phb->ioda.total_pe;
> +	pdn->max_vfs = mul;

Maybe this is the part that makes it hard to compute the size in
sriov_init() -- you reduce pdn->max_vfs in some cases, and maybe that can
affect the space you reserve for IOV BARs?  E.g., maybe you reduce
pdn->max_vfs to 128 because VF BAR 3 is larger than 64MB, but you've
already expanded the IOV space for VF BAR 1 based on 256 PEs?

But then I'm still confused because the loop here in
pnv_pci_ioda_fixup_iov_resources() always expands the resource based on
phb->ioda.total_pe; that part doesn't depend on "mul" or pdn->max_vfs at
all.

Or maybe this is just a bug in the fixup loop, and it *should* depend on
"mul"?

>  }
>  
>  static void pnv_pci_ioda_fixup_sriov(struct pci_bus *bus)
> -- 
> 1.7.9.5
> 
