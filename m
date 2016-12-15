Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfkZh5czwzDw63
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 06:50:51 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBFJn6rW081156
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 14:50:50 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27bv3m10nr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 14:50:49 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Thu, 15 Dec 2016 12:50:48 -0700
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Alistair Popple <apopple@au1.ibm.com>
Subject: [PATCH v3 0/5] powerpc/mm: enable memory hotplug on radix
Date: Thu, 15 Dec 2016 13:50:38 -0600
Message-Id: <1481831443-22761-1-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Memory hotplug is leading to hash page table calls, even on radix:

...
        arch_add_memory
                create_section_mapping
                        htab_bolt_mapping
                                BUG_ON(!ppc_md.hpte_insert);

To fix, refactor {create,remove}_section_mapping() into hash__ and radix__
variants. Implement the radix versions by borrowing from existing vmemmap
and x86 code.

This passes basic verification of plugging and removing memory, but this 
stuff is tricky and I'd appreciate extra scrutiny of the series for 
correctness--in particular, the adaptation of remove_pagetable() from x86.

/* changelog */

v3:
* Port remove_pagetable() et al. from x86 for unmapping.

* [RFC] -> [PATCH]

v2:
* https://lkml.kernel.org/r/1471449083-15931-1-git-send-email-arbab@linux.vnet.ibm.com

* Do not simply fall through to vmemmap_{create,remove}_mapping(). As Aneesh
  and Michael pointed out, they are tied to CONFIG_SPARSEMEM_VMEMMAP and only
  did what I needed by luck anyway.

v1:
* https://lkml.kernel.org/r/1466699962-22412-1-git-send-email-arbab@linux.vnet.ibm.com

Reza Arbab (5):
  powerpc/mm: set the radix linear page mapping size
  powerpc/mm: refactor {create,remove}_section_mapping()
  powerpc/mm: add radix__create_section_mapping()
  powerpc/mm: add radix__remove_section_mapping()
  powerpc/mm: unstub radix__vmemmap_remove_mapping()

 arch/powerpc/include/asm/book3s/64/hash.h  |   5 +
 arch/powerpc/include/asm/book3s/64/radix.h |   5 +
 arch/powerpc/mm/hash_utils_64.c            |   4 +-
 arch/powerpc/mm/pgtable-book3s64.c         |  18 +++
 arch/powerpc/mm/pgtable-radix.c            | 207 ++++++++++++++++++++++++++++-
 5 files changed, 236 insertions(+), 3 deletions(-)

-- 
1.8.3.1
