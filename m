Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id BF1A8B7BCA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 18:06:38 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 84348BADFD
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 08:06:33 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 08/13] powerpc/5200: LocalPlus driver: smart flush of receive
	FIFO
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
In-Reply-To: <200912220755.09756.roman.fietze@telemotive.de>
MIME-Version: 1.0
Message-ID: <200912220806.33304.roman.fietze@telemotive.de>
Date: Tue, 22 Dec 2009 08:06:33 +0100
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
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c |   40 ++++++++++++++++-----=
=2D---
 1 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc/p=
latforms/52xx/mpc52xx_lpbfifo.c
index a7cd585..48f2b4f 100644
=2D-- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
@@ -84,8 +84,7 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo_r=
equest *req)
 	struct bcom_bd *bd;
 	void __iomem *reg;
 	u32 *data;
=2D	int i;
=2D	int bit_fields;
+	u32 bit_fields;
 	int rflags =3D req->flags;
=20
 	/* Set and clear the reset bits; is good practice in User Manual */
@@ -96,27 +95,32 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo=
_request *req)
=20
 	/* Set CS and BPT */
 	bit_fields =3D MPC52xx_SCLPC_CONTROL_CS(req->cs) | 0x8;
=2D	if (!(mpc52xx_lpbfifo_is_write(rflags))) {
+	if (!(mpc52xx_lpbfifo_is_write(rflags)))
 		bit_fields |=3D MPC52xx_SCLPC_CONTROL_RWB_RECEIVE;	/* read mode */
=2D		bit_fields |=3D MPC52xx_SCLPC_CONTROL_FLUSH;
=2D	}
=2D	out_be32(&lpbfifo.regs->control, bit_fields);
=20
 	if (!mpc52xx_lpbfifo_is_dma(rflags)) {
=2D		/* While the FIFO can be setup for transfer sizes as large as
=2D		 * 16M-1, the FIFO itself is only 512 bytes deep and it does
=2D		 * not generate interrupts for FIFO full events (only transfer
=2D		 * complete will raise an IRQ).  Therefore when not using
=2D		 * Bestcomm to drive the FIFO it needs to either be polled, or
=2D		 * transfers need to constrained to the size of the fifo.
+		/* While the FIFO can be setup for transfer sizes as
+		 * large as 16M-1, the FIFO itself is only 512 bytes
+		 * deep and it does not generate interrupts for FIFO
+		 * full events (only transfer complete will raise an
+		 * IRQ). Therefore when not using Bestcomm to drive the
+		 * FIFO it needs to either be polled, or transfers need
+		 * to constrained to the size of the fifo.
 		 *
 		 * This driver restricts the size of the transfer
+		 *
+		 * The last block of data will be received with the
+		 * flush bit set. This avoids stale read data.
 		 */
 		if (transfer_size > 512)
 			transfer_size =3D 512;
+		else if (!(mpc52xx_lpbfifo_is_write(rflags)))
+			bit_fields |=3D MPC52xx_SCLPC_CONTROL_FLUSH;
=20
 		/* Load the FIFO with data */
 		if (mpc52xx_lpbfifo_is_write(rflags)) {
+			size_t i;
+
 			reg =3D &lpbfifo.regs->fifo_data;
 			data =3D req->data + req->pos;
 			for (i =3D 0; i < transfer_size; i +=3D 4)
@@ -128,6 +132,12 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfif=
o_request *req)
 						 MPC52xx_SCLPC_ENABLE_NIE |
 						 MPC52xx_SCLPC_ENABLE_ME));
 	} else {
+
+		/* In DMA mode we can always set the flush bit to avoid
+		 * stale read data. */
+		if (!(mpc52xx_lpbfifo_is_write(rflags)))
+			bit_fields |=3D MPC52xx_SCLPC_CONTROL_FLUSH;
+
 		/* Choose the correct direction
 		 *
 		 * Configure the watermarks so DMA will always complete correctly.
@@ -168,6 +178,8 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo=
_request *req)
 		bcom_submit_next_buffer(lpbfifo.bcom_cur_task, NULL);
 	}
=20
+	out_be32(&lpbfifo.regs->control, bit_fields);
+
 	/* Set packet size and kick it off */
 	out_be32(&lpbfifo.regs->packet_size.packet_size, MPC52xx_SCLPC_PACKET_SIZ=
E_RESTART | transfer_size);
 	if (mpc52xx_lpbfifo_is_dma(rflags))
@@ -455,7 +467,7 @@ mpc52xx_lpbfifo_probe(struct of_device *op, const struc=
t of_device_id *match)
 		goto err_irq;
=20
 	/* Request the Bestcomm receive (fifo --> memory) task and IRQ */
=2D	lpbfifo.bcom_rx_task =3D bcom_gen_bd_rx_init(4,
+	lpbfifo.bcom_rx_task =3D bcom_gen_bd_rx_init(2,
 						   res.start + offsetof(struct mpc52xx_sclpc, fifo_data),
 						   BCOM_INITIATOR_SCLPC, BCOM_IPR_SCLPC,
 						   16 * 1024 * 1024);
@@ -469,7 +481,7 @@ mpc52xx_lpbfifo_probe(struct of_device *op, const struc=
t of_device_id *match)
 		goto err_bcom_rx_irq;
=20
 	/* Request the Bestcomm transmit (memory --> fifo) task and IRQ */
=2D	lpbfifo.bcom_tx_task =3D bcom_gen_bd_tx_init(4,
+	lpbfifo.bcom_tx_task =3D bcom_gen_bd_tx_init(2,
 						   res.start + offsetof(struct mpc52xx_sclpc, fifo_data),
 						   BCOM_INITIATOR_SCLPC,
 						   BCOM_IPR_SCLPC);
=2D-=20
1.6.5.5



=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
