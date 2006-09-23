Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0F44067BBE
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Sep 2006 10:37:46 +1000 (EST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat
	Linux)) id 1GQvWX-0002eA-Pm
	for linuxppc-dev@ozlabs.org; Sat, 23 Sep 2006 01:37:41 +0100
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] cell spufs iomem annotations
Message-Id: <E1GQvWX-0002eA-Pm@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Sat, 23 Sep 2006 01:37:41 +0100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/platforms/cell/spu_base.c     |    4 ++--
 arch/powerpc/platforms/cell/spufs/hw_ops.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
index d06042d..20f74e7 100644
--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -538,7 +538,7 @@ static void __iomem * __init map_spe_pro
 
 	void *p;
 	int proplen;
-	void* ret = NULL;
+	void __iomem *ret = NULL;
 	int err = 0;
 
 	p = get_property(n, name, &proplen);
@@ -562,7 +562,7 @@ static void spu_unmap(struct spu *spu)
 	iounmap(spu->priv2);
 	iounmap(spu->priv1);
 	iounmap(spu->problem);
-	iounmap((u8 __iomem *)spu->local_store);
+	iounmap((__force u8 __iomem *)spu->local_store);
 }
 
 /* This function shall be abstracted for HV platforms */
diff --git a/arch/powerpc/platforms/cell/spufs/hw_ops.c b/arch/powerpc/platforms/cell/spufs/hw_ops.c
index c8670f5..efc452e 100644
--- a/arch/powerpc/platforms/cell/spufs/hw_ops.c
+++ b/arch/powerpc/platforms/cell/spufs/hw_ops.c
@@ -234,7 +234,7 @@ static void spu_hw_runcntl_stop(struct s
 
 static int spu_hw_set_mfc_query(struct spu_context * ctx, u32 mask, u32 mode)
 {
-	struct spu_problem *prob = ctx->spu->problem;
+	struct spu_problem __iomem *prob = ctx->spu->problem;
 	int ret;
 
 	spin_lock_irq(&ctx->spu->register_lock);
@@ -263,7 +263,7 @@ static int spu_hw_send_mfc_command(struc
 					struct mfc_dma_command *cmd)
 {
 	u32 status;
-	struct spu_problem *prob = ctx->spu->problem;
+	struct spu_problem __iomem *prob = ctx->spu->problem;
 
 	spin_lock_irq(&ctx->spu->register_lock);
 	out_be32(&prob->mfc_lsa_W, cmd->lsa);
-- 
1.4.2.GIT
