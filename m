Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF16C83F12
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Aug 2023 08:28:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RZ3bX0wdvz3c58
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Aug 2023 18:28:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=astralinux.ru (client-ip=217.74.38.119; helo=mail.astralinux.ru; envelope-from=adiupina@astralinux.ru; receiver=lists.ozlabs.org)
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RZ3Zz3mKzz2yQ8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2023 18:27:37 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astralinux.ru (Postfix) with ESMTP id CFF701864F2E;
	Mon, 28 Aug 2023 11:27:30 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
	by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id g40DCzp0QuPr; Mon, 28 Aug 2023 11:27:30 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astralinux.ru (Postfix) with ESMTP id 753F41864EF4;
	Mon, 28 Aug 2023 11:27:30 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
	by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Uc5eHaw1c0Xb; Mon, 28 Aug 2023 11:27:30 +0300 (MSK)
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.233.169])
	by mail.astralinux.ru (Postfix) with ESMTPSA id 315211862F57;
	Mon, 28 Aug 2023 11:27:28 +0300 (MSK)
From: Alexandra Diupina <adiupina@astralinux.ru>
To: Zhao Qiang <qiang.zhao@nxp.com>
Subject: [PATCH v2] fsl_ucc_hdlc: add a check of the return value from hdlc_open
Date: Mon, 28 Aug 2023 11:27:03 +0300
Message-Id: <20230828082703.3246-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <bd4a41b6-339e-67aa-a725-9d833efa6c79@csgroup.eu>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Alexandra Diupina <adiupina@astralinux.ru>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, lvc-project@linuxtesting.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Process the result of hold_open() and return it from
uhdlc_open() in case of an error
It is necessary to pass the error code up the control flow,
similar to a possible error in request_irq()

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
v2: Remove the 'rc' variable (stores the return value of the=20
hdlc_open()) as Christophe Leroy <christophe.leroy@csgroup.eu> suggested
 drivers/net/wan/fsl_ucc_hdlc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdl=
c.c
index cdd9489c712e..4164abea7725 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -708,7 +708,6 @@ static int uhdlc_open(struct net_device *dev)
 	hdlc_device *hdlc =3D dev_to_hdlc(dev);
 	struct ucc_hdlc_private *priv =3D hdlc->priv;
 	struct ucc_tdm *utdm =3D priv->utdm;
-	int rc =3D 0;
=20
 	if (priv->hdlc_busy !=3D 1) {
 		if (request_irq(priv->ut_info->uf_info.irq,
@@ -732,12 +731,10 @@ static int uhdlc_open(struct net_device *dev)
 		napi_enable(&priv->napi);
 		netdev_reset_queue(dev);
 		netif_start_queue(dev);
-		rc =3D hdlc_open(dev);
-		if (rc)
-			return rc;
+		return hdlc_open(dev);
 	}
=20
-	return rc;
+	return 0;
 }
=20
 static void uhdlc_memclean(struct ucc_hdlc_private *priv)
--=20
2.30.2

