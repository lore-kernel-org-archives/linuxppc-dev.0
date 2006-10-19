Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5585467B6C
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 14:33:44 +1000 (EST)
Date: Thu, 19 Oct 2006 14:33:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] Add the thread topolgy to sysfs
Message-Id: <20061019143326.45bb54c3.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds the /sys/devices/system/cpu/*/topology/thread_siblings
files.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-powerpc/topology.h |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/asm-powerpc/topology.h b/include/asm-powerpc/topology.h
index 8f7ee16..9fe7894 100644
--- a/include/asm-powerpc/topology.h
+++ b/include/asm-powerpc/topology.h
@@ -96,7 +96,13 @@ #endif /* CONFIG_NUMA */
 
 #ifdef CONFIG_SMP
 #include <asm/cputable.h>
-#define smt_capable() 		(cpu_has_feature(CPU_FTR_SMT))
+#define smt_capable()		(cpu_has_feature(CPU_FTR_SMT))
+
+#ifdef CONFIG_PPC64
+#include <asm/smp.h>
+
+#define topology_thread_siblings(cpu)	(cpu_sibling_map[cpu])
+#endif
 #endif
 
 #endif /* __KERNEL__ */
-- 
1.4.2.3
