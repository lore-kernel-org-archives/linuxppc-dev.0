Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqDNY2Nw8zDqfD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 19:41:01 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D9d7NP088967
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:40:58 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2452at7aqp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:40:58 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 03:40:57 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH for-4.8_set4 0/2] Segment table support
Date: Wed, 13 Jul 2016 15:10:48 +0530
Message-Id: <1468402850-6052-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This series add support for ISA 3.0 memory segment table.

Aneesh Kumar K.V (2):
  powerpc/mm: Switch user slb fault handling to translation enabled
  powerpc/mm: Support segment table for Power9

 Documentation/kernel-parameters.txt           |   3 +
 arch/powerpc/include/asm/book3s/64/hash.h     |  10 +
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  17 ++
 arch/powerpc/include/asm/book3s/64/mmu.h      |   4 +
 arch/powerpc/include/asm/mmu.h                |   6 +-
 arch/powerpc/include/asm/mmu_context.h        |   5 +-
 arch/powerpc/kernel/exceptions-64s.S          |  55 +++-
 arch/powerpc/kernel/prom.c                    |  13 +-
 arch/powerpc/mm/hash_utils_64.c               |  83 +++++-
 arch/powerpc/mm/mmu_context_book3s64.c        |  32 ++-
 arch/powerpc/mm/slb.c                         | 359 ++++++++++++++++++++++++++
 11 files changed, 564 insertions(+), 23 deletions(-)

-- 
2.7.4
