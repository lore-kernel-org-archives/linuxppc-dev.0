Return-Path: <SRS0=LJle=LI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1CAC48BE8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jun 2021 03:08:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D54860FD8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jun 2021 03:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D54860FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G3Gbw528Hz3bwb
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jun 2021 13:08:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=slqQDRxK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530;
 helo=mail-pg1-x530.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=slqQDRxK; dkim-atps=neutral
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G3GbS2LLHz2xvL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jun 2021 13:07:48 +1000 (AEST)
Received: by mail-pg1-x530.google.com with SMTP id e22so7491489pgv.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Jun 2021 20:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=U3YHNE7P8lYSeBC7M0hGaNUcPpPrqIycgAPOdK5k1ro=;
 b=slqQDRxKx07A3y40pwqVKMzKhY8rALLhgSDkxnY3eibTM33nOMR1V76tOw7MPxgNyG
 v+o0dx6P5P3RnArysF8N+4T5l/OwGuWZ7SQ4xO1RxAg24fmVFysJcN2toWwbQoYv4XoZ
 /7vj9bwbWTTd/dDpeumpwR5UMOZIgrzNSrIox/opPKUKyC1lLZ6suy0vC/l9lRjlwb3c
 QJ0WRgGUTX2OkCuXZHcDAB2PB7xqQZsFH6EX27tReyKs3qL1s74211+jqQDOgO7WgwoV
 uceLQ+QCqD6m91UssWgHwXAP6MsJ7r3lJVkzjcfq7Mc6t6Yt4eDanQ76OeWE35l4d9tO
 ZG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=U3YHNE7P8lYSeBC7M0hGaNUcPpPrqIycgAPOdK5k1ro=;
 b=VVuotEwP1Uh7t4FO/REakt3cxt7xmlCx0p6+q0hMwPwLqdzgLArE/rttALUsYz//Z5
 +8kxUuuGr5Bk7OB3T+LRi4M1MxzGeGaIHjeGFbl6zm0IYeIBxPhQnfv7y2/XZTWBj3/t
 mDmtiRNQuayPNEkHmpjp/3qWKJQXbKeYxmjAHHq/hdEqq/Na3mT/NfJDVEwAOxPVQIqv
 381Yrq+xZaf6KDTetGIEi1pDGpr+40NEn5OJWvBd0xwSv4LMPVCtZrItIKabSSJjVIzm
 PZz21OBZpGuvjcmftUhqbnqn1W4ei5VZO2OhBAHzdWWruZn85PZHihOHaLEYwBgLfBY/
 ApTw==
X-Gm-Message-State: AOAM530gGudEy/boJczgHqU244LHSQSeEj9EzQtiGV+GtaEG720zSdOq
 k991HIdiShL9Mu7haCq0g8g=
X-Google-Smtp-Source: ABdhPJwQSnAOsdo9zi/xhttLEkQEUrGe+VI+hb/1JesOdcE5zeabFZfBn5GyJrp73uw+xJd+wpPfRA==
X-Received: by 2002:a05:6a00:bd0:b029:2f1:3fbb:317f with SMTP id
 x16-20020a056a000bd0b02902f13fbb317fmr19610792pfu.17.1623640065433; 
 Sun, 13 Jun 2021 20:07:45 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
 by smtp.gmail.com with ESMTPSA id ev11sm15564103pjb.36.2021.06.13.20.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Jun 2021 20:07:45 -0700 (PDT)
Date: Mon, 14 Jun 2021 13:07:40 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 14/17] crypto/nx: Rename nx-842-pseries file name to
 nx-common-pseries
To: Haren Myneni <haren@linux.ibm.com>, herbert@gondor.apana.org.au,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
References: <ed7a09822cf3a2e463f942e5a37309a2365c9d79.camel@linux.ibm.com>
 <03731a80b5af5f8cea95579215c6d2241c291b70.camel@linux.ibm.com>
In-Reply-To: <03731a80b5af5f8cea95579215c6d2241c291b70.camel@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <1623640035.t3tk2uz8r4.astroid@bobo.none>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Haren Myneni's message of June 13, 2021 9:03 pm:
>=20
> Rename nx-842-pseries.c to nx-common-pseries.c to add code for new
> GZIP compression type. The actual functionality is not changed in
> this patch.
>=20
> Signed-off-by: Haren Myneni <haren@linux.ibm.com>
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  drivers/crypto/nx/Makefile                                  | 2 +-
>  drivers/crypto/nx/{nx-842-pseries.c =3D> nx-common-pseries.c} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename drivers/crypto/nx/{nx-842-pseries.c =3D> nx-common-pseries.c} (10=
0%)
>=20
> diff --git a/drivers/crypto/nx/Makefile b/drivers/crypto/nx/Makefile
> index bc89a20e5d9d..d00181a26dd6 100644
> --- a/drivers/crypto/nx/Makefile
> +++ b/drivers/crypto/nx/Makefile
> @@ -14,5 +14,5 @@ nx-crypto-objs :=3D nx.o \
>  obj-$(CONFIG_CRYPTO_DEV_NX_COMPRESS_PSERIES) +=3D nx-compress-pseries.o =
nx-compress.o
>  obj-$(CONFIG_CRYPTO_DEV_NX_COMPRESS_POWERNV) +=3D nx-compress-powernv.o =
nx-compress.o
>  nx-compress-objs :=3D nx-842.o
> -nx-compress-pseries-objs :=3D nx-842-pseries.o
> +nx-compress-pseries-objs :=3D nx-common-pseries.o
>  nx-compress-powernv-objs :=3D nx-common-powernv.o
> diff --git a/drivers/crypto/nx/nx-842-pseries.c b/drivers/crypto/nx/nx-co=
mmon-pseries.c
> similarity index 100%
> rename from drivers/crypto/nx/nx-842-pseries.c
> rename to drivers/crypto/nx/nx-common-pseries.c
> --=20
> 2.18.2
>=20
>=20
>=20
