Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wxFW5s5jzDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 02:41:51 +1000 (AEST)
Message-Id: <ebe331c679940acdae8cbdd6425c589601e7d72b.1527697995.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1527697995.git.christophe.leroy@c-s.fr>
References: <cover.1527697995.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH 2/8] powerpc: remove unneeded inclusions of
 cpu_has_feature.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 30 May 2018 16:41:48 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Files not using cpu_has_feature() don't need cpu_has_feature.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/cacheflush.h  | 1 -
 arch/powerpc/include/asm/cputime.h     | 1 -
 arch/powerpc/include/asm/dbell.h       | 1 -
 arch/powerpc/include/asm/dt_cpu_ftrs.h | 3 ---
 arch/powerpc/kernel/vdso.c             | 1 -
 5 files changed, 7 deletions(-)

diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index 11843e37d9cf..cfe3a98349c4 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -11,7 +11,6 @@
 
 #include <linux/mm.h>
 #include <asm/cputable.h>
-#include <asm/cpu_has_feature.h>
 
 /*
  * No cache flushing is required when address mappings are changed,
diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/asm/cputime.h
index 99b541865d8d..d78fee0cdbf0 100644
--- a/arch/powerpc/include/asm/cputime.h
+++ b/arch/powerpc/include/asm/cputime.h
@@ -23,7 +23,6 @@
 #include <asm/div64.h>
 #include <asm/time.h>
 #include <asm/param.h>
-#include <asm/cpu_has_feature.h>
 
 typedef u64 __nocast cputime_t;
 typedef u64 __nocast cputime64_t;
diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/dbell.h
index 9f2ae0d25e15..998c42ff1caa 100644
--- a/arch/powerpc/include/asm/dbell.h
+++ b/arch/powerpc/include/asm/dbell.h
@@ -16,7 +16,6 @@
 #include <linux/threads.h>
 
 #include <asm/ppc-opcode.h>
-#include <asm/cpu_has_feature.h>
 
 #define PPC_DBELL_MSG_BRDCAST	(0x04000000)
 #define PPC_DBELL_TYPE(x)	(((x) & 0xf) << (63-36))
diff --git a/arch/powerpc/include/asm/dt_cpu_ftrs.h b/arch/powerpc/include/asm/dt_cpu_ftrs.h
index 71515d909ed1..40165eea22ee 100644
--- a/arch/powerpc/include/asm/dt_cpu_ftrs.h
+++ b/arch/powerpc/include/asm/dt_cpu_ftrs.h
@@ -10,9 +10,6 @@
  */
 
 #include <linux/types.h>
-#include <asm/asm-compat.h>
-#include <asm/feature-fixups.h>
-#include <uapi/asm/cputable.h>
 
 #ifdef CONFIG_PPC_DT_CPU_FTRS
 bool dt_cpu_ftrs_init(void *fdt);
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index b44ec104a5a1..63b4e4485b00 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -22,7 +22,6 @@
 #include <linux/security.h>
 #include <linux/memblock.h>
 
-#include <asm/cpu_has_feature.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 #include <asm/mmu.h>
-- 
2.13.3
