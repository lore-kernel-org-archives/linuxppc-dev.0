Return-Path: <mgorman@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 818901A0008
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 10:54:59 +1100 (AEDT)
From: Mel Gorman <mgorman@suse.de>
To: Dave Chinner <david@fromorbit.com>
Subject: [RFC PATCH 0/2] Automatic NUMA balancing and PROT_NONE handling
 followup
Date: Thu,  5 Mar 2015 23:54:50 +0000
Message-Id: <1425599692-32445-1-git-send-email-mgorman@suse.de>
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

Dave Chinner reported a problem due to excessive NUMA balancing activity and
bisected it. These are two patches that address two major issues with that
series. The first patch is almost certainly unrelated to what he saw due
to fact his vmstats showed no huge page activity but the fix is important.
The second patch restores performance of one benchmark to similar levels
to 3.19-vanilla but it still has to be tested on his workload. While I
have a test configuration for his workload, I don't have either the KVM
setup or suitable storage to test against. It also needs to be reviewed
and tested on ppc64.

 arch/powerpc/include/asm/pgtable-ppc64.h | 16 ++++++++++++++++
 arch/x86/include/asm/pgtable.h           | 14 ++++++++++++++
 include/asm-generic/pgtable.h            | 19 +++++++++++++++++++
 mm/huge_memory.c                         | 23 ++++++++++++++++++-----
 mm/mprotect.c                            |  5 +++++
 5 files changed, 72 insertions(+), 5 deletions(-)

-- 
2.1.2
