Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBF3606A327
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 23:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=UGapqXlC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRDBr4fVxz3cFG;
	Sat, 14 Nov 2026 10:35:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794564826;
	cv=none; b=R22MxtYUsEfUX+VIP4G6ptlzncf7lHS0yZFb56IJB6r8e/CLnGCa/SwX3p0X6iArvgnuR4uGoAEXlAmEW8F1mAZtPOeKArr2gcgwFYYug0GBpO5MVZWrlVzjxekEMmxav8wr7QlHx5HmB2quTzeg5bcmP8euqUsDAvrbvChjShfcOvf2ZWxVdH77TWQOz3YvptXChycZ4c4KybXk7jNgoy9zQfGHa0EvSYoQeixwKj1sKOLqgPV4MtyBTU9/MoIwvsbPi7JdHS6G6u9W9TflmbwdBhvsLYnm8pMLyVtRVO+ewHnYTtpc6IuoaLhqa2Tl/yjTETUSbnrx2rBIYmj/hA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794564826; c=relaxed/relaxed;
	bh=ycFr7tcHP3BtNSevVHScuCcUOF/OuOrXOdu+rsUd7U8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oDVsb15TeGTtd7kGpSUbhyf5foSHXamVTuZG0RbxgCBM8XJOpFoaDIGd8X4+8m8bv8TAycG7kdxqQfyEEpMfSmJbQBXjoMiy/S4i9UlJAF8XUMkOHUSgGSJc4J+8FAgEzk8ndk26TGUR+XuowhP+awpVT1GUP/hp1+WBR1N/4s9D8PJHtLv8fZa0llqpPcTCt5LNCsGsNAFz/cFpPj/qlUYiPK5hzr2xkvv8/dpFJKH42RrlNCbrxDBG3BvFzqzhZniv7Lkj8q3tqdm/6nFzZ6rbaM9/dJwFN7uUrRoW8gs4mEA7fGo5HsdtTRvg6gPuzaA7NSmp7zMoRXy0gErvrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=UGapqXlC; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=UGapqXlC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQtQ14PdHz3bfF
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 21:13:45 +1100 (AEDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-6b7221c0f2cso1490865a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 02:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564822; x=1795169622; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ycFr7tcHP3BtNSevVHScuCcUOF/OuOrXOdu+rsUd7U8=;
        b=UGapqXlCTxLwGsXe9VYuQvkrX69Y1Ns73qqDAJFg1TXpsYi1KrYzoKHmskOojEpgmu
         BXTcvQoI21zFBRSPB0D/HLojtjSHqNPO2S4eXmnjm8dZglIFJrk9NzY6TJGgKI0r12cK
         cNumDlVYB+vcCINYX6tEZa5/KS4Z8cmzSVVWjZSHls2fnQiDxT4/IKeF5HrfCW8suWej
         9AdHZlmm6IgCZxgVGeVg5nezuHODjxlD92RXQn2h6u5A9Rzb/M5+7I8lID3EBmY/NSaK
         hC+ttnO8D155hQmr6u6NpFGKJh3ls7P+qeAmpzQpXJRJ2JQ/ONq2xGSxe9ly3Ukl9PAZ
         7L0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564822; x=1795169622;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ycFr7tcHP3BtNSevVHScuCcUOF/OuOrXOdu+rsUd7U8=;
        b=NXFcVPk5XWArffG1KHwD3+/+38JcavZ6ASGzhduvLLDUu3PrXHJPTjPo30cpELrIlR
         3DmaWZv2S/oZ2yhROwc9BvgM0F9C7q8dDKes/MIu8uQLJPk7bgbqP6NfbpIhbky5RvrY
         cFi0ot8xaZfGruUg8dJBHUGpgWZsAKM7M2dLiaNbgzKVY5W1ydw7rcuE9zB3Jal2bMw5
         cWZRVUnu6o1mK1DtiuP13K0a2wl5cnYBH+6L0cwpPLQqNec4z4UML5WmPoKcGb5gjIuj
         ZYmEdlhIAONnPtVVxq/FFtoQ7X7FUdjpCwLIQn+wkE0A1nhOXAlpRd5bOs72jfALwQWy
         w5ug==
X-Forwarded-Encrypted: i=1; AL+hErGdtE6EgHdQId1L+v9BCWqG21HO9vXylYdWpqYpbFhqTeyncFihr/J8G/NJkLEWJvHWIopxwa3YVquRwEQ=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/BBXqseen/I++W0Ek3d7uPQIhssNXfq4DsW+0c6iCjEbXcTJkJ
	IM26QMy8uaOY9MVx3v8vvswtr3zbnJwN1+zS4JDnrc1pNgEQeHpzVTrx9xE6CiY2tosV
X-Gm-Gg: AYBFou1o0kIzQK6Lgc7230/LO/Ir7rZfabQiGObBponNpnrgBu/WnOzdSIzT4H0r3K6
	aZUIVpIGwwDT+X+4HxSWm/oVBJk8FacJL82fcXXSvYdw1tmRq4eOsATIEm3fvhPLUsVa5M7HEzk
	2ZJrfftHwiDoVbAbDGzrgNgU/Vq9vyafYCCWaAk0r9CFQmxxD1cdp7W9fI/mhK8CxpNs1UXKXJJ
	OtvP3RmA3An0xdCSPGZJXMC9ndInrlTh56c1hh+19UZWoCw7Z6If0xVZCeQZGVGG13jLalX+iYf
	RGSundCrcXHifMBAM2zpFkgN1IZP59nNK1RhuN/R/fUgITVWbTHg98y5U/vmCJvvpV0l657SqNi
	ZeaaHZBLjZDdU35QVklWQSjkd1+Uv4p1I/aaPQhQc/BZ6GAV3Ca6amJnqrTtJZZCZVFdevk7KvK
	UhFmpTIHEdTWvXs41Mq6dOTGtAHFa2zhvMRkGrioV4AvnlO5xansOOLxPhlv0OTPqty6PbqErn1
	cugyAxNtVQE3Mm0lZAI1GMJ+MU8truo2frNy66fgSUk+Z7dvTzHxOJ7oNTCDqIbIqIPfDnNCYc2
	xraDN5Ib122oUV/oYldpymuoiK8bvVnHXCsfYHh+QoS9aJl2pYMPdIoC1nHPG6TNtnIKUWzmgZA
	pq/1mstOW
X-Received: by 2002:a05:6402:208c:20b0:6b5:69f4:e7ce with SMTP id 4fb4d7f45d1cf-6b7c0c62bacmr1415990a12.39.1794564822367;
        Fri, 13 Nov 2026 02:13:42 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c603f4d29sm4332158f8f.35.2026.11.13.02.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:13:42 -0800 (PST)
Message-ID: <3546dd28b1d63c1478d391a2015fff4c1b976639.camel@amutable.com>
Subject: Re: [PATCH RFC 24/41] efivarfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:13:40 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-24-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-24-4c998976c6c7@kernel.org>
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
> Initialize efivarfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. efivarfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/efivarfs/super.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index 12746ced6dc6..e598d42c5f42 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -8,6 +8,7 @@
> =C2=A0#include <linux/efi.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/pagemap.h>
> @@ -554,6 +555,7 @@ static int efivarfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	}
> =C2=A0
> =C2=A0	fc->s_fs_info =3D sfi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &efivarfs_context_ops;
> =C2=A0
> =C2=A0	return 0;

