Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.231])
	by ozlabs.org (Postfix) with ESMTP id 898A7DDF0C
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Dec 2008 19:06:34 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2289593rvb.9
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Dec 2008 00:06:34 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 3/4] powerpc/mpc5200: Disable bestcomm prefetching when ATA
	DMA enabled
To: linuxppc-dev@ozlabs.org, hans.lehmann@ritter-elektronik.de,
	matt@genesi-usa.com, olaf@aepfle.de
Date: Sun, 21 Dec 2008 01:06:30 -0700
Message-ID: <20081221080630.29029.51667.stgit@localhost.localdomain>
In-Reply-To: <20081221080213.29029.7646.stgit@localhost.localdomain>
References: <20081221080213.29029.7646.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

When ATA DMA is enabled, bestcomm prefetching does not work.  This
patch adds a function to disable bestcomm prefetch when the ATA
Bestcomm task is initialized.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/sysdev/bestcomm/ata.c           |    3 +++
 arch/powerpc/sysdev/bestcomm/bestcomm.c      |    7 ++-----
 arch/powerpc/sysdev/bestcomm/bestcomm_priv.h |   16 ++++++++++++++++
 3 files changed, 21 insertions(+), 5 deletions(-)


diff --git a/arch/powerpc/sysdev/bestcomm/ata.c b/arch/powerpc/sysdev/bestcomm/ata.c
index 1f5258f..901c9f9 100644
--- a/arch/powerpc/sysdev/bestcomm/ata.c
+++ b/arch/powerpc/sysdev/bestcomm/ata.c
@@ -61,6 +61,9 @@ bcom_ata_init(int queue_len, int maxbufsize)
 	struct bcom_ata_var *var;
 	struct bcom_ata_inc *inc;
 
+	/* Prefetch breaks ATA DMA.  Turn it off for ATA DMA */
+	bcom_disable_prefetch();
+
 	tsk = bcom_task_alloc(queue_len, sizeof(struct bcom_ata_bd), 0);
 	if (!tsk)
 		return NULL;
diff --git a/arch/powerpc/sysdev/bestcomm/bestcomm.c b/arch/powerpc/sysdev/bestcomm/bestcomm.c
index 446c9ea..378ebd9 100644
--- a/arch/powerpc/sysdev/bestcomm/bestcomm.c
+++ b/arch/powerpc/sysdev/bestcomm/bestcomm.c
@@ -279,7 +279,6 @@ bcom_engine_init(void)
 	int task;
 	phys_addr_t tdt_pa, ctx_pa, var_pa, fdt_pa;
 	unsigned int tdt_size, ctx_size, var_size, fdt_size;
-	u16 regval;
 
 	/* Allocate & clear SRAM zones for FDT, TDTs, contexts and vars/incs */
 	tdt_size = BCOM_MAX_TASKS * sizeof(struct bcom_tdt);
@@ -331,10 +330,8 @@ bcom_engine_init(void)
 	out_8(&bcom_eng->regs->ipr[BCOM_INITIATOR_ALWAYS], BCOM_IPR_ALWAYS);
 
 	/* Disable COMM Bus Prefetch on the original 5200; it's broken */
-	if ((mfspr(SPRN_SVR) & MPC5200_SVR_MASK) == MPC5200_SVR) {
-		regval = in_be16(&bcom_eng->regs->PtdCntrl);
-		out_be16(&bcom_eng->regs->PtdCntrl,  regval | 1);
-	}
+	if ((mfspr(SPRN_SVR) & MPC5200_SVR_MASK) == MPC5200_SVR)
+		bcom_disable_prefetch();
 
 	/* Init lock */
 	spin_lock_init(&bcom_eng->lock);
diff --git a/arch/powerpc/sysdev/bestcomm/bestcomm_priv.h b/arch/powerpc/sysdev/bestcomm/bestcomm_priv.h
index 746f155..eb0d1c8 100644
--- a/arch/powerpc/sysdev/bestcomm/bestcomm_priv.h
+++ b/arch/powerpc/sysdev/bestcomm/bestcomm_priv.h
@@ -241,6 +241,22 @@ extern void bcom_set_initiator(int task, int initiator);
 
 #define TASK_ENABLE             0x8000
 
+/**
+ * bcom_disable_prefetch - Hook to disable bus prefetching
+ *
+ * ATA DMA and the original MPC5200 need this due to silicon bugs.  At the
+ * moment disabling prefetch is a one-way street.  There is no mechanism
+ * in place to turn prefetch back on after it has been disabled.  There is
+ * no reason it couldn't be done, it would just be more complex to implement.
+ */
+static inline void bcom_disable_prefetch(void)
+{
+	u16 regval;
+
+	regval = in_be16(&bcom_eng->regs->PtdCntrl);
+	out_be16(&bcom_eng->regs->PtdCntrl, regval | 1);
+};
+
 static inline void
 bcom_enable_task(int task)
 {
