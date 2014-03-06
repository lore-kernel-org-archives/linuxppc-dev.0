Return-Path: <yoush@cs.msu.su>
Received: from mail.lvk.cs.msu.su (lvk-gate.cs.msu.ru [188.44.42.233])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E45B12C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Mar 2014 01:36:13 +1100 (EST)
From: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
To: kexec@lists.infradead.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] kexec/powerpc: fix exporting memory limit
Date: Thu,  6 Mar 2014 18:24:14 +0400
Message-Id: <1394115854-11709-1-git-send-email-nyushchenko@dev.rtsoft.ru>
Cc: yadviga@dev.rtsoft.ru, nyushchenko@dev.rtsoft.ru, lugovskoy@dev.rtsoft.ru,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When preparing dump-capturing kernel, kexec userspace tool needs to know
actual amount of memory used by the running kernel. This may differ from
extire available DRAM for a couple of reasons. To address this issue,
kdump kernel support code injects several attributes into device tree that
are later captured by userspace kexec tool via /proc interface.

One such attrubute is 'chosen/linux,memory_limit' that is used to pass
memory limit of the running kernel.

This was initialized using kernel's 'memory_limit' variable, that is set
by early init code based on mem= kernel parameter and other reasons.

But there are cases when memory_limit variable does not contain proper
information. One such case is when !CONFIG_HIGHMEM kernel runs on system
with memory large enough not to fit into lowmem.

This patch fixes initialization of 'chosen/linux,memory_limit' to use
values from memblock subsystem. These are adjusted at kernel memory
management init and thus always contain values that match reality.

Signed-off-by: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
---
 arch/powerpc/kernel/machine_kexec.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index 015ae55..372cda5 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -250,8 +250,14 @@ static void __init export_crashk_values(struct device_node *node)
 	/*
 	 * memory_limit is required by the kexec-tools to limit the
 	 * crash regions to the actual memory used.
+	 *
+	 * There are cases when memory_limit variable does not hold actual
+	 * limit, for example when memory was limited by no kernel support
+	 * for HIGHMEM. Reliable information is known by memblock because
+	 * memory management init adjusts it.
 	 */
-	mem_limit = cpu_to_be_ulong(memory_limit);
+	mem_limit = cpu_to_be_ulong(memblock_end_of_DRAM() -
+					memblock_start_of_DRAM());
 	of_update_property(node, &memory_limit_prop);
 }
 
-- 
1.7.10.4
