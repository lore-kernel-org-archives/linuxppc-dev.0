Return-Path: <david@fromorbit.com>
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
 [150.101.137.141])
 by lists.ozlabs.org (Postfix) with ESMTP id D45E31A02B6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 22:51:43 +1100 (AEDT)
Date: Tue, 24 Mar 2015 22:51:41 +1100
From: Dave Chinner <david@fromorbit.com>
To: Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH 0/3] Reduce system overhead of automatic NUMA balancing
Message-ID: <20150324115141.GS28621@dastard>
References: <1427113443-20973-1-git-send-email-mgorman@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427113443-20973-1-git-send-email-mgorman@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com,
 Linux-MM <linux-mm@kvack.org>, Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 23, 2015 at 12:24:00PM +0000, Mel Gorman wrote:
> These are three follow-on patches based on the xfsrepair workload Dave
> Chinner reported was problematic in 4.0-rc1 due to changes in page table
> management -- https://lkml.org/lkml/2015/3/1/226.
> 
> Much of the problem was reduced by commit 53da3bc2ba9e ("mm: fix up numa
> read-only thread grouping logic") and commit ba68bc0115eb ("mm: thp:
> Return the correct value for change_huge_pmd"). It was known that the performance
> in 3.19 was still better even if is far less safe. This series aims to
> restore the performance without compromising on safety.
> 
> Dave, you already tested patch 1 on its own but it would be nice to test
> patches 1+2 and 1+2+3 separately just to be certain.

			   3.19  4.0-rc4    +p1      +p2      +p3
mm_migrate_pages	266,750  572,839  558,632  223,706  201,429
run time		  4m54s    7m50s    7m20s    5m07s    4m31s

numa stats form p1+p2:

numa_hit 8436537
numa_miss 0
numa_foreign 0
numa_interleave 30765
numa_local 8409240
numa_other 27297
numa_pte_updates 46109698
numa_huge_pte_updates 0
numa_hint_faults 44756389
numa_hint_faults_local 11841095
numa_pages_migrated 4868674
pgmigrate_success 4868674
pgmigrate_fail 0


numa stats form p1+p2+p3:

numa_hit 6991596
numa_miss 0
numa_foreign 0
numa_interleave 10336
numa_local 6983144
numa_other 8452
numa_pte_updates 24460492
numa_huge_pte_updates 0
numa_hint_faults 23677262
numa_hint_faults_local 5952273
numa_pages_migrated 3557928
pgmigrate_success 3557928
pgmigrate_fail 0

OK, the summary with all patches applied:

config                          3.19   4.0-rc1  4.0-rc4  4.0-rc5+
defaults                       8m08s     9m34s    9m14s    6m57s
-o ag_stride=-1                4m04s     4m38s    4m11s    4m06s
-o bhash=101073                6m04s    17m43s    7m35s    6m13s
-o ag_stride=-1,bhash=101073   4m54s     9m58s    7m50s    4m31s

So it looks like the patch set fixes the remaining regression and in
2 of the four cases actually improves performance....

Thanks, Linus and Mel, for tracking this tricky problem down! 

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
