Return-Path: <b10716@zro03-ws408.ea.freescale.net>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D6E382C0428
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 02:53:15 +1100 (EST)
Received: from mail143-db8 (localhost [127.0.0.1])	by
 mail143-db8-R.bigfish.com (Postfix) with ESMTP id 62E3A4000CB	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2013 15:53:00 +0000 (UTC)
Received: from DB8EHSMHS008.bigfish.com (unknown [10.174.8.227])	by
 mail143-db8.bigfish.com (Postfix) with ESMTP id 67725260049	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2013 15:52:41 +0000 (UTC)
From: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx: Move ePAPR paravirt initialization earlier
Date: Tue, 5 Mar 2013 17:52:36 +0200
Message-ID: <1362498756-395-1-git-send-email-Laurentiu.Tudor@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tudor Laurentiu <laurentiu.tudor@freescale.com>

The ePAPR para-virtualization needs to happen very early
otherwise the bytechannel based console will silently
drop some of the early boot messages.

Before this patch, this is how the kernel log started:
-----------------------------------------------------
 > Brought up 2 CPUs
 > devtmpfs: initialized
 > NET: Registered protocol family 16
 [...]
-----------------------------------------------------

After the patch the early messages show up:
-----------------------------------------------------
 > Using P5020 DS machine description
 > MMU: Supported page sizes
 >          4 KB as direct
 >       4096 KB as direct
 [...]
-----------------------------------------------------

At console init, the kernel tried to flush the log buffer.
Since the paravirt was not yet initialized the console write
function failed silently, thus losing the buffered messages.

Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
---
 arch/powerpc/include/asm/epapr_hcalls.h |    6 ++++++
 arch/powerpc/kernel/epapr_paravirt.c    |    3 +--
 arch/powerpc/kernel/setup_32.c          |    2 ++
 arch/powerpc/kernel/setup_64.c          |    3 +++
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/epapr_hcalls.h b/arch/powerpc/include/asm/epapr_hcalls.h
index d3d6342..544176e 100644
--- a/arch/powerpc/include/asm/epapr_hcalls.h
+++ b/arch/powerpc/include/asm/epapr_hcalls.h
@@ -105,6 +105,12 @@
 extern bool epapr_paravirt_enabled;
 extern u32 epapr_hypercall_start[];
 
+#ifdef CONFIG_EPAPR_PARAVIRT
+int __init epapr_paravirt_init(void);
+#else
+static inline int epapr_paravirt_init(void) { return 0; }
+#endif
+
 /*
  * We use "uintptr_t" to define a register because it's guaranteed to be a
  * 32-bit integer on a 32-bit platform, and a 64-bit integer on a 64-bit
diff --git a/arch/powerpc/kernel/epapr_paravirt.c b/arch/powerpc/kernel/epapr_paravirt.c
index f3eab85..9848713 100644
--- a/arch/powerpc/kernel/epapr_paravirt.c
+++ b/arch/powerpc/kernel/epapr_paravirt.c
@@ -28,7 +28,7 @@ extern u32 epapr_ev_idle_start[];
 
 bool epapr_paravirt_enabled;
 
-static int __init epapr_paravirt_init(void)
+int __init epapr_paravirt_init(void)
 {
 	struct device_node *hyper_node;
 	const u32 *insts;
@@ -58,4 +58,3 @@ static int __init epapr_paravirt_init(void)
 	return 0;
 }
 
-early_initcall(epapr_paravirt_init);
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index a8f54ec..1464655 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -38,6 +38,7 @@
 #include <asm/serial.h>
 #include <asm/udbg.h>
 #include <asm/mmu_context.h>
+#include <asm/epapr_hcalls.h>
 
 #include "setup.h"
 
@@ -327,4 +328,5 @@ void __init setup_arch(char **cmdline_p)
 	/* Initialize the MMU context management stuff */
 	mmu_context_init();
 
+	epapr_paravirt_init();
 }
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 6da881b..ce092ac 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -66,6 +66,7 @@
 #include <asm/code-patching.h>
 #include <asm/kvm_ppc.h>
 #include <asm/hugetlb.h>
+#include <asm/epapr_hcalls.h>
 
 #include "setup.h"
 
@@ -599,6 +600,8 @@ void __init setup_arch(char **cmdline_p)
 	/* Initialize the MMU context management stuff */
 	mmu_context_init();
 
+	epapr_paravirt_init();
+
 	kvm_linear_init();
 
 	/* Interrupt code needs to be 64K-aligned */
-- 
1.7.6.5
