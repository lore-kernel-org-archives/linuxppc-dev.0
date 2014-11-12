Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 474BA1A0250
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 13:36:28 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1D04014017B
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 13:36:28 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 12 Nov 2014 12:36:27 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 39A292BB0062
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 13:36:25 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAC2cJK86684910
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 13:38:19 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAC2aODf021583
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 13:36:24 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/8] powerpc/powernv: PCI code cleanup
Date: Wed, 12 Nov 2014 13:36:03 +1100
Message-Id: <1415759771-11359-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patchset cleans up PowerNV PCI code. Also, the compound PEs are
affected to each other with help of PELTV, which was missed from
commit 262af557 ("powerpc/powernv: Enable M64 aperatus for PHB3").

Gavin Shan (8):
  powerpc/powernv: Check PHB type in advance
  powerpc/powernv: Fix condition to remove M64
  powerpc/powernv: Rename alloc_m64_pe() to reserve_m64_pe()
  powerpc/powernv: Initialize M64 PE in time
  powerpc/powernv: Set PELTV for compound PEs
  powerpc/powernv: Simplify pnv_ioda_configure_pe()
  powerpc/powernv: Bail upon invalid master PE
  powerpc/powernv: Fix potential zero devisor

 arch/powerpc/platforms/powernv/pci-ioda.c   | 205 +++++++++++++++++++++-------
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |  28 ++--
 arch/powerpc/platforms/powernv/pci.h        |   2 +-
 3 files changed, 172 insertions(+), 63 deletions(-)

-- 
1.8.3.2
