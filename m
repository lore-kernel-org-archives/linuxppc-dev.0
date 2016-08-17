Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDtxw6kz9zDqS5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 01:51:32 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7HFMuxk128706
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 11:51:30 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24vmge4gev-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 11:51:29 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Wed, 17 Aug 2016 09:51:28 -0600
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: [RFC v2 0/2] powerpc/mm: enable memory hotplug on radix
Date: Wed, 17 Aug 2016 10:51:21 -0500
Message-Id: <1471449083-15931-1-git-send-email-arbab@linux.vnet.ibm.com>
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

Refactor {create,remove}_section_mapping() into hash__ and radix__ variants.

RFC/TODO:
I wasn't sure what to do in radix__remove_section_mapping(). Its vmemmap
counterpart radix__vmemmap_remove_mapping() is stubbed as a FIXME. I left it
empty for now.

v2:
* Do not simply fall through to vmemmap_{create,remove}_mapping(). As Aneesh 
  and Michael pointed out, they are tied to CONFIG_SPARSEMEM_VMEMMAP and only
  did what I needed by luck anyway.

v1:
* https://lkml.kernel.org/r/1466699962-22412-1-git-send-email-arbab@linux.vnet.ibm.com

Reza Arbab (2):
  powerpc/mm: refactor {create,remove}_section_mapping()
  powerpc/mm: add radix__{create,remove}_section_mapping()

 arch/powerpc/include/asm/book3s/64/hash.h  |  5 +++++
 arch/powerpc/include/asm/book3s/64/radix.h |  5 +++++
 arch/powerpc/include/asm/sparsemem.h       | 22 ++++++++++++++++++++--
 arch/powerpc/mm/hash_utils_64.c            |  4 ++--
 arch/powerpc/mm/pgtable-radix.c            | 23 +++++++++++++++++++++++
 5 files changed, 55 insertions(+), 4 deletions(-)

-- 
1.8.3.1


*** BLURB HERE ***

Reza Arbab (2):
  powerpc/mm: refactor {create,remove}_section_mapping()
  powerpc/mm: add radix__{create,remove}_section_mapping()

 arch/powerpc/include/asm/book3s/64/hash.h  |  5 +++++
 arch/powerpc/include/asm/book3s/64/radix.h |  5 +++++
 arch/powerpc/include/asm/sparsemem.h       | 22 ++++++++++++++++++++--
 arch/powerpc/mm/hash_utils_64.c            |  4 ++--
 arch/powerpc/mm/pgtable-radix.c            | 23 +++++++++++++++++++++++
 5 files changed, 55 insertions(+), 4 deletions(-)

-- 
1.8.3.1
