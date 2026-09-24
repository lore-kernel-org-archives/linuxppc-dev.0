Return-Path: <linuxppc-dev+bounces-28093-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA38C98310
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 07:19:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hr4w81QG2z2yD3;
	Thu, 24 Sep 2026 17:19:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.17.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790234376;
	cv=none; b=jonAfLJZRrd4cNKb/oWfkR0xogE1EPR6x+y9XofRwwJLsOfutOi5qmeKkdJZk+T4K5kyfp2dCXee6oZ4k9qBSws0UuxsT46Ad/3X6UsHMZObP2lqfcsolEPKCrTmhrupWWV/UtocanXoEQi7oiufGASclBT09+fJ7rA96F2Qv4AkUdwuAffcqMszH3jzLX/0HhpZg7Wur31ibEdCYuCbQA8I3SaJxqi/VXvEHRXDiRGWO3QuyxrLpdz11fKLJ2+4XIaAyf+RN0VdB21GCurdS/XQ3BzHGNubmGGfsHLCLKNPSySaEFZgi6cOJO8xdfqKefnPecKHYBARom2JepSp9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790234376; c=relaxed/relaxed;
	bh=0XUgHBKl+8aNjpnuXAg3u8yjXgijKHdoDznpTqDalNM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=d1vYDnpNCSvLuEtg2JBZjSUfsBgtx23T82N9sGakKZ8EL+/8tZ9ltdU1e6MJF8nUm0OdcpboGj2mmCwQIo/KTeh2VPILiDZ6Mo0TSSLW+iCVLjQzn47duzUysYkI19cH3wpoQvs/RvONqRkFSiGP/XBkhm1b4O55Vgkk6eSEZBEPDZ77bnwoPl3R4xYAKEKKVfjuqZu938EB7SVIArm9gEGItaDx/8F/4EwM6gVVkRAA+kSuHyAmTYA6qg+de1rbzYWC3HkTgH3bA5qeDGlscB8uouZBKDNDdLuEcZzG+rpesFobOnSBwKeR845pZttFZYAk8S5f8ywCAG3QSVXgiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=f7SYQF6L; dkim-atps=neutral; spf=pass (client-ip=212.227.17.12; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=f7SYQF6L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.17.12; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 189 seconds by postgrey-1.37 at boromir; Thu, 24 Sep 2026 17:19:32 AEST
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hr4w45H1Tz2y7Y
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 17:19:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1790234364; x=1790839164; i=markus.elfring@web.de;
	bh=0XUgHBKl+8aNjpnuXAg3u8yjXgijKHdoDznpTqDalNM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=f7SYQF6Lo8dA1BKUG4ZeB//SXZeERtICUdzQLL2S436Fz9/Ucr95g/qxjW2UORd9
	 5B3yX7XAYEUH5tEByalbCbR//bgBn9zW5D60/j9wV+1v5JAgRuKQTGsuRqvdXY4BW
	 gW0qKHWB28c9c4M1rlqllu2OB/VPvLYAzTYYKKXs29NL7ZkWhrD9rqNQ2qfEpuunK
	 2pRA9uTtCa0CU91g9vBu0Yu9jaFlIqQEJo1Npto6JzGGP49cXMVpFvKOUXKpm3npj
	 YFVi+5ViWee+69fGAKRIUazTExvIZ4+DkSvo44pKlc0RFywF6sMO2Xpw5f1K46xR3
	 jSiZS7yuJkkdNdfmOQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlsOP-1wSMYh3Qgd-00naCI; Thu, 24
 Sep 2026 09:19:24 +0200
Message-ID: <1c14d2a2-895e-4acd-9469-e518d2dda1ad@web.de>
Date: Thu, 24 Sep 2026 09:19:21 +0200
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 2/2] soc: fsl: dpio: Use scope-based resource management in
 dpaa2_io_create()
From: Markus Elfring <Markus.Elfring@web.de>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <chleroy@kernel.org>, Dan Carpenter <error27@gmail.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Roy Pledge <Roy.Pledge@nxp.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>
References: <6c08552a-49e9-4ee0-b1ba-b27e17ade9c5@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <6c08552a-49e9-4ee0-b1ba-b27e17ade9c5@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XaTPsWKm/lHJ41HrppNk3GbFDvoBtakRL2oGWScPPXpcbHwuA3w
 +Px3i5pSDiNpoaS9GgUElzEixmMCJC9nCQ7gi1+63mwewmowpEArngId4K1ohmvLBMGV7Um
 CGp0CT+y/lsOUaSSeUg92NDhv5R0wfo26occutN8RIl0psDLTONeol86JR1/qy2wHS/q6Wp
 zNgRbALL1RyeGyUj42F9g==
UI-OutboundReport: notjunk:1;M01:P0:ETiO0FwLrHE=;q5/FzNVVDjL/nOFSr9NehwmAQjq
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 24 Sep 2026 08:42:19 +0200

Scope-based resource management became supported for some
programming interfaces by contributions of Peter Zijlstra on 2023-05-26.
See also the commit 54da6a0924311c7cf5015533991e44fb8eb12773 ("locking:
Introduce __cleanup() based infrastructure").

* Move some source code from the implementation of the function
  =E2=80=9Cdpaa2_io_create=E2=80=9D to a new function.

* Use the attribute =E2=80=9C__free(kfree)=E2=80=9D for the local variable=
 =E2=80=9Cobj=E2=80=9D.

* Omit two kfree() calls accordingly.

* Replace a return statement by the macro call =E2=80=9Creturn_ptr(obj)=E2=
=80=9D.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/soc/fsl/dpio/dpio-service.c | 48 +++++++++++++++--------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dp=
io-service.c
index cb870aae30b4..8085c42c74ce 100644
=2D-- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -121,31 +121,15 @@ static void dpaa2_io_dim_work(struct work_struct *w)
 	dim->state =3D DIM_START_MEASURE;
 }
=20
-/**
- * dpaa2_io_create() - create a dpaa2_io object.
- * @desc: the dpaa2_io descriptor
- * @dev: the actual DPIO device
- *
- * Activates a "struct dpaa2_io" corresponding to the given config of an =
actual
- * DPIO object.
- *
- * Return a valid dpaa2_io object for success, or NULL for failure.
- */
-struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc,
-				 struct device *dev)
+static inline
+struct dpaa2_io *dpaa2_io_create_impl(const struct dpaa2_io_desc *desc, s=
truct device *dev)
 {
-	struct dpaa2_io *obj =3D kmalloc_obj(*obj);
 	u32 qman_256_cycles_per_ns;
+	struct dpaa2_io *obj __free(kfree) =3D kmalloc_obj(*obj);
=20
 	if (!obj)
 		return NULL;
=20
-	/* check if CPU is out of range (-1 means any cpu) */
-	if (desc->cpu !=3D DPAA2_IO_ANY_CPU && desc->cpu >=3D num_possible_cpus(=
)) {
-		kfree(obj);
-		return NULL;
-	}
-
 	obj->dpio_desc =3D *desc;
 	obj->swp_desc.cena_bar =3D obj->dpio_desc.regs_cena;
 	obj->swp_desc.cinh_bar =3D obj->dpio_desc.regs_cinh;
@@ -160,10 +144,8 @@ struct dpaa2_io *dpaa2_io_create(const struct dpaa2_i=
o_desc *desc,
 	obj->swp_desc.qman_256_cycles_per_ns =3D qman_256_cycles_per_ns;
 	obj->swp =3D qbman_swp_init(&obj->swp_desc);
=20
-	if (!obj->swp) {
-		kfree(obj);
+	if (!obj->swp)
 		return NULL;
-	}
=20
 	INIT_LIST_HEAD(&obj->node);
 	spin_lock_init(&obj->lock_mgmt_cmd);
@@ -192,7 +174,27 @@ struct dpaa2_io *dpaa2_io_create(const struct dpaa2_i=
o_desc *desc,
 	obj->bytes =3D 0;
 	obj->frames =3D 0;
=20
-	return obj;
+	return_ptr(obj);
+}
+
+/**
+ * dpaa2_io_create() - create a dpaa2_io object.
+ * @desc: the dpaa2_io descriptor
+ * @dev: the actual DPIO device
+ *
+ * Activates a "struct dpaa2_io" corresponding to the given config of an =
actual
+ * DPIO object.
+ *
+ * Return a valid dpaa2_io object for success, or NULL for failure.
+ */
+struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc,
+				 struct device *dev)
+{
+	/* check if CPU is out of range (-1 means any cpu) */
+	if (desc->cpu !=3D DPAA2_IO_ANY_CPU && desc->cpu >=3D num_possible_cpus(=
))
+		return NULL;
+
+	return dpaa2_io_create_impl(desc, dev);
 }
=20
 /**
=2D-=20
2.55.0


