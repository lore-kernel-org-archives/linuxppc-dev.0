Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] powerpc: fix CONFIG_SWAP=n builds for 64-bit
Message-Id: <1190694802.994259.729715056386.1.gpush@pokey>
To: Paul Mackerras <paulus@samba.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Tue, 25 Sep 2007 14:33:22 +1000
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, 64-bit won't build with CONFIG_SWAP=n, as asm-generic/tlb.h
needs page_cache_release() and release_pages(), which are defined in
linux/pagemap.h.

We can't include linux/pagemap.h in asm-generic/tlb.h, as (apparently)
this breaks sparc. So, include it in the necessary places in the
powerpc mm code.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/mm/hash_native_64.c |    1 +
 arch/powerpc/mm/hash_utils_64.c  |    1 +
 arch/powerpc/mm/init_64.c        |    1 +
 arch/powerpc/mm/pgtable_64.c     |    1 +
 arch/powerpc/mm/tlb_64.c         |    1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 6ba9b47..dd1e9fb 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -16,6 +16,7 @@
 #include <linux/bitops.h>
 #include <linux/threads.h>
 #include <linux/smp.h>
+#include <linux/pagemap.h>
 
 #include <asm/abs_addr.h>
 #include <asm/machdep.h>
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index d525f2e..1ff0117 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -31,6 +31,7 @@
 #include <linux/cache.h>
 #include <linux/init.h>
 #include <linux/signal.h>
+#include <linux/pagemap.h>
 
 #include <asm/processor.h>
 #include <asm/pgtable.h>
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 9f27bb5..a1e8364 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -40,6 +40,7 @@
 #include <linux/nodemask.h>
 #include <linux/module.h>
 #include <linux/poison.h>
+#include <linux/pagemap.h>
 
 #include <asm/pgalloc.h>
 #include <asm/page.h>
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 60fd52c..4265eed 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -33,6 +33,7 @@
 #include <linux/stddef.h>
 #include <linux/vmalloc.h>
 #include <linux/init.h>
+#include <linux/pagemap.h>
 
 #include <asm/pgalloc.h>
 #include <asm/page.h>
diff --git a/arch/powerpc/mm/tlb_64.c b/arch/powerpc/mm/tlb_64.c
index cbd34fc..b51ca5b 100644
--- a/arch/powerpc/mm/tlb_64.c
+++ b/arch/powerpc/mm/tlb_64.c
@@ -26,6 +26,7 @@
 #include <linux/init.h>
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
+#include <linux/pagemap.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
