Return-Path: <tangchen@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 37B5C2C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 20:39:04 +1100 (EST)
From: Tang Chen <tangchen@cn.fujitsu.com>
To: akpm@linux-foundation.org, rjw@sisk.pl, len.brown@intel.com,
 mingo@redhat.com, tglx@linutronix.de, minchan.kim@gmail.com,
 rientjes@google.com, benh@kernel.crashing.org, paulus@samba.org,
 cl@linux.com, kosaki.motohiro@jp.fujitsu.com,
 isimatu.yasuaki@jp.fujitsu.com, wujianguo@huawei.com,
 wency@cn.fujitsu.com, hpa@zytor.com, linfeng@cn.fujitsu.com,
 laijs@cn.fujitsu.com, mgorman@suse.de, yinghai@kernel.org,
 glommer@parallels.com, jiang.liu@huawei.com, julian.calaby@gmail.com,
 sfr@canb.auug.org.au, guz.fnst@cn.fujitsu.com
Subject: [PATCH 2/2] cpu-hotplug,
 memory-hotplug: Remove __cpuinit declaration of numa_clear_node().
Date: Thu, 24 Jan 2013 17:38:07 +0800
Message-Id: <1359020287-11661-3-git-send-email-tangchen@cn.fujitsu.com>
In-Reply-To: <1359020287-11661-1-git-send-email-tangchen@cn.fujitsu.com>
References: <1359020287-11661-1-git-send-email-tangchen@cn.fujitsu.com>
Cc: linux-mm@kvack.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

numa_clear_node() will be used by check_and_unmap_cpu_on_node()
when we do node hotplug. So it is no longer a __cpuinit function.
Do not declare it as a __cpuinit function, otherwise it will cause
section mismatch warning when compiling.

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
 arch/x86/mm/numa.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 0624c85..6864b08 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -100,7 +100,7 @@ void __cpuinit numa_set_node(int cpu, int node)
 	set_cpu_numa_node(cpu, node);
 }
 
-void __cpuinit numa_clear_node(int cpu)
+void numa_clear_node(int cpu)
 {
 	numa_set_node(cpu, NUMA_NO_NODE);
 }
-- 
1.7.1
