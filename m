Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 243F2B7D10
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Mar 2010 17:05:44 +1100 (EST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] mpc52xx_lpbfifo: flag DMA irqs as enabled after requesting
	them
MIME-Version: 1.0
Message-ID: <201003120658.55967.roman.fietze@telemotive.de>
Date: Fri, 12 Mar 2010 06:58:55 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

This patch avoids unbalanced enable/disable messages for the DMA
interrupts when running the 5200 platform SCLPC/BestComm driver in DMA
mode.


Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
=2D--
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc/p=
latforms/52xx/mpc52xx_lpbfifo.c
index 929d017..d4f8be3 100644
=2D-- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
@@ -481,6 +481,8 @@ mpc52xx_lpbfifo_probe(struct of_device *op, const struc=
t of_device_id *match)
 	if (rc)
 		goto err_bcom_rx_irq;
=20
+	lpbfifo.dma_irqs_enabled =3D 1;
+
 	/* Request the Bestcomm transmit (memory --> fifo) task and IRQ */
 	lpbfifo.bcom_tx_task =3D
 		bcom_gen_bd_tx_init(2, res.start + LPBFIFO_REG_FIFO_DATA,
=2D-=20
1.7.0.1


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
