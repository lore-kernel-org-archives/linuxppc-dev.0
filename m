Return-Path: <linuxppc-dev+bounces-23598-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C273C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 10:38:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv16H60MMz2yVZ;
	Mon, 06 Jul 2026 20:38:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.72.192.78
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783334295;
	cv=none; b=mvPbTUGANi8oVrFDVuIU1IZCfCk86sse2whdSG49EBMRkuDGASOT89E+9rjuLQcvjgqij4m12JrK0SQ07r3Hxu3yfO/99sVq/tzcqJtbwS2PPCF3wlwv2kqrH32StGLtSJUl6tvCyqZ5DU5J04BpwEXOIGzn8iaVX+rZwkAVRKMDWiSmscR2UEoIhyeQW58TXSQXy1XM5Fo9tj9FJ6rmLXVLeYJ6FqOESnGkLHpsxEzM3jttPNINmM2nDYMTNuCUHwkJOv4nC+qab94HwSG2srNr2gyQkEy2bZf9bhLT2vmzKjzri8P18vPVHsWrcJsKu68UsHKWJ9aSDCz9S/wk7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783334295; c=relaxed/relaxed;
	bh=ra6ISfD9SPm9nOu+EXB67TfhtSZZgazhoJXn2VSkq30=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MPjvmYmQcm/YwsaMi++YiAqUwFq5dKsCFRxLKkgRs1GsZxZD7uMKLnga+Hjds/VmZvErRzumLBksTqWAjOe1Eyg3pAvlCx16F+TxeOQYJVSYbAhvKKtg6RvJ9ggQwizbZbqHjLIeEZh6OgAoscX2kKheFMa+oD1WJyz3QKQOWU6zq6y8qqpLeOOdnCHjxrWifEJwSoUaBytwdlZ2Z5mvmpDMJeoqFzVu6g3ZnYT/WDV5eXcDYoQi2axhdT1sgvfi5smBKEqyfPdCbpwSSrG2aBuH+D39SGs3gPSCLQEClrSdkB6rhBAaMDrSiFe8zZ6DZc1g/X81r7EdGI0JNuiIBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=Y6G624Es; dkim-atps=neutral; spf=pass (client-ip=217.72.192.78; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=Y6G624Es;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=217.72.192.78; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv16G3zJqz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 20:38:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783334290; x=1783939090; i=markus.elfring@web.de;
	bh=ra6ISfD9SPm9nOu+EXB67TfhtSZZgazhoJXn2VSkq30=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Y6G624EsF390QxIQq8ZebKgeeVruBYRkjMhnb88HTWhLo5KKrnHu62mwI64VPxRP
	 b7jML09UGCOEdWa57elCT+Q1OsNxkfNVEyEYknBeKRWOdqavscKAv0Uui4lGjHoUh
	 kGmso8Boo2yQTuBsCZ7YxGSQHeMUTU+ZrnJsq3OsU+T6LJT0ifWtP5R5PIftu8g24
	 Eu+0/BxPB8xcPKzi1MOIzP0vFWht4/x26I0Ka3zfYtWHxatZRB45QB7y/HkRuKM4W
	 rvIsTJ68xfRj1IsGJZlDWy0i5oZhJk7fcBolh9dKvZGrXbTzLigDe+K1qifkneVFh
	 XQzGjpixaNM/2bz64A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRW6Z-1wUOWN2TGH-00MPiE; Mon, 06
 Jul 2026 12:38:10 +0200
Message-ID: <6607bb4e-a747-4791-b93f-f82f26e4a334@web.de>
Date: Mon, 6 Jul 2026 12:38:08 +0200
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
Subject: [PATCH v2 1/2] soc: fsl: dpio: Use scope-based resource management in
 dpaa2_io_store_create()
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
X-Provags-ID: V03:K1:Ek/LZGIGLzG33522bS3n43R68LOXEb95sbpfDSscSmdVSuNN9fv
 rE5mB+/QWQ6dZo7x2FzlneUO2ycBwa+6Xlop73V06he2SgdQkY32MrVA0WGUiJcS1AIynBs
 g1ZcDmPorFHm/vTIlW8mD8E7othaTraKyw2IhbYX/PedYqWzlrxvOOxUg8kVOa3eWiVYApF
 LUWp6u64HIgZPZQzc/dOQ==
UI-OutboundReport: notjunk:1;M01:P0:VIsLwCURV7I=;TcrhdYNOynWWoSW9B4OvrFaN+5Q
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 6 Jul 2026 10:34:43 +0200

Scope-based resource management became supported for some
programming interfaces by contributions of Peter Zijlstra on 2023-05-26.
See also the commit 54da6a0924311c7cf5015533991e44fb8eb12773 ("locking:
Introduce __cleanup() based infrastructure").

* Thus use the attribute =E2=80=9C__free(kfree)=E2=80=9D.

* Reduce the scope for the local variable =E2=80=9Cret=E2=80=9D.

* Omit two kfree() calls accordingly.

* Omit the local variable =E2=80=9Csize=E2=80=9D (for another memory alloc=
ation).

* Use the macro call =E2=80=9Creturn_ptr(ret)=E2=80=9D at the end.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/soc/fsl/dpio/dpio-service.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dp=
io-service.c
index 317ca50b0c2b..b252c3c7fa65 100644
=2D-- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -652,23 +652,17 @@ EXPORT_SYMBOL_GPL(dpaa2_io_service_acquire);
 struct dpaa2_io_store *dpaa2_io_store_create(unsigned int max_frames,
 					     struct device *dev)
 {
-	struct dpaa2_io_store *ret;
-	size_t size;
-
 	if (!max_frames || (max_frames > 32))
 		return NULL;
=20
-	ret =3D kmalloc_obj(*ret);
+	struct dpaa2_io_store *ret __free(kfree) =3D kmalloc_obj(*ret);
 	if (!ret)
 		return NULL;
=20
 	ret->max =3D max_frames;
-	size =3D max_frames * sizeof(struct dpaa2_dq) + 64;
-	ret->alloced_addr =3D kzalloc(size, GFP_KERNEL);
-	if (!ret->alloced_addr) {
-		kfree(ret);
+	ret->alloced_addr =3D kzalloc(max_frames * sizeof(struct dpaa2_dq) + 64,=
 GFP_KERNEL);
+	if (!ret->alloced_addr)
 		return NULL;
-	}
=20
 	ret->vaddr =3D PTR_ALIGN(ret->alloced_addr, 64);
 	ret->paddr =3D dma_map_single(dev, ret->vaddr,
@@ -676,14 +670,13 @@ struct dpaa2_io_store *dpaa2_io_store_create(unsigne=
d int max_frames,
 				    DMA_FROM_DEVICE);
 	if (dma_mapping_error(dev, ret->paddr)) {
 		kfree(ret->alloced_addr);
-		kfree(ret);
 		return NULL;
 	}
=20
 	ret->idx =3D 0;
 	ret->dev =3D dev;
=20
-	return ret;
+	return_ptr(ret);
 }
 EXPORT_SYMBOL_GPL(dpaa2_io_store_create);
=20
=2D-=20
2.54.0


