Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wW2PD0zyszDqMK
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 23:16:32 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id f27so14511064pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 06:16:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 7/9] powerpc/64s: paca EX_LR can be merged with EX_DAR
Date: Sun, 21 May 2017 23:15:48 +1000
Message-Id: <20170521131550.25813-8-npiggin@gmail.com>
In-Reply-To: <20170521131550.25813-1-npiggin@gmail.com>
References: <20170521131550.25813-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

EX_LR is used only for a small section of the SLB miss handler.
Merge it with EX_DAR.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index e1103dc9d8e8..ba03db14e1e8 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -35,12 +35,19 @@
 #define EX_DSISR	48
 #define EX_CCR		52
 #define EX_R3		56
-#define EX_LR		64
-#define EX_CFAR		72
-#define EX_PPR		80	/* SMT thread status register (priority) */
-#define EX_CTR		88
+#define EX_CFAR		64
+#define EX_PPR		72
+#define EX_CTR		80
 
-#define EX_SIZE		12	/* size in u64 units */
+#define EX_SIZE		11	/* size in u64 units */
+
+/*
+ * EX_LR is only used in EXSLB and where it does not overlap with EX_DAR
+ * EX_CCR similarly with DSISR, but being 4 byte registers there is a hole
+ * in the save area so it's not necessary to overlap them. Could be used
+ * for future savings though if another 4 byte register was to be saved.
+ */
+#define EX_LR		EX_DAR
 
 #ifdef __ASSEMBLY__
 
-- 
2.11.0
