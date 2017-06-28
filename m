Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyMCF5RKQzDr3l
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 22:13:45 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH 1/2] powerpc/64: implement spin loop primitives
Date: Wed, 28 Jun 2017 22:13:41 +1000
Message-Id: <1498652022-10417-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/processor.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index c49165a7439c..832775771bd3 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -428,6 +428,26 @@ static inline unsigned long __pack_fe01(unsigned int fpmode)
 
 #ifdef CONFIG_PPC64
 #define cpu_relax()	do { HMT_low(); HMT_medium(); barrier(); } while (0)
+
+#define spin_begin()	HMT_low()
+
+#define spin_cpu_relax()	barrier()
+
+#define spin_cpu_yield()	spin_cpu_relax()
+
+#define spin_end()	HMT_medium()
+
+#define spin_until_cond(cond)					\
+do {								\
+	if (unlikely(!(cond))) {				\
+		spin_begin();					\
+		do {						\
+			spin_cpu_relax();			\
+		} while (!(cond));				\
+		spin_end();					\
+	}							\
+} while (0)
+
 #else
 #define cpu_relax()	barrier()
 #endif
-- 
2.7.4
