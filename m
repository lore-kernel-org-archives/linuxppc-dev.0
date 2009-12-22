Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 29E16B7D1A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 18:08:20 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 1CB19BADFD
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 08:08:15 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 09/13] powerpc/5200: LocalPlus driver: smarter calculation of
	BPT, bytes per transfer
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
In-Reply-To: <200912220755.09756.roman.fietze@telemotive.de>
MIME-Version: 1.0
Message-ID: <200912220808.14759.roman.fietze@telemotive.de>
Date: Tue, 22 Dec 2009 08:08:14 +0100
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
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c |   33 +++++++++++++++------=
=2D---
 1 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc/p=
latforms/52xx/mpc52xx_lpbfifo.c
index 48f2b4f..21b2a40 100644
=2D-- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
@@ -80,11 +80,11 @@ static inline int mpc52xx_lpbfifo_is_poll_dma(int flags)
  */
 static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo_request *req)
 {
=2D	size_t transfer_size =3D req->size - req->pos;
+	size_t tc =3D req->size - req->pos;
 	struct bcom_bd *bd;
 	void __iomem *reg;
 	u32 *data;
=2D	u32 bit_fields;
+	u32 control;
 	int rflags =3D req->flags;
=20
 	/* Set and clear the reset bits; is good practice in User Manual */
@@ -93,10 +93,10 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo=
_request *req)
 	/* Set width, chip select and READ mode */
 	out_be32(&lpbfifo.regs->start_address, req->offset + req->pos);
=20
=2D	/* Set CS and BPT */
=2D	bit_fields =3D MPC52xx_SCLPC_CONTROL_CS(req->cs) | 0x8;
+	/* Setup CS */
+	control =3D MPC52xx_SCLPC_CONTROL_CS(req->cs);
 	if (!(mpc52xx_lpbfifo_is_write(rflags)))
=2D		bit_fields |=3D MPC52xx_SCLPC_CONTROL_RWB_RECEIVE;	/* read mode */
+		control |=3D MPC52xx_SCLPC_CONTROL_RWB_RECEIVE;	/* read mode */
=20
 	if (!mpc52xx_lpbfifo_is_dma(rflags)) {
 		/* While the FIFO can be setup for transfer sizes as
@@ -112,10 +112,10 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfi=
fo_request *req)
 		 * The last block of data will be received with the
 		 * flush bit set. This avoids stale read data.
 		 */
=2D		if (transfer_size > 512)
=2D			transfer_size =3D 512;
+		if (tc > 512)
+			tc =3D 512;
 		else if (!(mpc52xx_lpbfifo_is_write(rflags)))
=2D			bit_fields |=3D MPC52xx_SCLPC_CONTROL_FLUSH;
+			control |=3D MPC52xx_SCLPC_CONTROL_FLUSH;
=20
 		/* Load the FIFO with data */
 		if (mpc52xx_lpbfifo_is_write(rflags)) {
@@ -123,7 +123,7 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo=
_request *req)
=20
 			reg =3D &lpbfifo.regs->fifo_data;
 			data =3D req->data + req->pos;
=2D			for (i =3D 0; i < transfer_size; i +=3D 4)
+			for (i =3D 0; i < tc; i +=3D 4)
 				out_be32(reg, *data++);
 		}
=20
@@ -136,7 +136,7 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo=
_request *req)
 		/* In DMA mode we can always set the flush bit to avoid
 		 * stale read data. */
 		if (!(mpc52xx_lpbfifo_is_write(rflags)))
=2D			bit_fields |=3D MPC52xx_SCLPC_CONTROL_FLUSH;
+			control |=3D MPC52xx_SCLPC_CONTROL_FLUSH;
=20
 		/* Choose the correct direction
 		 *
@@ -173,15 +173,17 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfi=
fo_request *req)
 		out_be32(&lpbfifo.regs->enable, MPC52xx_SCLPC_ENABLE_AIE | MPC52xx_SCLPC=
_ENABLE_NIE | MPC52xx_SCLPC_ENABLE_ME);
=20
 		bd =3D bcom_prepare_next_buffer(lpbfifo.bcom_cur_task);
=2D		bd->status =3D transfer_size;
+		bd->status =3D tc;
 		bd->data[0] =3D req->data_dma + req->pos;
 		bcom_submit_next_buffer(lpbfifo.bcom_cur_task, NULL);
 	}
=20
=2D	out_be32(&lpbfifo.regs->control, bit_fields);
+	/* Setup BPT. tc is already screened and a multiple of 4 */
+	control |=3D tc & 7 ? 4 : 8;
+	out_be32(&lpbfifo.regs->control, control);
=20
 	/* Set packet size and kick it off */
=2D	out_be32(&lpbfifo.regs->packet_size.packet_size, MPC52xx_SCLPC_PACKET_S=
IZE_RESTART | transfer_size);
+	out_be32(&lpbfifo.regs->packet_size.packet_size, MPC52xx_SCLPC_PACKET_SIZ=
E_RESTART | tc);
 	if (mpc52xx_lpbfifo_is_dma(rflags))
 		bcom_enable(lpbfifo.bcom_cur_task);
 }
@@ -395,6 +397,11 @@ int mpc52xx_lpbfifo_submit(struct mpc52xx_lpbfifo_requ=
est *req)
 	if (!lpbfifo.regs)
 		return -ENODEV;
=20
+	/* The gen bd BestComm task currently only allows an increment
+	 * of 4 */
+	if (!req->size || req->size & 0x03)
+		return -EINVAL;
+
 	spin_lock_irqsave(&lpbfifo.lock, flags);
=20
 	/* If the req pointer is already set, then a transfer is in progress */
=2D-=20
1.6.5.5



=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
