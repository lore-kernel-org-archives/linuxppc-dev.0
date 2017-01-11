Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyr0C0W3gzDqG4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 11:50:18 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0B0j6n0083285
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 19:50:16 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27w3n58r7u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 19:50:16 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 11 Jan 2017 10:50:14 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id EA2DC2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 11:50:11 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0B0oCtJ46203120
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 11:50:12 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0B0oBqq020518
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 11:50:11 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, hankmax0000@gmail.com, williel@supermicro.com.tw,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 0/3] powerpc/powernv: PCI hotplug fixes and improvement
Date: Wed, 11 Jan 2017 11:50:05 +1100
Message-Id: <1484095808-24777-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series fixes couple issues or improves its reliability:

   * The PDC event is never detected inside the IRQ handler in surprise
     hot-add path.
   * The slot's initial state should be REGISTERED state if it's emtpy.
     Otherwise, the PCI devices behind the slot won't be populated properly
     in hot-add path.
   * PDC isn't reliable for hot-add on some machines. Introduce another
     device-tree property to disable it if required by (skiboot) firmware.

Gavin Shan (3):
  drivers/pci/hotplug: Handle presence detection change properly
  drivers/pci/hotplug: Fix initial state for empty slot
  drivers/pci/hotplug: Mask PDC interrupt if required

 arch/powerpc/include/asm/pnv-pci.h |  2 ++
 drivers/pci/hotplug/pnv_php.c      | 49 +++++++++++++++++++++++++++++++-------
 2 files changed, 43 insertions(+), 8 deletions(-)

-- 
2.7.4
