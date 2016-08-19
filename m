Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFxYx0GBFzDqd7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 18:52:52 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7J8n8pG015156
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 04:52:50 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24wt629bjk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 04:52:50 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 19 Aug 2016 02:52:49 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 0/5] kexec changes for Power ISA 3.0
Date: Fri, 19 Aug 2016 14:22:34 +0530
Message-Id: <1471596759-3396-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add kexec support with radix page table config.

Changes from v1:
* Rebase to latest kernel
* add tlbflush on MMU cleanup

Aneesh Kumar K.V (1):
  powerpc/mm: Add radix flush all with IS=3

Benjamin Herrenschmidt (4):
  powerpc/64/kexec: NULL check "clear_all" in kexec_sequence
  powerpc/64/kexec: Fix MMU cleanup on radix
  powerpc/64/kexec: Copy image with MMU off when possible
  powerpc/64/kexec: Remove BookE special default_machine_kexec_prepare()

 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  1 +
 arch/powerpc/include/asm/mmu-book3e.h              |  3 +
 arch/powerpc/include/asm/mmu.h                     |  4 ++
 arch/powerpc/kernel/machine_kexec_64.c             | 74 +++++++---------------
 arch/powerpc/kernel/misc_64.S                      | 25 ++++++--
 arch/powerpc/mm/pgtable-book3s64.c                 |  9 +++
 arch/powerpc/mm/pgtable-radix.c                    | 12 ++++
 arch/powerpc/mm/tlb-radix.c                        | 15 +++++
 8 files changed, 84 insertions(+), 59 deletions(-)

-- 
2.7.4
