Return-Path: <linuxppc-dev+bounces-24994-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB29BC54F51
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 11:44:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h99VH2TWxz2xwP;
	Wed, 29 Jul 2026 21:44:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.15.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785325479;
	cv=none; b=Sp1PgGXjHqEhI99NzlSfX3mvXxcw8tmMvXLe5BeMiyeYbuMj3RFAD52Sd9w3ZVnfi3/U15/GAp9kl322sDMzhMg6cI9ay5M+SKP1KhZkKHlkCb5tdxxBULZ+GmTgOZnL5/vZQRTJCuhy5eEWz7P4uyT4tvuRffqTLwqOH/Y4wJBWT8U2msOQ//EpbJobs3tMBuXzrGk0oFMLnZzwRC9TIce5Fmf/J7hlwXyNj97wcekKIJ2dsj341cvoE+yZzTBjj6+XnLUaTwyQ8k2ssqCgeQe4HaqTZqs0pqFyBWbkkwb9HzCGUUU4J2iSZYVqe3cKnQYBNdI7PJ+uYfkmttsIDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785325479; c=relaxed/relaxed;
	bh=ZB7fkr+8u1itkrDNGFxMlw0+3hPrJQV3CvlOA1XIJ28=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eT7LFaE+Lr+KZIjw8xdvwQIcJuXn/rr2FtXKVWNfGZq9wpLV5HeECMR6CnX6An0ncFXoNLJa4wyAfqwfqfa2Yhvxj3iT3uLINXNnJqTv3NX2j2bLnEg5mW/vtK25T/DIvfyZCifhCXfsXZharXHQCCNunjIHCliGqXETHTJvb6f7H84OwXFEknPC7qak3ZKSs+aQHkTiAui3toNwnJ8XQ7uclh1rS+Fnxk+umUsceuMoldQoUx6kHni24V/ajUl5DYH7H26QgUcXUWH+IcDHGIMKLEikRY3s0abVvdIdncMAgl3RqwHcEMn/9eRJvbiMAGIhxFVi8NDNb10jobsfog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=g9tDIkoF; dkim-atps=neutral; spf=pass (client-ip=212.227.15.4; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=g9tDIkoF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.15.4; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h99VG17XYz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 21:44:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785325448; x=1785930248; i=markus.elfring@web.de;
	bh=ZB7fkr+8u1itkrDNGFxMlw0+3hPrJQV3CvlOA1XIJ28=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=g9tDIkoFu34RCfnV+WVYBiTvDOn8jL8VlOYVxpcUtj9GEIFjiAJiGOqUzByNa19U
	 JZLTKm80AB0ELdhyp92iHqorbugrpzAQq1ZWc9TiPIwGPL2TOs4LVOIpIMByTGcCf
	 BoqVnXeG2tHggs+8GvxGyf+ow05EkDMJuBWiLB08zG0gJPGJRvEt6gJ7qQB4eRSLl
	 b/DNv/lRazXrkDGayIsAqKgU9vsCukmsj5TPC4eZgbzWcwBsmA4RfT79zFGpCJ5ib
	 KULt/rs8BudP8sz8GFU9+5BWUQkMNWwLxtQRzK/ONCYo0JRP7x2dNojOUelWodFym
	 bIK9i/0ioRiZKYGJLA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbkWQ-1xNYRS0WKs-00bYaV; Wed, 29
 Jul 2026 13:44:08 +0200
Message-ID: <d03db8ee-0b75-43da-9e0a-056cd7c28967@web.de>
Date: Wed, 29 Jul 2026 13:44:06 +0200
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
Subject: [PATCH v3 2/2] soc: fsl: dpio: Use scope-based resource management in
 dpaa2_io_create()
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
X-Provags-ID: V03:K1:JWfvhv9xaM9no0/+wK+mo5Nbg7cGTOCcrv9o8GrPo6qDck+r0Sd
 5fJMqJmzmiBx/pvvn5/8ptgnC8OKJv+raLf65JdB3dP/nH5dAX+ucAhnSRKvewhKpWIHyBi
 4yBzqDsxf2pwy/KCWRuX8MXv+/zi2x6bRXthsPzQE3y/DKUU9jvNxKVQHX+fIWf3qQuRIc7
 I0WJiKQPkBB8i4zZR9RMg==
UI-OutboundReport: notjunk:1;M01:P0:4RP72vNzfQI=;WVcJkbU3Q/ep+YTeJnH0bkdXyDC
 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
 sQ1Hn0u6jCwRnVFiVjy7KyI7vL/ubUkjA85yxvABnFCT8R3fl90Bh3v4/b0m7Fnqur1yeMVr6
 mamRDBCT5CizZilwlhahbY/spjdmQ6I/o+A57aUO5orhHcFeh/VurEvpXGM37foPQjrr4Dnbf
 18TqIdLIT/tuIhrUEiKg773K2Zr10d4mZv62HtOBRY/J3vHNNnLADaRJAenjAC14DFRnkpXZs
 q1shJPIiN8MAJzl5IzvN2ncRoY5kTRODLfA0OYT4NYYEK1OAfB/RpY9HAZzKdk5OGfHrENYYH
 gs1ve1FcGHyvD3yA00cRuPkuDjuK0Qlz6FhwQDv/qxsZu9Be1l+xTC3NOaMm7hAggtg3oJZo5
 rLTA4hTgHKrFDVMy4V/89SJ8vvJN03qcjkIeWPNEYUVJA7UXpIAXV4SyK1BGfqUflv8G4woR7
 mOarDkqmuo1CozO7GzrrF1rifDb5ZCLvD+pPSlU/Ti2JxMGit2XFlVwHFDQapcxpD+1EAAqV5
 p0px/2ZgK/N7JQLzBwLSei4RWxUh+HVimWX4lHau5r/ghPQS9T7Bl+bgqPFxHCgjYdNGefukr
 slJeTULH5Y/HTkgskRDn0Qijq29phayJl6EKgr49NL1pBBHLNl3wQ17ZfQ5nXmO4LM1QQyZ9x
 A3MFCM5YyUVmT2uPc4NS/f5ZmILOE+olOPfXWYOaRsUs9ZVkdt/lWj0eFAFOGurKU3yYOQEO+
 v4pWPpDArtdVfMy7hVjdXqSgPXS26aB2wvllJF/ea+LLqVzccXpynKpfKLxC1UPOQTtx/p5TN
 ra62+Da9sRoiLRWRuM7q5O7SugtLG8+L6Z5CzN7qln27tWxxRuT8B/Hsw5NjpQ2RMXY70Pwzl
 eqicB6TSOU2hO1la9Dje9hKVNmUYOI+C3bAyn3AV87MHFRW5JOIVCe7S3SDyoMd9hyNxAJYol
 dg8ZgkGgF8SF

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 29 Jul 2026 12:46:56 +0200

Scope-based resource management became supported for some
programming interfaces by contributions of Peter Zijlstra on 2023-05-26.
See also the commit 54da6a0924311c7cf5015533991e44fb8eb12773 ("locking:
Introduce __cleanup() based infrastructure").

* Move some source code from the implementation of the function
  =E2=80=9Cdpaa2_io_create=E2=80=9D to a new function.

* Use the attribute =E2=80=9C__free(kfree)=E2=80=9D for the local variable=
 =E2=80=9Cobj=E2=80=9D.

* Omit two kfree() calls accordingly.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/soc/fsl/dpio/dpio-service.c | 46 +++++++++++++++--------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dp=
io-service.c
index b621755d8988..4ff99928e9c6 100644
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
@@ -195,6 +177,26 @@ struct dpaa2_io *dpaa2_io_create(const struct dpaa2_i=
o_desc *desc,
 	return obj;
 }
=20
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
+}
+
 /**
  * dpaa2_io_down() - release the dpaa2_io object.
  * @d: the dpaa2_io object to be released.
=2D-=20
2.55.0


