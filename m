Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxZqm2zQJzF1pR
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 13:55:00 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH 4/4] powerpc/xmon: Move empty plpar_set_ciabr() into
 plpar_wrappers.h
Date: Thu,  8 Mar 2018 13:54:42 +1100
Message-Id: <20180308025442.6165-4-mpe@ellerman.id.au>
In-Reply-To: <20180308025442.6165-1-mpe@ellerman.id.au>
References: <20180308025442.6165-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that plpar_wrappers.h has an #ifdef PSERIES we can move the empty
version of plpar_set_ciabr() which xmon wants into there.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/plpar_wrappers.h | 6 ++++++
 arch/powerpc/xmon/xmon.c                  | 7 +------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index 9233b84f489a..96c1a46acbd0 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -334,6 +334,12 @@ static inline long plpar_get_cpu_characteristics(struct h_cpu_char_result *p)
 	return rc;
 }
 
+#else /* !CONFIG_PPC_PSERIES */
+
+static inline long plpar_set_ciabr(unsigned long ciabr)
+{
+	return 0;
+}
 #endif /* CONFIG_PPC_PSERIES */
 
 #endif /* _ASM_POWERPC_PLPAR_WRAPPERS_H */
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index ecbb34eb1ddf..4118f723ed00 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -41,6 +41,7 @@
 #include <asm/pgtable.h>
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
+#include <asm/plpar_wrappers.h>
 #include <asm/cputable.h>
 #include <asm/rtas.h>
 #include <asm/sstep.h>
@@ -61,12 +62,6 @@
 #include <asm/paca.h>
 #endif
 
-#if defined(CONFIG_PPC_SPLPAR)
-#include <asm/plpar_wrappers.h>
-#else
-static inline long plpar_set_ciabr(unsigned long ciabr) {return 0; };
-#endif
-
 #include "nonstdio.h"
 #include "dis-asm.h"
 
-- 
2.14.1
