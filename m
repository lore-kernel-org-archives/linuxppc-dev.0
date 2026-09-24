Return-Path: <linuxppc-dev+bounces-28095-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7BFC98310
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 07:23:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hr50J4LSyz2yD3;
	Thu, 24 Sep 2026 17:23:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.17.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790234592;
	cv=none; b=UghJ/N1xWegUB7XYAgXUY7QtvSGtbKZJ8lXVp/brBiZ7IHYsIFZi8tBdNeetOZc8qmr9RJX5DLHBg4xxvdLvgybwOIhfMqX7wdYItNYXYr4/TgGTTyjv/1fhWp263urHQQG7G0SONwmEw9Dx+tMLYD0jhoVefpFF3jJQRb6wtx6eXsGfjgf/iZXtP2t0+BkxTyk/o71oxK+AoNJvWkTallqToL0eH/AjkipmgNX1FbZIKBsh58272cP8//36siZMuGzmgE2z3LwJcJYvFOuI6gnkxNClEG+oKmeloH2WlDwHjT/5b5J74aSNVAPAqwKbh23kwnH3WazQ9Z6wMA7e4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790234592; c=relaxed/relaxed;
	bh=0t7YOYeSnpVlNJjWBSQP4LBSfpfHSi2gjM6NX4GmRgY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=g1d6tqW+JGN3yhXbnOdiOXhgrTpoxib3l0RFZL0wPgeqoxg4LzC4nCFyv/A+gVr+0GqChuGpj2I/ttLQrRaxX6oEeXNLsgc20JgW08tm/jTefh301no+rDwN1Rsv8GscUnFd/gwSXif1ST2IRd5JrQX9BhScgUao3aIT/WY/9Keq983Kg457/Ko3nhR/pQtNqzDLWIXPL6QF5e2eax5WMwxjappSekpPnEzWBOBdZU28jC7JWBQZXa5pOH5+PaU9trXrYS/1/oMXUfG4BbrYxC1rMXkCkZQODDVuRY+kr0TMBFfnDyAZ+J6U8iK5SgO3O/5JflevfoJ2mP0j+TkJ6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=aXurschM; dkim-atps=neutral; spf=pass (client-ip=212.227.17.12; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=aXurschM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.17.12; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hr50H176Dz2y7Y
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 17:23:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1790234587; x=1790839387; i=markus.elfring@web.de;
	bh=0t7YOYeSnpVlNJjWBSQP4LBSfpfHSi2gjM6NX4GmRgY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aXurschMgYCYlxzXyGmnUnGsKksNHVJZAJfV3Seq+yFnicjfGEYFXI7o1I4Zcouo
	 1gllGap78m4k1OOLKyucr46w0KlVXVrZJTqvNTdc4fh4rpbTbRMmiE++yOCOHb6U5
	 FEfEUncwjLJ6iUt14NZodN8q5SBJhomOaNdaVJZFj509uEVyTJTi9uY5GpiYzghKp
	 sWx1+uEfKytr9ixNU8N0aT0Py9DbF8Pz4tu4KKn1/YK6X1OZ0tKGlmWn/OqoSLnbf
	 VRDy7uuF6XVouBnE4OSqwz0Pf/2Nk3c7Z2Y96tQMhDWsIUD/raBcu74RvoL3RrYyZ
	 MjEaUmg1Z4FtxkudCQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMpCg-1xQ48C0nxs-00MjcY; Thu, 24
 Sep 2026 09:17:28 +0200
Message-ID: <7862715c-da53-49ba-9fc1-6ca5c5d39dde@web.de>
Date: Thu, 24 Sep 2026 09:17:26 +0200
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
Subject: [PATCH v4 1/2] soc: fsl: dpio: Use scope-based resource management in
 dpaa2_io_store_create()
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
X-Provags-ID: V03:K1:+rMhZgZMkKvSzMOsFbb8Jp/BAOed9W/APFxOyOXc468CLAS1jnd
 BT1xLN0/XRLMDyWhZZUec4+7WHBJakilSSmnh8gItEsNNHCq8oyHqxm6bAIlWOJthd1nmjs
 ulcKPvXFWDu2jvCpj889joeOEn6TGVfAQs1n4lwOhoJ2xF+OXDSpzA4oDWp/HSSaCly0EXS
 CoSAn97bJ+oiGq4W1qKYA==
UI-OutboundReport: notjunk:1;M01:P0:filvRnOZY1k=;ZcgWIpyCY1Mod5arL6ntgRFy03y
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 23 Sep 2026 15:48:11 +0200

Scope-based resource management became supported for some
programming interfaces by contributions of Peter Zijlstra on 2023-05-26.
See also the commit 54da6a0924311c7cf5015533991e44fb8eb12773 ("locking:
Introduce __cleanup() based infrastructure").

* Move some source code from the implementation of the function
  =E2=80=9Cdpaa2_io_store_create=E2=80=9D to a new function.

* Use the attribute =E2=80=9C__free(kfree)=E2=80=9D for the local variable=
 =E2=80=9Cret=E2=80=9D.

* Omit two kfree() calls accordingly.

* Replace a return statement by the macro call =E2=80=9Creturn_ptr(ret)=E2=
=80=9D.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/soc/fsl/dpio/dpio-service.c | 49 +++++++++++++++--------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dp=
io-service.c
index 317ca50b0c2b..cb870aae30b4 100644
=2D-- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -4,6 +4,7 @@
  * Copyright 2016-2019 NXP
  *
  */
+#include <linux/cleanup.h>
 #include <linux/types.h>
 #include <linux/fsl/mc.h>
 #include <soc/fsl/dpaa2-io.h>
@@ -638,37 +639,20 @@ EXPORT_SYMBOL_GPL(dpaa2_io_service_acquire);
  * assist with parsing those results.
  */
=20
-/**
- * dpaa2_io_store_create() - Create the dma memory storage for dequeue re=
sult.
- * @max_frames: the maximum number of dequeued result for frames, must be=
 <=3D 32.
- * @dev:        the device to allow mapping/unmapping the DMAable region.
- *
- * The size of the storage is "max_frames*sizeof(struct dpaa2_dq)".
- * The 'dpaa2_io_store' returned is a DPIO service managed object.
- *
- * Return pointer to dpaa2_io_store struct for successfully created stora=
ge
- * memory, or NULL on error.
- */
-struct dpaa2_io_store *dpaa2_io_store_create(unsigned int max_frames,
-					     struct device *dev)
+static inline
+struct dpaa2_io_store *dpaa2_io_store_create_impl(unsigned int max_frames=
, struct device *dev)
 {
-	struct dpaa2_io_store *ret;
 	size_t size;
+	struct dpaa2_io_store *ret __free(kfree) =3D kmalloc_obj(*ret);
=20
-	if (!max_frames || (max_frames > 32))
-		return NULL;
-
-	ret =3D kmalloc_obj(*ret);
 	if (!ret)
 		return NULL;
=20
 	ret->max =3D max_frames;
 	size =3D max_frames * sizeof(struct dpaa2_dq) + 64;
 	ret->alloced_addr =3D kzalloc(size, GFP_KERNEL);
-	if (!ret->alloced_addr) {
-		kfree(ret);
+	if (!ret->alloced_addr)
 		return NULL;
-	}
=20
 	ret->vaddr =3D PTR_ALIGN(ret->alloced_addr, 64);
 	ret->paddr =3D dma_map_single(dev, ret->vaddr,
@@ -676,14 +660,33 @@ struct dpaa2_io_store *dpaa2_io_store_create(unsigne=
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
+}
+
+/**
+ * dpaa2_io_store_create() - Create the dma memory storage for dequeue re=
sult.
+ * @max_frames: the maximum number of dequeued result for frames, must be=
 <=3D 32.
+ * @dev:        the device to allow mapping/unmapping the DMAable region.
+ *
+ * The size of the storage is "max_frames*sizeof(struct dpaa2_dq)".
+ * The 'dpaa2_io_store' returned is a DPIO service managed object.
+ *
+ * Return pointer to dpaa2_io_store struct for successfully created stora=
ge
+ * memory, or NULL on error.
+ */
+struct dpaa2_io_store *dpaa2_io_store_create(unsigned int max_frames,
+					     struct device *dev)
+{
+	if (!max_frames || (max_frames > 32))
+		return NULL;
+
+	return dpaa2_io_store_create_impl(max_frames, dev);
 }
 EXPORT_SYMBOL_GPL(dpaa2_io_store_create);
=20
=2D-=20
2.55.0


