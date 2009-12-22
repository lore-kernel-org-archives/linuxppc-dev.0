Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 285F7B6F0A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 17:57:50 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 04885BD647
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 07:57:44 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/13] powerpc/5200: LocalPlus driver: fix indentation and
	white space
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
In-Reply-To: <200912220755.09756.roman.fietze@telemotive.de>
MIME-Version: 1.0
Message-ID: <200912220757.44591.roman.fietze@telemotive.de>
Date: Tue, 22 Dec 2009 07:57:44 +0100
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
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc/p=
latforms/52xx/mpc52xx_lpbfifo.c
index 929d017..4c84aa5 100644
=2D-- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
@@ -165,7 +165,7 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfifo=
_request *req)
=20
 	bit_fields =3D req->cs << 24 | 0x000008;
 	if (!write)
=2D		bit_fields |=3D 0x010000; /* read mode */
+		bit_fields |=3D 0x010000;	/* read mode */
 	out_be32(lpbfifo.regs + LPBFIFO_REG_CONTROL, bit_fields);
=20
 	/* Kick it off */
@@ -279,7 +279,7 @@ static irqreturn_t mpc52xx_lpbfifo_irq(int irq, void *d=
ev_id)
 	else
 		do_callback =3D 1;
=20
=2D out:
+out:
 	/* Clear the IRQ */
 	out_8(lpbfifo.regs + LPBFIFO_REG_BYTES_DONE_STATUS, 0x01);
=20
@@ -379,11 +379,11 @@ void mpc52xx_lpbfifo_poll(void)
 	int write =3D req->flags & MPC52XX_LPBFIFO_FLAG_WRITE;
=20
 	/*
=2D	 * For more information, see comments on the "Fat Lady"=20
+	 * For more information, see comments on the "Fat Lady"
 	 */
 	if (dma && write)
 		mpc52xx_lpbfifo_irq(0, NULL);
=2D	else=20
+	else
 		mpc52xx_lpbfifo_bcom_irq(0, NULL);
 }
 EXPORT_SYMBOL(mpc52xx_lpbfifo_poll);
@@ -491,12 +491,12 @@ mpc52xx_lpbfifo_probe(struct of_device *op, const str=
uct of_device_id *match)
 	lpbfifo.dev =3D &op->dev;
 	return 0;
=20
=2D err_bcom_tx:
+err_bcom_tx:
 	free_irq(bcom_get_task_irq(lpbfifo.bcom_rx_task), &lpbfifo);
=2D err_bcom_rx_irq:
+err_bcom_rx_irq:
 	bcom_gen_bd_rx_release(lpbfifo.bcom_rx_task);
=2D err_bcom_rx:
=2D err_irq:
+err_bcom_rx:
+err_irq:
 	iounmap(lpbfifo.regs);
 	lpbfifo.regs =3D NULL;
=20
@@ -516,7 +516,7 @@ static int __devexit mpc52xx_lpbfifo_remove(struct of_d=
evice *op)
 	/* Release the bestcomm transmit task */
 	free_irq(bcom_get_task_irq(lpbfifo.bcom_tx_task), &lpbfifo);
 	bcom_gen_bd_tx_release(lpbfifo.bcom_tx_task);
=2D=09
+
 	/* Release the bestcomm receive task */
 	free_irq(bcom_get_task_irq(lpbfifo.bcom_rx_task), &lpbfifo);
 	bcom_gen_bd_rx_release(lpbfifo.bcom_rx_task);
=2D-=20
1.6.5.5


=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
