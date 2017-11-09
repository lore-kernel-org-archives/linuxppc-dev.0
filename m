Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yXP244bxmzDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Nov 2017 11:20:12 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <helgaas@kernel.org>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
 seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
 saeedm@mellanox.com
Subject: Re: [PATCH v4 3/3] pci/iov: Expose VF drivers Auto Probe Globally
In-Reply-To: <20171108230537.GD21597@bhelgaas-glaptop.roam.corp.google.com>
References: <20171031144724.27808-1-bryantly@linux.vnet.ibm.com>
 <20171031144724.27808-4-bryantly@linux.vnet.ibm.com>
 <20171108230537.GD21597@bhelgaas-glaptop.roam.corp.google.com>
Date: Thu, 09 Nov 2017 11:20:10 +1100
Message-ID: <87375o2thh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bjorn Helgaas <helgaas@kernel.org> writes:
> Please update the subject line from
>
>   pci/iov: Expose VF drivers Auto Probe Globally
>
> to
>
>   PCI/IOV: Add pci_vf_drivers_autoprobe() interface
...
>
>> + */
>> +void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool auto_probe)
>> +{
>> +	if (dev->is_physfn)
>> +		dev->sriov->drivers_autoprobe = auto_probe;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_vf_drivers_autoprobe);
>
> I don't think this needs to be exported.  It's only called from arch
> code that cannot be a module.
>
> With these changes,
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> I assume you'll merge these via the powerpc tree.  Let me know if you
> need anything else from me.

Thanks.

Actually I'd basically missed this series because it wasn't properly
cc'ed to linuxppc-dev, so it doesn't appear in patchwork.

Bryant, please incorporate Bjorn's review comments and resend a v5 to
linuxppc-dev. Thanks.

It should show up here for me to see it:
  http://patchwork.ozlabs.org/project/linuxppc-dev/list/?submitter=72247

cheers
