Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CD4606A32E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 23:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mRu4c5T5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRDJK3vkvz3bkd;
	Sat, 14 Nov 2026 10:40:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794573512;
	cv=none; b=bQg8uqUYNrLCIVLTi9Pq2vcMtngy7lsmokSxe1E3kqLrjRx6wN3pVjD+BKFcCfcwXMvVapu7BkWIuNk+PT43FCVriaoUu359dT9xV1pZLpyzx9H4cVCGatpbBDdK2blljFNxpkupWbI2bQ63WwEewwVD6GwLQtYPwIDZZoBG9BhjgJEzXFuChPxF7Al4pjTbLe7peKzJmij/We2ZFPYkzyoqQWZmKw9yvllgG3HQy/37sxPNYg/bJciPd3pBFe3Bdye9ZDsQdsENbDl/Q1Y2ty5soZ4ltCbeNWEoBiNSSscVHwGZxNARTAQV4r+PDNR6OmTRgkPTgQvh4rkS1eXsLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794573512; c=relaxed/relaxed;
	bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TgunAdyL/wZ7BZ0mk9TKx1NxuUItOGKD8c8G/7+91A8tusaX/OX0jcse7tcU7apj5VTb+PvE0gK5x0gNOjnDNB2qJDqEqjXPUDW5mXau+/BfPaCrr+pc7x18iXAjtumzBlXCfAuXG778XN3PkGogKpNPf4I8Pvj8uUal0LVBgtfLxGWJCcH7PP1p2gtlmqYMVBhFzs556iiMA6UtlD81uQrxUrNwiya6WontRY6x1YfjK8ykDHRx9T3ojFtW25wvDAzTfMz2NNe5GpV1i/w/bvVcnuVnt3wKkgeRIo87pMtLsvRbB/BrtHD13OuXA/6wK6QhYDHXVyjn3D1RydMEoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mRu4c5T5; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mRu4c5T5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQxd346Wzz2ySV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 23:38:31 +1100 (AEDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so9108215e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 04:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794573508; x=1795178308; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=;
        b=mRu4c5T5AU1lKDY4Y40TxFZTbiE9VaKrrkgbn0+8ONQBXkqXuPlSRV2WQebNDcDM7C
         f9rQ3P1aoSM19Jn27Rpff2CGjE0GUSkfpfEw2jXO42kHfI/39g8sxNmrapVLxqqHdBlF
         O2en/sf7V1H2MBOppqS+81NtnjqwBjNeyeOiKUC7JKQqzoXpCfIvyAezZpj8EIl9SeVQ
         UO355RLWQrjfLOg20sAUQ7wAvXbI9Zc3+Y6OADyqFpceqD10FA5woMCBG/7HEJV7KHhz
         I3ohTMVGGES7AVX0tpDs4jolGiqB3Fo1CDQf9nb/Fmtc55D/UD+Jl7Ic49gNm2AiIxmI
         hxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794573508; x=1795178308;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ny+1veWg8VD0eIDxFJ1X48Kguf5Oe9PbJZTpbcgMiOk=;
        b=NgnNKIYqMI4WoL8BbIi/Gvalzr30Sdp7O7Vl1ihtXsNIsjI3dVXFJsFwVYWFLzjMaU
         fSe4aHdX0srpYyDyQe6pM3l/7N2mxim9OC/isO2YmrXIc4pSjQfo+5BZY2ysKY1lcUqu
         L8yJiShgPxn3SSqF1L8A+Qi2njhmciZYVCU/lGR1SYq6VoZ2vxJgLCxhwVhhucpiNrmn
         WoMgrUJcwPtn35o9AY8F7G8A47P+VPxT/+xqGskbXDhfe3rpYADaqR4Ps99EKErzPzyH
         X0/zdk+SGyPyUrDyOH2z7d2QJX4r8yQ5p7I2xwQPjrhKlxlsHLGll+uRxDiOVhe3UuiK
         ZPbA==
X-Forwarded-Encrypted: i=1; AL+hErERZfnh2TRO29o0J8qZ6NP6ySbbv75ZJ1m7m2Ss+w/mxOEWh0BqQSpjJoHrgpZHKdM271/INJ/kFARagGg=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+Ymj3iimjQ/2faUdb1izUItoHq2LANnab+hgXRSkJmob5LjC5e
	MDhufQ/l2v1qiOCdN3d3Qyvq10kwYDZge8UqUDRNL3tp6T0uyqM7WZbf8WQvyIwO8edN
X-Gm-Gg: AYBFou0S0l47svitcWUMWHtQxq7FVEGDdPwvWkiTPhZE1lidFGxIgMLt2D1vTibJgll
	7APg9Xp1eBj0WABUkh8xZ7KrP/fMWqzHrSEJAaEoCkZRe0lsxcdVjea6Nkqno6YZXJKNAe6eOji
	WcAJNZ0+T7siyHuTynjqUgYuq+MwwSJXYuy3C+8m8k5bEThgf0cxhZ8bZgTndM+c87/T9t06lnI
	s+Guck7dzOTaNUPl6n6BiQUHzHjNoYjGu5JuVFjUCLTTqS+5nJKP8g0H8CiZ5KqnG4UR72AmQ9K
	Td5I6D3HNGNRcANpgExXHV0C5J1xu4YZ6DRJVX+hsOyeRz5Llbh1sa1mmLUi5yXAv3yLOUgQgnv
	D+xeG29EjNQxrrBxZSRU6+g1RHKuQAe5js/M06qAFC1N+oG2mFWE/uBCYxPM9v0PMyHjOFFqXEF
	+dtEQAY2C+cUpyL1H8EQRgUIi/ZvKuoXBCE64fUBIqjrjvbtbgat4CJWYyi5SsaulQIGmvyqqfM
	u5VcIey8rM4rklpDe7rzgJnlPoAkBdCroqAur/pWftBnEF4BuuLB8eF6ueAkNN9i80SQMMUtjdQ
	8qq3r7N+olXQQR3Dx2YXM/ec7m1k4WXzzt4X1fn78bN5CUfDWGpWDn3jQ6Hlsz4=
X-Received: by 2002:a05:600c:a596:b0:4b5:d95c:2380 with SMTP id 5b1f17b1804b1-4bb55a86fb2mr24790785e9.11.1794573508217;
        Fri, 13 Nov 2026 04:38:28 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571cfa2esm48348475e9.2.2026.11.13.04.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:38:27 -0800 (PST)
Message-ID: <28a33fa649dcaae2eadcc934ec49fa591ec1c283.camel@amutable.com>
Subject: Re: [PATCH RFC 20/41] apparmor: use fc_init_pseudo() for apparmorfs
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
Date: Fri, 13 Nov 2026 13:38:25 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-20-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-20-4c998976c6c7@kernel.org>
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
> Initialize apparmorfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. apparmorfs never holds executables
> or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0security/apparmor/apparmorfs.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/security/apparmor/apparmorfs.c
> b/security/apparmor/apparmorfs.c
> index a99366467217..351ea3a7120e 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -21,6 +21,7 @@
> =C2=A0#include <linux/rcupdate.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/poll.h>
> =C2=A0#include <linux/zstd.h>
> =C2=A0#include <linux/string.h>
> @@ -263,6 +264,7 @@ static const struct fs_context_operations
> apparmorfs_context_ops =3D {
> =C2=A0
> =C2=A0static int apparmorfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &apparmorfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

