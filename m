Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9F07E2C026C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 20:08:30 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 16 Aug 2013 19:54:53 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4ED9C2BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 20:08:10 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7G9q9mP1049042
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 19:52:09 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7GA8970016108
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 20:08:09 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] powerpc/iommu: check dev->iommu_group before remove it
Date: Fri, 16 Aug 2013 18:08:05 +0800
Message-Id: <1376647687-20550-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, paulus@au1.ibm.com, benh@au1.ibm.com,
 Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Had a talk with Alexey, who suggest me to send this for comments.

On powernv platform, the P7IOC provide limited range of DMA space. For
example, there are only 8 DMA segments on each PHB. When there are more 
than 8 PEs, some of PE's tce32_table is not initialized.

In the normal case, 8 PE is enough. If VF is enabled, 8 is not enough. This
lead to some pci_dev's iommu_table_base is NULL. Which results this device
couldn't be added to any iommu_group, and finally dev->iommu_group is left NULL.
When this VF is removed from the system, this will case kernel crash.

These two patches add the check to guard the kernel. Comments are welcome for
which place is better.

One more comment from Alexey is where we allow these non-DMA capable device
exist in the system. Maybe we should not allow to create a pci_dev for those
who can't get proper DMA space. Your comments are welcome :-)

Thanks in advance.

Wei Yang (2):
  iommu: Don't remove device when no iommu_group associated
  powerpc/iommu: check dev->iommu_group before remove a device from
    iommu_group

 arch/powerpc/kernel/iommu.c |    3 ++-
 drivers/iommu/iommu.c       |    3 +++
 2 files changed, 5 insertions(+), 1 deletions(-)

-- 
1.7.5.4
