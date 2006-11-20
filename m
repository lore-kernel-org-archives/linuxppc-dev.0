Return-Path: <arnd@arndb.de>
Message-Id: <20061120180525.851134000@arndb.de>
References: <20061120174454.067872000@arndb.de>
Date: Mon, 20 Nov 2006 18:45:09 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: [PATCH 15/22] spufs: Add runcntrl read accessors
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jeremy Kerr <jeremy@au1.ibm.com>
This change adds a read accessor for the SPE problem-state run control
register.

This is required for for applying (userspace) changes made to the run
control register while the SPE is stopped - simply asserting the master
run control bit is not sufficient. My next patch for isolated-mode
setup requires this.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

 arch/powerpc/platforms/cell/spufs/backing_ops.c |    6 ++++++
 arch/powerpc/platforms/cell/spufs/hw_ops.c      |    6 ++++++
 arch/powerpc/platforms/cell/spufs/spufs.h       |    1 +
 3 files changed, 13 insertions(+)
 
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/backing_ops.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/backing_ops.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/backing_ops.c
@@ -268,6 +268,11 @@ static char *spu_backing_get_ls(struct s
 	return ctx->csa.lscsa->ls;
 }
 
+static u32 spu_backing_runcntl_read(struct spu_context *ctx)
+{
+	return ctx->csa.prob.spu_runcntl_RW;
+}
+
 static void spu_backing_runcntl_write(struct spu_context *ctx, u32 val)
 {
 	spin_lock(&ctx->csa.register_lock);
@@ -363,6 +368,7 @@ struct spu_context_ops spu_backing_ops =
 	.npc_write = spu_backing_npc_write,
 	.status_read = spu_backing_status_read,
 	.get_ls = spu_backing_get_ls,
+	.runcntl_read = spu_backing_runcntl_read,
 	.runcntl_write = spu_backing_runcntl_write,
 	.master_start = spu_backing_master_start,
 	.master_stop = spu_backing_master_stop,
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/hw_ops.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/hw_ops.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/hw_ops.c
@@ -207,6 +207,11 @@ static char *spu_hw_get_ls(struct spu_co
 	return ctx->spu->local_store;
 }
 
+static u32 spu_hw_runcntl_read(struct spu_context *ctx)
+{
+	return in_be32(&ctx->spu->problem->spu_runcntl_RW);
+}
+
 static void spu_hw_runcntl_write(struct spu_context *ctx, u32 val)
 {
 	spin_lock_irq(&ctx->spu->register_lock);
@@ -307,6 +312,7 @@ struct spu_context_ops spu_hw_ops = {
 	.npc_write = spu_hw_npc_write,
 	.status_read = spu_hw_status_read,
 	.get_ls = spu_hw_get_ls,
+	.runcntl_read = spu_hw_runcntl_read,
 	.runcntl_write = spu_hw_runcntl_write,
 	.master_start = spu_hw_master_start,
 	.master_stop = spu_hw_master_stop,
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/spufs.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/spufs.h
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -115,6 +115,7 @@ struct spu_context_ops {
 	void (*npc_write) (struct spu_context * ctx, u32 data);
 	 u32(*status_read) (struct spu_context * ctx);
 	char*(*get_ls) (struct spu_context * ctx);
+	 u32 (*runcntl_read) (struct spu_context * ctx);
 	void (*runcntl_write) (struct spu_context * ctx, u32 data);
 	void (*master_start) (struct spu_context * ctx);
 	void (*master_stop) (struct spu_context * ctx);

--
