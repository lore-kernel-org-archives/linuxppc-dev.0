Return-Path: <mylinux@10.ap.freescale.net>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe006.messaging.microsoft.com [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 305FFB6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Mar 2012 19:13:16 +1100 (EST)
Received: from mail76-db3 (localhost [127.0.0.1])	by mail76-db3-R.bigfish.com
 (Postfix) with ESMTP id 543E9E0362	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Mar 2012 08:13:09 +0000 (UTC)
Received: from DB3EHSMHS011.bigfish.com (unknown [10.3.81.230])	by
 mail76-db3.bigfish.com (Postfix) with ESMTP id AEA0246004C	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Mar 2012 08:13:06 +0000 (UTC)
Received: from 10.ap.freescale.net ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q298D1EW003377	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Mar 2012 01:13:03 -0700
From: Liu Gang <Gang.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <Alexandre.Bounine@idt.com>
Subject: [PATCH v3] powerpc/srio: Fix the compile errors when building with
 64bit
Date: Fri, 9 Mar 2012 16:10:38 +0800
Message-ID: <1331280638-23525-1-git-send-email-Gang.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: r58472@freescale.com, linux-kernel@vger.kernel.org, r61911@freescale.com,
 paul.gortmaker@windriver.com, Liu Gang <Gang.Liu@freescale.com>,
 akpm@linux-foundation.org, Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For the file "arch/powerpc/sysdev/fsl_rmu.c", there will be some compile
errors while using the corenet64_smp_defconfig:

.../fsl_rmu.c:315: error: cast from pointer to integer of different size
.../fsl_rmu.c:320: error: cast to pointer from integer of different size
.../fsl_rmu.c:320: error: cast to pointer from integer of different size
.../fsl_rmu.c:320: error: cast to pointer from integer of different size
.../fsl_rmu.c:330: error: cast to pointer from integer of different size
.../fsl_rmu.c:332: error: cast to pointer from integer of different size
.../fsl_rmu.c:339: error: cast to pointer from integer of different size
.../fsl_rmu.c:340: error: cast to pointer from integer of different size
.../fsl_rmu.c:341: error: cast to pointer from integer of different size
.../fsl_rmu.c:348: error: cast to pointer from integer of different size
.../fsl_rmu.c:348: error: cast to pointer from integer of different size
.../fsl_rmu.c:348: error: cast to pointer from integer of different size
.../fsl_rmu.c:659: error: cast from pointer to integer of different size
.../fsl_rmu.c:659: error: format '%8.8x' expects type 'unsigned int',
                   but argument 5 has type 'size_t'
.../fsl_rmu.c:985: error: cast from pointer to integer of different size
.../fsl_rmu.c:997: error: cast to pointer from integer of different size

Rewrote the corresponding code with the support of 64bit building.

Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
Changes in v2:
 - Add the struct "rio_dbell_msg" to instead of some DBELL_* macros.
 - Change the "virt_buf" to be "void *" type.
 - Change "Signed-off-by" to "Reported-by" for Paul.

Changes in v3:
 - Change the "%8.8lx" to be "%p" and remove the cast of the "buffer"

 arch/powerpc/sysdev/fsl_rmu.c |   42 +++++++++++++++++++++-------------------
 1 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rmu.c b/arch/powerpc/sysdev/fsl_rmu.c
index 1548578..14bd522 100644
--- a/arch/powerpc/sysdev/fsl_rmu.c
+++ b/arch/powerpc/sysdev/fsl_rmu.c
@@ -100,14 +100,8 @@
 #define DOORBELL_DSR_TE		0x00000080
 #define DOORBELL_DSR_QFI	0x00000010
 #define DOORBELL_DSR_DIQI	0x00000001
-#define DOORBELL_TID_OFFSET	0x02
-#define DOORBELL_SID_OFFSET	0x04
-#define DOORBELL_INFO_OFFSET	0x06
 
 #define DOORBELL_MESSAGE_SIZE	0x08
-#define DBELL_SID(x)		(*(u16 *)(x + DOORBELL_SID_OFFSET))
-#define DBELL_TID(x)		(*(u16 *)(x + DOORBELL_TID_OFFSET))
-#define DBELL_INF(x)		(*(u16 *)(x + DOORBELL_INFO_OFFSET))
 
 struct rio_msg_regs {
 	u32 omr;
@@ -193,6 +187,13 @@ struct fsl_rmu {
 	int rxirq;
 };
 
+struct rio_dbell_msg {
+	u16 pad1;
+	u16 tid;
+	u16 sid;
+	u16 info;
+};
+
 /**
  * fsl_rio_tx_handler - MPC85xx outbound message interrupt handler
  * @irq: Linux interrupt number
@@ -311,8 +312,8 @@ fsl_rio_dbell_handler(int irq, void *dev_instance)
 
 	/* XXX Need to check/dispatch until queue empty */
 	if (dsr & DOORBELL_DSR_DIQI) {
-		u32 dmsg =
-			(u32) fsl_dbell->dbell_ring.virt +
+		struct rio_dbell_msg *dmsg =
+			fsl_dbell->dbell_ring.virt +
 			(in_be32(&fsl_dbell->dbell_regs->dqdpar) & 0xfff);
 		struct rio_dbell *dbell;
 		int found = 0;
@@ -320,25 +321,25 @@ fsl_rio_dbell_handler(int irq, void *dev_instance)
 		pr_debug
 			("RIO: processing doorbell,"
 			" sid %2.2x tid %2.2x info %4.4x\n",
-			DBELL_SID(dmsg), DBELL_TID(dmsg), DBELL_INF(dmsg));
+			dmsg->sid, dmsg->tid, dmsg->info);
 
 		for (i = 0; i < MAX_PORT_NUM; i++) {
 			if (fsl_dbell->mport[i]) {
 				list_for_each_entry(dbell,
 					&fsl_dbell->mport[i]->dbells, node) {
 					if ((dbell->res->start
-						<= DBELL_INF(dmsg))
+						<= dmsg->info)
 						&& (dbell->res->end
-						>= DBELL_INF(dmsg))) {
+						>= dmsg->info)) {
 						found = 1;
 						break;
 					}
 				}
 				if (found && dbell->dinb) {
 					dbell->dinb(fsl_dbell->mport[i],
-						dbell->dev_id, DBELL_SID(dmsg),
-						DBELL_TID(dmsg),
-						DBELL_INF(dmsg));
+						dbell->dev_id, dmsg->sid,
+						dmsg->tid,
+						dmsg->info);
 					break;
 				}
 			}
@@ -348,8 +349,8 @@ fsl_rio_dbell_handler(int irq, void *dev_instance)
 			pr_debug
 				("RIO: spurious doorbell,"
 				" sid %2.2x tid %2.2x info %4.4x\n",
-				DBELL_SID(dmsg), DBELL_TID(dmsg),
-				DBELL_INF(dmsg));
+				dmsg->sid, dmsg->tid,
+				dmsg->info);
 		}
 		setbits32(&fsl_dbell->dbell_regs->dmr, DOORBELL_DMR_DI);
 		out_be32(&fsl_dbell->dbell_regs->dsr, DOORBELL_DSR_DIQI);
@@ -657,7 +658,7 @@ fsl_add_outb_message(struct rio_mport *mport, struct rio_dev *rdev, int mbox,
 	int ret = 0;
 
 	pr_debug("RIO: fsl_add_outb_message(): destid %4.4x mbox %d buffer " \
-		 "%8.8x len %8.8x\n", rdev->destid, mbox, (int)buffer, len);
+		 "%p len %8.8zx\n", rdev->destid, mbox, buffer, len);
 	if ((len < 8) || (len > RIO_MAX_MSG_SIZE)) {
 		ret = -EINVAL;
 		goto out;
@@ -972,7 +973,8 @@ out:
 void *fsl_get_inb_message(struct rio_mport *mport, int mbox)
 {
 	struct fsl_rmu *rmu = GET_RMM_HANDLE(mport);
-	u32 phys_buf, virt_buf;
+	u32 phys_buf;
+	void *virt_buf;
 	void *buf = NULL;
 	int buf_idx;
 
@@ -982,7 +984,7 @@ void *fsl_get_inb_message(struct rio_mport *mport, int mbox)
 	if (phys_buf == in_be32(&rmu->msg_regs->ifqepar))
 		goto out2;
 
-	virt_buf = (u32) rmu->msg_rx_ring.virt + (phys_buf
+	virt_buf = rmu->msg_rx_ring.virt + (phys_buf
 						- rmu->msg_rx_ring.phys);
 	buf_idx = (phys_buf - rmu->msg_rx_ring.phys) / RIO_MAX_MSG_SIZE;
 	buf = rmu->msg_rx_ring.virt_buffer[buf_idx];
@@ -994,7 +996,7 @@ void *fsl_get_inb_message(struct rio_mport *mport, int mbox)
 	}
 
 	/* Copy max message size, caller is expected to allocate that big */
-	memcpy(buf, (void *)virt_buf, RIO_MAX_MSG_SIZE);
+	memcpy(buf, virt_buf, RIO_MAX_MSG_SIZE);
 
 	/* Clear the available buffer */
 	rmu->msg_rx_ring.virt_buffer[buf_idx] = NULL;
-- 
1.7.0.4
