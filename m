Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <46F6D188.7090201@am.sony.com>
Date: Sun, 23 Sep 2007 13:50:16 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: jk@ozlabs.org
Subject: [patch v3] Cell: Wrap master run control bit
References: <46DD4783.9040103@am.sony.com>
In-Reply-To: <46DD4783.9040103@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: Masato Noguchi <Masato.Noguchi@jp.sony.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Arnd Bergmann <arnd@arndb.de>
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

Jeremy,

Here is an updated version for 2.6.24.  Noguchi-san will
work on the LS unmapping feature for 2.6.25.

-Geoff

v2:
 o Added comments about unmapping PS pages when disabled.
v3:
 o Changed routines to return void instead of int.
 o Rebased to apply to Jeremy's 2.6.23-rc work-around.

 arch/powerpc/platforms/cell/spu_manage.c        |   13 +++++++++++
 arch/powerpc/platforms/cell/spufs/backing_ops.c |    6 +++++
 arch/powerpc/platforms/cell/spufs/hw_ops.c      |   10 ++++++++
 arch/powerpc/platforms/cell/spufs/run.c         |    4 +--
 arch/powerpc/platforms/cell/spufs/spufs.h       |    1 
 arch/powerpc/platforms/ps3/spu.c                |   27 ++++++++++++++++++++++--
 include/asm-powerpc/spu_priv1.h                 |   15 +++++++++++++
 7 files changed, 72 insertions(+), 4 deletions(-)

--- a/arch/powerpc/platforms/cell/spu_manage.c
+++ b/arch/powerpc/platforms/cell/spu_manage.c
@@ -35,6 +35,7 @@
 #include <asm/firmware.h>
 #include <asm/prom.h>
 
+#include "spufs/spufs.h"
 #include "interrupt.h"
 
 struct device_node *spu_devnode(struct spu *spu)
@@ -369,6 +370,16 @@ static int of_destroy_spu(struct spu *sp
 	return 0;
 }
 
+static void enable_spu_by_master_run(struct spu_context *ctx)
+{
+	ctx->ops->master_start(ctx);
+}
+
+static void disable_spu_by_master_run(struct spu_context *ctx)
+{
+	ctx->ops->master_stop(ctx);
+}
+
 /* Hardcoded affinity idxs for qs20 */
 #define QS20_SPES_PER_BE 8
 static int qs20_reg_idxs[QS20_SPES_PER_BE] =   { 0, 2, 4, 6, 7, 5, 3, 1 };
@@ -535,5 +546,7 @@ const struct spu_management_ops spu_mana
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
+	while (in_be32(&ctx->spu->problem->spu_status_R) & SPU_STATUS_RUNNING)
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
@@ -419,10 +420,34 @@ static int ps3_init_affinity(void)
 	return 0;
 }
 
+/**
+ * ps3_enable_spu - Enable SPU run control.
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
+static void ps3_enable_spu(struct spu_context *ctx)
+{
+}
+
+static void ps3_disable_spu(struct spu_context *ctx)
+{
+	ctx->ops->runcntl_stop(ctx);
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
 
@@ -505,8 +530,6 @@ static void mfc_sr1_set(struct spu *spu,
 	static const u64 allowed = ~(MFC_STATE1_LOCAL_STORAGE_DECODE_MASK
 		| MFC_STATE1_PROBLEM_STATE_MASK);
 
-	sr1 |= MFC_STATE1_MASTER_RUN_CONTROL_MASK;
-
 	BUG_ON((sr1 & allowed) != (spu_pdata(spu)->cache.sr1 & allowed));
 
 	spu_pdata(spu)->cache.sr1 = sr1;
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
+	void (*enable_spu)(struct spu_context *ctx);
+	void (*disable_spu)(struct spu_context *ctx);
 	int (*init_affinity)(void);
 };
 
@@ -207,6 +210,18 @@ spu_init_affinity (void)
 	return spu_management_ops->init_affinity();
 }
 
+static inline void
+spu_enable_spu (struct spu_context *ctx)
+{
+	spu_management_ops->enable_spu(ctx);
+}
+
+static inline void
+spu_disable_spu (struct spu_context *ctx)
+{
+	spu_management_ops->disable_spu(ctx);
+}
+
 /*
  * The declarations folowing are put here for convenience
  * and only intended to be used by the platform setup code.
