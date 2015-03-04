Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B81A1A0006
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 14:02:18 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 4 Mar 2015 13:02:17 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 077B82BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 14:02:16 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t24327PT29950026
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Mar 2015 14:02:16 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2431gtt022363
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Mar 2015 14:01:42 +1100
Date: Wed, 4 Mar 2015 11:01:24 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 17/21] powerpc/powernv: Shift VF resource with an
 offset
Message-ID: <20150304030051.GA10797@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224083457.32124.55534.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224090037.GK6220@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150224090037.GK6220@google.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 24, 2015 at 03:00:37AM -0600, Bjorn Helgaas wrote:
>On Tue, Feb 24, 2015 at 02:34:57AM -0600, Bjorn Helgaas wrote:
>> From: Wei Yang <weiyang@linux.vnet.ibm.com>
>> 
>> On PowerNV platform, resource position in M64 implies the PE# the resource
>> belongs to.  In some cases, adjustment of a resource is necessary to locate
>> it to a correct position in M64.
>> 
>> Add pnv_pci_vf_resource_shift() to shift the 'real' PF IOV BAR address
>> according to an offset.
>> 
>> [bhelgaas: rework loops, rework overlap check, index resource[]
>> conventionally, remove pci_regs.h include, squashed with next patch]
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
>...
>
>> +#ifdef CONFIG_PCI_IOV
>> +static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
>> +{
>> +	struct pci_dn *pdn = pci_get_pdn(dev);
>> +	int i;
>> +	struct resource *res, res2;
>> +	resource_size_t size;
>> +	u16 vf_num;
>> +
>> +	if (!dev->is_physfn)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * "offset" is in VFs.  The M64 windows are sized so that when they
>> +	 * are segmented, each segment is the same size as the IOV BAR.
>> +	 * Each segment is in a separate PE, and the high order bits of the
>> +	 * address are the PE number.  Therefore, each VF's BAR is in a
>> +	 * separate PE, and changing the IOV BAR start address changes the
>> +	 * range of PEs the VFs are in.
>> +	 */
>> +	vf_num = pdn->vf_pes;
>> +	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>> +		res = &dev->resource[i + PCI_IOV_RESOURCES];
>> +		if (!res->flags || !res->parent)
>> +			continue;
>> +
>> +		if (!pnv_pci_is_mem_pref_64(res->flags))
>> +			continue;
>> +
>> +		/*
>> +		 * The actual IOV BAR range is determined by the start address
>> +		 * and the actual size for vf_num VFs BAR.  This check is to
>> +		 * make sure that after shifting, the range will not overlap
>> +		 * with another device.
>> +		 */
>> +		size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
>> +		res2.flags = res->flags;
>> +		res2.start = res->start + (size * offset);
>> +		res2.end = res2.start + (size * vf_num) - 1;
>> +
>> +		if (res2.end > res->end) {
>> +			dev_err(&dev->dev, "VF BAR%d: %pR would extend past %pR (trying to enable %d VFs shifted by %d)\n",
>> +				i, &res2, res, vf_num, offset);
>> +			return -EBUSY;
>> +		}
>> +	}
>> +
>> +	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>> +		res = &dev->resource[i + PCI_IOV_RESOURCES];
>> +		if (!res->flags || !res->parent)
>> +			continue;
>> +
>> +		if (!pnv_pci_is_mem_pref_64(res->flags))
>> +			continue;
>> +
>> +		size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
>> +		res2 = *res;
>> +		res->start += size * offset;
>
>I'm still not happy about this fiddling with res->start.
>
>Increasing res->start means that in principle, the "size * offset" bytes
>that we just removed from res are now available for allocation to somebody
>else.  I don't think we *will* give that space to anything else because of
>the alignment restrictions you're enforcing, but "res" now doesn't
>correctly describe the real resource map.
>
>Would you be able to just update the BAR here while leaving the struct
>resource alone?  In that case, it would look a little funny that lspci
>would show a BAR value in the middle of the region in /proc/iomem, but
>the /proc/iomem region would be more correct.

Bjorn,

I did some tests, while the result is not good.

What I did is still write the shifted resource address to the device by
pci_update_resource(), but I revert the res->start to the original one. If
this step is not correct, please let me know.

This can't work since after we revert the res->start, those VFs will be given
resources from res->start instead of (res->start + offset * size). This is not
what we expect.

I have rebased/clean/change the code according to your comments based on this
patch set. Will send it out v13 soon.

>
>> +
>> +		dev_info(&dev->dev, "VF BAR%d: %pR shifted to %pR (enabling %d VFs shifted by %d)\n",
>> +			 i, &res2, res, vf_num, offset);
>> +		pci_update_resource(dev, i + PCI_IOV_RESOURCES);
>> +	}
>> +	pdn->max_vfs -= offset;
>> +	return 0;
>> +}
>> +#endif /* CONFIG_PCI_IOV */

-- 
Richard Yang
Help you, Help me
