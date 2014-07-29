Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DAB451A01A5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 19:38:08 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 29 Jul 2014 19:37:50 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9BBF12BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 19:38:03 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6T9F3RI4522274
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 19:15:04 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6T9c1bi008054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 19:38:02 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH 0/8] THP fixes for ppc64
Date: Tue, 29 Jul 2014 15:07:41 +0530
Message-Id: <1406626669-31154-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This patch series fixes machine check exception that we observed when using
transparent huge page along with 4k hash pte on power bare metal platform.
Patch "powerpc: mm: Use read barrier when creating real_pte" is not really
related to thp, but was added in the series  because it is fixing a related
issue with 4k pte. That patch was not really needed to fix the MCE.

Aneesh Kumar K.V (8):
  powerpc: thp: Add write barrier after updating the valid bit
  powerpc: thp: don't recompute vsid and ssize in loop on invalidate
  powerpc: thp: invalidate old 64K based hash page mapping before insert
    of 4k pte
  powerpc: thp: Handle combo pages in invalidate
  powerpc: thp: inalidate with vpn in loop
  powerpc: thp: use ACCESS_ONCE when loading pmdp
  powerpc: mm: Use read barrier when creating real_pte
  powerpc: thp: Add tracepoints to track hugepage invalidate

 arch/powerpc/include/asm/machdep.h        |  6 +--
 arch/powerpc/include/asm/pgtable-ppc64.h  |  2 +-
 arch/powerpc/include/asm/pte-hash64-64k.h | 27 ++++++++--
 arch/powerpc/mm/hash_native_64.c          | 40 ++++----------
 arch/powerpc/mm/hugepage-hash64.c         | 88 +++++++++++++++++++++++++++----
 arch/powerpc/mm/pgtable_64.c              | 44 ++++++++++------
 arch/powerpc/mm/tlb_hash64.c              |  6 ++-
 arch/powerpc/platforms/pseries/lpar.c     | 20 +++----
 include/trace/events/thp.h                | 88 +++++++++++++++++++++++++++++++
 9 files changed, 242 insertions(+), 79 deletions(-)
 create mode 100644 include/trace/events/thp.h

-aneesh
