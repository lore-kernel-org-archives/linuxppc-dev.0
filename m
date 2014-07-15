Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0B3CD1A02DD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 22:22:35 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/3] powerpc: Add machine_early_initcall()
Date: Tue, 15 Jul 2014 22:22:23 +1000
Message-Id: <1405426945-19058-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/machdep.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index f92b0b54e921..5c7e74ddee4c 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -366,6 +366,7 @@ static inline void log_error(char *buf, unsigned int err_type, int fatal)
 	} \
 	__define_initcall(__machine_initcall_##mach##_##fn, id);
 
+#define machine_early_initcall(mach, fn)	__define_machine_initcall(mach, fn, early)
 #define machine_core_initcall(mach, fn)		__define_machine_initcall(mach, fn, 1)
 #define machine_core_initcall_sync(mach, fn)	__define_machine_initcall(mach, fn, 1s)
 #define machine_postcore_initcall(mach, fn)	__define_machine_initcall(mach, fn, 2)
-- 
1.9.1
