Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxZqk1VJ8zF1hM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 13:54:58 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH 2/4] powerpc/pseries: Make plpar_wrappers.h safe to include
 when PSERIES=n
Date: Thu,  8 Mar 2018 13:54:40 +1100
Message-Id: <20180308025442.6165-2-mpe@ellerman.id.au>
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

Currently plpar_wrappers.h is not safe to include when
CONFIG_PPC_PSERIES=n, or at least it can be depending on other config
options and so on.

Fix that by wrapping the entire content in an ifdef.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/plpar_wrappers.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index 1776af9e0118..09cb26816b2d 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_POWERPC_PLPAR_WRAPPERS_H
 #define _ASM_POWERPC_PLPAR_WRAPPERS_H
 
+#ifdef CONFIG_PPC_PSERIES
+
 #include <linux/string.h>
 #include <linux/irqflags.h>
 
@@ -332,4 +334,6 @@ static inline long plpar_get_cpu_characteristics(struct h_cpu_char_result *p)
 	return rc;
 }
 
+#endif /* CONFIG_PPC_PSERIES */
+
 #endif /* _ASM_POWERPC_PLPAR_WRAPPERS_H */
-- 
2.14.1
