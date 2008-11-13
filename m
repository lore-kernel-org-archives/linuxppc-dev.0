Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.230])
	by ozlabs.org (Postfix) with ESMTP id 73D91DDFB3
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 12:08:53 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so676800rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 17:08:51 -0800 (PST)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/2] powerpc/mpc5200: Bestcomm fixes to ATA support
To: plasm@roo.me.uk, matt@genesi-usa.com, hans.lehmann@ritter-elektronik.de,
	linux-ide@vger.kernel.ort, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
Date: Wed, 12 Nov 2008 18:08:48 -0700
Message-ID: <20081113010841.464.48441.stgit@localhost.localdomain>
In-Reply-To: <20081113010438.464.23602.stgit@localhost.localdomain>
References: <20081113010438.464.23602.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: Grant Likely <glikely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Tim Yamin <plasm@roo.me.uk>

1) ata.h has dst_pa in the wrong place (needs to match what the BestComm
   task microcode in bcom_ata_task.c expects); fix it.

2) The BestComm ATA task priority was changed to maximum in bestcomm_priv.h;
   this fixes a deadlock issue I was experiencing when heavy DMA was
   occuring on both the ATA and Ethernet BestComm tasks, e.g. when
   downloading a large file over a LAN to disk.

3) The ATA BestComm driver uses bcom_ata_bd which is bigger than bcom_bd
   and this causes problems because the various bcom_... functions do not
   dereference the correct location. I've introduced bcom_get_bd which
   uses bcom_task.bd_size and this fixes the problem.

Signed-off-by: Tim Yamin <plasm@roo.me.uk>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/sysdev/bestcomm/ata.h           |    2 +
 arch/powerpc/sysdev/bestcomm/bestcomm.h      |   35 +++++++++++++++++++++-----
 arch/powerpc/sysdev/bestcomm/bestcomm_priv.h |    4 +--
 3 files changed, 31 insertions(+), 10 deletions(-)


diff --git a/arch/powerpc/sysdev/bestcomm/ata.h b/arch/powerpc/sysdev/bestcomm/ata.h
index 1098276..0374322 100644
--- a/arch/powerpc/sysdev/bestcomm/ata.h
+++ b/arch/powerpc/sysdev/bestcomm/ata.h
@@ -16,8 +16,8 @@
 
 struct bcom_ata_bd {
 	u32	status;
-	u32	dst_pa;
 	u32	src_pa;
+	u32	dst_pa;
 };
 
 extern struct bcom_task *
diff --git a/arch/powerpc/sysdev/bestcomm/bestcomm.h b/arch/powerpc/sysdev/bestcomm/bestcomm.h
index c960a8b..dc2b143 100644
--- a/arch/powerpc/sysdev/bestcomm/bestcomm.h
+++ b/arch/powerpc/sysdev/bestcomm/bestcomm.h
@@ -38,7 +38,7 @@ struct bcom_task {
 	unsigned int	flags;
 	int		irq;
 
-	struct bcom_bd	*bd;
+	void		*bd;
 	phys_addr_t	bd_pa;
 	void		**cookie;
 	unsigned short	index;
@@ -140,15 +140,29 @@ bcom_queue_full(struct bcom_task *tsk)
 }
 
 /**
+ * bcom_get_bd - Get a BD from the queue
+ * @tsk: The BestComm task structure
+ * index: Index of the BD to fetch
+ */
+static inline struct bcom_bd
+*bcom_get_bd(struct bcom_task *tsk, unsigned int index)
+{
+	return tsk->bd + index * tsk->bd_size;
+}
+
+/**
  * bcom_buffer_done - Checks if a BestComm 
  * @tsk: The BestComm task structure
  */
 static inline int
 bcom_buffer_done(struct bcom_task *tsk)
 {
+	struct bcom_bd *bd;
 	if (bcom_queue_empty(tsk))
 		return 0;
-	return !(tsk->bd[tsk->outdex].status & BCOM_BD_READY);
+
+	bd = bcom_get_bd(tsk, tsk->outdex);
+	return !(bd->status & BCOM_BD_READY);
 }
 
 /**
@@ -160,16 +174,21 @@ bcom_buffer_done(struct bcom_task *tsk)
 static inline struct bcom_bd *
 bcom_prepare_next_buffer(struct bcom_task *tsk)
 {
-	tsk->bd[tsk->index].status = 0;	/* cleanup last status */
-	return &tsk->bd[tsk->index];
+	struct bcom_bd *bd;
+
+	bd = bcom_get_bd(tsk, tsk->index);
+	bd->status = 0;	/* cleanup last status */
+	return bd;
 }
 
 static inline void
 bcom_submit_next_buffer(struct bcom_task *tsk, void *cookie)
 {
+	struct bcom_bd *bd = bcom_get_bd(tsk, tsk->index);
+
 	tsk->cookie[tsk->index] = cookie;
 	mb();	/* ensure the bd is really up-to-date */
-	tsk->bd[tsk->index].status |= BCOM_BD_READY;
+	bd->status |= BCOM_BD_READY;
 	tsk->index = _bcom_next_index(tsk);
 	if (tsk->flags & BCOM_FLAGS_ENABLE_TASK)
 		bcom_enable(tsk);
@@ -179,10 +198,12 @@ static inline void *
 bcom_retrieve_buffer(struct bcom_task *tsk, u32 *p_status, struct bcom_bd **p_bd)
 {
 	void *cookie = tsk->cookie[tsk->outdex];
+	struct bcom_bd *bd = bcom_get_bd(tsk, tsk->outdex);
+
 	if (p_status)
-		*p_status = tsk->bd[tsk->outdex].status;
+		*p_status = bd->status;
 	if (p_bd)
-		*p_bd = &tsk->bd[tsk->outdex];
+		*p_bd = bd;
 	tsk->outdex = _bcom_next_outdex(tsk);
 	return cookie;
 }
diff --git a/arch/powerpc/sysdev/bestcomm/bestcomm_priv.h b/arch/powerpc/sysdev/bestcomm/bestcomm_priv.h
index 866a291..746f155 100644
--- a/arch/powerpc/sysdev/bestcomm/bestcomm_priv.h
+++ b/arch/powerpc/sysdev/bestcomm/bestcomm_priv.h
@@ -198,8 +198,8 @@ struct bcom_task_header {
 #define BCOM_IPR_SCTMR_1	2
 #define BCOM_IPR_FEC_RX		6
 #define BCOM_IPR_FEC_TX		5
-#define BCOM_IPR_ATA_RX		4
-#define BCOM_IPR_ATA_TX		3
+#define BCOM_IPR_ATA_RX		7
+#define BCOM_IPR_ATA_TX		7
 #define BCOM_IPR_SCPCI_RX	2
 #define BCOM_IPR_SCPCI_TX	2
 #define BCOM_IPR_PSC3_RX	2
