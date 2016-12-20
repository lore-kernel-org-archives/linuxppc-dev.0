Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjTlC2FYkzDwSK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 18:22:46 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id b1so10898806pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 23:22:46 -0800 (PST)
Subject: Re: [RFC PATCH v7 0/3] PCI: Introduce a way to enforce all MMIO BARs
 not to share PAGE_SIZE
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>, bhelgaas@google.com
References: <1477464813-2499-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <6931390b-151e-ec62-b694-e3ff49163245@linux.vnet.ibm.com>
 <2d8d7196-9eb3-01cc-4f21-423b90bd7cf7@ozlabs.ru>
Cc: zhong@linux.vnet.ibm.com, linux-pci@vger.kernel.org,
 gwshan@linux.vnet.ibm.com, alex.williamson@redhat.com, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <33088110-dd46-6a55-611a-793d82a48b50@ozlabs.ru>
Date: Tue, 20 Dec 2016 18:22:38 +1100
MIME-Version: 1.0
In-Reply-To: <2d8d7196-9eb3-01cc-4f21-423b90bd7cf7@ozlabs.ru>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/12/16 13:32, Alexey Kardashevskiy wrote:
> On 15/11/16 13:53, Yongji Xie wrote:
>> Hi Bjorn,
>>
>>
>> Kindly ping. What do you think of the way to fix the bug that resources's
>> size is changed
>>
>> when using resource_alignment. Thanks.
> 
> 
> Could anyone please comment on this? Thanks!


Anyone, please?


> 
> 
> 
>>
>>
>> On 2016/10/26 14:53, Yongji Xie wrote:
>>> This series introduces a way for PCI resource allocator to force
>>> MMIO BARs not to share PAGE_SIZE. This would make sense to VFIO
>>> driver. Because current VFIO implementation disallows to mmap
>>> sub-page(size < PAGE_SIZE) MMIO BARs which may share the same page
>>> with other BARs for security reasons. Thus, we have to handle mmio
>>> access to these BARs in QEMU emulation rather than in guest which
>>> will cause some performance loss.
>>>
>>> In our solution, we try to make use of the existing code path of
>>> resource_alignment kernel parameter and add a macro to set default
>>> alignment for it. Thus we can define this macro by default on some
>>> archs which may easily hit the performance issue because of their
>>> 64K page.
>>>
>>> In this series, patch 1,2 fixed bugs of using resource_alignment;
>>> patch 3 adds a macro to set the default alignment of all MMIO BARs.
>>>
>>> Changelog v7:
>>> - Rebased against v4.9-rc2
>>> - Drop two merged patches
>>> - Rework the patch which fix a bug that resources's size is changed when
>>>    using resource_alignment
>>> - Add a patch that fix a bug for IOV BARs when using resource_alignment
>>>
>>> Changelog v6:
>>> - Remove the option "noresize@" of resource_alignment
>>>
>>> Changelog v5:
>>> - Rebased against v4.8-rc6
>>> - Drop the patch that forbidding disable memory decoding in
>>>    pci_reassigndev_resource_alignment()
>>>
>>> Changelog v4:
>>> - Rebased against v4.8-rc1
>>> - Drop one irrelevant patch
>>> - Drop the patch that adding wildcard to resource_alignment to enforce
>>>    the alignment of all MMIO BARs to be at least PAGE_SIZE
>>> - Change the format of option "noresize" of resource_alignment
>>> - Code style improvements
>>>
>>> Changelog v3:
>>> - Ignore enforced alignment to fixed BARs
>>> - Fix issue that disabling memory decoding when reassigning the alignment
>>> - Only enable default alignment on PowerNV platform
>>>
>>> Changelog v2:
>>> - Ignore enforced alignment to VF BARs on
>>> pci_reassigndev_resource_alignment()
>>>
>>> Yongji Xie (3):
>>>    PCI: Ignore requested alignment for IOV BARs
>>>    PCI: Restore resource's size if we expand it by using resource_alignment
>>>    PCI: Add a macro to set default alignment for all PCI devices
>>>
>>>   arch/powerpc/include/asm/pci.h |    4 ++++
>>>   drivers/pci/pci.c              |    6 +++++-
>>>   drivers/pci/setup-bus.c        |   19 +++++++++++++++++++
>>>   include/linux/pci.h            |    1 +
>>>   4 files changed, 29 insertions(+), 1 deletion(-)
>>>
>>
> 
> 


-- 
Alexey
