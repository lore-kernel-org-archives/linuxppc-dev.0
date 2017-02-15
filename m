Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNwMc03yJzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 10:23:39 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1FNIsl0086936
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 18:23:38 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28mq9r0d9c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 18:23:37 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 16 Feb 2017 09:23:35 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 899493578058
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 10:23:32 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1FNNO0916318700
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 10:23:32 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1FNN0ZH027378
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 10:23:00 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, mpe@ellerman.id.au, bhelgaas@google.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 0/3] pci/hotplug/pnv-php: More bug fixes
Date: Thu, 16 Feb 2017 10:22:31 +1100
Message-Id: <1487200954-14681-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series bases on the series: https://patchwork.ozlabs.org/patch/713513.
This series fixes couple of issues:

   * Remove WARN_ON() in pnv_php_put_slot(). The parent slot's refcount
     is decreased when releasing PCI slot. The parent slot can be NULL
     and no need to give a warning.
   * The MSI (or MSIx) could be enabled prior to load pnv-php.ko. A
     backtrace is thrown when phv-php.ko attempts to enable MSI again.
     PATCH[2/3] skips enabling surprise hotplug if MSI has been enabled
     by other driver.
   * PATCH[3/3] doesn't disable MSI that was enabled by other dirver.
     Also, the upstream port of the PCI slot is disabled when it's
     destroyed.

Gavin Shan (3):
  pci/hotplug/pnv-php: Remove WARN_ON() in pnv_php_put_slot()
  pci/hotplug/pnv-php: Disable surprise hotplug capability on conflicts
  pci/hotplug/pnv-php: Disable MSI and PCI device properly

 drivers/pci/hotplug/pnv_php.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

-- 
2.7.4
