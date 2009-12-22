Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 4B4B4B6F0A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 18:02:00 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id D51B4BADFD
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 08:01:54 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 04/13] mpc52xx: LocalPlus driver: rewrite interrupt routines,
	fix errors
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
In-Reply-To: <200912220755.09756.roman.fietze@telemotive.de>
MIME-Version: 1.0
Message-ID: <200912220801.53720.roman.fietze@telemotive.de>
Date: Tue, 22 Dec 2009 08:01:53 +0100
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


Use SCLPC bit definitions from mpc52xx.h for better readability.
Rewrite IRQ handlers, make them work for DMA.
=46ix module unload error.

Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
=2D--
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c |  306 ++++++++++++---------=
=2D---
 1 files changed, 149 insertions(+), 157 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc/p=
latforms/52xx/mpc52xx_lpbfifo.c
index 2763d5e..2fd1f3f 100644
=2D-- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
@@ -46,6 +46,34 @@ struct mpc52xx_lpbfifo {
 /* The MPC5200 has only one fifo, so only need one instance structure */
 static struct mpc52xx_lpbfifo lpbfifo;
=20
+
+/**
+ * mpc52xx_lpbfifo_is_write - return true if it's a WRITE request
+ */
+static inline int mpc52xx_lpbfifo_is_write(int flags)
+{
+	return flags & MPC52XX_LPBFIFO_FLAG_WRITE;
+}
+
+
+/**
+ * mpc52xx_lpbfifo_is_dma - return true if it's a DMA request
+ */
+static inline int mpc52xx_lpbfifo_is_dma(int flags)
+{
+	return !(flags & MPC52XX_LPBFIFO_FLAG_NO_DMA);
+}
+
+
+/**
+ * mpc52xx_lpbfifo_is_poll_dma - return true if it's a polled DMA request
+ */
+static inline int mpc52xx_lpbfifo_is_poll_dma(int flags)
+{
+	return flags & MPC52XX_LPBFIFO_FLAG_POLL_DMA;
+}
+
+
 /**
  * mpc52xx_lpbfifo_kick - Trigger the next block of data to be transfered
  */
@@ -57,16 +85,23 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo=
_request *req)
 	u32 *data;
 	int i;
 	int bit_fields;
=2D	int dma =3D !(req->flags & MPC52XX_LPBFIFO_FLAG_NO_DMA);
=2D	int write =3D req->flags & MPC52XX_LPBFIFO_FLAG_WRITE;
=2D	int poll_dma =3D req->flags & MPC52XX_LPBFIFO_FLAG_POLL_DMA;
+	int rflags =3D req->flags;
=20
 	/* Set and clear the reset bits; is good practice in User Manual */
=2D	out_be32(&lpbfifo.regs->enable, 0x01010000);
+	out_be32(&lpbfifo.regs->enable, MPC52xx_SCLPC_ENABLE_RC	| MPC52xx_SCLPC_E=
NABLE_RF);
+
+	/* Set width, chip select and READ mode */
+	out_be32(&lpbfifo.regs->start_address, req->offset + req->pos);
+
+	/* Set CS and BPT */
+	bit_fields =3D MPC52xx_SCLPC_CONTROL_CS(req->cs) | 0x8;
+	if (!(mpc52xx_lpbfifo_is_write(rflags))) {
+		bit_fields |=3D MPC52xx_SCLPC_CONTROL_RWB_RECEIVE;	/* read mode */
+		bit_fields |=3D MPC52xx_SCLPC_CONTROL_FLUSH;
+	}
+	out_be32(&lpbfifo.regs->control, bit_fields);
=20
=2D	/* set master enable bit */
=2D	out_be32(&lpbfifo.regs->enable, 0x00000001);
=2D	if (!dma) {
+	if (!mpc52xx_lpbfifo_is_dma(rflags)) {
 		/* While the FIFO can be setup for transfer sizes as large as
 		 * 16M-1, the FIFO itself is only 512 bytes deep and it does
 		 * not generate interrupts for FIFO full events (only transfer
@@ -80,7 +115,7 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo_=
request *req)
 			transfer_size =3D 512;
=20
 		/* Load the FIFO with data */
=2D		if (write) {
+		if (mpc52xx_lpbfifo_is_write(rflags)) {
 			reg =3D &lpbfifo.regs->fifo_data;
 			data =3D req->data + req->pos;
 			for (i =3D 0; i < transfer_size; i +=3D 4)
@@ -88,7 +123,9 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo_=
request *req)
 		}
=20
 		/* Unmask both error and completion irqs */
=2D		out_be32(&lpbfifo.regs->enable, 0x00000301);
+		out_be32(&lpbfifo.regs->enable, (MPC52xx_SCLPC_ENABLE_AIE |
+						 MPC52xx_SCLPC_ENABLE_NIE |
+						 MPC52xx_SCLPC_ENABLE_ME));
 	} else {
 		/* Choose the correct direction
 		 *
@@ -97,16 +134,16 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfif=
o_request *req)
 		 * there is a performance impacit.  However, if it is wrong there
 		 * is a risk of DMA not transferring the last chunk of data
 		 */
=2D		if (write) {
=2D			out_be32(&lpbfifo.regs->fifo_alarm, 0x1e4);
=2D			out_8(&lpbfifo.regs->fifo_control, 7);
+		if (mpc52xx_lpbfifo_is_write(rflags)) {
+			out_be32(&lpbfifo.regs->fifo_alarm, MPC52xx_SCLPC_FIFO_SIZE - 28);
+			out_be32(&lpbfifo.regs->fifo_control, MPC52xx_SLPC_FIFO_CONTROL_GR(7));
 			lpbfifo.bcom_cur_task =3D lpbfifo.bcom_tx_task;
 		} else {
=2D			out_be32(&lpbfifo.regs->fifo_alarm, 0x1ff);
=2D			out_8(&lpbfifo.regs->fifo_control, 0);
+			out_be32(&lpbfifo.regs->fifo_alarm, MPC52xx_SCLPC_FIFO_SIZE - 1);
+			out_be32(&lpbfifo.regs->fifo_control, MPC52xx_SLPC_FIFO_CONTROL_GR(0));
 			lpbfifo.bcom_cur_task =3D lpbfifo.bcom_rx_task;
=20
=2D			if (poll_dma) {
+			if (mpc52xx_lpbfifo_is_poll_dma(rflags)) {
 				if (lpbfifo.dma_irqs_enabled) {
 					disable_irq(bcom_get_task_irq(lpbfifo.bcom_rx_task));
 					lpbfifo.dma_irqs_enabled =3D 0;
@@ -119,63 +156,34 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfi=
fo_request *req)
 			}
 		}
=20
+		/* error irq & master enabled bit */
+		out_be32(&lpbfifo.regs->enable, MPC52xx_SCLPC_ENABLE_AIE | MPC52xx_SCLPC=
_ENABLE_NIE | MPC52xx_SCLPC_ENABLE_ME);
+
 		bd =3D bcom_prepare_next_buffer(lpbfifo.bcom_cur_task);
 		bd->status =3D transfer_size;
=2D		if (!write) {
=2D			/*
=2D			 * In the DMA read case, the DMA doesn't complete,
=2D			 * possibly due to incorrect watermarks in the ALARM
=2D			 * and CONTROL regs. For now instead of trying to
=2D			 * determine the right watermarks that will make this
=2D			 * work, just increase the number of bytes the FIFO is
=2D			 * expecting.
=2D			 *
=2D			 * When submitting another operation, the FIFO will get
=2D			 * reset, so the condition of the FIFO waiting for a
=2D			 * non-existent 4 bytes will get cleared.
=2D			 */
=2D			transfer_size +=3D 4; /* BLECH! */
=2D		}
 		bd->data[0] =3D req->data_phys + req->pos;
 		bcom_submit_next_buffer(lpbfifo.bcom_cur_task, NULL);
=2D
=2D		/* error irq & master enabled bit */
=2D		bit_fields =3D 0x00000201;
=2D
=2D		/* Unmask irqs */
=2D		if (write && (!poll_dma))
=2D			bit_fields |=3D 0x00000100; /* completion irq too */
=2D		out_be32(&lpbfifo.regs->enable, bit_fields);
 	}
=20
=2D	/* Set transfer size, width, chip select and READ mode */
=2D	out_be32(&lpbfifo.regs->start_address,
=2D		 req->offset + req->pos);
=2D	out_be32(&lpbfifo.regs->packet_size.packet_size, transfer_size);
=2D
=2D	bit_fields =3D req->cs << 24 | 0x000008;
=2D	if (!write)
=2D		bit_fields |=3D 0x010000;	/* read mode */
=2D	out_be32(&lpbfifo.regs->control, bit_fields);
=2D
=2D	/* Kick it off */
=2D	out_8(&lpbfifo.regs->packet_size.restart, 0x01);
=2D	if (dma)
+	/* Set packet size and kick it off */
+	out_be32(&lpbfifo.regs->packet_size.packet_size, MPC52xx_SCLPC_PACKET_SIZ=
E_RESTART | transfer_size);
+	if (mpc52xx_lpbfifo_is_dma(rflags))
 		bcom_enable(lpbfifo.bcom_cur_task);
 }
=20
 /**
=2D * mpc52xx_lpbfifo_irq - IRQ handler for LPB FIFO
+ * mpc52xx_lpbfifo_sclpc_irq - IRQ handler for LPB FIFO
  *
=2D * On transmit, the dma completion irq triggers before the fifo completi=
on
=2D * triggers.  Handle the dma completion here instead of the LPB FIFO Bes=
tcomm
=2D * task completion irq becuase everyting is not really done until the LP=
B FIFO
=2D * completion irq triggers.
+ * On transmit, the dma completion irq triggers before the fifo
+ * completion triggers.  Handle the dma completion here instead of the
+ * LPB FIFO Bestcomm task completion irq because everything is not
+ * really done until the LPB FIFO completion irq triggers.
  *
  * In other words:
  * For DMA, on receive, the "Fat Lady" is the bestcom completion irq. on
=2D * transmit, the fifo completion irq is the "Fat Lady". The opera (or in=
 this
=2D * case the DMA/FIFO operation) is not finished until the "Fat Lady" sin=
gs.
+ * transmit, the fifo completion irq is the "Fat Lady". The opera (or in
+ * this case the DMA/FIFO operation) is not finished until the "Fat
+ * Lady" sings.
  *
  * Reasons for entering this routine:
  * 1) PIO mode rx and tx completion irq
@@ -205,17 +213,17 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfi=
fo_request *req)
  * extra fiddling is done to make sure all paths lead to the same
  * outbound code.
  */
=2Dstatic irqreturn_t mpc52xx_lpbfifo_irq(int irq, void *dev_id)
+static irqreturn_t mpc52xx_lpbfifo_sclpc_irq(int irq, void *dev_id)
 {
 	struct mpc52xx_lpbfifo_request *req;
=2D	u32 status =3D in_8(&lpbfifo.regs->bytes_done_status.status);
+	u32 status_count =3D in_be32(&lpbfifo.regs->bytes_done_status.bytes_done);
 	void __iomem *reg;
 	u32 *data;
=2D	int count, i;
+	size_t i;
 	int do_callback =3D 0;
 	u32 ts;
 	unsigned long flags;
=2D	int dma, write, poll_dma;
+	int rflags;
=20
 	spin_lock_irqsave(&lpbfifo.lock, flags);
 	ts =3D get_tbl();
@@ -223,87 +231,79 @@ static irqreturn_t mpc52xx_lpbfifo_irq(int irq, void =
*dev_id)
 	req =3D lpbfifo.req;
 	if (!req) {
 		spin_unlock_irqrestore(&lpbfifo.lock, flags);
=2D		pr_err("bogus LPBFIFO IRQ\n");
+		pr_err("bogus SCLPC IRQ\n");
 		return IRQ_HANDLED;
 	}
=20
=2D	dma =3D !(req->flags & MPC52XX_LPBFIFO_FLAG_NO_DMA);
=2D	write =3D req->flags & MPC52XX_LPBFIFO_FLAG_WRITE;
=2D	poll_dma =3D req->flags & MPC52XX_LPBFIFO_FLAG_POLL_DMA;
+	rflags =3D req->flags;
=20
=2D	if (dma && !write) {
=2D		spin_unlock_irqrestore(&lpbfifo.lock, flags);
=2D		pr_err("bogus LPBFIFO IRQ (dma and not writting)\n");
=2D		return IRQ_HANDLED;
=2D	}
=2D
=2D	if ((status & 0x01) =3D=3D 0) {
+	/* check normal termination bit */
+	if (!(status_count & MPC52xx_SCLPC_STATUS_NT))
 		goto out;
=2D	}
=20
 	/* check abort bit */
=2D	if (status & 0x10) {
=2D		out_be32(&lpbfifo.regs->enable, 0x01010000);
+	if (status_count & MPC52xx_SCLPC_STATUS_AT) {
+		out_be32(&lpbfifo.regs->enable, MPC52xx_SCLPC_ENABLE_RC | MPC52xx_SCLPC_=
ENABLE_RF);
 		do_callback =3D 1;
 		goto out;
 	}
=20
=2D	/* Read result from hardware */
=2D	count =3D in_be32(&lpbfifo.regs->bytes_done_status.bytes_done);
=2D	count &=3D 0x00ffffff;
+	if (!mpc52xx_lpbfifo_is_dma(rflags)) {
=20
=2D	if (!dma && !write) {
=2D		/* copy the data out of the FIFO */
=2D		reg =3D &lpbfifo.regs->fifo_data;
=2D		data =3D req->data + req->pos;
=2D		for (i =3D 0; i < count; i +=3D 4)
=2D			*data++ =3D in_be32(reg);
=2D	}
+		/* bytes done */
+		status_count &=3D MPC52xx_SCLPC_STATUS_BYTES_DONE_MASK;
=20
=2D	/* Update transfer position and count */
=2D	req->pos +=3D count;
+		if (!mpc52xx_lpbfifo_is_write(rflags)) {
+			/* copy the data out of the FIFO */
+			reg =3D &lpbfifo.regs->fifo_data;
+			data =3D req->data + req->pos;
+			for (i =3D 0; i < status_count; i +=3D sizeof(u32))
+				*data++ =3D in_be32(reg);
+		}
=20
=2D	/* Decide what to do next */
=2D	if (req->size - req->pos)
=2D		mpc52xx_lpbfifo_kick(req); /* more work to do */
=2D	else
+		/* Update transfer position and count */
+		req->pos +=3D status_count;
+
+		/* Decide what to do next */
+		if (req->size - req->pos)
+			mpc52xx_lpbfifo_kick(req); /* more work to do */
+		else
+			do_callback =3D 1;
+	}
+	else {
 		do_callback =3D 1;
+	}
=20
 out:
 	/* Clear the IRQ */
=2D	out_8(&lpbfifo.regs->bytes_done_status.status, 0x01);
+	out_8(&lpbfifo.regs->bytes_done_status.status, BIT(0));
=20
=2D	if (dma && (status & 0x11)) {
=2D		/*
=2D		 * Count the DMA as complete only when the FIFO completion
=2D		 * status or abort bits are set.
=2D		 *
=2D		 * (status & 0x01) should always be the case except sometimes
=2D		 * when using polled DMA.
=2D		 *
=2D		 * (status & 0x10) {transfer aborted}: This case needs more
=2D		 * testing.
=2D		 */
=2D		bcom_retrieve_buffer(lpbfifo.bcom_cur_task, &status, NULL);
=2D	}
 	req->last_byte =3D ((u8 *)req->data)[req->size - 1];
=20
+	if (irq !=3D 0) /* don't increment on polled case */
+		req->irq_count++;
+
 	/* When the do_callback flag is set; it means the transfer is finished
 	 * so set the FIFO as idle */
=2D	if (do_callback)
+	if (do_callback) {
 		lpbfifo.req =3D NULL;
+		out_be32(&lpbfifo.regs->enable, MPC52xx_SCLPC_ENABLE_RC | MPC52xx_SCLPC_=
ENABLE_RF);
=20
=2D	if (irq !=3D 0) /* don't increment on polled case */
=2D		req->irq_count++;
+		req->irq_ticks +=3D get_tbl() - ts;
+		spin_unlock_irqrestore(&lpbfifo.lock, flags);
=20
=2D	req->irq_ticks +=3D get_tbl() - ts;
=2D	spin_unlock_irqrestore(&lpbfifo.lock, flags);
+		/* Spinlock is released; it is now safe to call the callback */
+		if (req->callback)
+			req->callback(req);
=20
=2D	/* Spinlock is released; it is now safe to call the callback */
=2D	if (do_callback && req->callback)
=2D		req->callback(req);
+		return IRQ_HANDLED;
+	}
+	else {
+		req->irq_ticks +=3D get_tbl() - ts;
+		spin_unlock_irqrestore(&lpbfifo.lock, flags);
=20
=2D	return IRQ_HANDLED;
+		return IRQ_HANDLED;
+	}
 }
=20
 /**
@@ -313,48 +313,30 @@ out:
  */
 static irqreturn_t mpc52xx_lpbfifo_bcom_irq(int irq, void *dev_id)
 {
=2D	struct mpc52xx_lpbfifo_request *req;
+	struct mpc52xx_lpbfifo *lpbfifo =3D dev_id;
 	unsigned long flags;
=2D	u32 status;
=2D	u32 ts;
=2D
=2D	spin_lock_irqsave(&lpbfifo.lock, flags);
=2D	ts =3D get_tbl();
=2D
=2D	req =3D lpbfifo.req;
=2D	if (!req || (req->flags & MPC52XX_LPBFIFO_FLAG_NO_DMA)) {
=2D		spin_unlock_irqrestore(&lpbfifo.lock, flags);
=2D		return IRQ_HANDLED;
=2D	}
=20
=2D	if (irq !=3D 0) /* don't increment on polled case */
=2D		req->irq_count++;
+	spin_lock_irqsave(&lpbfifo->lock, flags);
+	// ts =3D get_tbl();
=20
=2D	if (!bcom_buffer_done(lpbfifo.bcom_cur_task)) {
=2D		spin_unlock_irqrestore(&lpbfifo.lock, flags);
+	if (!bcom_buffer_done(lpbfifo->bcom_cur_task)) {
=20
=2D		req->buffer_not_done_cnt++;
=2D		if ((req->buffer_not_done_cnt % 1000) =3D=3D 0)
=2D			pr_err("transfer stalled\n");
+		if (bcom_queue_empty(lpbfifo->bcom_cur_task)) {
+			spin_unlock_irqrestore(&lpbfifo->lock, flags);
+			dev_err(lpbfifo->dev, "DMA queue empty\n");
+		}
+		else {
+			spin_unlock_irqrestore(&lpbfifo->lock, flags);
+			dev_err(lpbfifo->dev, "DMA buffer not done\n");
+		}
=20
 		return IRQ_HANDLED;
 	}
=20
=2D	bcom_retrieve_buffer(lpbfifo.bcom_cur_task, &status, NULL);
=2D
=2D	req->last_byte =3D ((u8 *)req->data)[req->size - 1];
=2D
=2D	req->pos =3D status & 0x00ffffff;
=2D
=2D	/* Mark the FIFO as idle */
=2D	lpbfifo.req =3D NULL;
+	bcom_retrieve_buffer(lpbfifo->bcom_cur_task, NULL, NULL);
+	// req->irq_ticks +=3D get_tbl() - ts;
=20
=2D	/* Release the lock before calling out to the callback. */
=2D	req->irq_ticks +=3D get_tbl() - ts;
=2D	spin_unlock_irqrestore(&lpbfifo.lock, flags);
=2D
=2D	if (req->callback)
=2D		req->callback(req);
+	spin_unlock_irqrestore(&lpbfifo->lock, flags);
=20
 	return IRQ_HANDLED;
 }
@@ -365,14 +347,12 @@ static irqreturn_t mpc52xx_lpbfifo_bcom_irq(int irq, =
void *dev_id)
 void mpc52xx_lpbfifo_poll(void)
 {
 	struct mpc52xx_lpbfifo_request *req =3D lpbfifo.req;
=2D	int dma =3D !(req->flags & MPC52XX_LPBFIFO_FLAG_NO_DMA);
=2D	int write =3D req->flags & MPC52XX_LPBFIFO_FLAG_WRITE;
=20
 	/*
 	 * For more information, see comments on the "Fat Lady"=20
 	 */
=2D	if (dma && write)
=2D		mpc52xx_lpbfifo_irq(0, NULL);
+	if (mpc52xx_lpbfifo_is_dma(req->flags) && (req->flags & MPC52XX_LPBFIFO_F=
LAG_WRITE))
+		mpc52xx_lpbfifo_sclpc_irq(0, NULL);
 	else=20
 		mpc52xx_lpbfifo_bcom_irq(0, NULL);
 }
@@ -406,6 +386,7 @@ int mpc52xx_lpbfifo_submit(struct mpc52xx_lpbfifo_reque=
st *req)
=20
 	mpc52xx_lpbfifo_kick(req);
 	spin_unlock_irqrestore(&lpbfifo.lock, flags);
+
 	return 0;
 }
 EXPORT_SYMBOL(mpc52xx_lpbfifo_submit);
@@ -419,7 +400,7 @@ void mpc52xx_lpbfifo_abort(struct mpc52xx_lpbfifo_reque=
st *req)
 		/* Put it into reset and clear the state */
 		bcom_gen_bd_rx_reset(lpbfifo.bcom_rx_task);
 		bcom_gen_bd_tx_reset(lpbfifo.bcom_tx_task);
=2D		out_be32(&lpbfifo.regs->enable, 0x01010000);
+		out_be32(&lpbfifo.regs->enable, MPC52xx_SCLPC_ENABLE_RC | MPC52xx_SCLPC_=
ENABLE_RF);
 		lpbfifo.req =3D NULL;
 	}
 	spin_unlock_irqrestore(&lpbfifo.lock, flags);
@@ -449,16 +430,16 @@ mpc52xx_lpbfifo_probe(struct of_device *op, const str=
uct of_device_id *match)
 	spin_lock_init(&lpbfifo.lock);
=20
 	/* Put FIFO into reset */
=2D	out_be32(&lpbfifo.regs->enable, 0x01010000);
+	out_be32(&lpbfifo.regs->enable, MPC52xx_SCLPC_ENABLE_RC | MPC52xx_SCLPC_E=
NABLE_RF);
=20
 	/* register the interrupt handler */
=2D	rc =3D request_irq(lpbfifo.irq, mpc52xx_lpbfifo_irq, 0,
+	rc =3D request_irq(lpbfifo.irq, mpc52xx_lpbfifo_sclpc_irq, 0,
 			 "mpc52xx-lpbfifo", &lpbfifo);
 	if (rc)
 		goto err_irq;
=20
 	/* Request the Bestcomm receive (fifo --> memory) task and IRQ */
=2D	lpbfifo.bcom_rx_task =3D bcom_gen_bd_rx_init(2,
+	lpbfifo.bcom_rx_task =3D bcom_gen_bd_rx_init(16,
 						   res.start + offsetof(struct mpc52xx_sclpc, fifo_data),
 						   BCOM_INITIATOR_SCLPC, BCOM_IPR_SCLPC,
 						   16*1024*1024);
@@ -472,16 +453,27 @@ mpc52xx_lpbfifo_probe(struct of_device *op, const str=
uct of_device_id *match)
 		goto err_bcom_rx_irq;
=20
 	/* Request the Bestcomm transmit (memory --> fifo) task and IRQ */
=2D	lpbfifo.bcom_tx_task =3D bcom_gen_bd_tx_init(2,
+	lpbfifo.bcom_tx_task =3D bcom_gen_bd_tx_init(16,
 						   res.start + offsetof(struct mpc52xx_sclpc, fifo_data),
 						   BCOM_INITIATOR_SCLPC,
 						   BCOM_IPR_SCLPC);
 	if (!lpbfifo.bcom_tx_task)
 		goto err_bcom_tx;
=20
+	rc =3D request_irq(bcom_get_task_irq(lpbfifo.bcom_rx_task),
+			 mpc52xx_lpbfifo_bcom_irq, 0,
+			 "mpc52xx-lpbfifo-rx", &lpbfifo);
+	if (rc)
+		goto err_bcom_tx_irq;
+
+	lpbfifo.dma_irqs_enabled =3D 1;
+
 	lpbfifo.dev =3D &op->dev;
+
 	return 0;
=20
+err_bcom_tx_irq:
+	free_irq(bcom_get_task_irq(lpbfifo.bcom_tx_task), &lpbfifo);
 err_bcom_tx:
 	free_irq(bcom_get_task_irq(lpbfifo.bcom_rx_task), &lpbfifo);
 err_bcom_rx_irq:
=2D-=20
1.6.5.5


=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
