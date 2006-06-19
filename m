Return-Path: <arnd@arndb.de>
Message-Id: <20060619183405.554656000@klappe.arndb.de>
References: <20060619183315.653672000@klappe.arndb.de>
Date: Mon, 19 Jun 2006 20:33:26 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 11/20] spufs: use kzalloc in create_spu
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jeremy Kerr <jk@ozlabs.org>

Clean up create_spu() a little by using kzalloc instead of kmalloc +
assignments.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

 arch/powerpc/platforms/cell/spu_base.c |   17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

Index: powerpc.git/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spu_base.c
+++ powerpc.git/arch/powerpc/platforms/cell/spu_base.c
@@ -701,7 +701,7 @@ static int __init create_spu(struct devi
 	static int number;
 
 	ret = -ENOMEM;
-	spu = kmalloc(sizeof (*spu), GFP_KERNEL);
+	spu = kzalloc(sizeof (*spu), GFP_KERNEL);
 	if (!spu)
 		goto out;
 
@@ -713,28 +713,11 @@ static int __init create_spu(struct devi
 	spu->nid = of_node_to_nid(spe);
 	if (spu->nid == -1)
 		spu->nid = 0;
-
-	spu->stop_code = 0;
-	spu->slb_replace = 0;
-	spu->mm = NULL;
-	spu->ctx = NULL;
-	spu->rq = NULL;
-	spu->pid = 0;
-	spu->class_0_pending = 0;
-	spu->flags = 0UL;
-	spu->dar = 0UL;
-	spu->dsisr = 0UL;
 	spin_lock_init(&spu->register_lock);
-
 	spu_mfc_sdr_set(spu, mfspr(SPRN_SDR1));
 	spu_mfc_sr1_set(spu, 0x33);
-
-	spu->ibox_callback = NULL;
-	spu->wbox_callback = NULL;
-	spu->stop_callback = NULL;
-	spu->mfc_callback = NULL;
-
 	mutex_lock(&spu_mutex);
+
 	spu->number = number++;
 	ret = spu_request_irqs(spu);
 	if (ret)

--
