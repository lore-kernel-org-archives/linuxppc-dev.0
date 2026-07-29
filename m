Return-Path: <linuxppc-dev+bounces-24993-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC8FC53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 11:42:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h99S02rdVz2yDr;
	Wed, 29 Jul 2026 21:42:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.15.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785325360;
	cv=none; b=IfUyh4c/EtzGTRWJJKYDfEMDQSuzY64lWJnnJ6TkB3WSaSQrk0O/lH72GOJADLevc/oz4OSrcnTeWPf52RtZ9Ero8761igd/bqxN8S3vR7BiYjAMac5ZbUkRwasVx4tYY13scBAea0h5evE6d3QlEHuplTKqUsEj4jBQjHMTfJjtQuWICejhIG+1RHWEfIkfMuuJOFunmCgNgCJ1iUZEq2sOSkIQ7qMH/WibhSCFXJ6aqnsNeUzbnJNuurYsug4i2ExqKzx2uIXSHsxAbPaolawjiLJr42Y+eWx8b2ZLcCZXr6vWPr8kLtr8/ZQQ6GR34kaX+i9I6JZnlxfSBMqbvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785325360; c=relaxed/relaxed;
	bh=iYrzl69BfWthDSpuWWFsb6fPKMdMihwMRTVL8q8fdNg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iDsS9RipqEPDYUGbv6EG8pOExomnu+jeXRO5N7hWlo7W046Sli/6mxGmRH6DjDWYL7wPJsK6iJ9LZtvfTdNeL04Gp5Q803TtktWDASubEvCsBvAcKGT9Src2MhfgvkWvaAQIzcU3aZZm3eB6S4pJ9kF2DKNywYA3tBUUieeD+Qr9bns+zuJzbuAVGyboY+nKInVjgppFa4YBGi9uqyGytHIb8ls88AtcBIviZpz51PXzAZ1HRi5Ek0AMcP1WtAxO6OssfJALs5NCEAaRehPeyIoO4RskU/unZNjQ32GM4eDv24xh/r587JFBGTC6pcVdVkI5eiXwMegN+L6M5IecvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=nCsug9o5; dkim-atps=neutral; spf=pass (client-ip=212.227.15.14; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=nCsug9o5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.15.14; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h99Ry69yzz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 21:42:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785325347; x=1785930147; i=markus.elfring@web.de;
	bh=iYrzl69BfWthDSpuWWFsb6fPKMdMihwMRTVL8q8fdNg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nCsug9o55P0Ta9yynN9wePHG6LyI7QWPXS6LFUaAKg8yInnSInJY6JjQyjR49Oqe
	 8XUK0w08x5/KW32zKuC9+78eNQfwvsUHwPfNgp4iz/S4q985HjHiTH+2v8xMI7Jso
	 6De/VRzGKUAybdML1sQzeE9nK/tJllDxQ/NLkR9piHoHU8HCc1HKPsD0TFw27j7v6
	 cgHhpzHh8FQSAo2g5/PhTNYqO2uzdSx4yuEtjLbWDPSokkz5pX83BzIhEl2T9b9wk
	 +UCH3K1QHiYDjCggREJFeJQmsWN8gVRRpDwhnveDO59CPp5xWoJN0RyY9bTRFrS90
	 UELZGbUMk98JWdmOsA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MN6BN-1wYC7K1QvN-00IWe5; Wed, 29
 Jul 2026 13:42:27 +0200
Message-ID: <398b98c0-010c-41a5-8c54-2eccb5e6c7aa@web.de>
Date: Wed, 29 Jul 2026 13:42:24 +0200
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
Subject: [PATCH v3 1/2] soc: fsl: dpio: Use scope-based resource management in
 dpaa2_io_store_create()
From: Markus Elfring <Markus.Elfring@web.de>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <chleroy@kernel.org>, Dan Carpenter <error27@gmail.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Roy Pledge <Roy.Pledge@nxp.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>
References: <709fefd1-821a-4cd1-8598-b1179a95ce52@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <709fefd1-821a-4cd1-8598-b1179a95ce52@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4HCnUZUS4TZ7P0z/XYniV2A2jzoE42R/ZDtVew8c7nfXUaordxd
 ZZ/FYL2aJ6mMyUUfWFWkIGXAI2EETMZQUVD24LVzg9ET6smUYVXO/7uu2uNUjIn/QDOG1k5
 r9is7IWT8huaIVbldzrBdfXzWqmCLg3NXSz7reYN4J698CYdCsg+WJwnO3mNl0PJkkoc85h
 um6VvSHB5U6e38G5zyA4A==
UI-OutboundReport: notjunk:1;M01:P0:0Ud9trrHUpE=;XEvDGhFAHHVIjUmbwoWz3wNwKph
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 29 Jul 2026 10:54:15 +0200

Scope-based resource management became supported for some
programming interfaces by contributions of Peter Zijlstra on 2023-05-26.
See also the commit 54da6a0924311c7cf5015533991e44fb8eb12773 ("locking:
Introduce __cleanup() based infrastructure").

* Move some source code from the implementation of the function
  =E2=80=9Cdpaa2_io_store_create=E2=80=9D to a new function.

* Use the attribute =E2=80=9C__free(kfree)=E2=80=9D for the local variable=
 =E2=80=9Cret=E2=80=9D.

* Omit two kfree() calls accordingly.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/soc/fsl/dpio/dpio-service.c | 47 +++++++++++++++--------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dp=
io-service.c
index 317ca50b0c2b..b621755d8988 100644
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
@@ -676,7 +660,6 @@ struct dpaa2_io_store *dpaa2_io_store_create(unsigned =
int max_frames,
 				    DMA_FROM_DEVICE);
 	if (dma_mapping_error(dev, ret->paddr)) {
 		kfree(ret->alloced_addr);
-		kfree(ret);
 		return NULL;
 	}
=20
@@ -685,6 +668,26 @@ struct dpaa2_io_store *dpaa2_io_store_create(unsigned=
 int max_frames,
=20
 	return ret;
 }
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
+}
 EXPORT_SYMBOL_GPL(dpaa2_io_store_create);
=20
 /**
=2D-=20
2.55.0


