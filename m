Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AE0921A0CC7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 19:16:27 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 11 Aug 2014 19:16:26 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E84742BB002D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 19:16:23 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s7B8x4im52953318
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 18:59:05 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7B9GNLJ001111
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 19:16:23 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/pseries: Failure on removing device node
Date: Mon, 11 Aug 2014 19:16:19 +1000
Message-Id: <1407748580-3412-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While running command "drmgr -c phb -r -s 'PHB 528'", following
backtrace jumped out because the target device node isn't marked
with OF_DETACHED by of_detach_node(), which caused by error
returned from memory hotplug related reconfig notifier when
disabling CONFIG_MEMORY_HOTREMOVE. The patch fixes it.

ERROR: Bad of_node_put() on /pci@800000020000210/ethernet@0
CPU: 14 PID: 2252 Comm: drmgr Tainted: G        W     3.16.0+ #427
Call Trace:
[c000000012a776a0] [c000000000013d9c] .show_stack+0x88/0x148 (unreliable)
[c000000012a77750] [c00000000083cd34] .dump_stack+0x7c/0x9c
[c000000012a777d0] [c0000000006807c4] .of_node_release+0x58/0xe0
[c000000012a77860] [c00000000038a7d0] .kobject_release+0x174/0x1b8
[c000000012a77900] [c00000000038a884] .kobject_put+0x70/0x78
[c000000012a77980] [c000000000681680] .of_node_put+0x28/0x34
[c000000012a77a00] [c000000000681ea8] .__of_get_next_child+0x64/0x70
[c000000012a77a90] [c000000000682138] .of_find_node_by_path+0x1b8/0x20c
[c000000012a77b40] [c000000000051840] .ofdt_write+0x308/0x688
[c000000012a77c20] [c000000000238430] .proc_reg_write+0xb8/0xd4
[c000000012a77cd0] [c0000000001cbeac] .vfs_write+0xec/0x1f8
[c000000012a77d70] [c0000000001cc3b0] .SyS_write+0x58/0xa0
[c000000012a77e30] [c00000000000a064] syscall_exit+0x0/0x98

Cc: stable@vger.kernel.org
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 7995135..24abc5c 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -146,7 +146,7 @@ static inline int pseries_remove_memblock(unsigned long base,
 }
 static inline int pseries_remove_mem_node(struct device_node *np)
 {
-	return -EOPNOTSUPP;
+	return 0;
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
-- 
1.8.3.2
