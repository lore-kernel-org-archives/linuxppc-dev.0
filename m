Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJ0t65HCtzDqJn
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 00:29:50 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v43ETTNZ137401
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 May 2017 10:29:38 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a7eqeyre5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 May 2017 10:29:36 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 3 May 2017 15:29:13 +0100
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: alistair@popple.id.au, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: [RFC 0/2] powerpc/mm: Mark memory contexts requiring global TLBIs
Date: Wed,  3 May 2017 16:29:04 +0200
Message-Id: <20170503142906.29220-1-fbarrat@linux.vnet.ibm.com>
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
opencapi). The CAPP (for PSL) and NPU snoop the power bus.

This is not new: for the hash memory model, as soon as the cxl driver
is active, all local TLBIs become global. We need a similar mechanism
for the radix memory model. This patch tries to improve things a bit
by flagging the contexts requiring global TLBIs, therefore limiting
the "upgrade" and not affecting contexts not used by the card.

Alistair: for nvlink2, it is my understanding that all the required
invalidations are already in place through software mmio/ATSD, i.e. this
patch is not useful for you.

Submitting as an RFC, since I don't get to touch mmu.h everyday and
would like to probe people's reaction.



Frederic Barrat (2):
  powerpc/mm: Add marker for contexts requiring global TLB invalidations
  cxl: Mark context requiring global TLBIs

 arch/powerpc/include/asm/book3s/64/mmu.h |  9 +++++++++
 arch/powerpc/include/asm/tlb.h           | 10 ++++++++--
 arch/powerpc/mm/mmu_context_book3s64.c   |  1 +
 drivers/misc/cxl/api.c                   |  5 ++++-
 drivers/misc/cxl/file.c                  |  5 ++++-
 5 files changed, 26 insertions(+), 4 deletions(-)

-- 
2.11.0
