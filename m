Return-Path: <yhlu.kernel@gmail.com>
Received: from mail-vk0-x244.google.com (mail-vk0-x244.google.com
 [IPv6:2607:f8b0:400c:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZBXh6lK0zDqFM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 14:32:52 +1000 (AEST)
Received: by mail-vk0-x244.google.com with SMTP id k2so5856957vkb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 21:32:52 -0700 (PDT)
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <20160618121752.GA22721@localhost>
References: <20160618022501.15648-1-yinghai@kernel.org>
 <20160618022501.15648-2-yinghai@kernel.org>
 <20160618121752.GA22721@localhost>
From: Yinghai Lu <yinghai@kernel.org>
Date: Tue, 21 Jun 2016 21:32:49 -0700
Message-ID: <CAE9FiQXKVLWZaiD0CgSGEMN6c4g6GeCNGS=NE=gC-CEAymo1eQ@mail.gmail.com>
Subject: Re: [PATCH v13 01/16] PCI: Let pci_mmap_page_range() take resource
 address
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Wei Yang <weiyang@linux.vnet.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 18, 2016 at 5:17 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, Jun 17, 2016 at 07:24:46PM -0700, Yinghai Lu wrote:
>> In 8c05cd08a7 ("PCI: fix offset check for sysfs mmapped files"), try
>> to check exposed value with resource start/end in proc mmap path.
>>
>> |        start = vma->vm_pgoff;
>> |        size = ((pci_resource_len(pdev, resno) - 1) >> PAGE_SHIFT) + 1;
>> |        pci_start = (mmap_api == PCI_MMAP_PROCFS) ?
>> |                        pci_resource_start(pdev, resno) >> PAGE_SHIFT : 0;
>> |        if (start >= pci_start && start < pci_start + size &&
>> |                        start + nr <= pci_start + size)
>>
>> That breaks sparc that exposed value is BAR value, and need to be offseted
>> to resource address.
>
> I asked this same question of the v12 patch, but I don't think you
> answered it:
>
> I'm not quite sure what you're saying here.  Are you saying that sparc
> is currently broken, and this patch fixes it?  If so, what exactly is
> broken?  Can you give a small example of an mmap that is currently
> broken?

Yes, for sparc that path (proc mmap) is broken, but only according to
code checking.

The reason for the problem is not discovered is that seem all users
(other than x86) are not
use proc_mmap ?

vma->vm_pgoff is that code segment is User/BAR value >> PAGE_SHIFT.
pci_start is resource->start >> PAGE_SHIFT.

For sparc, resource start is different from BAR start aka pci bus address.
pci bus address add offset to be the resource start.

Thanks

Yinghai
