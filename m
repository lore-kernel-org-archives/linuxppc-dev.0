Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B7D121A06B1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 23:07:23 +1100 (AEDT)
Received: from localhost
 by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Fri, 16 Oct 2015 13:07:20 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5818D219004D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 13:07:15 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9GC7HjZ34341036
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 12:07:17 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9GC7AV6009792
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 06:07:15 -0600
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org, xemul@parallels.com,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, aneesh.kumar@linux.vnet.ibm.com, paulus@samba.org
Cc: criu@openvz.org
Subject: [PATCH 0/3] mm/powerpc: enabling memory soft dirty tracking 
Date: Fri, 16 Oct 2015 14:07:05 +0200
Message-Id: <cover.1444995096.git.ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series is enabling the software memory dirty tracking in the
kernel for powerpc.  This is the follow up of the commit 0f8975ec4db2
("mm: soft-dirty bits for user memory changes tracking") which
introduced this feature in the mm code.

The first patch is fixing an issue in the code clearing the soft dirty
bit.  The PTE were not cleared before being modified, leading to hang
on ppc64.

The second patch is fixing a build issue when the transparent huge
page is not enabled.

The third patch is introducing the soft dirty tracking in the powerpc
architecture code. 

Laurent Dufour (3):
  mm: clearing pte in clear_soft_dirty()
  mm: clear_soft_dirty_pmd requires THP
  powerpc/mm: Add page soft dirty tracking

 arch/powerpc/Kconfig                     |  2 ++
 arch/powerpc/include/asm/pgtable-ppc64.h | 13 +++++++++--
 arch/powerpc/include/asm/pgtable.h       | 40 +++++++++++++++++++++++++++++++-
 arch/powerpc/include/asm/pte-book3e.h    |  1 +
 arch/powerpc/include/asm/pte-common.h    |  5 ++--
 arch/powerpc/include/asm/pte-hash64.h    |  1 +
 fs/proc/task_mmu.c                       | 21 +++++++++--------
 7 files changed, 68 insertions(+), 15 deletions(-)

-- 
1.9.1
