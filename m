Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHsQn0crPzDvZ2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 13:53:36 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAF2p0P6027201
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 21:53:34 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26qpxdphww-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 21:53:34 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Tue, 15 Nov 2016 12:53:31 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 009203578057
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 13:53:28 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAF2rR1I1180060
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 13:53:27 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAF2rRIF004386
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 13:53:27 +1100
Subject: Re: [RFC PATCH v7 0/3] PCI: Introduce a way to enforce all MMIO BARs
 not to share PAGE_SIZE
To: bhelgaas@google.com
References: <1477464813-2499-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Cc: zhong@linux.vnet.ibm.com, aik@ozlabs.ru, linux-pci@vger.kernel.org,
 gwshan@linux.vnet.ibm.com, alex.williamson@redhat.com,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date: Tue, 15 Nov 2016 10:53:25 +0800
MIME-Version: 1.0
In-Reply-To: <1477464813-2499-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <6931390b-151e-ec62-b694-e3ff49163245@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Bjorn,


Kindly ping. What do you think of the way to fix the bug that 
resources's size is changed

when using resource_alignment. Thanks.


On 2016/10/26 14:53, Yongji Xie wrote:
> This series introduces a way for PCI resource allocator to force
> MMIO BARs not to share PAGE_SIZE. This would make sense to VFIO
> driver. Because current VFIO implementation disallows to mmap
> sub-page(size < PAGE_SIZE) MMIO BARs which may share the same page
> with other BARs for security reasons. Thus, we have to handle mmio
> access to these BARs in QEMU emulation rather than in guest which
> will cause some performance loss.
>
> In our solution, we try to make use of the existing code path of
> resource_alignment kernel parameter and add a macro to set default
> alignment for it. Thus we can define this macro by default on some
> archs which may easily hit the performance issue because of their
> 64K page.
>
> In this series, patch 1,2 fixed bugs of using resource_alignment;
> patch 3 adds a macro to set the default alignment of all MMIO BARs.
>
> Changelog v7:
> - Rebased against v4.9-rc2
> - Drop two merged patches
> - Rework the patch which fix a bug that resources's size is changed when
>    using resource_alignment
> - Add a patch that fix a bug for IOV BARs when using resource_alignment
>
> Changelog v6:
> - Remove the option "noresize@" of resource_alignment
>
> Changelog v5:
> - Rebased against v4.8-rc6
> - Drop the patch that forbidding disable memory decoding in
>    pci_reassigndev_resource_alignment()
>
> Changelog v4:
> - Rebased against v4.8-rc1
> - Drop one irrelevant patch
> - Drop the patch that adding wildcard to resource_alignment to enforce
>    the alignment of all MMIO BARs to be at least PAGE_SIZE
> - Change the format of option "noresize" of resource_alignment
> - Code style improvements
>
> Changelog v3:
> - Ignore enforced alignment to fixed BARs
> - Fix issue that disabling memory decoding when reassigning the alignment
> - Only enable default alignment on PowerNV platform
>
> Changelog v2:
> - Ignore enforced alignment to VF BARs on pci_reassigndev_resource_alignment()
>
> Yongji Xie (3):
>    PCI: Ignore requested alignment for IOV BARs
>    PCI: Restore resource's size if we expand it by using resource_alignment
>    PCI: Add a macro to set default alignment for all PCI devices
>
>   arch/powerpc/include/asm/pci.h |    4 ++++
>   drivers/pci/pci.c              |    6 +++++-
>   drivers/pci/setup-bus.c        |   19 +++++++++++++++++++
>   include/linux/pci.h            |    1 +
>   4 files changed, 29 insertions(+), 1 deletion(-)
>
