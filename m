Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xN4YL5HNFzDr0Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 06:29:42 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v72KT1U8089844
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 16:29:40 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c3ekt6sch-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 16:29:40 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 2 Aug 2017 21:29:38 +0100
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Cc: clombard@linux.vnet.ibm.com, alistair@popple.id.au,
 vaibhav@linux.vnet.ibm.com
Subject: [PATCH v3 0/3] powerpc/mm: Mark memory contexts requiring global TLBIs
Date: Wed,  2 Aug 2017 22:29:27 +0200
Message-Id: <20170802202930.5616-1-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

capi2 and opencapi require the TLB invalidations being sent for
addresses used on the cxl adapter or opencapi device to be global, as
there's a translation cache in the PSL (for capi2) or NPU (for
opencapi). The CAPP, on behalf of the PSL, and NPU snoop the power bus.

This is not new: for the hash memory model, as soon as the cxl driver
is active, all local TLBIs become global. We need a similar mechanism
for the radix memory model. This patch tries to improve things a bit
by flagging the contexts requiring global TLBIs, therefore limiting
the "upgrade" and not affecting contexts not used by the card.

A longer-term goal is to modify the current implementation for hash to
follow the same direction, i.e. identify contexts needing global
TLBIs, but that will be for later. It would be required to support
hash for opencapi.

Changelog:
v3:
 - convert from RFC to PATCH
 - mark contexts used by XSL (cxllib) as needed global invalidation
RFC v2:
 - address comments received
 - rename MM_CONTEXT_GLOBAL_TLBI -> MM_GLOBAL_TLBIE
 - add memory barriers to make sure the device doesn't miss any TLBI
 - also add barrier for the hash implemention to fix the same issue

Frederic Barrat (3):
  powerpc/mm: Add marker for contexts requiring global TLB invalidations
  cxl: Mark context requiring global TLBIs
  cxl: Add memory barrier to guarantee TLBI scope

 arch/powerpc/include/asm/book3s/64/mmu.h | 18 ++++++++++++++++++
 arch/powerpc/include/asm/tlb.h           | 27 +++++++++++++++++++++++----
 arch/powerpc/mm/mmu_context_book3s64.c   |  1 +
 arch/powerpc/mm/tlb-radix.c              |  8 ++++----
 arch/powerpc/mm/tlb_hash64.c             |  3 ++-
 drivers/misc/cxl/api.c                   | 12 ++++++++++--
 drivers/misc/cxl/cxllib.c                |  7 +++++++
 drivers/misc/cxl/file.c                  | 12 ++++++++++--
 include/misc/cxl-base.h                  | 22 +++++++++++++++++++---
 9 files changed, 94 insertions(+), 16 deletions(-)

-- 
2.11.0
