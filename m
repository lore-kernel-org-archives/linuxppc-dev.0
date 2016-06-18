Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rWx3D5QLGzDqhC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jun 2016 22:18:00 +1000 (AEST)
Date: Sat, 18 Jun 2016 07:17:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Wei Yang <weiyang@linux.vnet.ibm.com>,
 Khalid Aziz <khalid.aziz@oracle.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v13 01/16] PCI: Let pci_mmap_page_range() take resource
 address
Message-ID: <20160618121752.GA22721@localhost>
References: <20160618022501.15648-1-yinghai@kernel.org>
 <20160618022501.15648-2-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160618022501.15648-2-yinghai@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 17, 2016 at 07:24:46PM -0700, Yinghai Lu wrote:
> In 8c05cd08a7 ("PCI: fix offset check for sysfs mmapped files"), try
> to check exposed value with resource start/end in proc mmap path.
> 
> |        start = vma->vm_pgoff;
> |        size = ((pci_resource_len(pdev, resno) - 1) >> PAGE_SHIFT) + 1;
> |        pci_start = (mmap_api == PCI_MMAP_PROCFS) ?
> |                        pci_resource_start(pdev, resno) >> PAGE_SHIFT : 0;
> |        if (start >= pci_start && start < pci_start + size &&
> |                        start + nr <= pci_start + size)
> 
> That breaks sparc that exposed value is BAR value, and need to be offseted
> to resource address.

I asked this same question of the v12 patch, but I don't think you
answered it:

I'm not quite sure what you're saying here.  Are you saying that sparc
is currently broken, and this patch fixes it?  If so, what exactly is
broken?  Can you give a small example of an mmap that is currently
broken?
