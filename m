Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D8B15B7BC2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 18:10:26 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id D0262BD647
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 08:10:20 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 11/13] powerpc/5200: LocalPlus driver: move RAM DMA address
	from request to driver
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
In-Reply-To: <200912220755.09756.roman.fietze@telemotive.de>
MIME-Version: 1.0
Message-ID: <200912220810.20622.roman.fietze@telemotive.de>
Date: Tue, 22 Dec 2009 08:10:20 +0100
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
 arch/powerpc/include/asm/mpc52xx.h            |    1 -
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c |   13 +++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/asm/=
mpc52xx.h
index 043458e..91c65d0 100644
=2D-- a/arch/powerpc/include/asm/mpc52xx.h
+++ b/arch/powerpc/include/asm/mpc52xx.h
@@ -347,7 +347,6 @@ struct mpc52xx_lpbfifo_request {
=20
 	/* Memory address */
 	void *data;
=2D	dma_addr_t data_dma;
=20
 	/* Details of transfer */
 	size_t size;
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc/p=
latforms/52xx/mpc52xx_lpbfifo.c
index cd8dc69..b2c92f5 100644
=2D-- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
@@ -41,6 +41,7 @@ struct mpc52xx_lpbfifo {
=20
 	/* Current state data */
 	struct mpc52xx_lpbfifo_request *req;
+	dma_addr_t data_dma;
 	unsigned short irqs_pending;
 	int dma_irqs_enabled;
 };
@@ -49,7 +50,7 @@ struct mpc52xx_lpbfifo {
 static struct mpc52xx_lpbfifo lpbfifo;
=20
=20
=2D/* The order of the raised interrupts of SCLPC and BCOM cann not be
+/* The order of the raised interrupts of SCLPC and BCOM cannot be
  * predicted, because it depends on the individual BCOM and CPU
  * loads. So in DMA mode we just wait for both until we finish the
  * transaction. */
@@ -160,7 +161,7 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo=
_request *req)
 			out_be32(&lpbfifo.regs->fifo_alarm, MPC52xx_SCLPC_FIFO_SIZE - 28);
 			out_be32(&lpbfifo.regs->fifo_control, MPC52xx_SLPC_FIFO_CONTROL_GR(7));
 			lpbfifo.bcom_cur_task =3D lpbfifo.bcom_tx_task;
=2D			req->data_dma =3D dma_map_single(lpbfifo.dev, req->data, req->size, D=
MA_TO_DEVICE);
+			lpbfifo.data_dma =3D dma_map_single(lpbfifo.dev, req->data, req->size, =
DMA_TO_DEVICE);
 		} else {
 			out_be32(&lpbfifo.regs->fifo_alarm, MPC52xx_SCLPC_FIFO_SIZE - 1);
 			out_be32(&lpbfifo.regs->fifo_control, MPC52xx_SLPC_FIFO_CONTROL_GR(0));
@@ -177,7 +178,7 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo=
_request *req)
 					lpbfifo.dma_irqs_enabled =3D 1;
 				}
 			}
=2D			req->data_dma =3D dma_map_single(lpbfifo.dev, req->data, req->size, D=
MA_FROM_DEVICE);
+			lpbfifo.data_dma =3D dma_map_single(lpbfifo.dev, req->data, req->size, =
DMA_FROM_DEVICE);
 		}
=20
 		/* error irq & master enabled bit */
@@ -187,7 +188,7 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo=
_request *req)
=20
 		bd =3D bcom_prepare_next_buffer(lpbfifo.bcom_cur_task);
 		bd->status =3D tc;
=2D		bd->data[0] =3D req->data_dma + req->pos;
+		bd->data[0] =3D lpbfifo.data_dma + req->pos;
 		bcom_submit_next_buffer(lpbfifo.bcom_cur_task, NULL);
 	}
=20
@@ -378,9 +379,9 @@ static irqreturn_t mpc52xx_lpbfifo_bcom_irq(int irq, vo=
id *dev_id)
=20
 		if (req) {
 			if (mpc52xx_lpbfifo_is_write(lpbfifo->req->flags))
=2D				dma_unmap_single(lpbfifo->dev, lpbfifo->req->data_dma, lpbfifo->req-=
>size, DMA_TO_DEVICE);
+				dma_unmap_single(lpbfifo->dev, lpbfifo->data_dma, lpbfifo->req->size, =
DMA_TO_DEVICE);
 			else
=2D				dma_unmap_single(lpbfifo->dev, lpbfifo->req->data_dma, lpbfifo->req-=
>size, DMA_FROM_DEVICE);
+				dma_unmap_single(lpbfifo->dev, lpbfifo->data_dma, lpbfifo->req->size, =
DMA_FROM_DEVICE);
=20
 			lpbfifo->req =3D NULL;
 			out_be32(&lpbfifo->regs->enable, MPC52xx_SCLPC_ENABLE_RC | MPC52xx_SCLP=
C_ENABLE_RF);
=2D-=20
1.6.5.5



=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
