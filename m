Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] OProfile: remove dependency on spufs module
Date: Fri, 14 Dec 2007 15:27:30 +0100
References: <18274.3076.467791.719752@cargo.ozlabs.ibm.com>
In-Reply-To: <18274.3076.467791.719752@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712141527.31893.arnd@arndb.de>
Cc: David Woodhouse <dwmw2@infradead.org>, Paul Mackerras <paulus@samba.org>,
	jk@ozlabs.org, Bob Nelson <rrnelson@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Bob Nelson <rrnelson@linux.vnet.ibm.com>

This is a patch removes an OProfile dependency on the spufs module.
This was causing a problem for multiplatform systems that are
built with support for Oprofile on Cell but try to load the
oprofile module on another system.

Signed-off-by: Bob Nelson <rrnelson@us.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---
On Friday 14 December 2007, Paul Mackerras wrote:
> Currently I have just this one bugfix queued up to go to Linus for
> 2.6.24:
> 
> Stephen Rothwell (1):
>       [POWERPC] iSeries: don't printk with HV spinlock held
> 
> Does anyone else have bugfixes that need to go in 2.6.24?

A few  people have asked me for including this one, I'd like
it to get that in still. It was broken ever since you could
enable support for spu oprofile.

Jeremy, please ack the spufs changes if you are ok with the patch.

Sorry for delaying this patch so long on my side everyone.

	Arnd <><

 arch/powerpc/platforms/cell/Kconfig          |    2 +-
 arch/powerpc/platforms/cell/Makefile         |    1 +
 arch/powerpc/platforms/cell/spu_notify.c     |   67 ++++++++++++++++++++++++++
 arch/powerpc/platforms/cell/spu_syscalls.c   |   14 +++++
 arch/powerpc/platforms/cell/spufs/context.c  |   16 ------
 arch/powerpc/platforms/cell/spufs/sched.c    |   29 +++--------
 arch/powerpc/platforms/cell/spufs/syscalls.c |    1 +
 include/asm-powerpc/spu.h                    |    4 ++
 8 files changed, 95 insertions(+), 39 deletions(-)
 create mode 100644 arch/powerpc/platforms/cell/spu_notify.c


Index: linux-2.6-new/arch/powerpc/platforms/cell/Kconfig
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/cell/Kconfig
+++ linux-2.6-new/arch/powerpc/platforms/cell/Kconfig
@@ -88,3 +88,8 @@ config CBE_CPUFREQ_PMI
 	  but also at lower core voltage.
 
 endmenu
+
+config OPROFILE_CELL
+	def_bool y
+	depends on PPC_CELL_NATIVE && (OPROFILE = m || OPROFILE = y)
+
Index: linux-2.6-new/arch/powerpc/platforms/cell/Makefile
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/cell/Makefile
+++ linux-2.6-new/arch/powerpc/platforms/cell/Makefile
@@ -19,6 +19,7 @@ spu-manage-$(CONFIG_PPC_CELLEB)		+= spu_
 spu-manage-$(CONFIG_PPC_CELL_NATIVE)	+= spu_manage.o
 
 obj-$(CONFIG_SPU_BASE)			+= spu_callbacks.o spu_base.o \
+					   spu_notify.o \
 					   spu_syscalls.o \
 					   $(spu-priv1-y) \
 					   $(spu-manage-y) \
Index: linux-2.6-new/arch/powerpc/platforms/cell/spu_notify.c
===================================================================
--- /dev/null
+++ linux-2.6-new/arch/powerpc/platforms/cell/spu_notify.c
@@ -0,0 +1,67 @@
+/*
+ * Move OProfile dependencies from spufs module to the kernel so it
+ * can run on non-cell PPC.
+ *
+ * Copyright (C) IBM 2005
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#undef DEBUG
+
+#include <linux/module.h>
+#include <asm/spu.h>
+#include "spufs/spufs.h"
+
+static BLOCKING_NOTIFIER_HEAD(spu_switch_notifier);
+
+void spu_switch_notify(struct spu *spu, struct spu_context *ctx)
+{
+	blocking_notifier_call_chain(&spu_switch_notifier,
+				     ctx ? ctx->object_id : 0, spu);
+}
+EXPORT_SYMBOL_GPL(spu_switch_notify);
+
+int spu_switch_event_register(struct notifier_block *n)
+{
+	int ret;
+	ret = blocking_notifier_chain_register(&spu_switch_notifier, n);
+	if (!ret)
+		notify_spus_active();
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spu_switch_event_register);
+
+int spu_switch_event_unregister(struct notifier_block *n)
+{
+	return blocking_notifier_chain_unregister(&spu_switch_notifier, n);
+}
+EXPORT_SYMBOL_GPL(spu_switch_event_unregister);
+
+void spu_set_profile_private_kref(struct spu_context *ctx,
+				  struct kref *prof_info_kref,
+				  void (* prof_info_release) (struct kref *kref))
+{
+	ctx->prof_priv_kref = prof_info_kref;
+	ctx->prof_priv_release = prof_info_release;
+}
+EXPORT_SYMBOL_GPL(spu_set_profile_private_kref);
+
+void *spu_get_profile_private_kref(struct spu_context *ctx)
+{
+	return ctx->prof_priv_kref;
+}
+EXPORT_SYMBOL_GPL(spu_get_profile_private_kref);
+
Index: linux-2.6-new/arch/powerpc/platforms/cell/spu_syscalls.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/cell/spu_syscalls.c
+++ linux-2.6-new/arch/powerpc/platforms/cell/spu_syscalls.c
@@ -145,6 +145,20 @@ int elf_coredump_extra_notes_write(struc
 	return ret;
 }
 
+void notify_spus_active(void)
+{
+	struct spufs_calls *calls;
+
+	calls = spufs_calls_get();
+	if (!calls)
+		return;
+
+	calls->notify_spus_active();
+	spufs_calls_put(calls);
+
+	return;
+}
+
 int register_spu_syscalls(struct spufs_calls *calls)
 {
 	if (spufs_calls)
Index: linux-2.6-new/arch/powerpc/platforms/cell/spufs/context.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/cell/spufs/context.c
+++ linux-2.6-new/arch/powerpc/platforms/cell/spufs/context.c
@@ -190,19 +190,3 @@ void spu_release_saved(struct spu_contex
 	spu_release(ctx);
 }
 
-void spu_set_profile_private_kref(struct spu_context *ctx,
-				  struct kref *prof_info_kref,
-				  void ( * prof_info_release) (struct kref *kref))
-{
-	ctx->prof_priv_kref = prof_info_kref;
-	ctx->prof_priv_release = prof_info_release;
-}
-EXPORT_SYMBOL_GPL(spu_set_profile_private_kref);
-
-void *spu_get_profile_private_kref(struct spu_context *ctx)
-{
-	return ctx->prof_priv_kref;
-}
-EXPORT_SYMBOL_GPL(spu_get_profile_private_kref);
-
-
Index: linux-2.6-new/arch/powerpc/platforms/cell/spufs/sched.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/cell/spufs/sched.c
+++ linux-2.6-new/arch/powerpc/platforms/cell/spufs/sched.c
@@ -166,15 +166,7 @@ static int node_allowed(struct spu_conte
 	return rval;
 }
 
-static BLOCKING_NOTIFIER_HEAD(spu_switch_notifier);
-
-void spu_switch_notify(struct spu *spu, struct spu_context *ctx)
-{
-	blocking_notifier_call_chain(&spu_switch_notifier,
-			    ctx ? ctx->object_id : 0, spu);
-}
-
-static void notify_spus_active(void)
+void do_notify_spus_active(void)
 {
 	int node;
 
@@ -200,22 +192,15 @@ static void notify_spus_active(void)
 		mutex_unlock(&cbe_spu_info[node].list_mutex);
 	}
 }
+EXPORT_SYMBOL_GPL(do_notify_spus_active);
 
-int spu_switch_event_register(struct notifier_block * n)
-{
-	int ret;
-	ret = blocking_notifier_chain_register(&spu_switch_notifier, n);
-	if (!ret)
-		notify_spus_active();
-	return ret;
-}
-EXPORT_SYMBOL_GPL(spu_switch_event_register);
-
-int spu_switch_event_unregister(struct notifier_block * n)
+#ifndef MODULE
+void notify_spus_active(void)
 {
-	return blocking_notifier_chain_unregister(&spu_switch_notifier, n);
+	do_notify_spus_active();
 }
-EXPORT_SYMBOL_GPL(spu_switch_event_unregister);
+EXPORT_SYMBOL_GPL(notify_spus_active);
+#endif
 
 /**
  * spu_bind_context - bind spu context to physical spu
Index: linux-2.6-new/arch/powerpc/platforms/cell/spufs/syscalls.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/cell/spufs/syscalls.c
+++ linux-2.6-new/arch/powerpc/platforms/cell/spufs/syscalls.c
@@ -86,5 +86,6 @@ struct spufs_calls spufs_calls = {
 	.spu_run = do_spu_run,
 	.coredump_extra_notes_size = spufs_coredump_extra_notes_size,
 	.coredump_extra_notes_write = spufs_coredump_extra_notes_write,
+	.notify_spus_active = do_notify_spus_active,
 	.owner = THIS_MODULE,
 };
Index: linux-2.6-new/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6-new.orig/include/asm-powerpc/spu.h
+++ linux-2.6-new/include/asm-powerpc/spu.h
@@ -246,6 +246,7 @@ struct spufs_calls {
 						__u32 __user *ustatus);
 	int (*coredump_extra_notes_size)(void);
 	int (*coredump_extra_notes_write)(struct file *file, loff_t *foffset);
+	void (*notify_spus_active)(void);
 	struct module *owner;
 };
 
@@ -298,6 +299,9 @@ struct notifier_block;
 int spu_switch_event_register(struct notifier_block * n);
 int spu_switch_event_unregister(struct notifier_block * n);
 
+extern void notify_spus_active(void);
+extern void do_notify_spus_active(void);
+
 /*
  * This defines the Local Store, Problem Area and Privlege Area of an SPU.
  */
