Return-Path: <SRS0=nOib=EH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CF7C2D0A3
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2020 23:27:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B132084C
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2020 23:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PPyt9gQi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YYkUh3F+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B132084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CPXJQ5FXmzDqQM
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2020 10:27:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1;
 helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256
 header.s=2020 header.b=PPyt9gQi; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=YYkUh3F+; 
 dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CPXCy5tswzDqNG
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2020 10:23:26 +1100 (AEDT)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1604272998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=objmCB578O0WgDGB399fbmGWIfOjdTh2+ne4BqEHoJU=;
 b=PPyt9gQi7j7MjMIYXsEl00OErW9cxlTBmvxxmHRA/FGlaNAYMu5XE8IgawHZAw5dZ8ywvu
 8JDHDQ6cr0VrgpfoX5HZRGQduSFlh0x2hCC4Mb1CfbTrM2XR+2W8rLJ86KcLzfJU0bmDt+
 MfkngRSJVdNbxanzbZRwwb/SpW5sh0dTA0nDm4T99TEERQ+niZJe5C//A46Iyj4gYkCbZb
 eDqguJ32voH8cFdvh6u72Y2YE/3Xha1CnMtH9zO0mvyWhVsALfvoiaPW/wFP+CMRcdwvpn
 VMUUl+ZU6eB/uY87bR3r1+bpqlf1R34k+ZuLOOOap/1fSPT/z5xThytPbSKh0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1604272998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=objmCB578O0WgDGB399fbmGWIfOjdTh2+ne4BqEHoJU=;
 b=YYkUh3F+7GqKvtRfPzdH2AXrNOpmy92iQAY4Y2efOTLqmgppQoLpDUu0iQCUiIOfz0pK26
 Cua8qoHUulAefKBg==
To: netdev@vger.kernel.org
Subject: [PATCH v2 net-next 2/3] net: dpaa: Replace in_irq() usage.
Date: Mon,  2 Nov 2020 00:22:56 +0100
Message-Id: <20201101232257.3028508-3-bigeasy@linutronix.de>
In-Reply-To: <20201101232257.3028508-1-bigeasy@linutronix.de>
References: <20201101232257.3028508-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
 Madalin Bucur <madalin.bucur@nxp.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Li Yang <leoyang.li@nxp.com>, linux-crypto@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The driver uses in_irq() + in_serving_softirq() magic to decide if NAPI
scheduling is required or packet processing.

The usage of in_*() in drivers is phased out and Linus clearly requested
that code which changes behaviour depending on context should either be
separated or the context be conveyed in an argument passed by the caller,
which usually knows the context.

Use the `sched_napi' argument passed by the callback. It is set true if
called from the interrupt handler and NAPI should be scheduled.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Horia Geant=C4=83" <horia.geanta@nxp.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Madalin Bucur <madalin.bucur@nxp.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: linux-crypto@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/e=
thernet/freescale/dpaa/dpaa_eth.c
index 98ead77c673e5..39c996b64ccec 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2300,9 +2300,9 @@ static void dpaa_tx_conf(struct net_device *net_dev,
 }
=20
 static inline int dpaa_eth_napi_schedule(struct dpaa_percpu_priv *percpu_p=
riv,
-					 struct qman_portal *portal)
+					 struct qman_portal *portal, bool sched_napi)
 {
-	if (unlikely(in_irq() || !in_serving_softirq())) {
+	if (sched_napi) {
 		/* Disable QMan IRQ and invoke NAPI */
 		qman_p_irqsource_remove(portal, QM_PIRQ_DQRI);
=20
@@ -2333,7 +2333,7 @@ static enum qman_cb_dqrr_result rx_error_dqrr(struct =
qman_portal *portal,
=20
 	percpu_priv =3D this_cpu_ptr(priv->percpu_priv);
=20
-	if (dpaa_eth_napi_schedule(percpu_priv, portal))
+	if (dpaa_eth_napi_schedule(percpu_priv, portal, sched_napi))
 		return qman_cb_dqrr_stop;
=20
 	dpaa_eth_refill_bpools(priv);
@@ -2377,7 +2377,7 @@ static enum qman_cb_dqrr_result rx_default_dqrr(struc=
t qman_portal *portal,
 	percpu_priv =3D this_cpu_ptr(priv->percpu_priv);
 	percpu_stats =3D &percpu_priv->stats;
=20
-	if (unlikely(dpaa_eth_napi_schedule(percpu_priv, portal)))
+	if (unlikely(dpaa_eth_napi_schedule(percpu_priv, portal, sched_napi)))
 		return qman_cb_dqrr_stop;
=20
 	/* Make sure we didn't run out of buffers */
@@ -2474,7 +2474,7 @@ static enum qman_cb_dqrr_result conf_error_dqrr(struc=
t qman_portal *portal,
=20
 	percpu_priv =3D this_cpu_ptr(priv->percpu_priv);
=20
-	if (dpaa_eth_napi_schedule(percpu_priv, portal))
+	if (dpaa_eth_napi_schedule(percpu_priv, portal, sched_napi))
 		return qman_cb_dqrr_stop;
=20
 	dpaa_tx_error(net_dev, priv, percpu_priv, &dq->fd, fq->fqid);
@@ -2499,7 +2499,7 @@ static enum qman_cb_dqrr_result conf_dflt_dqrr(struct=
 qman_portal *portal,
=20
 	percpu_priv =3D this_cpu_ptr(priv->percpu_priv);
=20
-	if (dpaa_eth_napi_schedule(percpu_priv, portal))
+	if (dpaa_eth_napi_schedule(percpu_priv, portal, sched_napi))
 		return qman_cb_dqrr_stop;
=20
 	dpaa_tx_conf(net_dev, priv, percpu_priv, &dq->fd, fq->fqid);
--=20
2.29.1

