Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D39F606A337
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 23:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bKhoVhDu
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRD9M5bFhz3bhY;
	Sat, 14 Nov 2026 10:33:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794564239;
	cv=none; b=ZAmX93UjSSLWGmnmfIrVOSIaI1KzrpQlGWaQ2b0IAWERW63lckbTKCLyWfqFXmDaUSVLHq1Dy40kroKg+0sgesv4TeJ4x8ze69UAPueZu6piSYX1XUDeG5H2sbLwqtx1rRNTPQeons9g8rzDmG0FYy0MDHF2or8aslE9MbqRb3ZCqdohZGgICJEoiXRmJb0lsvDABHz6rUP6Mrj9AwtCCP+TnBVoIhhkeyG1dkUNNcfykzNKTII0fOytOuDJthNWxXGCKL0xr8kAnOrFb8DNK8UXWdBJwY3AZIkBc9aDspoArZahmSl1vmJKNSgVoLVGRah3OSJB9V/OKmfen6/jbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794564239; c=relaxed/relaxed;
	bh=isfwHOSFEU1THdAtyjNR/BymwB+TGu4CpGjFt5oul8o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O/FbwZIlqI4PW+wY9pSaxfrWtyr1gDi8kdDUDdrOdOGvllUrxIvXJpJIcHm4e/xH6LAH7v7rs4lxFRBc28SRrW5q63kr6wankKPB4QslG5TnFXapJzITwlnwEh8g2iUe7o8eF2ChpnkYtl2SWWOfxzQktO8jME2D3MoxUo8ewURa1mTmXPgIQw7e9XbCMPSOUcymgkzijmy8jpt2reiJqg3xc0EtIEsHZ0IXSGgNfXU84G/Q2Zc9n8lv46di1/YZ0wivsIFZYFM/jkrd0WhaXXuY5EjCZMyOajw70BW0jr/JVav5ucH++IMpuJgSSvudTmacZuanxHtcnGFm4IKOPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bKhoVhDu; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bKhoVhDu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQtBk2qP6z3bb6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 21:03:58 +1100 (AEDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-6b6f42095bcso1441623a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 02:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564235; x=1795169035; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=isfwHOSFEU1THdAtyjNR/BymwB+TGu4CpGjFt5oul8o=;
        b=bKhoVhDu25gXhai0TYaMM0rdwmsYSGJGTM5i2G93kPqxiZUxBCMnLoi8so8Hibx5eD
         ebmPZ/x/Q8xVhw3s1cYhB/WcEgQ149pZuOJOZDNhLaAmMNVKB2gxyKHveNaIpy+8dsZc
         lXbSBWfkJ2T6gLCRNokolNMDIxlK6ItnxlPzgSaZiqI+CqNyndY8ncKVeq6ZHclzNxga
         1l6tUW1MC9mOXSTR6gT5fuiZzaWqODwk5C31SrPEE93wHHP3afGZGhSBuCbYWU6xrUfS
         gfe81e+2wQTQBPyq3B9XE/Qe8OlksV5pGC3RDb7wZcraxjOLqseC2SZmS3RpVXUQycD+
         F9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564235; x=1795169035;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=isfwHOSFEU1THdAtyjNR/BymwB+TGu4CpGjFt5oul8o=;
        b=ZA8Lmvogt0j+jaE0N36P9yy6HMLCmb5eJNUlrX6RTPs7EgbMtC7Fq56HJfboaCvG5v
         v65pJZqzDF1EaSSVV6tlyQfo8NQ0HVe0T9tM6PB9bqE5U0ov8ksfhUNBFPxAkqd3cBAR
         tZkizxyjj0vjBDjlH4t3VuvfVWK+cGWmHjuOTXYpK0Wlc87M2Vxf4RKQVI6GaKiEgZPl
         GYlR+4O2dDdVZS8xuqpBzmZqU1IlZtnD3LgDLGeHC547dw+5WjbXC1RdUbC/5FPNyx/G
         mmu8QBpkl35h6W8nuNUoqgY0jRB2gEOvHG35ODjGcsJipzm8v67uQCukLdJ84UZTVz6/
         Fu6w==
X-Forwarded-Encrypted: i=1; AL+hErHH3ngOy04H/RtU7dx86qKembL+9vJEZxePgnJOdvR2VBLX54AXTN2TH/JPoHP3q6HAgETSJ2PGqJ0r+QA=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8bndJMI/eJ1FTRqm8fW+anufXRf6swZ5LBVVRLPnpvoBC1Npva
	z+6Ck67GQRe6KlG2nJ5GwxLzCFpI2ziP4opD5uUAtisAN91rLnm2OwoTcf2mKxJqzg2E
X-Gm-Gg: AYBFou3K185U1M/3bBNCuoxMdtYOqZzt9X8q3RPbyMPghsm9Vigdbe74V7PRtOQd6ZO
	Vnw8uS0CARwzB1kZ3HN8TYBAJE0AwRj7f2BFV4jdr9wJK4afT4mXdQ9n8eKviDmjnwT0iWW9XPE
	w3TDGrsz9TnlyenQSuz81DknCu9sWiE0QNHbv34/Hz5lq0YD9BDCRb7Hm/8J8ugYNIL8/JbfySp
	XQF38GU9se8PtGYFLeIM38xIKkRnJXSbWIzRQKJ10X3bQWUeiRJMU+T1ZiitYjk8VffDk5LV4Rg
	4Zh9HaepUiky8xg8VCuP5HvoBTd8zqjP4FmCrO6OPSu/6HuM4yk9Jjfeh/+qfuxQlrjvkMpO8fG
	k7q358umjwrWmW3RvPS5ZiukqHyn4gWrvur0ay5F3K8c6rk8GemEXuNloBYZ+mK984C0RwK8+ks
	SWNvN/oPPa0wPi4hr4GUbdVFm9I1Gv9qwbbU9vT6g3nZ9HXJc1UqxnfDHFECPVhh1pD14hwXZuU
	CUEu7X0PfKXdqCk15fL6nujAw9DLT5QDouAxdl7YmpOlX8Jb/6BGqIaD8+YFpCy0RupLcdsMjRf
	wPcJYap7uhcWSq0A+HoBDkyx6XUbwKCX43ti2k5tFnuS88OCAR4ZSKn6zolCU94=
X-Received: by 2002:aa7:d556:0:b0:6b5:96e9:ae97 with SMTP id 4fb4d7f45d1cf-6b7c0ccaafdmr1234919a12.34.1794564235160;
        Fri, 13 Nov 2026 02:03:55 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c23611casm766458a12.9.2026.11.13.02.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:03:54 -0800 (PST)
Message-ID: <16dbddeb5cbb9613dc806b43fc681eb26aa3b0dd.camel@amutable.com>
Subject: Re: [PATCH RFC 10/41] nullfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:03:52 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-10-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-10-4c998976c6c7@kernel.org>
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
> Initialize nullfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/nullfs.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nullfs.c b/fs/nullfs.c
> index 319c2f5c5a67..2fe24cb97160 100644
> --- a/fs/nullfs.c
> +++ b/fs/nullfs.c
> @@ -2,6 +2,7 @@
> =C2=A0/* Copyright (c) 2026 Christian Brauner <brauner@kernel.org> */
> =C2=A0#include <linux/fs/super_types.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/magic.h>
> =C2=A0#include <linux/splice.h>
> =C2=A0#include <linux/uio.h>
> @@ -174,7 +175,7 @@ static int nullfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0{
> =C2=A0	fc->ops		=3D &nullfs_fs_context_ops;
> =C2=A0	fc->sb_flags	|=3D SB_NOUSER;
> -	fc->s_iflags	|=3D SB_I_NOEXEC | SB_I_NODEV;
> +	fc_init_pseudo(fc);
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0

