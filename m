Return-Path: <linuxppc-dev+bounces-23599-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914B5C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 10:46:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv1HH1n6fz2yfS;
	Mon, 06 Jul 2026 20:46:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.17.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783334763;
	cv=none; b=lvwI63TxZT/lJPNbOidkYdhI4ieGz9alie5hQTlEx0pA3buxByqy1KNGFZ64SXKYvIKvgEwm/OBNx8jCBHCdBlzlRo9zKQyH+RJ4u7KXyiZRkn6WB6B41tsTUqOEwuyr0+hfgK+e/z42ZrJwKy1CH6TuNZr/HXAJNuWrvLYqK+liQ99sWpIIL8N1JyGc0tBbyYNK5jNa3N/E5bMjxSu0E7uJm7Dkwz/bnmcmyzOk3d/gtrpgHNn0lvkCXiDd0XYmXoCL2QsSF9BObTaSMDWWwCFbSkGgPBeFJjHOIpIar+XReKY7tNtbmjUtbO6+fgHHE9PhzDz1JuocjdS0XUl5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783334763; c=relaxed/relaxed;
	bh=ul5AJDTYA7aLNwXWzGmKwSKEDzMH7D/FAfxASkHiZHY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LW4MkE6W7v580wo+FrJyMqRSmGFDoPZCB5oHXkjtbVkLZJwQk0PkGoj1zHbK0baSvTza9vYeGwWpijIc7uEFrIoAAenzRW1biQ42VOehCBwjW/Fmncy8pCjSqpDHN0AQIffH3D9qZQSgs0+RCTUnsKR/YxnoJOG20IQv29qyvNu9LbqBC5ibVAEtR8TsZP0A556X+4KW7DXrXwG0sMMQQ5d1JCzqKTOWqTtsgOsUuSiDjwkL0NY3nRvHN/lYbH83+eOBD1qIiW14vyP6I3VQ/5kDDucTclGEjEoUIoSPlzb+hkvRFoOItanNy1I0GJ4pX8zIyXzKDbaB2vmjRO4r4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=VkLL+rJM; dkim-atps=neutral; spf=pass (client-ip=212.227.17.12; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=VkLL+rJM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.17.12; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 322 seconds by postgrey-1.37 at boromir; Mon, 06 Jul 2026 20:46:01 AEST
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv1HF4ZfBz2yVZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 20:46:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783334756; x=1783939556; i=markus.elfring@web.de;
	bh=ul5AJDTYA7aLNwXWzGmKwSKEDzMH7D/FAfxASkHiZHY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VkLL+rJMJOQZoL99DcXLizA5+hicEWPdCgLxQSj2U4VLEGxDMcPdRL64WmMqN8Nh
	 WJViSLTO9CNKn3xaEGSq0DmAkBAX0jfcyjWJMvpqVQsPcQHQNEJh2636It4l97G8n
	 ZLEHt8YLd8LZ4kt5ezjRMQtrz71kJaCkgczmhbPIjAstjmPnWD6wZ7hR7wXRlUqOP
	 gV9qOUtaQsJBr/uKY2+4hbkQgoJnpfdHUHzTyYWLH13BWycmaT45MNAOLcrMwZUIL
	 8P3+v/tAgumzG3w61GmxkXYJpYH5JWZi08ktB+BzQzcTsMzmkLdrtZA5d4opPZRfb
	 Iv39/c2m6Ey+nN+2+w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4KJX-1wgPlL3SqH-001EX3; Mon, 06
 Jul 2026 12:40:10 +0200
Message-ID: <f47abd6e-9337-404c-a24f-39a9dd7454d2@web.de>
Date: Mon, 6 Jul 2026 12:40:09 +0200
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
Subject: [PATCH v2 2/2] soc: fsl: dpio: Use scope-based resource management in
 dpaa2_io_create()
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Christophe Leroy <chleroy@kernel.org>, Roy Pledge <Roy.Pledge@nxp.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <690827f2-e746-4378-bb7c-9948cd69dc15@web.de>
 <d95d2f4c-f3cf-44eb-b61b-79ba7891674d@kernel.org>
 <d2e5df25-c8b7-4ee6-8ebf-1725542baabd@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <d2e5df25-c8b7-4ee6-8ebf-1725542baabd@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BgikFvy0UCxadnIWbi7Ro86BGCmLYEw6oPOqX+iYeIvp3uyEjkX
 iMz4VhaUg4JaFZoKx1lJgD+2vz8LxUbNXpA6uFktC8zrP+4+gSZCavHu2HlIA0wvnp2abUu
 xtc+PBTFF/wabDIv4n1KcNDGNfuVdyV/M51Ec8y//BWLITEAWgt6Q7/Ht+/VlUoLMkJ9AY+
 Ohfqp9rRIFduMIN3F1gXg==
UI-OutboundReport: notjunk:1;M01:P0:s7CzU5+f50Q=;yQnWfPzDVJ5avfDj61zgDL8RveC
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 6 Jul 2026 11:18:39 +0200

Scope-based resource management became supported for some
programming interfaces by contributions of Peter Zijlstra on 2023-05-26.
See also the commit 54da6a0924311c7cf5015533991e44fb8eb12773 ("locking:
Introduce __cleanup() based infrastructure").

* Thus use the attribute =E2=80=9C__free(kfree)=E2=80=9D.

* Omit two kfree() calls accordingly.

* Reduce the scopes for the local variables =E2=80=9Cobj=E2=80=9D
  and =E2=80=9Cqman_256_cycles_per_ns=E2=80=9D.

* Use the macro call =E2=80=9Creturn_ptr(obj)=E2=80=9D at the end.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/soc/fsl/dpio/dpio-service.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dp=
io-service.c
index b252c3c7fa65..80fb11206160 100644
=2D-- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -133,17 +133,14 @@ static void dpaa2_io_dim_work(struct work_struct *w)
 struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc,
 				 struct device *dev)
 {
-	struct dpaa2_io *obj =3D kmalloc_obj(*obj);
-	u32 qman_256_cycles_per_ns;
-
-	if (!obj)
+	/* check if CPU is out of range (-1 means any cpu) */
+	if (desc->cpu !=3D DPAA2_IO_ANY_CPU && desc->cpu >=3D num_possible_cpus(=
))
 		return NULL;
=20
-	/* check if CPU is out of range (-1 means any cpu) */
-	if (desc->cpu !=3D DPAA2_IO_ANY_CPU && desc->cpu >=3D num_possible_cpus(=
)) {
-		kfree(obj);
+	struct dpaa2_io *obj __free(kfree) =3D kmalloc_obj(*obj);
+
+	if (!obj)
 		return NULL;
-	}
=20
 	obj->dpio_desc =3D *desc;
 	obj->swp_desc.cena_bar =3D obj->dpio_desc.regs_cena;
@@ -155,14 +152,11 @@ struct dpaa2_io *dpaa2_io_create(const struct dpaa2_=
io_desc *desc,
 	 * the interrupt timeout period register needs to be specified in QBMAN
 	 * clock cycles in increments of 256.
 	 */
-	qman_256_cycles_per_ns =3D 256000 / (obj->swp_desc.qman_clk / 1000000);
+	u32 qman_256_cycles_per_ns =3D 256000 / (obj->swp_desc.qman_clk / 100000=
0);
 	obj->swp_desc.qman_256_cycles_per_ns =3D qman_256_cycles_per_ns;
 	obj->swp =3D qbman_swp_init(&obj->swp_desc);
-
-	if (!obj->swp) {
-		kfree(obj);
+	if (!obj->swp)
 		return NULL;
-	}
=20
 	INIT_LIST_HEAD(&obj->node);
 	spin_lock_init(&obj->lock_mgmt_cmd);
@@ -191,7 +185,7 @@ struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io=
_desc *desc,
 	obj->bytes =3D 0;
 	obj->frames =3D 0;
=20
-	return obj;
+	return_ptr(obj);
 }
=20
 /**
=2D-=20
2.54.0


