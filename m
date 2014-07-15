Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B30EE1A019B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 17:01:05 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 15 Jul 2014 17:01:05 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 69E812BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 17:00:59 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F6cHD4983460
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 16:38:17 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F70wn2000410
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 17:00:58 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] Bug fix for VFIO EEH
Date: Tue, 15 Jul 2014 17:00:54 +1000
Message-Id: <1405407656-3751-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Those 2 patches are bug fix for VFIO EEH support, which isn't merged yet though
all reviewers gave their ack. So I'm sending this to avoid revert or something
like that.

The problem is that dma_offset/iommu_table_base
are sharing same memory location. When disabling bypass mode, we missed to restore
iommu_table_base. EEH is utilizing that to translate IOMMU group ID to PE. The
patches fix the issue.

Another issue is that we're searching all online PCI devices for translating
IOMMU group ID to PE. That's incorrect since we're uncertain that one speicific
device (except those in current IOMMU group) is running in bypassed mode or
not. So we should have search current IOMMU group.

It should be applied on top of unmerged VFIO EEH support patchset:

http://patchwork.ozlabs.org/patch/357665/

Gavin Shan (2):
  powerpc/powernv: Fix IOMMU table for VFIO dev
  powerpc/eeh: Fetch IOMMU table in reliable way

 arch/powerpc/kernel/eeh.c                 | 33 ++++++++++++++++++++-----------
 arch/powerpc/platforms/powernv/pci-ioda.c | 30 +++++++++++++++++++---------
 2 files changed, 43 insertions(+), 20 deletions(-)

-- 
1.8.3.2
