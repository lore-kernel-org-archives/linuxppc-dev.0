Return-Path: <mgorman@techsingularity.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4l7t5smtzDqQs
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 19:31:54 +1000 (AEST)
Received: from outbound-smtp07.blacknight.com (outbound-smtp07.blacknight.com
 [46.22.139.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s4l7t0YYBz9sBX
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Aug 2016 19:31:54 +1000 (AEST)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
 by outbound-smtp07.blacknight.com (Postfix) with ESMTPS id ECD891C1955
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Aug 2016 10:24:06 +0100 (IST)
Date: Thu, 4 Aug 2016 10:24:04 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: mm: Initialise per_cpu_nodestats for all online pgdats at boot
Message-ID: <20160804092404.GI2799@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras and Reza Arbab reported that machines with memoryless nodes
fails when vmstats are refreshed. Paul reported an oops as follows

[    1.713998] Unable to handle kernel paging request for data at address 0xff7a10000
[    1.714164] Faulting instruction address: 0xc000000000270cd0
[    1.714304] Oops: Kernel access of bad area, sig: 11 [#1]
[    1.714414] SMP NR_CPUS=2048 NUMA PowerNV
[    1.714530] Modules linked in:
[    1.714647] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.7.0-kvm+ #118
[    1.714786] task: c000000ff0680010 task.stack: c000000ff0704000
[    1.714926] NIP: c000000000270cd0 LR: c000000000270ce8 CTR: 0000000000000000
[    1.715093] REGS: c000000ff0707900 TRAP: 0300   Not tainted  (4.7.0-kvm+)
[    1.715232] MSR: 9000000102009033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE,TM[E]>  CR: 846b6824  XER: 20000000
[    1.715748] CFAR: c000000000008768 DAR: 0000000ff7a10000 DSISR: 42000000 SOFTE: 1
GPR00: c000000000270d08 c000000ff0707b80 c0000000011fb200 0000000000000000
GPR04: 0000000000000800 0000000000000000 0000000000000000 0000000000000000
GPR08: ffffffffffffffff 0000000000000000 0000000ff7a10000 c00000000122aae0
GPR12: c000000000a1e440 c00000000fb80000 c00000000000c188 0000000000000000
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR20: 0000000000000000 0000000000000000 0000000000000000 c000000000cecad0
GPR24: c000000000d035b8 c000000000d6cd18 c000000000d6cd18 c000001fffa86300
GPR28: 0000000000000000 c000001fffa96300 c000000001230034 c00000000122eb18
[    1.717484] NIP [c000000000270cd0] refresh_zone_stat_thresholds+0x80/0x240
[    1.717568] LR [c000000000270ce8] refresh_zone_stat_thresholds+0x98/0x240
[    1.717648] Call Trace:
[    1.717687] [c000000ff0707b80] [c000000000270d08] refresh_zone_stat_thresholds+0xb8/0x240 (unreliable)

Both supplied potential fixes but one potentially misses checks and another
had redundant initialisations. This version initialises per_cpu_nodestats
on a per-pgdat basis instead of on a per-zone basis.

Reported-by: Paul Mackerras <paulus@ozlabs.org>
Reported-by: Reza Arbab <arbab@linux.vnet.ibm.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
This has been compile-tested and boot-tested on a 32-bit KVM only. A
memoryless system was not available to test the patch with. A confirmation
from Paul and Reza that it resolves their problem is welcome.

 mm/page_alloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 39a372a2a1d6..fb975cec3518 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5257,11 +5257,6 @@ static void __meminit setup_zone_pageset(struct zone *zone)
 	zone->pageset = alloc_percpu(struct per_cpu_pageset);
 	for_each_possible_cpu(cpu)
 		zone_pageset_init(zone, cpu);
-
-	if (!zone->zone_pgdat->per_cpu_nodestats) {
-		zone->zone_pgdat->per_cpu_nodestats =
-			alloc_percpu(struct per_cpu_nodestat);
-	}
 }
 
 /*
@@ -5270,10 +5265,15 @@ static void __meminit setup_zone_pageset(struct zone *zone)
  */
 void __init setup_per_cpu_pageset(void)
 {
+	struct pglist_data *pgdat;
 	struct zone *zone;
 
 	for_each_populated_zone(zone)
 		setup_zone_pageset(zone);
+
+	for_each_online_pgdat(pgdat)
+		pgdat->per_cpu_nodestats =
+			alloc_percpu(struct per_cpu_nodestat);
 }
 
 static noinline __ref
