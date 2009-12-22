Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A0B4AB7C11
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 18:05:25 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 6B5B8C01F3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 08:05:20 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/13] powerpc/5200: LocalPlus driver: reset BestComm when
	committing new request
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
In-Reply-To: <200912220755.09756.roman.fietze@telemotive.de>
MIME-Version: 1.0
Message-ID: <200912220805.20200.roman.fietze@telemotive.de>
Date: Tue, 22 Dec 2009 08:05:20 +0100
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
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc/p=
latforms/52xx/mpc52xx_lpbfifo.c
index 8d8a63a..a7cd585 100644
=2D-- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
@@ -398,6 +398,8 @@ int mpc52xx_lpbfifo_submit(struct mpc52xx_lpbfifo_reque=
st *req)
 	req->buffer_not_done_cnt =3D 0;
 	req->pos =3D 0;
=20
+	bcom_gen_bd_rx_reset(lpbfifo.bcom_rx_task);
+	bcom_gen_bd_tx_reset(lpbfifo.bcom_tx_task);
 	mpc52xx_lpbfifo_kick(req);
 	spin_unlock_irqrestore(&lpbfifo.lock, flags);
=20
@@ -456,7 +458,7 @@ mpc52xx_lpbfifo_probe(struct of_device *op, const struc=
t of_device_id *match)
 	lpbfifo.bcom_rx_task =3D bcom_gen_bd_rx_init(4,
 						   res.start + offsetof(struct mpc52xx_sclpc, fifo_data),
 						   BCOM_INITIATOR_SCLPC, BCOM_IPR_SCLPC,
=2D						   16*1024*1024);
+						   16 * 1024 * 1024);
 	if (!lpbfifo.bcom_rx_task)
 		goto err_bcom_rx;
=20
=2D-=20
1.6.5.5



=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
