Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x244.google.com (mail-wr0-x244.google.com
 [IPv6:2a00:1450:400c:c0c::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406dNX1SZHzF20D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 07:21:16 +1100 (AEDT)
Received: by mail-wr0-x244.google.com with SMTP id o8so10002083wra.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 13:21:16 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 19/19] powerpc/tau: Synchronize function prototypes and body
Date: Thu, 22 Mar 2018 21:20:05 +0100
Message-Id: <20180322202007.23088-20-malat@debian.org>
In-Reply-To: <20180322202007.23088-1-malat@debian.org>
References: <20180322202007.23088-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some function prototypes and body for Thermal Assist Units were not in
sync. Update the function definition to match the existing function
declaration found in `setup-common.c`, changing an `int` return type to a
`u32` return type. Move the prototypes to a header file. Fix the following
warnings, treated as error with W=1:

  arch/powerpc/kernel/tau_6xx.c:257:5: error: no previous prototype for ‘cpu_temp_both’ [-Werror=missing-prototypes]
  arch/powerpc/kernel/tau_6xx.c:262:5: error: no previous prototype for ‘cpu_temp’ [-Werror=missing-prototypes]
  arch/powerpc/kernel/tau_6xx.c:267:5: error: no previous prototype for ‘tau_interrupts’ [-Werror=missing-prototypes]

Compile tested with CONFIG_TAU_INT.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/irq.c          | 2 +-
 arch/powerpc/kernel/setup-common.c | 6 ------
 arch/powerpc/kernel/setup.h        | 6 ++++++
 arch/powerpc/kernel/tau_6xx.c      | 7 +++++--
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index f88038847790..3777b6e09142 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -89,7 +89,7 @@ atomic_t ppc_n_lost_interrupts;
 
 #ifdef CONFIG_TAU_INT
 extern int tau_initialized;
-extern int tau_interrupts(int);
+extern u32 tau_interrupts(unsigned long cpu);
 #endif
 #endif /* CONFIG_PPC32 */
 
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index d73ec518ef80..bd3675c3984b 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -192,12 +192,6 @@ void machine_halt(void)
 	machine_hang();
 }
 
-
-#ifdef CONFIG_TAU
-extern u32 cpu_temp(unsigned long cpu);
-extern u32 cpu_temp_both(unsigned long cpu);
-#endif /* CONFIG_TAU */
-
 #ifdef CONFIG_SMP
 DEFINE_PER_CPU(unsigned int, cpu_pvr);
 #endif
diff --git a/arch/powerpc/kernel/setup.h b/arch/powerpc/kernel/setup.h
index d768023a04bd..3c9c19430439 100644
--- a/arch/powerpc/kernel/setup.h
+++ b/arch/powerpc/kernel/setup.h
@@ -70,4 +70,10 @@ void kvm_cma_reserve(void);
 static inline void kvm_cma_reserve(void) { };
 #endif
 
+#ifdef CONFIG_TAU
+extern u32 cpu_temp(unsigned long cpu);
+extern u32 cpu_temp_both(unsigned long cpu);
+extern u32 tau_interrupts(unsigned long cpu);
+#endif /* CONFIG_TAU */
+
 #endif /* __ARCH_POWERPC_KERNEL_SETUP_H */
diff --git a/arch/powerpc/kernel/tau_6xx.c b/arch/powerpc/kernel/tau_6xx.c
index 1fc6a89a978e..e2ab8a111b69 100644
--- a/arch/powerpc/kernel/tau_6xx.c
+++ b/arch/powerpc/kernel/tau_6xx.c
@@ -27,6 +27,9 @@
 #include <asm/cache.h>
 #include <asm/8xx_immap.h>
 #include <asm/machdep.h>
+#include <asm/asm-prototypes.h>
+
+#include "setup.h"
 
 static struct tau_temp
 {
@@ -259,12 +262,12 @@ u32 cpu_temp_both(unsigned long cpu)
 	return ((tau[cpu].high << 16) | tau[cpu].low);
 }
 
-int cpu_temp(unsigned long cpu)
+u32 cpu_temp(unsigned long cpu)
 {
 	return ((tau[cpu].high + tau[cpu].low) / 2);
 }
 
-int tau_interrupts(unsigned long cpu)
+u32 tau_interrupts(unsigned long cpu)
 {
 	return (tau[cpu].interrupts);
 }
-- 
2.11.0
