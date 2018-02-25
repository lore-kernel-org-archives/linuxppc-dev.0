Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x243.google.com (mail-wr0-x243.google.com
 [IPv6:2a00:1450:400c:c0c::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqBcf729KzF1N4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 04:23:14 +1100 (AEDT)
Received: by mail-wr0-x243.google.com with SMTP id m5so18860034wrg.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 09:23:14 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 21/21] powerpc: Add missing prototypes in setup_32.c
Date: Sun, 25 Feb 2018 18:22:36 +0100
Message-Id: <20180225172236.29650-22-malat@debian.org>
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
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

This commit add the prototypes for the following function:

- early_init
- machine_init
- ppc_setup_l2cr
- ppc_setup_l3cr
- ppc_init

the other missing ones were already added in setup.h previously. Fix the
following warnings (treated as error in W=1):

  AR      init/built-in.o
arch/powerpc/kernel/setup_32.c:68:30: error: no previous prototype for ‘early_init’ [-Werror=missing-prototypes]
 notrace unsigned long __init early_init(unsigned long dt_ptr)
                              ^~~~~~~~~~
arch/powerpc/kernel/setup_32.c:99:21: error: no previous prototype for ‘machine_init’ [-Werror=missing-prototypes]
 notrace void __init machine_init(u64 dt_ptr)
                     ^~~~~~~~~~~~
arch/powerpc/kernel/setup_32.c:124:12: error: no previous prototype for ‘ppc_setup_l2cr’ [-Werror=missing-prototypes]
 int __init ppc_setup_l2cr(char *str)
            ^~~~~~~~~~~~~~
arch/powerpc/kernel/setup_32.c:137:12: error: no previous prototype for ‘ppc_setup_l3cr’ [-Werror=missing-prototypes]
 int __init ppc_setup_l3cr(char *str)
            ^~~~~~~~~~~~~~
arch/powerpc/kernel/setup_32.c:183:12: error: no previous prototype for ‘ppc_init’ [-Werror=missing-prototypes]
 int __init ppc_init(void)
            ^~~~~~~~
arch/powerpc/kernel/setup_32.c:198:13: error: no previous prototype for ‘irqstack_early_init’ [-Werror=missing-prototypes]
 void __init irqstack_early_init(void)
             ^~~~~~~~~~~~~~~~~~~
arch/powerpc/kernel/setup_32.c:238:13: error: no previous prototype for ‘setup_power_save’ [-Werror=missing-prototypes]
 void __init setup_power_save(void)
             ^~~~~~~~~~~~~~~~
arch/powerpc/kernel/setup_32.c:253:13: error: no previous prototype for ‘initialize_cache_info’ [-Werror=missing-prototypes]
 __init void initialize_cache_info(void)
             ^~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/setup.h    | 5 +++++
 arch/powerpc/kernel/setup_32.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/arch/powerpc/kernel/setup.h b/arch/powerpc/kernel/setup.h
index 3fc11e30308f..d768023a04bd 100644
--- a/arch/powerpc/kernel/setup.h
+++ b/arch/powerpc/kernel/setup.h
@@ -17,6 +17,11 @@ void irqstack_early_init(void);
 
 #ifdef CONFIG_PPC32
 void setup_power_save(void);
+unsigned long __init early_init(unsigned long dt_ptr);
+void __init machine_init(u64 dt_ptr);
+int __init ppc_setup_l2cr(char *str);
+int __init ppc_setup_l3cr(char *str);
+int __init ppc_init(void);
 #else
 static inline void setup_power_save(void) { };
 #endif
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 51ebc01fff52..12bcab77a29f 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -40,6 +40,8 @@
 #include <asm/code-patching.h>
 #include <asm/cpu_has_feature.h>
 
+#include "setup.h"
+
 #define DBG(fmt...)
 
 extern void bootx_init(unsigned long r4, unsigned long phys);
-- 
2.11.0
