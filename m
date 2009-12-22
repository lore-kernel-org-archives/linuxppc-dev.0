Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E78CFB6F05
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 17:59:29 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id B7313BADFD
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 07:59:23 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 02/13] powerpc/5200: LocalPlus driver: use SCLPC register
	structure
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
In-Reply-To: <200912220755.09756.roman.fietze@telemotive.de>
MIME-Version: 1.0
Message-ID: <200912220759.23453.roman.fietze@telemotive.de>
Date: Tue, 22 Dec 2009 07:59:23 +0100
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
 arch/powerpc/include/asm/mpc52xx.h            |   24 ++++++++
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c |   79 +++++++++++----------=
=2D---
 2 files changed, 59 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/asm/=
mpc52xx.h
index b664ce7..57f8335 100644
=2D-- a/arch/powerpc/include/asm/mpc52xx.h
+++ b/arch/powerpc/include/asm/mpc52xx.h
@@ -193,6 +193,30 @@ struct mpc52xx_xlb {
 #define MPC52xx_XLB_CFG_PLDIS		(1 << 31)
 #define MPC52xx_XLB_CFG_SNOOP		(1 << 15)
=20
+/* SCLPC */
+struct mpc52xx_sclpc {
+	union {
+		u8 restart;	/* 0x00 restart bit */
+		u32 packet_size; /* 0x00 packet size register */
+	} packet_size;
+	u32 start_address;	/* 0x04	start Address register */
+	u32 control;		/* 0x08	control register */
+	u32 enable;		/* 0x0C	enable register */
+	u32 unused0;		/* 0x10 */
+	union {
+		u8 status;	/* 0x14	status register bits */
+		u32 bytes_done; /* 0x14	bytes done register bits, read only */
+	} bytes_done_status;
+
+	u32 reserved1[(0x40-0x18) / sizeof(u32)];	/* 0x18 .. 0x3c */
+
+	u32 fifo_data;		/* 0x40	FIFO data word register */
+	u32 fifo_status;	/* 0x44	FIFO status register */
+	u8 fifo_control;	/* 0x48	FIFO control register */
+	u8 reserved2[3];
+	u32 fifo_alarm;		/* 0x4C	FIFO alarm register */
+};
+
 /* Clock Distribution control */
 struct mpc52xx_cdm {
 	u32 jtag_id;		/* CDM + 0x00  reg0 read only */
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc/p=
latforms/52xx/mpc52xx_lpbfifo.c
index 4c84aa5..2763d5e 100644
=2D-- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
@@ -27,20 +27,10 @@ MODULE_AUTHOR("Grant Likely <grant.likely@secretlab.ca>=
");
 MODULE_DESCRIPTION("MPC5200 LocalPlus FIFO device driver");
 MODULE_LICENSE("GPL");
=20
=2D#define LPBFIFO_REG_PACKET_SIZE		(0x00)
=2D#define LPBFIFO_REG_START_ADDRESS	(0x04)
=2D#define LPBFIFO_REG_CONTROL		(0x08)
=2D#define LPBFIFO_REG_ENABLE		(0x0C)
=2D#define LPBFIFO_REG_BYTES_DONE_STATUS	(0x14)
=2D#define LPBFIFO_REG_FIFO_DATA		(0x40)
=2D#define LPBFIFO_REG_FIFO_STATUS		(0x44)
=2D#define LPBFIFO_REG_FIFO_CONTROL	(0x48)
=2D#define LPBFIFO_REG_FIFO_ALARM		(0x4C)
=2D
 struct mpc52xx_lpbfifo {
 	struct device *dev;
 	phys_addr_t regs_phys;
=2D	void __iomem *regs;
+	struct mpc52xx_sclpc __iomem *regs;
 	int irq;
 	spinlock_t lock;
=20
@@ -72,10 +62,10 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo=
_request *req)
 	int poll_dma =3D req->flags & MPC52XX_LPBFIFO_FLAG_POLL_DMA;
=20
 	/* Set and clear the reset bits; is good practice in User Manual */
=2D	out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x01010000);
+	out_be32(&lpbfifo.regs->enable, 0x01010000);
=20
 	/* set master enable bit */
=2D	out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x00000001);
+	out_be32(&lpbfifo.regs->enable, 0x00000001);
 	if (!dma) {
 		/* While the FIFO can be setup for transfer sizes as large as
 		 * 16M-1, the FIFO itself is only 512 bytes deep and it does
@@ -91,14 +81,14 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo=
_request *req)
=20
 		/* Load the FIFO with data */
 		if (write) {
=2D			reg =3D lpbfifo.regs + LPBFIFO_REG_FIFO_DATA;
+			reg =3D &lpbfifo.regs->fifo_data;
 			data =3D req->data + req->pos;
 			for (i =3D 0; i < transfer_size; i +=3D 4)
 				out_be32(reg, *data++);
 		}
=20
 		/* Unmask both error and completion irqs */
=2D		out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x00000301);
+		out_be32(&lpbfifo.regs->enable, 0x00000301);
 	} else {
 		/* Choose the correct direction
 		 *
@@ -108,12 +98,12 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfif=
o_request *req)
 		 * is a risk of DMA not transferring the last chunk of data
 		 */
 		if (write) {
=2D			out_be32(lpbfifo.regs + LPBFIFO_REG_FIFO_ALARM, 0x1e4);
=2D			out_8(lpbfifo.regs + LPBFIFO_REG_FIFO_CONTROL, 7);
+			out_be32(&lpbfifo.regs->fifo_alarm, 0x1e4);
+			out_8(&lpbfifo.regs->fifo_control, 7);
 			lpbfifo.bcom_cur_task =3D lpbfifo.bcom_tx_task;
 		} else {
=2D			out_be32(lpbfifo.regs + LPBFIFO_REG_FIFO_ALARM, 0x1ff);
=2D			out_8(lpbfifo.regs + LPBFIFO_REG_FIFO_CONTROL, 0);
+			out_be32(&lpbfifo.regs->fifo_alarm, 0x1ff);
+			out_8(&lpbfifo.regs->fifo_control, 0);
 			lpbfifo.bcom_cur_task =3D lpbfifo.bcom_rx_task;
=20
 			if (poll_dma) {
@@ -155,21 +145,21 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfi=
fo_request *req)
 		/* Unmask irqs */
 		if (write && (!poll_dma))
 			bit_fields |=3D 0x00000100; /* completion irq too */
=2D		out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, bit_fields);
+		out_be32(&lpbfifo.regs->enable, bit_fields);
 	}
=20
 	/* Set transfer size, width, chip select and READ mode */
=2D	out_be32(lpbfifo.regs + LPBFIFO_REG_START_ADDRESS,
+	out_be32(&lpbfifo.regs->start_address,
 		 req->offset + req->pos);
=2D	out_be32(lpbfifo.regs + LPBFIFO_REG_PACKET_SIZE, transfer_size);
+	out_be32(&lpbfifo.regs->packet_size.packet_size, transfer_size);
=20
 	bit_fields =3D req->cs << 24 | 0x000008;
 	if (!write)
 		bit_fields |=3D 0x010000;	/* read mode */
=2D	out_be32(lpbfifo.regs + LPBFIFO_REG_CONTROL, bit_fields);
+	out_be32(&lpbfifo.regs->control, bit_fields);
=20
 	/* Kick it off */
=2D	out_8(lpbfifo.regs + LPBFIFO_REG_PACKET_SIZE, 0x01);
+	out_8(&lpbfifo.regs->packet_size.restart, 0x01);
 	if (dma)
 		bcom_enable(lpbfifo.bcom_cur_task);
 }
@@ -218,7 +208,7 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo=
_request *req)
 static irqreturn_t mpc52xx_lpbfifo_irq(int irq, void *dev_id)
 {
 	struct mpc52xx_lpbfifo_request *req;
=2D	u32 status =3D in_8(lpbfifo.regs + LPBFIFO_REG_BYTES_DONE_STATUS);
+	u32 status =3D in_8(&lpbfifo.regs->bytes_done_status.status);
 	void __iomem *reg;
 	u32 *data;
 	int count, i;
@@ -253,18 +243,18 @@ static irqreturn_t mpc52xx_lpbfifo_irq(int irq, void =
*dev_id)
=20
 	/* check abort bit */
 	if (status & 0x10) {
=2D		out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x01010000);
+		out_be32(&lpbfifo.regs->enable, 0x01010000);
 		do_callback =3D 1;
 		goto out;
 	}
=20
 	/* Read result from hardware */
=2D	count =3D in_be32(lpbfifo.regs + LPBFIFO_REG_BYTES_DONE_STATUS);
+	count =3D in_be32(&lpbfifo.regs->bytes_done_status.bytes_done);
 	count &=3D 0x00ffffff;
=20
 	if (!dma && !write) {
 		/* copy the data out of the FIFO */
=2D		reg =3D lpbfifo.regs + LPBFIFO_REG_FIFO_DATA;
+		reg =3D &lpbfifo.regs->fifo_data;
 		data =3D req->data + req->pos;
 		for (i =3D 0; i < count; i +=3D 4)
 			*data++ =3D in_be32(reg);
@@ -281,7 +271,7 @@ static irqreturn_t mpc52xx_lpbfifo_irq(int irq, void *d=
ev_id)
=20
 out:
 	/* Clear the IRQ */
=2D	out_8(lpbfifo.regs + LPBFIFO_REG_BYTES_DONE_STATUS, 0x01);
+	out_8(&lpbfifo.regs->bytes_done_status.status, 0x01);
=20
 	if (dma && (status & 0x11)) {
 		/*
@@ -379,11 +369,11 @@ void mpc52xx_lpbfifo_poll(void)
 	int write =3D req->flags & MPC52XX_LPBFIFO_FLAG_WRITE;
=20
 	/*
=2D	 * For more information, see comments on the "Fat Lady"
+	 * For more information, see comments on the "Fat Lady"=20
 	 */
 	if (dma && write)
 		mpc52xx_lpbfifo_irq(0, NULL);
=2D	else
+	else=20
 		mpc52xx_lpbfifo_bcom_irq(0, NULL);
 }
 EXPORT_SYMBOL(mpc52xx_lpbfifo_poll);
@@ -429,7 +419,7 @@ void mpc52xx_lpbfifo_abort(struct mpc52xx_lpbfifo_reque=
st *req)
 		/* Put it into reset and clear the state */
 		bcom_gen_bd_rx_reset(lpbfifo.bcom_rx_task);
 		bcom_gen_bd_tx_reset(lpbfifo.bcom_tx_task);
=2D		out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x01010000);
+		out_be32(&lpbfifo.regs->enable, 0x01010000);
 		lpbfifo.req =3D NULL;
 	}
 	spin_unlock_irqrestore(&lpbfifo.lock, flags);
@@ -459,19 +449,19 @@ mpc52xx_lpbfifo_probe(struct of_device *op, const str=
uct of_device_id *match)
 	spin_lock_init(&lpbfifo.lock);
=20
 	/* Put FIFO into reset */
=2D	out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x01010000);
+	out_be32(&lpbfifo.regs->enable, 0x01010000);
=20
=2D	/* Register the interrupt handler */
+	/* register the interrupt handler */
 	rc =3D request_irq(lpbfifo.irq, mpc52xx_lpbfifo_irq, 0,
 			 "mpc52xx-lpbfifo", &lpbfifo);
 	if (rc)
 		goto err_irq;
=20
 	/* Request the Bestcomm receive (fifo --> memory) task and IRQ */
=2D	lpbfifo.bcom_rx_task =3D
=2D		bcom_gen_bd_rx_init(2, res.start + LPBFIFO_REG_FIFO_DATA,
=2D				    BCOM_INITIATOR_SCLPC, BCOM_IPR_SCLPC,
=2D				    16*1024*1024);
+	lpbfifo.bcom_rx_task =3D bcom_gen_bd_rx_init(2,
+						   res.start + offsetof(struct mpc52xx_sclpc, fifo_data),
+						   BCOM_INITIATOR_SCLPC, BCOM_IPR_SCLPC,
+						   16*1024*1024);
 	if (!lpbfifo.bcom_rx_task)
 		goto err_bcom_rx;
=20
@@ -482,9 +472,10 @@ mpc52xx_lpbfifo_probe(struct of_device *op, const stru=
ct of_device_id *match)
 		goto err_bcom_rx_irq;
=20
 	/* Request the Bestcomm transmit (memory --> fifo) task and IRQ */
=2D	lpbfifo.bcom_tx_task =3D
=2D		bcom_gen_bd_tx_init(2, res.start + LPBFIFO_REG_FIFO_DATA,
=2D				    BCOM_INITIATOR_SCLPC, BCOM_IPR_SCLPC);
+	lpbfifo.bcom_tx_task =3D bcom_gen_bd_tx_init(2,
+						   res.start + offsetof(struct mpc52xx_sclpc, fifo_data),
+						   BCOM_INITIATOR_SCLPC,
+						   BCOM_IPR_SCLPC);
 	if (!lpbfifo.bcom_tx_task)
 		goto err_bcom_tx;
=20
@@ -511,12 +502,12 @@ static int __devexit mpc52xx_lpbfifo_remove(struct of=
_device *op)
 		return 0;
=20
 	/* Put FIFO in reset */
=2D	out_be32(lpbfifo.regs + LPBFIFO_REG_ENABLE, 0x01010000);
+	out_be32(&lpbfifo.regs->enable, 0x01010000);
=20
=2D	/* Release the bestcomm transmit task */
+	/* release the bestcomm transmit task */
 	free_irq(bcom_get_task_irq(lpbfifo.bcom_tx_task), &lpbfifo);
 	bcom_gen_bd_tx_release(lpbfifo.bcom_tx_task);
=2D
+=09
 	/* Release the bestcomm receive task */
 	free_irq(bcom_get_task_irq(lpbfifo.bcom_rx_task), &lpbfifo);
 	bcom_gen_bd_rx_release(lpbfifo.bcom_rx_task);
=2D-=20
1.6.5.5


=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
