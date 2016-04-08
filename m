Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qh8sk4t0ZzDqDW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Apr 2016 16:38:02 +1000 (AEST)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 8 Apr 2016 16:38:01 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8E5813578056
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Apr 2016 16:37:48 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u386bamK61276164
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2016 16:37:48 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u386bB73021709
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2016 16:37:12 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH kernel 0/2] powerpc/powernv: Fix crash on PF unbind when VF is
 passed
Date: Fri,  8 Apr 2016 16:36:42 +1000
Message-Id: <1460097404-35422-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These 2 patches are to fix the crash which happens when the user (accidentally)
unbinds the driver of a physical function of a SRIOV device while
a virtual function is passed to a guest.

Please comment. Thanks!

There might be more work required in addition to this as it is not clear
what protects from races between pnv_ioda_free_pe and pnv_ioda_alloc_pe.
Gavin, please help.


Alexey Kardashevskiy (2):
  powerpc/iommu: Get rid of default group_release()
  powerpc/powernv/ioda2: Delay PE disposal

 arch/powerpc/include/asm/iommu.h          | 12 ++++++----
 arch/powerpc/kernel/iommu.c               | 14 ++++--------
 arch/powerpc/platforms/powernv/pci-ioda.c | 38 ++++++++++++++++---------------
 arch/powerpc/platforms/pseries/iommu.c    | 17 +++++++-------
 4 files changed, 40 insertions(+), 41 deletions(-)

-- 
2.5.0.rc3
