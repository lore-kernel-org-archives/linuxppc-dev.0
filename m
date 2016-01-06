Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD0871A0B62
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jan 2016 11:46:13 +1100 (AEDT)
Received: from mail-pf0-x22a.google.com (mail-pf0-x22a.google.com
 [IPv6:2607:f8b0:400e:c00::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EE9FE1402C0
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Jan 2016 11:46:12 +1100 (AEDT)
Received: by mail-pf0-x22a.google.com with SMTP id e65so175801197pfe.1
 for <linuxppc-dev@ozlabs.org>; Tue, 05 Jan 2016 16:46:12 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH 2/2] powerpc: sparse: Include headers for __weak symbols
Date: Wed,  6 Jan 2016 11:45:51 +1100
Message-Id: <1452041151-2387-2-git-send-email-dja@axtens.net>
In-Reply-To: <1452041151-2387-1-git-send-email-dja@axtens.net>
References: <1452041151-2387-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sometimes when sparse warns about undefined symbols, it isn't
because they should have 'static' added, it's because they're
overriding __weak symbols defined elsewhere, and the header has
been missed.

Fix a few of them by adding appropriate headers.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/kernel/process.c | 2 ++
 arch/powerpc/kernel/prom.c    | 1 +
 arch/powerpc/kernel/time.c    | 1 +
 arch/powerpc/mm/mmap.c        | 1 +
 4 files changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index dccc87e8fee5..afd81390add0 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -38,6 +38,7 @@
 #include <linux/random.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/uaccess.h>
+#include <linux/elf-randomize.h>
 
 #include <asm/pgtable.h>
 #include <asm/io.h>
@@ -55,6 +56,7 @@
 #include <asm/firmware.h>
 #endif
 #include <asm/code-patching.h>
+#include <asm/exec.h>
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 7030b035905d..1b082c729c29 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -34,6 +34,7 @@
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
+#include <linux/cpu.h>
 
 #include <asm/prom.h>
 #include <asm/rtas.h>
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 81b0900a39ee..3ed9a5a21d77 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -55,6 +55,7 @@
 #include <linux/delay.h>
 #include <linux/irq_work.h>
 #include <linux/clk-provider.h>
+#include <linux/suspend.h>
 #include <asm/trace.h>
 
 #include <asm/io.h>
diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
index 0f0502e12f6c..1ccb2f6ecaf9 100644
--- a/arch/powerpc/mm/mmap.c
+++ b/arch/powerpc/mm/mmap.c
@@ -26,6 +26,7 @@
 #include <linux/mm.h>
 #include <linux/random.h>
 #include <linux/sched.h>
+#include <linux/elf-randomize.h>
 
 /*
  * Top of mmap area (just below the process stack).
-- 
2.6.4
