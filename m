Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjm072Gl5zDrTv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 13:04:38 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8R32pBE105880
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 23:04:36 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25q8tp1sd5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 23:04:36 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Tue, 27 Sep 2016 08:34:33 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 0DEAD125805B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 08:34:51 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8R34J5a26083408
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 08:34:19 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8R34SUa007527
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 08:34:29 +0530
Subject: Re: [PATCH v5 0/4] PCI: Introduce a way to enforce all MMIO BARs not
 to share PAGE_SIZE
To: bhelgaas@google.com
References: <1473757234-5284-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Cc: zhong@linux.vnet.ibm.com, aik@ozlabs.ru, linux-pci@vger.kernel.org,
 gwshan@linux.vnet.ibm.com, alex.williamson@redhat.com,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date: Tue, 27 Sep 2016 11:04:22 +0800
MIME-Version: 1.0
In-Reply-To: <1473757234-5284-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <b3bc8af9-f54b-d248-ba32-ac3d8f67a938@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Bjorn,

Kindly Ping... Any comment on V5?

Thanks,
Yongji

On 2016/9/13 17:00, Yongji Xie wrote:
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
> patch 3 tried to add a new option for resource_alignment to use
> IORESOURCE_STARTALIGN to specify the alignment of PCI BARs; patch 4
> adds a macro to set the default alignment of all MMIO BARs.
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
> Yongji Xie (4):
>    PCI: Ignore enforced alignment when kernel uses existing firmware setup
>    PCI: Ignore enforced alignment to VF BARs
>    PCI: Add a new option for resource_alignment to reassign alignment
>    PCI: Add a macro to set default alignment for all PCI devices
>
>   Documentation/kernel-parameters.txt |    9 +++--
>   arch/powerpc/include/asm/pci.h      |    4 +++
>   drivers/pci/pci.c                   |   63 +++++++++++++++++++++++++++++------
>   3 files changed, 63 insertions(+), 13 deletions(-)
>
