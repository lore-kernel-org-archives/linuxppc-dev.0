Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNBPf0bQ0zDvqn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 14:52:38 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id 144so453481pfv.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 19:52:37 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: add more asm-prototypes.h declarations for asm
 exports
Date: Tue, 22 Nov 2016 14:52:22 +1100
Message-Id: <20161122035222.27115-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After patch 4efca4ed0 ("kbuild: modversions for EXPORT_SYMBOL() for asm"),
asm exports can get modversions CRCs generated if they have C definitions
in asm-prototypes.h. This patch adds missing definitions for 32 and 64 bit
allmodconfig builds.

Fixes: 9445aa1a3062 ("ppc: move exports to definitions")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Hi,

This should go into 4.9 to correct the modversions regression. Sorry it's
taken this long, the kbuild side took a while.

Thanks,
Nick


 arch/powerpc/include/asm/asm-prototypes.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index d149273..e0baba1 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -14,6 +14,10 @@
 
 #include <linux/threads.h>
 #include <linux/kprobes.h>
+#include <asm/cacheflush.h>
+#include <asm/checksum.h>
+#include <asm/uaccess.h>
+#include <asm/epapr_hcalls.h>
 
 #include <uapi/asm/ucontext.h>
 
@@ -109,4 +113,12 @@ void early_setup_secondary(void);
 /* time */
 void accumulate_stolen_time(void);
 
+/* misc runtime */
+extern u64 __bswapdi2(u64);
+extern s64 __lshrdi3(s64, int);
+extern s64 __ashldi3(s64, int);
+extern s64 __ashrdi3(s64, int);
+extern int __cmpdi2(s64, s64);
+extern int __ucmpdi2(u64, u64);
+
 #endif /* _ASM_POWERPC_ASM_PROTOTYPES_H */
-- 
2.10.2
