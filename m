Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D363FB7BBE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 18:04:11 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id C7EF9BADFD
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 08:04:05 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/13] powerpc/5200: LocalPlus driver: map and unmap DMA areas
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
In-Reply-To: <200912220755.09756.roman.fietze@telemotive.de>
MIME-Version: 1.0
Message-ID: <200912220804.05543.roman.fietze@telemotive.de>
Date: Tue, 22 Dec 2009 08:04:05 +0100
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


Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
=2D--
 arch/powerpc/include/asm/mpc52xx.h            |    2 +-
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c |   26 +++++++++++++++++++--=
=2D--
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/asm/=
mpc52xx.h
index c659d1d..043458e 100644
=2D-- a/arch/powerpc/include/asm/mpc52xx.h
+++ b/arch/powerpc/include/asm/mpc52xx.h
@@ -347,7 +347,7 @@ struct mpc52xx_lpbfifo_request {
=20
 	/* Memory address */
 	void *data;
=2D	phys_addr_t data_phys;
+	dma_addr_t data_dma;
=20
 	/* Details of transfer */
 	size_t size;
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc/p=
latforms/52xx/mpc52xx_lpbfifo.c
index 1e4f725..8d8a63a 100644
=2D-- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/spinlock.h>
+#include <linux/dma-mapping.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/mpc52xx.h>
@@ -138,6 +139,7 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo=
_request *req)
 			out_be32(&lpbfifo.regs->fifo_alarm, MPC52xx_SCLPC_FIFO_SIZE - 28);
 			out_be32(&lpbfifo.regs->fifo_control, MPC52xx_SLPC_FIFO_CONTROL_GR(7));
 			lpbfifo.bcom_cur_task =3D lpbfifo.bcom_tx_task;
+			req->data_dma =3D dma_map_single(lpbfifo.dev, req->data, req->size, DMA=
_TO_DEVICE);
 		} else {
 			out_be32(&lpbfifo.regs->fifo_alarm, MPC52xx_SCLPC_FIFO_SIZE - 1);
 			out_be32(&lpbfifo.regs->fifo_control, MPC52xx_SLPC_FIFO_CONTROL_GR(0));
@@ -154,6 +156,7 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo=
_request *req)
 					lpbfifo.dma_irqs_enabled =3D 1;
 				}
 			}
+			req->data_dma =3D dma_map_single(lpbfifo.dev, req->data, req->size, DMA=
_FROM_DEVICE);
 		}
=20
 		/* error irq & master enabled bit */
@@ -161,7 +164,7 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo=
_request *req)
=20
 		bd =3D bcom_prepare_next_buffer(lpbfifo.bcom_cur_task);
 		bd->status =3D transfer_size;
=2D		bd->data[0] =3D req->data_phys + req->pos;
+		bd->data[0] =3D req->data_dma + req->pos;
 		bcom_submit_next_buffer(lpbfifo.bcom_cur_task, NULL);
 	}
=20
@@ -236,12 +239,13 @@ static irqreturn_t mpc52xx_lpbfifo_sclpc_irq(int irq,=
 void *dev_id)
 	}
=20
 	rflags =3D req->flags;
+	status_count =3D in_be32(&lpbfifo.regs->bytes_done_status.bytes_done);
=20
=2D	/* check normal termination bit */
+	/* Check normal termination bit */
 	if (!(status_count & MPC52xx_SCLPC_STATUS_NT))
 		goto out;
=20
=2D	/* check abort bit */
+	/* Check abort bit */
 	if (status_count & MPC52xx_SCLPC_STATUS_AT) {
 		out_be32(&lpbfifo.regs->enable, MPC52xx_SCLPC_ENABLE_RC | MPC52xx_SCLPC_=
ENABLE_RF);
 		do_callback =3D 1;
@@ -250,7 +254,7 @@ static irqreturn_t mpc52xx_lpbfifo_sclpc_irq(int irq, v=
oid *dev_id)
=20
 	if (!mpc52xx_lpbfifo_is_dma(rflags)) {
=20
=2D		/* bytes done */
+		/* Bytes done */
 		status_count &=3D MPC52xx_SCLPC_STATUS_BYTES_DONE_MASK;
=20
 		if (!mpc52xx_lpbfifo_is_write(rflags)) {
@@ -336,6 +340,16 @@ static irqreturn_t mpc52xx_lpbfifo_bcom_irq(int irq, v=
oid *dev_id)
 	bcom_retrieve_buffer(lpbfifo->bcom_cur_task, NULL, NULL);
 	// req->irq_ticks +=3D get_tbl() - ts;
=20
+	if (lpbfifo->req) {
+		if (mpc52xx_lpbfifo_is_write(lpbfifo->req->flags))
+			dma_unmap_single(lpbfifo->dev, lpbfifo->req->data_dma, lpbfifo->req->si=
ze, DMA_TO_DEVICE);
+		else
+			dma_unmap_single(lpbfifo->dev, lpbfifo->req->data_dma, lpbfifo->req->si=
ze, DMA_FROM_DEVICE);
+	} else
+	{
+		dev_err(lpbfifo->dev, "request is NULL\n");
+	}
+
 	spin_unlock_irqrestore(&lpbfifo->lock, flags);
=20
 	return IRQ_HANDLED;
@@ -439,7 +453,7 @@ mpc52xx_lpbfifo_probe(struct of_device *op, const struc=
t of_device_id *match)
 		goto err_irq;
=20
 	/* Request the Bestcomm receive (fifo --> memory) task and IRQ */
=2D	lpbfifo.bcom_rx_task =3D bcom_gen_bd_rx_init(16,
+	lpbfifo.bcom_rx_task =3D bcom_gen_bd_rx_init(4,
 						   res.start + offsetof(struct mpc52xx_sclpc, fifo_data),
 						   BCOM_INITIATOR_SCLPC, BCOM_IPR_SCLPC,
 						   16*1024*1024);
@@ -453,7 +467,7 @@ mpc52xx_lpbfifo_probe(struct of_device *op, const struc=
t of_device_id *match)
 		goto err_bcom_rx_irq;
=20
 	/* Request the Bestcomm transmit (memory --> fifo) task and IRQ */
=2D	lpbfifo.bcom_tx_task =3D bcom_gen_bd_tx_init(16,
+	lpbfifo.bcom_tx_task =3D bcom_gen_bd_tx_init(4,
 						   res.start + offsetof(struct mpc52xx_sclpc, fifo_data),
 						   BCOM_INITIATOR_SCLPC,
 						   BCOM_IPR_SCLPC);
=2D-=20
1.6.5.5



=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
