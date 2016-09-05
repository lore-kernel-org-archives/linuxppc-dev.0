Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSQqw031gzDrnr
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Sep 2016 20:26:19 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u85AP3mW097462
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 06:26:17 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 258bnu58pf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Sep 2016 06:26:16 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Mon, 5 Sep 2016 20:26:13 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DAD7B2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Sep 2016 20:26:10 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u85AQATw459030
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 20:26:10 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u85AQAoJ006131
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 20:26:10 +1000
Subject: Re: [PATCH v4 0/5] PCI: Introduce a way to enforce all MMIO BARs not
 to share PAGE_SIZE
To: bhelgaas@google.com
References: <1470980546-2918-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Cc: zhong@linux.vnet.ibm.com, aik@ozlabs.ru, linux-pci@vger.kernel.org,
 gwshan@linux.vnet.ibm.com, alex.williamson@redhat.com,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date: Mon, 5 Sep 2016 18:26:07 +0800
MIME-Version: 1.0
In-Reply-To: <1470980546-2918-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <41a82dfc-5629-6f7e-1d8b-73e04fb44b57@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ping?

On 2016/8/12 13:42, Yongji Xie wrote:
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
> In this series, patch 1,2,3 fixed bugs of using resource_alignment;
> patch 4 tried to add a new option for resource_alignment to use
> IORESOURCE_STARTALIGN to specify the alignment of PCI BARs; patch 5
> adds a macro to set the default alignment of all MMIO BARs.
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
> Yongji Xie (5):
>    PCI: Ignore enforced alignment when kernel uses existing firmware setup
>    PCI: Ignore enforced alignment to VF BARs
>    PCI: Do not disable memory decoding in pci_reassigndev_resource_alignment()
>    PCI: Add a new option for resource_alignment to reassign alignment
>    PCI: Add a macro to set default alignment for all PCI devices
>
>   Documentation/kernel-parameters.txt |    9 +++--
>   arch/powerpc/include/asm/pci.h      |    4 ++
>   drivers/pci/pci.c                   |   71 ++++++++++++++++++++++++++---------
>   3 files changed, 64 insertions(+), 20 deletions(-)
>
