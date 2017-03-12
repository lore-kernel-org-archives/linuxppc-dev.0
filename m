Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vh6m93DjqzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 04:04:09 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id 77so15642595pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Mar 2017 10:04:09 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/powernv: fix POWER9 msgsnd addressing
Date: Mon, 13 Mar 2017 03:03:48 +1000
Message-Id: <20170312170349.20323-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ISAv3 changes the addressing mode of msgsnd from TIR to PIR. Without
this change, all doorbell IPIs on bare metal go to core 0 threads.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/dbell.h |  4 ----
 arch/powerpc/kernel/dbell.c      | 12 +++++++++++-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/dbell.h
index 378167377065..b9d3b52e2a2c 100644
--- a/arch/powerpc/include/asm/dbell.h
+++ b/arch/powerpc/include/asm/dbell.h
@@ -35,8 +35,6 @@ enum ppc_dbell {
 #ifdef CONFIG_PPC_BOOK3S
 
 #define PPC_DBELL_MSGTYPE		PPC_DBELL_SERVER
-#define SPRN_DOORBELL_CPUTAG		SPRN_TIR
-#define PPC_DBELL_TAG_MASK		0x7f
 
 static inline void _ppc_msgsnd(u32 msg)
 {
@@ -49,8 +47,6 @@ static inline void _ppc_msgsnd(u32 msg)
 #else /* CONFIG_PPC_BOOK3S */
 
 #define PPC_DBELL_MSGTYPE		PPC_DBELL
-#define SPRN_DOORBELL_CPUTAG		SPRN_PIR
-#define PPC_DBELL_TAG_MASK		0x3fff
 
 static inline void _ppc_msgsnd(u32 msg)
 {
diff --git a/arch/powerpc/kernel/dbell.c b/arch/powerpc/kernel/dbell.c
index 2128f3a96c32..b2011a261045 100644
--- a/arch/powerpc/kernel/dbell.c
+++ b/arch/powerpc/kernel/dbell.c
@@ -22,7 +22,17 @@
 #ifdef CONFIG_SMP
 void doorbell_setup_this_cpu(void)
 {
-	unsigned long tag = mfspr(SPRN_DOORBELL_CPUTAG) & PPC_DBELL_TAG_MASK;
+	unsigned long tag;
+
+#ifdef CONFIG_PPC_BOOK3S
+	if (cpu_has_feature(CPU_FTR_HVMODE) && cpu_has_feature(CPU_FTR_ARCH_300))
+		tag = mfspr(SPRN_PIR) & 0xfffff;
+	else
+		tag = mfspr(SPRN_TIR) & 0x7f;
+
+#else
+	tag = mfspr(SPRN_PIR) & 0x3fff;
+#endif
 
 	smp_muxed_ipi_set_data(smp_processor_id(), tag);
 }
-- 
2.11.0
