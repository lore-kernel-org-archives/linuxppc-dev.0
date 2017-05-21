Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wW2PK6D71zDqLj
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 23:16:37 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id u187so14694452pgb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 06:16:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 9/9] powerpc/64s: paca EX_CTR is not used with !RELOCATABLE,
 remove it
Date: Sun, 21 May 2017 23:15:50 +1000
Message-Id: <20170521131550.25813-10-npiggin@gmail.com>
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index aaee57f0e5ad..3b768cb668e7 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -36,9 +36,12 @@
 #define EX_CCR		52
 #define EX_CFAR		56
 #define EX_PPR		64
+#if defined(CONFIG_RELOCATABLE)
 #define EX_CTR		72
-
 #define EX_SIZE		10	/* size in u64 units */
+#else
+#define EX_SIZE		9	/* size in u64 units */
+#endif
 
 /*
  * EX_LR is only used in EXSLB and where it does not overlap with EX_DAR
-- 
2.11.0
