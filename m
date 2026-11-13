Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30EE606A336
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 23:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=C58uwuRA
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRDCc4kqDz2yLY;
	Sat, 14 Nov 2026 10:35:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794565076;
	cv=none; b=ZYt1LfVw1nXNZJUzuUk5UId+C855A0wlj0qNDBephSW1MZjMSOPa7orInlfTbJk6cIqBnK5E1rqoF4USrazBarnAEJNpTyejRuIPIRBU5ndkiXGrZMXFP/lmbEComQ85KRLekypTrDa01r8uuqqOzXYdUdheLvt2E6VZPV+mVPJuLXlUIg+WRDEPux9V9PKC5PRkpiiBtSNkIPJkRKBXTDSsM0rlMjCB0VBWm3EbqOxxvDWYpx8FiELYLRtQd9RNisyP3D2+Dr88i8i+aXY4IQ2P7vkhDk7EQzCq6oRBxexsKbVLVoAz8x/UD2UEDgYH0xra5RCzetvIlhbvcmDPKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794565076; c=relaxed/relaxed;
	bh=zqPqkCGOaO5RL/5NE1UeXRxAO7AqEHmUDDsiHSGxDsA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FmIZ/90KqtzXXXXknImpJKavwSkYSi9/ewtWwZXFbH08PDUPvJMi7tgVsjEfAoiZUgy4oz++6m0jB7rHFMuDNmwqLbFmEJu3K5kTYPxUUznLkosqDKhpoAiAH2ve5t58RxLOihgGJFFxX2ujEKEE7fHdvxrKQpZcl1M7msjm2GcPisnOxHNcz1MQlmzSsTlG+JvvuKc1jQ0NAoMj+vfTx3tQBqkE5Af2/zfvmF5IpgHyvDa0g/roRc8OWb2dsxUd6qyHbNapSORWOIZemaUH1E08RPjSp4R7Z5I8jCsZGZEbm7da1LIy3oJ+9bCxCOANjFpoT5oqX+mtoSvswGuewQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=C58uwuRA; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=C58uwuRA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQtVq1zPhz3bgw
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 21:17:54 +1100 (AEDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso7049425e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 02:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794565072; x=1795169872; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zqPqkCGOaO5RL/5NE1UeXRxAO7AqEHmUDDsiHSGxDsA=;
        b=C58uwuRALK00Efbqi1lkevcopXsljKIGkylbObObEvCAYKV3AZJy9c9bZwaJZb87SX
         3jYFix8xNSJ7C2gp12IdeDAOOvAMMX33hbdJSsX2CePZxf6J3sv8tIRvt2V47VNZmtMT
         3JKBzeaRnF0rsfmBT2e03P/Wkjw0vcfxpjj6qBNuwQGC7crYBTaDtyTWcLtKjeeVv+gx
         fBznFBoRYPfyke4TD8WEGoPWqn3HvJUDaN/aFPounUZufVyYHvVOAPWU1/d2qOZ648N9
         h59Nzyl4UUBTsIgX5WyFBOAj9P+lrqObpg4C2hc6r3pSaSpKvhUerFiuGIkGdPb+H0zY
         A4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794565072; x=1795169872;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zqPqkCGOaO5RL/5NE1UeXRxAO7AqEHmUDDsiHSGxDsA=;
        b=kYoXPqQ3jQLScb0uitDMrvY1veceTvMEFELIWfanfxJrpzvRaQQ5p1rcZFty7Ys60w
         uMAFDvb90A8l4nsTEYqm8OV8xXyGYr2jmzSgvsKhlWEGGlhy4Ygx3hhrzd9VmKg/wQiQ
         X8kwIwClSLelMyIaiksKc2TWrV2AZNZ9dYPELws059d0Tv301TfHgn3O7yhzyb6+pOsD
         Cul+t/NwpiKaUi0h8AxUkvZvnKqzXgFRFk8tXWP1ju1wAOGdG7+wfTw7lw8u3R22S8Yc
         rWQh7yiEF9czfdoFEmIAGmRvyA38JDWbfl2Wx4Sa3KpAe4EKQlN456LdQ0pYmunz8VFn
         G+Ew==
X-Forwarded-Encrypted: i=1; AL+hErHPhyQ3EqBDQGkenCefUJjsW4BlBtUwroJuKzNqEbS6V1po7kqvhNg6yRaInMALx2iAeJoukvdQlVI7jY4=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+rhPtk7wb3MamydLbHnptNydWCADeK35L7gZrIwefK+946JCNh
	jTVAtDuzY5eyYW12+puaN2mVaDxQgCjZ/ZUTHFBOHjNKGJbfwD22BN0uc4yV7TI8FlVS
X-Gm-Gg: AYBFou2HfsYmnbe0jRe/sk821sRQMm72kiEOKPKp5NcT4kdTZrIzn3spSqVGUuaJjBF
	bCk0s/l0JAKactdmVcq3UWFLXOlSsUjkBctTgloa/G9Z9HzNCHnl04dmaEwKMF4he5O0Hk/mcJ4
	aa6qlP+WFSNbxDzy9WvjZtOz5TBMD3ShQgxgv/8gUr0JFBmpyX0taHT1VhG7uiOzdJK7cL5I5xF
	SIC/NbwdpqmDaJZ9Zuq6ez1iZDVKJBeAldtErdGGp9m/c6xOr3BygbO8BqU3eipW1Wc8QYXfKL7
	dFXvj/rVjkXmV+E3zc7LFLATHIkUlGEq+55ts/aOjHcTd8dC2lxrAcFFYtcjfVG5VGYEgFX6hYl
	3BO+ZcGg8WGSmNxze7sKrShVsX6IirYsUYR7N2BKHkAe4aIp5MgAI3HS5ZGtcRD3lHYa6V52q99
	efVAlHWHCjq0C7hCeE40Jtjavn6V5Ul8D1MmAcXE0wVz/eGeotTR+kyeT51pumHSKmvfsOKAiUl
	k6GTr8ltx0ReCw74iUnu8TI0NzQzwrk2lSJrn1ZeNUikOdP6XQFrlWQSAuKbbcPv/bi8TbbitVc
	jvMA9Adkmdr7h+4J9Tf+Vc/7bZL1148xqOun+9U2lOMMLGznLQo/sS26kB3Tkow=
X-Received: by 2002:a05:600c:45d4:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4bb559f6f31mr43851425e9.2.1794565071804;
        Fri, 13 Nov 2026 02:17:51 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c7da37b19sm3937770f8f.5.2026.11.13.02.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:17:51 -0800 (PST)
Message-ID: <7cde6f3091f9d90593e4a6441723b6b889cc4024.camel@amutable.com>
Subject: Re: [PATCH RFC 35/41] zloop: refuse zone files on pseudo filesystems
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:17:48 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-35-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-35-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> zloop opens its zone files by name below the base directory but a
> bind
> mount can put any file there, including a procfs or sysfs file.
> Refuse
> files on pseudo filesystems as zone files just like loop does.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/block/zloop.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
> index 65634a39b0bf..dcc06dd47b04 100644
> --- a/drivers/block/zloop.c
> +++ b/drivers/block/zloop.c
> @@ -1137,6 +1137,11 @@ static int zloop_init_zone(struct zloop_device
> *zlo, struct zloop_options *opts,
> =C2=A0		goto out_fput;
> =C2=A0	}
> =C2=A0
> +	if (file_is_pseudo(zone->file)) {
> +		ret =3D -EINVAL;
> +		goto out_fput;
> +	}
> +
> =C2=A0	if (zlo->block_size) {
> =C2=A0		ret =3D zloop_get_block_size(zlo, zone);
> =C2=A0		if (ret)

