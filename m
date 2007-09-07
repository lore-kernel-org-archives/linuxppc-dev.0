Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw4.sony.co.jp (MGW4.Sony.CO.JP [137.153.0.46])
	by ozlabs.org (Postfix) with ESMTP id 81F6DDDF25
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 11:27:23 +1000 (EST)
Received: from mail3.sony.co.jp (localhost [127.0.0.1])
	by mail3.sony.co.jp (R8/Sony) with ESMTP id l871RLJ1002871
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 10:27:21 +0900 (JST)
Received: from mailgw02.scei.sony.co.jp (mailgw02.scei.sony.co.jp [43.27.73.8])
	by mail3.sony.co.jp (R8/Sony) with SMTP id l871RLqF002859
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 10:27:21 +0900 (JST)
Message-ID: <46E0A8C8.9030505@am.sony.com>
Date: Thu, 06 Sep 2007 18:26:32 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: jk@ozlabs.org
Subject: [patch v2] Cell: Wrap master run control bit
References: <46DD4783.9040103@am.sony.com> <200709050042.13926.arnd@arndb.de>
In-Reply-To: <200709050042.13926.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: Masato Noguchi <Masato.Noguchi@jp.sony.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Subject: Cell: Wrap master run control bit

From: Masato Noguchi <Masato.Noguchi@jp.sony.com>

Add platform specific SPU run control routines to the spufs.  The current
spufs implementation uses the SPU master run control bit (MFC_SR1[S]) to
control SPE execution, but the PS3 hypervisor does not support the use of
this feature.

This change adds the run control wrapper routies spu_enable_spu() and
spu_disable_spu().  The bare metal routines use the master run control
bit, and the PS3 specific routines use the priv2 run control register.

An outstanding enhancement for the PS3 would be to add a guard to check
for incorrect access to the spu problem state when the spu context is
disabled.  This check could be implemented with a flag added to the spu
context that would inhibit mapping problem state pages, and a routine
to unmap spu problem state pages.  When the spu is enabled with
ps3_enable_spu() the flag would be set allowing pages to be mapped,
and when the spu is disabled with ps3_disable_spu() the flag would be
cleared and mapped problem state pages would be unmapped.

Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
v2:
 o Added comments about unmapping PS pages when disabled.

 arch/powerpc/platforms/cell/spu_manage.c        |   15 +++++++++++++
 arch/powerpc/platforms/cell/spufs/backing_ops.c |    6 +++++
 arch/powerpc/platforms/cell/spufs/hw_ops.c      |   10 ++++++++
 arch/powerpc/platforms/cell/spufs/run.c         |    4 +--
 arch/powerpc/platforms/cell/spufs/spufs.h       |    1 
 arch/powerpc/platforms/ps3/spu.c                |   27 ++++++++++++++++++++++++
 include/asm-powerpc/spu_priv1.h                 |   15 +++++++++++++
 7 files changed, 76 insertions(+), 2 deletions(-)

--- a/arch/powerpc/platforms/cell/spu_manage.c
+++ b/arch/powerpc/platforms/cell/spu_manage.c
@@ -35,6 +35,7 @@
 #include <asm/firmware.h>
 #include <asm/prom.h>
 
+#include "spufs/spufs.h"
 #include "interrupt.h"
 
 struct device_node *spu_devnode(struct spu *spu)
@@ -369,6 +370,18 @@ static int of_destroy_spu(struct spu *sp
 	return 0;
 }
 
+static int enable_spu_by_master_run(struct spu_context *ctx)
+{
+	ctx->ops->master_start(ctx);
+	return 0;
+}
+
+static int disable_spu_by_master_run(struct spu_context *ctx)
+{
+	ctx->ops->master_stop(ctx);
+	return 0;
+}
+
 /* Hardcoded affinity idxs for qs20 */
 #define QS20_SPES_PER_BE 8
 static int qs20_reg_idxs[QS20_SPES_PER_BE] =   { 0, 2, 4, 6, 7, 5, 3, 1 };
@@ -535,5 +548,7 @@ const struct spu_management_ops spu_mana
 	.enumerate_spus = of_enumerate_spus,
 	.create_spu = of_create_spu,
 	.destroy_spu = of_destroy_spu,
+	.enable_spu = enable_spu_by_master_run,
+	.disable_spu = disable_spu_by_master_run,
 	.init_affinity = init_affinity,
 };
--- a/arch/powerpc/platforms/cell/spufs/backing_ops.c
+++ b/arch/powerpc/platforms/cell/spufs/backing_ops.c
@@ -285,6 +285,11 @@ static void spu_backing_runcntl_write(st
 	spin_unlock(&ctx->csa.register_lock);
 }
 
+static void spu_backing_runcntl_stop(struct spu_context *ctx)
+{
+	spu_backing_runcntl_write(ctx, SPU_RUNCNTL_STOP);
+}
+
 static void spu_backing_master_start(struct spu_context *ctx)
 {
 	struct spu_state *csa = &ctx->csa;
@@ -381,6 +386,7 @@ struct spu_context_ops spu_backing_ops =
 	.get_ls = spu_backing_get_ls,
 	.runcntl_read = spu_backing_runcntl_read,
 	.runcntl_write = spu_backing_runcntl_write,
+	.runcntl_stop = spu_backing_runcntl_stop,
 	.master_start = spu_backing_master_start,
 	.master_stop = spu_backing_master_stop,
 	.set_mfc_query = spu_backing_set_mfc_query,
--- a/arch/powerpc/platforms/cell/spufs/hw_ops.c
+++ b/arch/powerpc/platforms/cell/spufs/hw_ops.c
@@ -220,6 +220,15 @@ static void spu_hw_runcntl_write(struct 
 	spin_unlock_irq(&ctx->spu->register_lock);
 }
 
+static void spu_hw_runcntl_stop(struct spu_context *ctx)
+{
+	spin_lock_irq(&ctx->spu->register_lock);
+	out_be32(&ctx->spu->problem->spu_runcntl_RW, SPU_RUNCNTL_STOP);
+	while(in_be32(&ctx->spu->problem->spu_status_R) & SPU_STATUS_RUNNING)
+		cpu_relax();
+	spin_unlock_irq(&ctx->spu->register_lock);
+}
+
 static void spu_hw_master_start(struct spu_context *ctx)
 {
 	struct spu *spu = ctx->spu;
@@ -321,6 +330,7 @@ struct spu_context_ops spu_hw_ops = {
 	.get_ls = spu_hw_get_ls,
 	.runcntl_read = spu_hw_runcntl_read,
 	.runcntl_write = spu_hw_runcntl_write,
+	.runcntl_stop = spu_hw_runcntl_stop,
 	.master_start = spu_hw_master_start,
 	.master_stop = spu_hw_master_stop,
 	.set_mfc_query = spu_hw_set_mfc_query,
--- a/arch/powerpc/platforms/cell/spufs/run.c
+++ b/arch/powerpc/platforms/cell/spufs/run.c
@@ -302,7 +302,7 @@ long spufs_run_spu(struct spu_context *c
 	if (mutex_lock_interruptible(&ctx->run_mutex))
 		return -ERESTARTSYS;
 
-	ctx->ops->master_start(ctx);
+	spu_enable_spu(ctx);
 	ctx->event_return = 0;
 
 	spu_acquire(ctx);
@@ -376,7 +376,7 @@ long spufs_run_spu(struct spu_context *c
 		ctx->stats.libassist++;
 
 
-	ctx->ops->master_stop(ctx);
+	spu_disable_spu(ctx);
 	ret = spu_run_fini(ctx, npc, &status);
 	spu_yield(ctx);
 
--- a/arch/powerpc/platforms/cell/spufs/spufs.h
+++ b/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -170,6 +170,7 @@ struct spu_context_ops {
 	char*(*get_ls) (struct spu_context * ctx);
 	 u32 (*runcntl_read) (struct spu_context * ctx);
 	void (*runcntl_write) (struct spu_context * ctx, u32 data);
+	void (*runcntl_stop) (struct spu_context * ctx);
 	void (*master_start) (struct spu_context * ctx);
 	void (*master_stop) (struct spu_context * ctx);
 	int (*set_mfc_query)(struct spu_context * ctx, u32 mask, u32 mode);
--- a/arch/powerpc/platforms/ps3/spu.c
+++ b/arch/powerpc/platforms/ps3/spu.c
@@ -28,6 +28,7 @@
 #include <asm/spu_priv1.h>
 #include <asm/lv1call.h>
 
+#include "../cell/spufs/spufs.h"
 #include "platform.h"
 
 /* spu_management_ops */
@@ -419,10 +420,36 @@ static int ps3_init_affinity(void)
 	return 0;
 }
 
+/**
+ * ps3_enable_spu - Type of spe to create.
+ *
+ * An outstanding enhancement for the PS3 would be to add a guard to check
+ * for incorrect access to the spu problem state when the spu context is
+ * disabled.  This check could be implemented with a flag added to the spu
+ * context that would inhibit mapping problem state pages, and a routine
+ * to unmap spu problem state pages.  When the spu is enabled with
+ * ps3_enable_spu() the flag would be set allowing pages to be mapped,
+ * and when the spu is disabled with ps3_disable_spu() the flag would be
+ * cleared and the mapped problem state pages would be unmapped.
+ */
+
+static int ps3_enable_spu(struct spu_context *ctx)
+{
+	return -ENOSYS;
+}
+
+static int ps3_disable_spu(struct spu_context *ctx)
+{
+	ctx->ops->runcntl_stop(ctx);
+	return -ENOSYS;
+}
+
 const struct spu_management_ops spu_management_ps3_ops = {
 	.enumerate_spus = ps3_enumerate_spus,
 	.create_spu = ps3_create_spu,
 	.destroy_spu = ps3_destroy_spu,
+	.enable_spu = ps3_enable_spu,
+	.disable_spu = ps3_disable_spu,
 	.init_affinity = ps3_init_affinity,
 };
 
--- a/include/asm-powerpc/spu_priv1.h
+++ b/include/asm-powerpc/spu_priv1.h
@@ -24,6 +24,7 @@
 #include <linux/types.h>
 
 struct spu;
+struct spu_context;
 
 /* access to priv1 registers */
 
@@ -178,6 +179,8 @@ struct spu_management_ops {
 	int (*enumerate_spus)(int (*fn)(void *data));
 	int (*create_spu)(struct spu *spu, void *data);
 	int (*destroy_spu)(struct spu *spu);
+	int (*enable_spu)(struct spu_context *ctx);
+	int (*disable_spu)(struct spu_context *ctx);
 	int (*init_affinity)(void);
 };
 
@@ -207,6 +210,18 @@ spu_init_affinity (void)
 	return spu_management_ops->init_affinity();
 }
 
+static inline int
+spu_enable_spu (struct spu_context *ctx)
+{
+	return spu_management_ops->enable_spu(ctx);
+}
+
+static inline int
+spu_disable_spu (struct spu_context *ctx)
+{
+	return spu_management_ops->disable_spu(ctx);
+}
+
 /*
  * The declarations folowing are put here for convenience
  * and only intended to be used by the platform setup code.
