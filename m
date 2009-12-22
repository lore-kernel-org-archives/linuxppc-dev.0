Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A3776B7BC1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 18:09:15 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id C7398BADFD
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 08:09:09 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 10/13] powerpc/5200: LocalPlus driver: fix problem caused by
	unpredictable IRQ order
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
In-Reply-To: <200912220755.09756.roman.fietze@telemotive.de>
MIME-Version: 1.0
Message-ID: <200912220809.09578.roman.fietze@telemotive.de>
Date: Tue, 22 Dec 2009 08:09:09 +0100
Content-Type: Text/Plain;
  charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The order of the raised interrupts of SCLPC and BCOM cannot be
predicted, because it depends on the individual BCOM and CPU loads. So
in DMA mode we just wait for both until we finish the transaction.

Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
=2D--
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c |   94 +++++++++++++++++----=
=2D---
 1 files changed, 64 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc/p=
latforms/52xx/mpc52xx_lpbfifo.c
index 21b2a40..cd8dc69 100644
=2D-- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
@@ -32,7 +32,7 @@ struct mpc52xx_lpbfifo {
 	struct device *dev;
 	phys_addr_t regs_phys;
 	struct mpc52xx_sclpc __iomem *regs;
=2D	int irq;
+	int sclpc_irq;
 	spinlock_t lock;
=20
 	struct bcom_task *bcom_tx_task;
@@ -41,6 +41,7 @@ struct mpc52xx_lpbfifo {
=20
 	/* Current state data */
 	struct mpc52xx_lpbfifo_request *req;
+	unsigned short irqs_pending;
 	int dma_irqs_enabled;
 };
=20
@@ -48,6 +49,14 @@ struct mpc52xx_lpbfifo {
 static struct mpc52xx_lpbfifo lpbfifo;
=20
=20
+/* The order of the raised interrupts of SCLPC and BCOM cann not be
+ * predicted, because it depends on the individual BCOM and CPU
+ * loads. So in DMA mode we just wait for both until we finish the
+ * transaction. */
+#define MPC52XX_LPBFIFO_PENDING_SCLPC	BIT(0)
+#define MPC52XX_LPBFIFO_PENDING_BCOM	BIT(1)
+
+
 /**
  * mpc52xx_lpbfifo_is_write - return true if it's a WRITE request
  */
@@ -127,6 +136,8 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo=
_request *req)
 				out_be32(reg, *data++);
 		}
=20
+		lpbfifo.irqs_pending =3D MPC52XX_LPBFIFO_PENDING_SCLPC;
+
 		/* Unmask both error and completion irqs */
 		out_be32(&lpbfifo.regs->enable, (MPC52xx_SCLPC_ENABLE_AIE |
 						 MPC52xx_SCLPC_ENABLE_NIE |
@@ -172,6 +183,8 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo=
_request *req)
 		/* error irq & master enabled bit */
 		out_be32(&lpbfifo.regs->enable, MPC52xx_SCLPC_ENABLE_AIE | MPC52xx_SCLPC=
_ENABLE_NIE | MPC52xx_SCLPC_ENABLE_ME);
=20
+		lpbfifo.irqs_pending =3D MPC52XX_LPBFIFO_PENDING_BCOM | MPC52XX_LPBFIFO_=
PENDING_SCLPC;
+
 		bd =3D bcom_prepare_next_buffer(lpbfifo.bcom_cur_task);
 		bd->status =3D tc;
 		bd->data[0] =3D req->data_dma + req->pos;
@@ -188,6 +201,7 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo=
_request *req)
 		bcom_enable(lpbfifo.bcom_cur_task);
 }
=20
+
 /**
  * mpc52xx_lpbfifo_sclpc_irq - IRQ handler for LPB FIFO
  *
@@ -232,8 +246,9 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo=
_request *req)
  */
 static irqreturn_t mpc52xx_lpbfifo_sclpc_irq(int irq, void *dev_id)
 {
+	struct mpc52xx_lpbfifo *lpbfifo =3D dev_id;
 	struct mpc52xx_lpbfifo_request *req;
=2D	u32 status_count =3D in_be32(&lpbfifo.regs->bytes_done_status.bytes_don=
e);
+	u32 status_count =3D in_be32(&lpbfifo->regs->bytes_done_status.bytes_done=
);
 	void __iomem *reg;
 	u32 *data;
 	size_t i;
@@ -242,18 +257,20 @@ static irqreturn_t mpc52xx_lpbfifo_sclpc_irq(int irq,=
 void *dev_id)
 	unsigned long flags;
 	int rflags;
=20
=2D	spin_lock_irqsave(&lpbfifo.lock, flags);
+	spin_lock_irqsave(&lpbfifo->lock, flags);
 	ts =3D get_tbl();
=20
=2D	req =3D lpbfifo.req;
+	req =3D lpbfifo->req;
 	if (!req) {
=2D		spin_unlock_irqrestore(&lpbfifo.lock, flags);
+		spin_unlock_irqrestore(&lpbfifo->lock, flags);
 		pr_err("bogus SCLPC IRQ\n");
 		return IRQ_HANDLED;
 	}
=20
+	lpbfifo->irqs_pending &=3D ~MPC52XX_LPBFIFO_PENDING_SCLPC;
+
 	rflags =3D req->flags;
=2D	status_count =3D in_be32(&lpbfifo.regs->bytes_done_status.bytes_done);
+	status_count =3D in_be32(&lpbfifo->regs->bytes_done_status.bytes_done);
=20
 	/* Check normal termination bit */
 	if (!(status_count & MPC52xx_SCLPC_STATUS_NT))
@@ -261,19 +278,23 @@ static irqreturn_t mpc52xx_lpbfifo_sclpc_irq(int irq,=
 void *dev_id)
=20
 	/* Check abort bit */
 	if (status_count & MPC52xx_SCLPC_STATUS_AT) {
=2D		out_be32(&lpbfifo.regs->enable, MPC52xx_SCLPC_ENABLE_RC | MPC52xx_SCLP=
C_ENABLE_RF);
+		out_be32(&lpbfifo->regs->enable, MPC52xx_SCLPC_ENABLE_RC | MPC52xx_SCLPC=
_ENABLE_RF);
 		do_callback =3D 1;
 		goto out;
 	}
=20
=2D	if (!mpc52xx_lpbfifo_is_dma(rflags)) {
+	if (mpc52xx_lpbfifo_is_dma(rflags)) {
+		if (!lpbfifo->irqs_pending)
+			do_callback =3D 1;
+	}
+	else {
=20
 		/* Bytes done */
 		status_count &=3D MPC52xx_SCLPC_STATUS_BYTES_DONE_MASK;
=20
 		if (!mpc52xx_lpbfifo_is_write(rflags)) {
 			/* copy the data out of the FIFO */
=2D			reg =3D &lpbfifo.regs->fifo_data;
+			reg =3D &lpbfifo->regs->fifo_data;
 			data =3D req->data + req->pos;
 			for (i =3D 0; i < status_count; i +=3D sizeof(u32))
 				*data++ =3D in_be32(reg);
@@ -288,13 +309,10 @@ static irqreturn_t mpc52xx_lpbfifo_sclpc_irq(int irq,=
 void *dev_id)
 		else
 			do_callback =3D 1;
 	}
=2D	else {
=2D		do_callback =3D 1;
=2D	}
=20
 out:
 	/* Clear the IRQ */
=2D	out_8(&lpbfifo.regs->bytes_done_status.status, BIT(0));
+	out_8(&lpbfifo->regs->bytes_done_status.status, BIT(0));
=20
 	req->last_byte =3D ((u8 *)req->data)[req->size - 1];
=20
@@ -304,11 +322,11 @@ out:
 	/* When the do_callback flag is set; it means the transfer is finished
 	 * so set the FIFO as idle */
 	if (do_callback) {
=2D		lpbfifo.req =3D NULL;
=2D		out_be32(&lpbfifo.regs->enable, MPC52xx_SCLPC_ENABLE_RC | MPC52xx_SCLP=
C_ENABLE_RF);
+		lpbfifo->req =3D NULL;
+		out_be32(&lpbfifo->regs->enable, MPC52xx_SCLPC_ENABLE_RC | MPC52xx_SCLPC=
_ENABLE_RF);
=20
 		req->irq_ticks +=3D get_tbl() - ts;
=2D		spin_unlock_irqrestore(&lpbfifo.lock, flags);
+		spin_unlock_irqrestore(&lpbfifo->lock, flags);
=20
 		/* Spinlock is released; it is now safe to call the callback */
 		if (req->callback)
@@ -318,7 +336,7 @@ out:
 	}
 	else {
 		req->irq_ticks +=3D get_tbl() - ts;
=2D		spin_unlock_irqrestore(&lpbfifo.lock, flags);
+		spin_unlock_irqrestore(&lpbfifo->lock, flags);
=20
 		return IRQ_HANDLED;
 	}
@@ -354,14 +372,30 @@ static irqreturn_t mpc52xx_lpbfifo_bcom_irq(int irq, =
void *dev_id)
 	bcom_retrieve_buffer(lpbfifo->bcom_cur_task, NULL, NULL);
 	// req->irq_ticks +=3D get_tbl() - ts;
=20
=2D	if (lpbfifo->req) {
=2D		if (mpc52xx_lpbfifo_is_write(lpbfifo->req->flags))
=2D			dma_unmap_single(lpbfifo->dev, lpbfifo->req->data_dma, lpbfifo->req->=
size, DMA_TO_DEVICE);
=2D		else
=2D			dma_unmap_single(lpbfifo->dev, lpbfifo->req->data_dma, lpbfifo->req->=
size, DMA_FROM_DEVICE);
=2D	} else
=2D	{
=2D		dev_err(lpbfifo->dev, "request is NULL\n");
+	lpbfifo->irqs_pending &=3D ~MPC52XX_LPBFIFO_PENDING_BCOM;
+	if (!lpbfifo->irqs_pending) {
+		struct mpc52xx_lpbfifo_request *req =3D lpbfifo->req;
+
+		if (req) {
+			if (mpc52xx_lpbfifo_is_write(lpbfifo->req->flags))
+				dma_unmap_single(lpbfifo->dev, lpbfifo->req->data_dma, lpbfifo->req->s=
ize, DMA_TO_DEVICE);
+			else
+				dma_unmap_single(lpbfifo->dev, lpbfifo->req->data_dma, lpbfifo->req->s=
ize, DMA_FROM_DEVICE);
+
+			lpbfifo->req =3D NULL;
+			out_be32(&lpbfifo->regs->enable, MPC52xx_SCLPC_ENABLE_RC | MPC52xx_SCLP=
C_ENABLE_RF);
+
+			spin_unlock_irqrestore(&lpbfifo->lock, flags);
+
+			/* Spinlock is released; it is now safe to call the callback */
+			if (req->callback)
+				req->callback(req);
+
+			return IRQ_HANDLED;
+		}
+		else {
+			dev_err(lpbfifo->dev, "bogus BCOM IRQ\n");
+		}
 	}
=20
 	spin_unlock_irqrestore(&lpbfifo->lock, flags);
@@ -451,8 +485,8 @@ mpc52xx_lpbfifo_probe(struct of_device *op, const struc=
t of_device_id *match)
 	if (lpbfifo.dev !=3D NULL)
 		return -ENOSPC;
=20
=2D	lpbfifo.irq =3D irq_of_parse_and_map(op->node, 0);
=2D	if (!lpbfifo.irq)
+	lpbfifo.sclpc_irq =3D irq_of_parse_and_map(op->node, 0);
+	if (!lpbfifo.sclpc_irq)
 		return -ENODEV;
=20
 	if (of_address_to_resource(op->node, 0, &res))
@@ -468,7 +502,7 @@ mpc52xx_lpbfifo_probe(struct of_device *op, const struc=
t of_device_id *match)
 	out_be32(&lpbfifo.regs->enable, MPC52xx_SCLPC_ENABLE_RC | MPC52xx_SCLPC_E=
NABLE_RF);
=20
 	/* register the interrupt handler */
=2D	rc =3D request_irq(lpbfifo.irq, mpc52xx_lpbfifo_sclpc_irq, 0,
+	rc =3D request_irq(lpbfifo.sclpc_irq, mpc52xx_lpbfifo_sclpc_irq, 0,
 			 "mpc52xx-lpbfifo", &lpbfifo);
 	if (rc)
 		goto err_irq;
@@ -539,7 +573,7 @@ static int __devexit mpc52xx_lpbfifo_remove(struct of_d=
evice *op)
 	free_irq(bcom_get_task_irq(lpbfifo.bcom_rx_task), &lpbfifo);
 	bcom_gen_bd_rx_release(lpbfifo.bcom_rx_task);
=20
=2D	free_irq(lpbfifo.irq, &lpbfifo);
+	free_irq(lpbfifo.sclpc_irq, &lpbfifo);
 	iounmap(lpbfifo.regs);
 	lpbfifo.regs =3D NULL;
 	lpbfifo.dev =3D NULL;
@@ -547,7 +581,7 @@ static int __devexit mpc52xx_lpbfifo_remove(struct of_d=
evice *op)
 	return 0;
 }
=20
=2Dstatic struct of_device_id mpc52xx_lpbfifo_match[] __devinitconst =3D {
+static const struct of_device_id mpc52xx_lpbfifo_match[] __devinitconst =
=3D {
 	{ .compatible =3D "fsl,mpc5200-lpbfifo", },
 	{},
 };
=2D-=20
1.6.5.5



=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
