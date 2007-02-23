Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E846EDDE34
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 14:41:41 +1100 (EST)
Date: Fri, 23 Feb 2007 14:41:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] make ppc64_defconfig - CONFIG_PPC_PSERIES build
Message-Id: <20070223144141.c598a92a.sfr@canb.auug.org.au>
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


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/lib/locks.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
index 80b482c..79d0fa3 100644
--- a/arch/powerpc/lib/locks.c
+++ b/arch/powerpc/lib/locks.c
@@ -43,9 +43,11 @@ void __spin_yield(raw_spinlock_t *lock)
 	if (firmware_has_feature(FW_FEATURE_ISERIES))
 		HvCall2(HvCallBaseYieldProcessor, HvCall_YieldToProc,
 			((u64)holder_cpu << 32) | yield_count);
+#ifdef CONFIG_PPC_SPLPAR
 	else
 		plpar_hcall_norets(H_CONFER,
 			get_hard_smp_processor_id(holder_cpu), yield_count);
+#endif
 }
 
 /*
@@ -72,9 +74,11 @@ void __rw_yield(raw_rwlock_t *rw)
 	if (firmware_has_feature(FW_FEATURE_ISERIES))
 		HvCall2(HvCallBaseYieldProcessor, HvCall_YieldToProc,
 			((u64)holder_cpu << 32) | yield_count);
+#ifdef CONFIG_PPC_SPLPAR
 	else
 		plpar_hcall_norets(H_CONFER,
 			get_hard_smp_processor_id(holder_cpu), yield_count);
+#endif
 }
 #endif
 
-- 
1.4.4.4
