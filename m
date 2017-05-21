Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wW2PH0Cs0zDqLp
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 23:16:35 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id n23so14487093pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 06:16:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 8/9] powerpc/64s: paca EX_R3 can be merged with EX_DAR
Date: Sun, 21 May 2017 23:15:49 +1000
Message-Id: <20170521131550.25813-9-npiggin@gmail.com>
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

EX_R3 is used only for a small section of the bad stack handler.
Merge it with EX_DAR.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index ba03db14e1e8..aaee57f0e5ad 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -34,12 +34,11 @@
 #define EX_DAR		40
 #define EX_DSISR	48
 #define EX_CCR		52
-#define EX_R3		56
-#define EX_CFAR		64
-#define EX_PPR		72
-#define EX_CTR		80
+#define EX_CFAR		56
+#define EX_PPR		64
+#define EX_CTR		72
 
-#define EX_SIZE		11	/* size in u64 units */
+#define EX_SIZE		10	/* size in u64 units */
 
 /*
  * EX_LR is only used in EXSLB and where it does not overlap with EX_DAR
@@ -49,6 +48,13 @@
  */
 #define EX_LR		EX_DAR
 
+/*
+ * EX_R3 is only used by the bad_stack handler. bad_stack reloads and
+ * saves DAR from SPRN_DAR, and EX_DAR is not used. So EX_R3 can overlap
+ * with EX_DAR.
+ */
+#define EX_R3		EX_DAR
+
 #ifdef __ASSEMBLY__
 
 /*
-- 
2.11.0
