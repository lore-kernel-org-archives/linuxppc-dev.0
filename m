Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3N6H6qkTzDqpR
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 14:10:47 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7248qJc087056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 00:10:45 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24gre1xhu2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Aug 2016 00:10:45 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 2 Aug 2016 14:10:42 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9CD8E3578057
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 14:10:40 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u724Aete25362496
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 14:10:40 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u724Aep3029701
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 14:10:40 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 0/9] powerpc/powernv: Fix sparse warnings for PCI files
Date: Tue,  2 Aug 2016 14:10:28 +1000
Message-Id: <1470111037-18531-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes the warnings reported from sparse. With this applied, no sparse
warning seen from below files with "make C=2 CF=-D__CHECK_ENDIAN__".

 arch/powerpc/platforms/powernv/eeh-powernv.c
 arch/powerpc/platforms/powernv/pci-ioda.c
 arch/powerpc/platforms/powernv/pci.c

Gavin Shan (9):
  powerpc/powernv: Pass CPU-endian PE number to
    opal_pci_eeh_freeze_clear()
  powerpc/powernv: Use CPU-endian hub diag-data type in
    pnv_eeh_get_and_dump_hub_diag()
  powerpc/powernv: Specify proper data type for PCI_SLOT_ID_PREFIX
  powerpc/powernv: Use CPU-endian PEST in pnv_pci_dump_p7ioc_diag_data()
  powerpc/powernv: Fix endian for return value from pnv_tce_get()
  powerpc/powernv: Pass CPU-endian argument to xchg() in pnv_tce_xchg()
  powerpc/powernv: Fix data type for @r in pnv_ioda_parse_m64_window()
  powerpc/powernv: Fix data type of argument to __raw_{rm_, }writeq()
  powerpc/powernv: Fix data type in pnv_pci_ioda2_table_do_free_pages()

 arch/powerpc/include/asm/pnv-pci.h           |  2 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c |  4 ++--
 arch/powerpc/platforms/powernv/pci-ioda.c    | 25 ++++++++++++++++---------
 arch/powerpc/platforms/powernv/pci.c         | 10 ++++++----
 4 files changed, 25 insertions(+), 16 deletions(-)

-- 
2.1.0
