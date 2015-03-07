Return-Path: <mgorman@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E8C21A086D
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Mar 2015 02:21:00 +1100 (AEDT)
From: Mel Gorman <mgorman@suse.de>
To: Dave Chinner <david@fromorbit.com>
Subject: [RFC PATCH 0/4] Automatic NUMA balancing and PROT_NONE handling
 followup v2r8
Date: Sat,  7 Mar 2015 15:20:47 +0000
Message-Id: <1425741651-29152-1-git-send-email-mgorman@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com,
 Linux-MM <linux-mm@kvack.org>, Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
 Mel Gorman <mgorman@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dave Chinner reported a problem due to excessive NUMA balancing activity
and bisected it. The first patch in this series corrects a major problem
that is unlikely to affect Dave but is still serious. Patch 2 is a minor
cleanup that was spotted while looking at scan rate control. Patch 3 is
minor and unlikely to make a difference but is still an inconsistentcy
between base and THP handling. Patch 4 is the important one, it slows
PTE scan updates if migrations are failing or throttled. Details of the
performance impact on local tests is included in the patch.

 include/linux/migrate.h |  5 -----
 include/linux/sched.h   |  9 +++++----
 kernel/sched/fair.c     |  8 ++++++--
 mm/huge_memory.c        |  8 +++++---
 mm/memory.c             |  3 ++-
 mm/migrate.c            | 20 --------------------
 6 files changed, 18 insertions(+), 35 deletions(-)

-- 
2.1.2
