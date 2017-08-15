Return-Path: <jike.song@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWb5G65XpzDqYK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 11:49:54 +1000 (AEST)
Message-ID: <599252B9.8030407@intel.com>
Date: Tue, 15 Aug 2017 09:47:37 +0800
From: Jike Song <jike.song@intel.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Robin Murphy <robin.murphy@arm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 Yongji Xie <elohimes@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 Kyle Mahlkuch <Kyle.Mahlkuch@ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Joerg Roedel <joro@8bytes.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 Neo Jia <cjia@nvidia.com>, Paul Mackerras <paulus@samba.org>,
 Vlad Tsyrklevich <vlad@tsyrklevich.net>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 0/5] vfio-pci: Add support for mmapping MSI-X table
References: <20170807072548.3023-1-aik@ozlabs.ru>
 <8f5f7b82-3c10-7f39-b587-db4c4424f04c@ozlabs.ru>
 <ca2a4550-fb26-28db-0eea-a5940dfa612f@arm.com> <59924B85.5040405@intel.com>
 <1502760820.4493.40.camel@kernel.crashing.org>
In-Reply-To: <1502760820.4493.40.camel@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/15/2017 09:33 AM, Benjamin Herrenschmidt wrote:
> On Tue, 2017-08-15 at 09:16 +0800, Jike Song wrote:
>>> Taking a step back, though, why does vfio-pci perform this check in the
>>> first place? If a malicious guest already has control of a device, any
>>> kind of interrupt spoofing it could do by fiddling with the MSI-X
>>> message address/data it could simply do with a DMA write anyway, so the
>>> security argument doesn't stand up in general (sure, not all PCIe
>>> devices may be capable of arbitrary DMA, but that seems like more of a
>>> tenuous security-by-obscurity angle to me).
> 
> I tried to make that point for years, thanks for re-iterating it :-)
> 
>> Hi Robin,
>>
>> DMA writes will be translated (thereby censored) by DMA Remapping hardware,
>> while MSI/MSI-X will not. Is this different for non-x86?
> 
> There is no way your DMA remapping HW can differenciate. The only
> difference between a DMA write and an MSI is ... the address. So if I
> can make my device DMA to the MSI address range, I've defeated your
> security.

I don't think with IRQ remapping enabled, you can make your device DMA to
MSI address, without being treated as an IRQ and remapped. If so, the IRQ
remapping hardware is simply broken :)

--
Thanks,
Jike
