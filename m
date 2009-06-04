Return-Path: <kosaki.motohiro@jp.fujitsu.com>
Received: from fgwmail8.fujitsu.co.jp (fgwmail8.fujitsu.co.jp [192.51.44.38])
	by ozlabs.org (Postfix) with ESMTP id B4210DDDA0
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jun 2009 20:34:31 +1000 (EST)
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
	by fgwmail8.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n54ANKrc006953 for <linuxppc-dev@ozlabs.org> (envelope-from
	kosaki.motohiro@jp.fujitsu.com); Thu, 4 Jun 2009 19:23:20 +0900
Received: from m2.gw.fujitsu.co.jp ([10.0.50.72])
	by fgwmail7.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n54ANH8q006652 for <linuxppc-dev@ozlabs.org> (envelope-from
	kosaki.motohiro@jp.fujitsu.com); Thu, 4 Jun 2009 19:23:17 +0900
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 3CADA45DE5D
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jun 2009 19:23:17 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 0975445DD79
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jun 2009 19:23:17 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id D6BA61DB8046
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jun 2009 19:23:16 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.249.87.104])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8DDE71DB8040
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jun 2009 19:23:16 +0900 (JST)
From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
To: Christoph Lameter <cl@linux-foundation.org>,
	Rik van Riel <riel@redhat.com>, Robin Holt <holt@sgi.com>,
	"Zhang, Yanmin" <yanmin.zhang@intel.com>,
	Wu Fengguang <fengguang.wu@intel.com>, linux-ia64@vger.kernel.org,
	linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4] zone_reclaim is always 0 by default
Message-Id: <20090604192236.9761.A69D9226@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Date: Thu,  4 Jun 2009 19:23:15 +0900 (JST)
Cc: kosaki.motohiro@jp.fujitsu.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Current linux policy is, zone_reclaim_mode is enabled by default if the machine
has large remote node distance. it's because we could assume that large distance
mean large server until recently.

Unfortunately, recent modern x86 CPU (e.g. Core i7, Opeteron) have P2P transport
memory controller. IOW it's seen as NUMA from software view.
Some Core i7 machine has large remote node distance.

Yanmin reported zone_reclaim_mode=1 cause large apache regression.

    One Nehalem machine has 12GB memory,
    but there is always 2GB free although applications accesses lots of files.
    Eventually we located the root cause as zone_reclaim_mode=1.

Actually, zone_reclaim_mode=1 mean "I dislike remote node allocation rather than
disk access", it makes performance improvement to HPC workload.
but it makes performance degression to desktop, file server and web server.

In general, workload depended configration shouldn't put into default settings.

However, current code is long standing about two year. Highest POWER and IA64 HPC machine
(only) use this setting.

Thus, x86 and almost rest architecture change default setting, but Only power and ia64
remain current configuration for backward-compatibility.


Signed-off-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: Christoph Lameter <cl@linux-foundation.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Robin Holt <holt@sgi.com>
Cc: "Zhang, Yanmin" <yanmin.zhang@intel.com>
Cc: Wu Fengguang <fengguang.wu@intel.com>
Cc: linux-ia64@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org
---
 arch/powerpc/include/asm/topology.h |    6 ++++++
 include/linux/topology.h            |    7 +------
 2 files changed, 7 insertions(+), 6 deletions(-)

Index: b/include/linux/topology.h
===================================================================
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -54,12 +54,7 @@ int arch_update_cpu_topology(void);
 #define node_distance(from,to)	((from) == (to) ? LOCAL_DISTANCE : REMOTE_DISTANCE)
 #endif
 #ifndef RECLAIM_DISTANCE
-/*
- * If the distance between nodes in a system is larger than RECLAIM_DISTANCE
- * (in whatever arch specific measurement units returned by node_distance())
- * then switch on zone reclaim on boot.
- */
-#define RECLAIM_DISTANCE 20
+#define RECLAIM_DISTANCE INT_MAX
 #endif
 #ifndef PENALTY_FOR_NODE_WITH_CPUS
 #define PENALTY_FOR_NODE_WITH_CPUS	(1)
Index: b/arch/powerpc/include/asm/topology.h
===================================================================
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -10,6 +10,12 @@ struct device_node;
 
 #include <asm/mmzone.h>
 
+/*
+ * Distance above which we begin to use zone reclaim
+ */
+#define RECLAIM_DISTANCE 20
+
+
 static inline int cpu_to_node(int cpu)
 {
 	return numa_cpu_lookup_table[cpu];
