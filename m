Return-Path: <bhelgaas@google.com>
Received: from mail-qg0-x22c.google.com (mail-qg0-x22c.google.com
 [IPv6:2607:f8b0:400d:c04::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 93C2E1A108D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 04:10:56 +1100 (AEDT)
Received: by mail-qg0-f44.google.com with SMTP id j5so31065098qga.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 09:10:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150224090037.GK6220@google.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224083457.32124.55534.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224090037.GK6220@google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 24 Feb 2015 11:10:33 -0600
Message-ID: <CAErSpo7Yce518DXejsZW0cS34GFKYLxhctSoqk0y_C5UAiDQ9A@mail.gmail.com>
Subject: Re: [PATCH v12 17/21] powerpc/powernv: Shift VF resource with an
 offset
To: Wei Yang <weiyang@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 24, 2015 at 3:00 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Feb 24, 2015 at 02:34:57AM -0600, Bjorn Helgaas wrote:
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
> ...
>
>> +#ifdef CONFIG_PCI_IOV
>> +static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
>> +{
>> +     struct pci_dn *pdn = pci_get_pdn(dev);
>> +     int i;
>> +     struct resource *res, res2;
>> +     resource_size_t size;
>> +     u16 vf_num;
>> +
>> +     if (!dev->is_physfn)
>> +             return -EINVAL;
>> +
>> +     /*
>> +      * "offset" is in VFs.  The M64 windows are sized so that when they
>> +      * are segmented, each segment is the same size as the IOV BAR.
>> +      * Each segment is in a separate PE, and the high order bits of the
>> +      * address are the PE number.  Therefore, each VF's BAR is in a
>> +      * separate PE, and changing the IOV BAR start address changes the
>> +      * range of PEs the VFs are in.
>> +      */
>> +     vf_num = pdn->vf_pes;
>> +     for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>> +             res = &dev->resource[i + PCI_IOV_RESOURCES];
>> +             if (!res->flags || !res->parent)
>> +                     continue;
>> +
>> +             if (!pnv_pci_is_mem_pref_64(res->flags))
>> +                     continue;
>> +
>> +             /*
>> +              * The actual IOV BAR range is determined by the start address
>> +              * and the actual size for vf_num VFs BAR.  This check is to
>> +              * make sure that after shifting, the range will not overlap
>> +              * with another device.
>> +              */
>> +             size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
>> +             res2.flags = res->flags;
>> +             res2.start = res->start + (size * offset);
>> +             res2.end = res2.start + (size * vf_num) - 1;
>> +
>> +             if (res2.end > res->end) {
>> +                     dev_err(&dev->dev, "VF BAR%d: %pR would extend past %pR (trying to enable %d VFs shifted by %d)\n",
>> +                             i, &res2, res, vf_num, offset);
>> +                     return -EBUSY;
>> +             }
>> +     }
>> +
>> +     for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>> +             res = &dev->resource[i + PCI_IOV_RESOURCES];
>> +             if (!res->flags || !res->parent)
>> +                     continue;
>> +
>> +             if (!pnv_pci_is_mem_pref_64(res->flags))
>> +                     continue;
>> +
>> +             size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
>> +             res2 = *res;
>> +             res->start += size * offset;
>
> I'm still not happy about this fiddling with res->start.
>
> Increasing res->start means that in principle, the "size * offset" bytes
> that we just removed from res are now available for allocation to somebody
> else.  I don't think we *will* give that space to anything else because of
> the alignment restrictions you're enforcing, but "res" now doesn't
> correctly describe the real resource map.
>
> Would you be able to just update the BAR here while leaving the struct
> resource alone?  In that case, it would look a little funny that lspci
> would show a BAR value in the middle of the region in /proc/iomem, but
> the /proc/iomem region would be more correct.

I guess this would also require a tweak where we compute the addresses
of each of the VF resources.  Today it's probably just "base + VF_num
* size", where "base" is res->start.  We'd have to account for the
offset there if we don't adjust it here.

>> +
>> +             dev_info(&dev->dev, "VF BAR%d: %pR shifted to %pR (enabling %d VFs shifted by %d)\n",
>> +                      i, &res2, res, vf_num, offset);
>> +             pci_update_resource(dev, i + PCI_IOV_RESOURCES);
>> +     }
>> +     pdn->max_vfs -= offset;
>> +     return 0;
>> +}
>> +#endif /* CONFIG_PCI_IOV */
