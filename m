Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <021a5af117537ce9f7c6c3b27310f15851ab5034.1302856271.git.michael@ellerman.id.au>
In-Reply-To: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
References: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
Subject: [PATCH 10/15] powerpc: Define slb0_limit() for BOOK3E
Date: Fri, 15 Apr 2011 18:32:03 +1000 (EST)
From: michael@ozlabs.org (Michael Ellerman)
Cc: Jimi Xenidis <jimix@watson.ibm.com>, jack@codezen.org,
	kumar.gala@freescale.com, imunsie@au.ibm.com,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>

On BOOK3E we don't have an SLB 0, but the equivalent concept is the
bolted entry mapping the kernel. Currently this is a 1G entry, so
for now hardcode that. This will probably need to be reworked in
future.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/setup_64.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 91a5cc5..3d0daf4 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -436,10 +436,14 @@ void __init setup_system(void)
 
 static u64 slb0_limit(void)
 {
+#ifdef CONFIG_PPC_BOOK3E
+	return 1 << 30;
+#else
 	if (cpu_has_feature(CPU_FTR_1T_SEGMENT)) {
 		return 1UL << SID_SHIFT_1T;
 	}
 	return 1UL << SID_SHIFT;
+#endif
 }
 
 static void __init irqstack_early_init(void)
-- 
1.7.1
