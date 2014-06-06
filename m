Return-Path: <aik@ozlabs.ru>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A5B191A0008
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 18:44:19 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 6 Jun 2014 18:44:17 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1BC0E2CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 18:44:14 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s568SDwM21954628
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 18:28:14 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s568iB2n023849
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 18:44:11 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/6] powerpc/powernv: Applying it_page_shift to platform code
Date: Fri,  6 Jun 2014 18:44:00 +1000
Message-Id: <1402044246-13650-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org, Alistair Popple <alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here is what I got for powernv in order to support variable page size
in iommu_table.

I am very uncertain about Patch #4 "Add @it_owner to iommu_table struct"
and wonder if there any better way to get PE from iommu_table.

Please comment. Thanks.


Alexey Kardashevskiy (6):
  powerpc/powernv: use it_page_shift for TCE invalidation
  powerpc/powernv: use it_page_shift in TCE build
  powerpc/powernv: Add a page size parameter to
    pnv_pci_setup_iommu_table()
  powerpc/powernv: Add @it_owner to iommu_table struct
  powerpc/powernv: Make set_bypass() callback a type
  powerpc/powernv: Make invalidate() callback an iommu_table callback

 arch/powerpc/include/asm/iommu.h            | 13 ++++++-
 arch/powerpc/platforms/powernv/pci-ioda.c   | 55 ++++++++++++++---------------
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |  3 +-
 arch/powerpc/platforms/powernv/pci.c        | 43 +++++++++++++++-------
 arch/powerpc/platforms/powernv/pci.h        |  7 ++--
 5 files changed, 74 insertions(+), 47 deletions(-)

-- 
2.0.0
