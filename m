Return-Path: <tangchen@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 1A9BE2C020B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Dec 2012 23:10:31 +1100 (EST)
From: Tang Chen <tangchen@cn.fujitsu.com>
To: akpm@linux-foundation.org, rientjes@google.com, liuj97@gmail.com,
 len.brown@intel.com, benh@kernel.crashing.org, paulus@samba.org,
 cl@linux.com, minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com,
 isimatu.yasuaki@jp.fujitsu.com, wujianguo@huawei.com,
 wency@cn.fujitsu.com, tangchen@cn.fujitsu.com, hpa@zytor.com,
 linfeng@cn.fujitsu.com, laijs@cn.fujitsu.com, mgorman@suse.de,
 yinghai@kernel.org
Subject: [PATCH v5 09/14] memory-hotplug: remove page table of x86_64
 architecture
Date: Mon, 24 Dec 2012 20:09:19 +0800
Message-Id: <1356350964-13437-10-git-send-email-tangchen@cn.fujitsu.com>
In-Reply-To: <1356350964-13437-1-git-send-email-tangchen@cn.fujitsu.com>
References: <1356350964-13437-1-git-send-email-tangchen@cn.fujitsu.com>
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch searches a page table about the removed memory, and clear
page table for x86_64 architecture.

Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
Signed-off-by: Jianguo Wu <wujianguo@huawei.com>
Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
 arch/x86/mm/init_64.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index b30df3c..4b160d8 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -979,6 +979,15 @@ remove_pagetable(unsigned long start, unsigned long end, bool direct)
 	flush_tlb_all();
 }
 
+void __meminit
+kernel_physical_mapping_remove(unsigned long start, unsigned long end)
+{
+	start = (unsigned long)__va(start);
+	end = (unsigned long)__va(end);
+
+	remove_pagetable(start, end, true);
+}
+
 #ifdef CONFIG_MEMORY_HOTREMOVE
 int __ref arch_remove_memory(u64 start, u64 size)
 {
@@ -988,6 +997,7 @@ int __ref arch_remove_memory(u64 start, u64 size)
 	int ret;
 
 	zone = page_zone(pfn_to_page(start_pfn));
+	kernel_physical_mapping_remove(start, start + size);
 	ret = __remove_pages(zone, start_pfn, nr_pages);
 	WARN_ON_ONCE(ret);
 
-- 
1.7.1
