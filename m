Return-Path: <linuxppc-dev+bounces-22477-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4708CD98CC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 10:02:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbdVq2rxPz2xmV;
	Thu, 11 Jun 2026 20:02:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.15.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781172163;
	cv=none; b=auGAsBLmUWBGDoMO9wJqr0BoNJgAHReK5M2c2rnYXrw0VNxm2aegAPrGujCaeOI9DXsCQSaIgeStg/qBe1laicMYHTNStLiEu60EUm2gSCi8HtObUEVgO4enx8qKHQk2Hkfek0XI4VCQu/sWnM8QJAGzCF8QFD0JUbWsWp/TDukm3ZtOzU5I6E4MNC7zkqRogO4eGmNKr9IwCpvdMcCmrslHgq72B3Rlvy2k7JQMnmrqLLvmOVAAGVehNmPQx/ScuMAha3cMIBK2BNGnz/WVGANm/nbp9VTdhxe26Rrdn466uH6N3PHsHTXS37nS9+WrgNtd6pHcvnbBdiMHS6RC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781172163; c=relaxed/relaxed;
	bh=RVp3bryiEwMVR9Bz4t9wj5CzsTTsZiHsrQL/9DA6uVk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=C+gd//ZHQ+nXC4q/0EhDbG7lGWJh0sEKE47zP4xbrpRF52tr14wO4UhdtiaMFziT+8HRgYz28/y9xCyAoMbvhv0HOyHVKcNL1B68hA1Lft6zHVR/X3+extdeaaogmfDL1+4zksZIQQLcxfr8TGylofqIXl1f8Twct3V8KyM+muSjP1+do+jeauyW4YbI+A72egMkjr+U41oO5Z4QcwW79Gb+HyyljS71+UFDEInTWpRSe/it+Pi1NlCHAumY4BaJ7GDiAATk5lBUpZCIxsz0R5FOk3lDPS+AvAyQw/XKwFb8Y+nfyzXC2Ob5zPqGcoL8GpvjELLxTtx1OE+UYOfYrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=Qy6+O7Vj; dkim-atps=neutral; spf=pass (client-ip=212.227.15.14; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=Qy6+O7Vj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.15.14; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbdVn4twPz2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 20:02:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1781172150; x=1781776950; i=markus.elfring@web.de;
	bh=RVp3bryiEwMVR9Bz4t9wj5CzsTTsZiHsrQL/9DA6uVk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Qy6+O7VjCAIks2rGWFFV8PrXIiAGqlvBVGXllxTHCfsI+AItYTuOP8dMX3hufI4X
	 GTEP0XH/DG+m7Nik5jhNEs7T4z4ZVOACdnrOoq+1bin4+t4S8vBSRtXrY7dE0Nee6
	 OxbMC5LNYww0SIpTjd0zXycAiPNCodlMCLuJD4u5TFR9ZeeIcOweEEBE3GXZir2Lu
	 DYo1FpDpscGk4a5abnCHIa71aqGwyB76ZAXGIc1AUAABtLZoIJumtCXpv8GAzOw3G
	 xxmnU2L11JIrsSaw1hTWIrXzXDPNDiyS+bKqnMkfPRzCnvBwpVyia5HvrQlSyMKMw
	 hAKkwUceDLS6zhQ2TA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKuOP-1woShn0kAf-00Tbct; Thu, 11
 Jun 2026 12:02:30 +0200
Message-ID: <690827f2-e746-4378-bb7c-9948cd69dc15@web.de>
Date: Thu, 11 Jun 2026 12:02:27 +0200
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
To: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Christophe Leroy <chleroy@kernel.org>, Roy Pledge <Roy.Pledge@nxp.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] soc: fsl: dpio: Use common error handling code in two
 functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fuDLab4raeHeNjF0RATfEmeR7VH3vJWK57SXK1kirrMtbYFEjOI
 LvJyGwUY0TGbWwOfvK64Mzy0+eCJKPYm3/UwZwzvBqKT+KziDhhvCLRyP8AKG6HvJy06675
 qL2gxcpH/R4HaWQ5TnS2XH7BXRfqd8UbR6oVJNk2Ntk3DQTDR85RKGZlcSmkOx666FGsury
 QuQlQx/nDXBIRSPLOtVIA==
UI-OutboundReport: notjunk:1;M01:P0:BQ93aTbI3z4=;BYb50u7xgDv79aFopJVKLCOua+v
 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
 aMamHMDEvs9p7dkKm7lLrpT73joh8ruJIXP/QG+

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 11 Jun 2026 11:56:18 +0200

Use additional labels so that a bit of exception handling can be better
reused at the end of two function implementations.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/soc/fsl/dpio/dpio-service.c | 30 ++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dp=
io-service.c
index 317ca50b0c2b..025d9fb5660d 100644
=2D-- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -140,10 +140,8 @@ struct dpaa2_io *dpaa2_io_create(const struct dpaa2_i=
o_desc *desc,
 		return NULL;
=20
 	/* check if CPU is out of range (-1 means any cpu) */
-	if (desc->cpu !=3D DPAA2_IO_ANY_CPU && desc->cpu >=3D num_possible_cpus(=
)) {
-		kfree(obj);
-		return NULL;
-	}
+	if (desc->cpu !=3D DPAA2_IO_ANY_CPU && desc->cpu >=3D num_possible_cpus(=
))
+		goto free_obj;
=20
 	obj->dpio_desc =3D *desc;
 	obj->swp_desc.cena_bar =3D obj->dpio_desc.regs_cena;
@@ -158,11 +156,8 @@ struct dpaa2_io *dpaa2_io_create(const struct dpaa2_i=
o_desc *desc,
 	qman_256_cycles_per_ns =3D 256000 / (obj->swp_desc.qman_clk / 1000000);
 	obj->swp_desc.qman_256_cycles_per_ns =3D qman_256_cycles_per_ns;
 	obj->swp =3D qbman_swp_init(&obj->swp_desc);
-
-	if (!obj->swp) {
-		kfree(obj);
-		return NULL;
-	}
+	if (!obj->swp)
+		goto free_obj;
=20
 	INIT_LIST_HEAD(&obj->node);
 	spin_lock_init(&obj->lock_mgmt_cmd);
@@ -192,6 +187,10 @@ struct dpaa2_io *dpaa2_io_create(const struct dpaa2_i=
o_desc *desc,
 	obj->frames =3D 0;
=20
 	return obj;
+
+free_obj:
+	kfree(obj);
+	return NULL;
 }
=20
 /**
@@ -665,10 +664,8 @@ struct dpaa2_io_store *dpaa2_io_store_create(unsigned=
 int max_frames,
 	ret->max =3D max_frames;
 	size =3D max_frames * sizeof(struct dpaa2_dq) + 64;
 	ret->alloced_addr =3D kzalloc(size, GFP_KERNEL);
-	if (!ret->alloced_addr) {
-		kfree(ret);
-		return NULL;
-	}
+	if (!ret->alloced_addr)
+		goto free_ret;
=20
 	ret->vaddr =3D PTR_ALIGN(ret->alloced_addr, 64);
 	ret->paddr =3D dma_map_single(dev, ret->vaddr,
@@ -676,14 +673,17 @@ struct dpaa2_io_store *dpaa2_io_store_create(unsigne=
d int max_frames,
 				    DMA_FROM_DEVICE);
 	if (dma_mapping_error(dev, ret->paddr)) {
 		kfree(ret->alloced_addr);
-		kfree(ret);
-		return NULL;
+		goto free_ret;
 	}
=20
 	ret->idx =3D 0;
 	ret->dev =3D dev;
=20
 	return ret;
+
+free_ret:
+	kfree(ret);
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(dpaa2_io_store_create);
=20
=2D-=20
2.54.0


