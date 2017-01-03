Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttQrx1tzTzDqFq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 07:43:45 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v03KcgOf009507
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Jan 2017 15:43:43 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27rerckt1a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jan 2017 15:43:42 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Tue, 3 Jan 2017 13:43:41 -0700
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Alistair Popple <apopple@au1.ibm.com>
Subject: [PATCH v4 0/4] powerpc/mm: enable memory hotplug on radix
Date: Tue,  3 Jan 2017 14:43:34 -0600
Message-Id: <1483476218-17271-1-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Do the plumbing needed for memory hotplug on systems using radix pagetables,
borrowing from existing vmemmap and x86 code.

This passes basic verification of plugging and removing memory, but this 
stuff is tricky and I'd appreciate extra scrutiny of the series for 
correctness--in particular, the adaptation of remove_pagetable() from x86.

/* changelog */

v4:
* Sent patch 1 as a standalone fix. This set still depends on it:
  https://lkml.kernel.org/r/1483475991-16999-1-git-send-email-arbab@linux.vnet.ibm.com

* Extract a common function that can be used by both radix_init_pgtable() and
  radix__create_section_mapping().

* Reduce tlb flushing to one flush_tlb_kernel_range() per section, and do
  less granular locking of init_mm->page_table_lock.

v3:
* https://lkml.kernel.org/r/1481831443-22761-1-git-send-email-arbab@linux.vnet.ibm.com

* Port remove_pagetable() et al. from x86 for unmapping.

* [RFC] -> [PATCH]

v2:
* https://lkml.kernel.org/r/1471449083-15931-1-git-send-email-arbab@linux.vnet.ibm.com

* Do not simply fall through to vmemmap_{create,remove}_mapping(). As Aneesh
  and Michael pointed out, they are tied to CONFIG_SPARSEMEM_VMEMMAP and only
  did what I needed by luck anyway.

v1:
* https://lkml.kernel.org/r/1466699962-22412-1-git-send-email-arbab@linux.vnet.ibm.com

Reza Arbab (4):
  powerpc/mm: refactor radix physical page mapping
  powerpc/mm: add radix__create_section_mapping()
  powerpc/mm: add radix__remove_section_mapping()
  powerpc/mm: unstub radix__vmemmap_remove_mapping()

 arch/powerpc/include/asm/book3s/64/radix.h |   5 +
 arch/powerpc/mm/pgtable-book3s64.c         |   4 +-
 arch/powerpc/mm/pgtable-radix.c            | 254 ++++++++++++++++++++++++-----
 3 files changed, 222 insertions(+), 41 deletions(-)

-- 
1.8.3.1
