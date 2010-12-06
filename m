Return-Path: <mikey@neuling.org>
Message-Id: <20101206234049.880246100@neuling.org>
Date: Tue, 07 Dec 2010 10:40:45 +1100
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Kumar Gala <galak@kernel.crashing.org>
Subject: [RFC/PATCH 2/7] Rearrange include files to make struct
	call_single_data usable in more places
References: <20101206234043.083045003@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to put struct call_single_data in the powerpc thread_struct,
but can't without this.

The thread_struct is in processor.h.  To add a struct call_single_data
to the thread_struct asm/processor.h must include linux/smp.h.  When
linux/smp.h is added to processor.h this creates an include loop via
with list.h via:

  linux/list.h includes: 
    linux/prefetch.h includes:
      asm/processor.h (for powerpc) includes:
        linux/smp.h includes:
          linux/list.h

This loops results in an "incomplete list type" compile when using
struct list_head as used in struct call_single_data.

This patch rearanges some include files to avoid this loop.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 include/linux/call_single_data.h |   14 ++++++++++++++
 include/linux/list.h             |    4 +++-
 include/linux/smp.h              |    8 +-------
 3 files changed, 18 insertions(+), 8 deletions(-)

Index: linux-lazy/include/linux/call_single_data.h
===================================================================
--- /dev/null
+++ linux-lazy/include/linux/call_single_data.h
@@ -0,0 +1,14 @@
+#ifndef __LINUX_CALL_SINGLE_DATA_H
+#define __LINUX_CALL_SINGLE_DATA_H
+
+#include <linux/list.h>
+
+struct call_single_data {
+	struct list_head list;
+	void (*func) (void *info);
+	void *info;
+	u16 flags;
+	u16 priv;
+};
+
+#endif /* __LINUX_CALL_SINGLE_DATA_H */
Index: linux-lazy/include/linux/list.h
===================================================================
--- linux-lazy.orig/include/linux/list.h
+++ linux-lazy/include/linux/list.h
@@ -4,7 +4,6 @@
 #include <linux/types.h>
 #include <linux/stddef.h>
 #include <linux/poison.h>
-#include <linux/prefetch.h>
 
 /*
  * Simple doubly linked list implementation.
@@ -16,6 +15,9 @@
  * using the generic single-entry routines.
  */
 
+#include <linux/prefetch.h>
+#include <asm/system.h>
+
 #define LIST_HEAD_INIT(name) { &(name), &(name) }
 
 #define LIST_HEAD(name) \
Index: linux-lazy/include/linux/smp.h
===================================================================
--- linux-lazy.orig/include/linux/smp.h
+++ linux-lazy/include/linux/smp.h
@@ -9,18 +9,12 @@
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/list.h>
+#include <linux/call_single_data.h>
 #include <linux/cpumask.h>
 
 extern void cpu_idle(void);
 
 typedef void (*smp_call_func_t)(void *info);
-struct call_single_data {
-	struct list_head list;
-	smp_call_func_t func;
-	void *info;
-	u16 flags;
-	u16 priv;
-};
 
 /* total number of cpus in this system (may exceed NR_CPUS) */
 extern unsigned int total_cpus;
