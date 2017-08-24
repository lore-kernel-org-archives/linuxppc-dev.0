Return-Path: <ioan.nicu.ext@nokia.com>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0130.outbound.protection.outlook.com [104.47.0.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdMY973rdzDqm8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 21:30:37 +1000 (AEST)
Date: Thu, 24 Aug 2017 13:30:24 +0200
From: Ioan Nicu <ioan.nicu.ext@nokia.com>
To: Matt Porter <mporter@kernel.crashing.org>,
 Alexandre Bounine <alexandre.bounine@idt.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Frank Kunz <frank.kunz@nokia.com>,
 Ioan Nicu <ioan.nicu.ext@nokia.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] rapidio: remove global irq spinlocks from the subsystem
Message-ID: <20170824113023.GD50104@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Locking of config and doorbell operations should be done
only if the underlying hardware requires it.

This patch removes the global spinlocks from the rapidio
subsystem and moves them to the mport drivers (fsl_rio and tsi721),
only to the necessary places. For example, local config space
read and write operations (lcread/lcwrite) are atomic in all
existing drivers, so there should be no need for locking, while
the cread/cwrite operations which generate maintenance transactions
need to be synchronized with a lock.

Later, each driver could chose to use a per-port lock instead
of a global one, or even more granular locking.

Signed-off-by: Ioan Nicu <ioan.nicu.ext@nokia.com>
Signed-off-by: Frank Kunz <frank.kunz@nokia.com>
---
 arch/powerpc/sysdev/fsl_rio.c    | 17 +++++++++++++++--
 arch/powerpc/sysdev/fsl_rmu.c    |  8 ++++++++
 drivers/rapidio/devices/tsi721.c |  7 +++++++
 drivers/rapidio/rio-access.c     | 40 +++++-----------------------------------
 4 files changed, 35 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index 1c41c51..e9f3bc9 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -71,6 +71,8 @@
 #define RIWAR_WRTYP_ALLOC	0x00006000
 #define RIWAR_SIZE_MASK		0x0000003F
 
+static DEFINE_SPINLOCK(fsl_rio_config_lock);
+
 #define __fsl_read_rio_config(x, addr, err, op)		\
 	__asm__ __volatile__(				\
 		"1:	"op" %1,0(%2)\n"		\
@@ -184,6 +186,7 @@ static int fsl_local_config_write(struct rio_mport *mport,
 			u8 hopcount, u32 offset, int len, u32 *val)
 {
 	struct rio_priv *priv = mport->priv;
+	unsigned long flags;
 	u8 *data;
 	u32 rval, err = 0;
 
@@ -197,6 +200,8 @@ static int fsl_local_config_write(struct rio_mport *mport,
 	if (offset > (0x1000000 - len) || !IS_ALIGNED(offset, len))
 		return -EINVAL;
 
+	spin_lock_irqsave(&fsl_rio_config_lock, flags);
+
 	out_be32(&priv->maint_atmu_regs->rowtar,
 		 (destid << 22) | (hopcount << 12) | (offset >> 12));
 	out_be32(&priv->maint_atmu_regs->rowtear, (destid >> 10));
@@ -213,6 +218,7 @@ static int fsl_local_config_write(struct rio_mport *mport,
 		__fsl_read_rio_config(rval, data, err, "lwz");
 		break;
 	default:
+		spin_unlock_irqrestore(&fsl_rio_config_lock, flags);
 		return -EINVAL;
 	}
 
@@ -221,6 +227,7 @@ static int fsl_local_config_write(struct rio_mport *mport,
 			 err, destid, hopcount, offset);
 	}
 
+	spin_unlock_irqrestore(&fsl_rio_config_lock, flags);
 	*val = rval;
 
 	return err;
@@ -244,7 +251,10 @@ static int fsl_local_config_write(struct rio_mport *mport,
 			u8 hopcount, u32 offset, int len, u32 val)
 {
 	struct rio_priv *priv = mport->priv;
+	unsigned long flags;
 	u8 *data;
+	int ret = 0;
+
 	pr_debug
 		("fsl_rio_config_write:"
 		" index %d destid %d hopcount %d offset %8.8x len %d val %8.8x\n",
@@ -255,6 +265,8 @@ static int fsl_local_config_write(struct rio_mport *mport,
 	if (offset > (0x1000000 - len) || !IS_ALIGNED(offset, len))
 		return -EINVAL;
 
+	spin_lock_irqsave(&fsl_rio_config_lock, flags);
+
 	out_be32(&priv->maint_atmu_regs->rowtar,
 		 (destid << 22) | (hopcount << 12) | (offset >> 12));
 	out_be32(&priv->maint_atmu_regs->rowtear, (destid >> 10));
@@ -271,10 +283,11 @@ static int fsl_local_config_write(struct rio_mport *mport,
 		out_be32((u32 *) data, val);
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+	spin_unlock_irqrestore(&fsl_rio_config_lock, flags);
 
-	return 0;
+	return ret;
 }
 
 static void fsl_rio_inbound_mem_init(struct rio_priv *priv)
diff --git a/arch/powerpc/sysdev/fsl_rmu.c b/arch/powerpc/sysdev/fsl_rmu.c
index c1826de..c15a17a 100644
--- a/arch/powerpc/sysdev/fsl_rmu.c
+++ b/arch/powerpc/sysdev/fsl_rmu.c
@@ -104,6 +104,8 @@
 
 #define DOORBELL_MESSAGE_SIZE	0x08
 
+static DEFINE_SPINLOCK(fsl_rio_doorbell_lock);
+
 struct rio_msg_regs {
 	u32 omr;
 	u32 osr;
@@ -626,9 +628,13 @@ int fsl_rio_port_write_init(struct fsl_rio_pw *pw)
 int fsl_rio_doorbell_send(struct rio_mport *mport,
 				int index, u16 destid, u16 data)
 {
+	unsigned long flags;
+
 	pr_debug("fsl_doorbell_send: index %d destid %4.4x data %4.4x\n",
 		 index, destid, data);
 
+	spin_lock_irqsave(&fsl_rio_doorbell_lock, flags);
+
 	/* In the serial version silicons, such as MPC8548, MPC8641,
 	 * below operations is must be.
 	 */
@@ -638,6 +644,8 @@ int fsl_rio_doorbell_send(struct rio_mport *mport,
 	out_be32(&dbell->dbell_regs->oddatr, (index << 20) | data);
 	out_be32(&dbell->dbell_regs->odmr, 0x00000001);
 
+	spin_unlock_irqrestore(&fsl_rio_doorbell_lock, flags);
+
 	return 0;
 }
 
diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
index 315a4be..9a68914 100644
--- a/drivers/rapidio/devices/tsi721.c
+++ b/drivers/rapidio/devices/tsi721.c
@@ -51,6 +51,8 @@
 MODULE_PARM_DESC(mbox_sel,
 		 "RIO Messaging MBOX Selection Mask (default: 0x0f = all)");
 
+static DEFINE_SPINLOCK(tsi721_maint_lock);
+
 static void tsi721_omsg_handler(struct tsi721_device *priv, int ch);
 static void tsi721_imsg_handler(struct tsi721_device *priv, int ch);
 
@@ -124,12 +126,15 @@ static int tsi721_maint_dma(struct tsi721_device *priv, u32 sys_size,
 	void __iomem *regs = priv->regs + TSI721_DMAC_BASE(priv->mdma.ch_id);
 	struct tsi721_dma_desc *bd_ptr;
 	u32 rd_count, swr_ptr, ch_stat;
+	unsigned long flags;
 	int i, err = 0;
 	u32 op = do_wr ? MAINT_WR : MAINT_RD;
 
 	if (offset > (RIO_MAINT_SPACE_SZ - len) || (len != sizeof(u32)))
 		return -EINVAL;
 
+	spin_lock_irqsave(&tsi721_maint_lock, flags);
+
 	bd_ptr = priv->mdma.bd_base;
 
 	rd_count = ioread32(regs + TSI721_DMAC_DRDCNT);
@@ -197,7 +202,9 @@ static int tsi721_maint_dma(struct tsi721_device *priv, u32 sys_size,
 	 */
 	swr_ptr = ioread32(regs + TSI721_DMAC_DSWP);
 	iowrite32(swr_ptr, regs + TSI721_DMAC_DSRP);
+
 err_out:
+	spin_unlock_irqrestore(&tsi721_maint_lock, flags);
 
 	return err;
 }
diff --git a/drivers/rapidio/rio-access.c b/drivers/rapidio/rio-access.c
index a3824ba..3ee9af8 100644
--- a/drivers/rapidio/rio-access.c
+++ b/drivers/rapidio/rio-access.c
@@ -14,16 +14,8 @@
 #include <linux/module.h>
 
 /*
- * These interrupt-safe spinlocks protect all accesses to RIO
- * configuration space and doorbell access.
- */
-static DEFINE_SPINLOCK(rio_config_lock);
-static DEFINE_SPINLOCK(rio_doorbell_lock);
-
-/*
  *  Wrappers for all RIO configuration access functions.  They just check
- *  alignment, do locking and call the low-level functions pointed to
- *  by rio_mport->ops.
+ *  alignment and call the low-level functions pointed to by rio_mport->ops.
  */
 
 #define RIO_8_BAD 0
@@ -44,13 +36,10 @@
 	(struct rio_mport *mport, u32 offset, type *value)		\
 {									\
 	int res;							\
-	unsigned long flags;						\
 	u32 data = 0;							\
 	if (RIO_##size##_BAD) return RIO_BAD_SIZE;			\
-	spin_lock_irqsave(&rio_config_lock, flags);			\
 	res = mport->ops->lcread(mport, mport->id, offset, len, &data);	\
 	*value = (type)data;						\
-	spin_unlock_irqrestore(&rio_config_lock, flags);		\
 	return res;							\
 }
 
@@ -67,13 +56,8 @@
 int __rio_local_write_config_##size \
 	(struct rio_mport *mport, u32 offset, type value)		\
 {									\
-	int res;							\
-	unsigned long flags;						\
 	if (RIO_##size##_BAD) return RIO_BAD_SIZE;			\
-	spin_lock_irqsave(&rio_config_lock, flags);			\
-	res = mport->ops->lcwrite(mport, mport->id, offset, len, value);\
-	spin_unlock_irqrestore(&rio_config_lock, flags);		\
-	return res;							\
+	return mport->ops->lcwrite(mport, mport->id, offset, len, value);\
 }
 
 RIO_LOP_READ(8, u8, 1)
@@ -104,13 +88,10 @@
 	(struct rio_mport *mport, u16 destid, u8 hopcount, u32 offset, type *value)	\
 {									\
 	int res;							\
-	unsigned long flags;						\
 	u32 data = 0;							\
 	if (RIO_##size##_BAD) return RIO_BAD_SIZE;			\
-	spin_lock_irqsave(&rio_config_lock, flags);			\
 	res = mport->ops->cread(mport, mport->id, destid, hopcount, offset, len, &data); \
 	*value = (type)data;						\
-	spin_unlock_irqrestore(&rio_config_lock, flags);		\
 	return res;							\
 }
 
@@ -127,13 +108,9 @@
 int rio_mport_write_config_##size \
 	(struct rio_mport *mport, u16 destid, u8 hopcount, u32 offset, type value)	\
 {									\
-	int res;							\
-	unsigned long flags;						\
 	if (RIO_##size##_BAD) return RIO_BAD_SIZE;			\
-	spin_lock_irqsave(&rio_config_lock, flags);			\
-	res = mport->ops->cwrite(mport, mport->id, destid, hopcount, offset, len, value); \
-	spin_unlock_irqrestore(&rio_config_lock, flags);		\
-	return res;							\
+	return mport->ops->cwrite(mport, mport->id, destid, hopcount,	\
+			offset, len, value);				\
 }
 
 RIO_OP_READ(8, u8, 1)
@@ -162,14 +139,7 @@
  */
 int rio_mport_send_doorbell(struct rio_mport *mport, u16 destid, u16 data)
 {
-	int res;
-	unsigned long flags;
-
-	spin_lock_irqsave(&rio_doorbell_lock, flags);
-	res = mport->ops->dsend(mport, mport->id, destid, data);
-	spin_unlock_irqrestore(&rio_doorbell_lock, flags);
-
-	return res;
+	return mport->ops->dsend(mport, mport->id, destid, data);
 }
 
 EXPORT_SYMBOL_GPL(rio_mport_send_doorbell);
-- 
1.7.12.4
