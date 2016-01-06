Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BE651A11A9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jan 2016 20:58:05 +1100 (AEDT)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Wed, 6 Jan 2016 15:28:02 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 548FF125805B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jan 2016 15:28:42 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u069vwFd19136704
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jan 2016 15:27:59 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u069vwlf007728
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jan 2016 15:27:58 +0530
Subject: Re: [RFC PATCH v2 3/3] vfio-pci: Allow to mmap MSI-X table if EEH is
 supported
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org
References: <1451551844-11732-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1451551844-11732-4-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1451941655.6585.8.camel@redhat.com>
 <1451943775.12575.6.camel@kernel.crashing.org>
Cc: bhelgaas@google.com, corbet@lwn.net, aik@ozlabs.ru, paulus@samba.org,
 mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Message-ID: <568CE52F.8030407@linux.vnet.ibm.com>
Date: Wed, 6 Jan 2016 17:58:07 +0800
MIME-Version: 1.0
In-Reply-To: <1451943775.12575.6.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/1/5 5:42, Benjamin Herrenschmidt wrote:
> On Mon, 2016-01-04 at 14:07 -0700, Alex Williamson wrote:
>> On Thu, 2015-12-31 at 16:50 +0800, Yongji Xie wrote:
>>> Current vfio-pci implementation disallows to mmap MSI-X
>>> table in case that user get to touch this directly.
>>>
>>> However, EEH mechanism can ensure that a given pci device
>>> can only shoot the MSIs assigned for its PE. So we think
>>> it's safe to expose the MSI-X table to userspace because
>>> the exposed MSI-X table can't be used to do harm to other
>>> memory space.
>>>
>>> And with MSI-X table mmapped, some performance issues which
>>> are caused when PCI adapters have critical registers in the
>>> same page as the MSI-X table also can be resolved.
>>>
>>> So this patch adds a Kconfig option, VFIO_PCI_MMAP_MSIX,
>>> to support for mmapping MSI-X table.
>>>
>>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>>> ---
>>>   drivers/vfio/pci/Kconfig    |    4 ++++
>>>   drivers/vfio/pci/vfio_pci.c |    6 ++++--
>>>   2 files changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
>>> index 02912f1..67b0a2c 100644
>>> --- a/drivers/vfio/pci/Kconfig
>>> +++ b/drivers/vfio/pci/Kconfig
>>> @@ -23,6 +23,10 @@ config VFIO_PCI_MMAP
>>>   	depends on VFIO_PCI
>>>   	def_bool y if !S390
>>>   
>>> +config VFIO_PCI_MMAP_MSIX
>>> +	depends on VFIO_PCI_MMAP
>>> +	def_bool y if EEH
>> Does CONFIG_EEH necessarily mean the EEH is enabled?  Could the
>> system
>> not support EEH or could EEH be disabled via kernel commandline
>> options?
> EEH is definitely the wrong thing to test here anyway. What needs to be
> tested is that the PCI Host bridge supports filtering of MSIs, so
> ideally this should be some kind of host bridge attribute set by the
> architecture backend.

So do you mean this attribute can be added in pci_host_bridge like this:

--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -412,6 +412,7 @@ struct pci_host_bridge {
  	void (*release_fn)(struct pci_host_bridge *);
  	void *release_data;
  	unsigned int ignore_reset_delay:1;	/* for entire hierarchy */
+	unsigned int msix_filtered:1;	/* support filtering of MSIs */
  	/* Resource alignment requirements */
  	resource_size_t (*align_resource)(struct pci_dev *dev,
  			const struct resource *res,

I can surely do it if there is no objection from PCI folks. Thanks.

Regards,
Yongji Xie

> This can happen with or without CONFIG_EEH and you are right,
> CONFIG_EEH can be enabled and the machine not support it.
>
> Any IODA bridge will support this.
>
> Cheers,
> Ben.
>
