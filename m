Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svYyj5mN5zDt0t
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 13:07:25 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id s8so3882293pfj.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 19:07:25 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc: make _ASM_NOKPROBE_SYMBOL a noop when KPROBES not
 defined
Date: Thu, 13 Oct 2016 13:07:14 +1100
Message-Id: <20161013020714.5629-1-npiggin@gmail.com>
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
The linker orphan sections error patch caught this

 arch/powerpc/include/asm/ppc_asm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index c73750b..ceec199 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -265,10 +265,14 @@ GLUE(.,name):
  * latter is for those that incdentially must be excluded from probing
  * and allows them to be linked at more optimal location within text.
  */
+#ifdef CONFIG_KPROBES
 #define _ASM_NOKPROBE_SYMBOL(entry)			\
 	.pushsection "_kprobe_blacklist","aw";		\
 	PPC_LONG (entry) ;				\
 	.popsection
+#else
+#define _ASM_NOKPROBE_SYMBOL(entry)
+#endif
 
 #define FUNC_START(name)	_GLOBAL(name)
 #define FUNC_END(name)
-- 
2.9.3
