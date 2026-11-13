Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8CF606A327
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 23:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=a8KNXeIQ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRD9G3WdMz3bdq;
	Sat, 14 Nov 2026 10:33:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794564225;
	cv=none; b=iDDJXVYwIZhJ+P/F6I9/n0AdYCKwOnhoWInJgsyN/MseDRtR//N1y4uAmaeiEpvBCx8mn+5VFTOuR6Gk2cBAQ8qDH3pPp8ycjWiwDJYcSyOqQnuLqCAIt12VTwLhTd9VqATmOFmEKRj4CswyYX52ZvC2kqwcsaa6wskNMQRLd6m4dxADDsE1+STIPl81N5pZh46KQR/e8s6PFzltdtMwoGBYDevbhvgRc2wWGK0PtvfOZ0CCPrsXDF5tAaw4YbL9Ek5kcUUozcmOfHf2b0N4+47i1zeT/V1pdU5pXGO6E1P0YaD8ynPEgvviIYTDmJRf4is5qSxsvkxK9Wf8/2cfjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794564225; c=relaxed/relaxed;
	bh=6cN8hpP/bnwcYzPsZf0cUkd2pk5Vve+UdRh8Jmnig90=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ETtZJfmgJO3sdj/BdFzNx6IFN7zqB4tRZvnLhlNgPcwYd0io0c8CbfySwEEb8aUJn+jSpmKgec78dqqj+jWdoETj8w1GDRqeDropcW0LkGeuhAFhFuwM0Venp1hxUu7T+0nAB0Z7+Di/1oziCqRMnp+k81eCPoCcK4Jf17OZUuqGYkSyKBPid/X7RmLsS6x8cV50CzgPEzbBDZjhYyLbeYXoMuFx/GeV689md7ESEbZJefiGfve9tAXRhGK5/VlgltgImE2TC3lC5DEIqOjv7HU/8Mq19JotFee9SZzRsGlG+ZmGwYsl5sffB2HxTH3KeBA5i4gjkAKIn507/jWDTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=a8KNXeIQ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=a8KNXeIQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQtBS4S0jz3bbW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 21:03:44 +1100 (AEDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-c169ae1cb26so172963366b.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 02:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564221; x=1795169021; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6cN8hpP/bnwcYzPsZf0cUkd2pk5Vve+UdRh8Jmnig90=;
        b=a8KNXeIQFYlCZEgcY+04lzlgpDd/9CgGC77LsKsgqU21M1WgycO5aPN/UJ23V5ty8Z
         OOLqhhp1+GXBacMejNWClkUb876mY72uMBSw9EdbjMNP25uH1assb2sVOMQdsYitjA/0
         HyPGm6mc04J1VCqwPgU8a7FbmNVXIik9lDoxehdAc5KmHO5WT4vPCi7SLZS7Ji4iN07y
         OhUftfXLNF6N8kk8Gg+I6uwTdlHQLowIkbxBngjl02mLx7WGsLwEuZJhLW0La2nlzIps
         XKHiOAFsXuREcCuWfVbcClvUFBvvIHa7G3XbULnhxkuqCUr0vGb5hQpyzyAkYDkyP9cP
         4CMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564221; x=1795169021;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6cN8hpP/bnwcYzPsZf0cUkd2pk5Vve+UdRh8Jmnig90=;
        b=Z40dc4DDEhR8d3Y0h8RxJBf15J5oUujcyDfh1kInlybeRpIR2SvD3HJH5w77EJ2lrs
         WWCvgCagnYCwx5dIuEti7W2kiM6VEPkNeX7JiJ0Pbp1wr9qwc3O03szeoinMk9jSxCF7
         etIfnSo/8CslyZNOMdSliLPSXCE1kEaFDULa+rx2Y9zCgsutvvzMkJuByN9QVVsDLiti
         HlSmBnvG8YvZqO/BRUSTEuMdsHGYpu5s63UV6yiC46QsTb5xrcHo0gqsBHq6/WrglbC9
         mBiLzeaQK13BwzSzdB+0BRlYNtZKwOn+Dlrq46/+050Iu2ua/f5Ny6dJFMoglV0RJ7jt
         IO2w==
X-Forwarded-Encrypted: i=1; AL+hErFrejOWVFr01U+/kASLz4B5qzMO/8uiJHLacKXUd93ktkgbFlEOTdhe9hECWnS6apIgLcT+HOkYPGpOdDI=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z956JO6zt4+lSu2vBpCv+Qq4c4esHWJNFDPQtg1LHkQANQgaPDt
	fZeCy2U3AxnvaCeA8rxjvlqL9hWUz7V/PBfKtMDA+D4cVRa4WmiDDryeWNaTcuGtFoEV
X-Gm-Gg: AYBFou1cOTd3HM4zt0RrBJU44hC1PmuOejSWyeq3rsV/U7uUzg0jozGJo+4FVJNuVNk
	rL7itneErGfw6MbDBZ+OG9K5mepIDvQVpMphRlay+Mcmc35vzhCr5ijQDdn3ZJzf8T8+OsFpO9I
	z9XkoRmEYnzIZaNtkVVXvmakfqmQ8/MpaOyWJM9it4aTHsl12r9N8CWQdvDd1k2jygO+hkvif9z
	DhXK/JluUKIcFfdAhiudhzk0rvjzon4a7OHLUMwfiB/ASvx+aGvUU93DjpJNyXcLZa3sEhhv2Me
	tKn7hEkDZ5P6AqZPab6RelK5u4FiYeXw6MadmJice8Q+bKcTgZRt391Wv0j/CsRpjO+RmVJbeEH
	WjB5pv3rC0r+344dtTWeQoEhf/ks+nqOhwJldgDl3u9UDCy4lDyKI9i4pUNVYdYzj2E+u8V6yhx
	IHP7zYPqtFsjJ+Wyetktyv9YCXrhHyrUii25DeyVUZ51GRWUQwEnGxLUhXNTNTTOR0MfrniBUAX
	Kzw9NDBb6G9OR6/hyN/69PaE7Sz/SdRbuv29KRbKvWd2RU8AKCVXR+MuSXAyd/7QmSxptdVlv/7
	LMGdhtmCsH4yjuSnhHWpMiVTbglgrMws+YPfpUINdU/En8dEFTaOiE3+T6Wf3Zo=
X-Received: by 2002:a17:907:7b8c:b0:c42:bc58:f21 with SMTP id a640c23a62f3a-c50963856f2mr175546966b.15.1794564221164;
        Fri, 13 Nov 2026 02:03:41 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b3asm74752966b.27.2026.11.13.02.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:03:40 -0800 (PST)
Message-ID: <cfcbef5caf7651b63774549fa1999d34981c78a4.camel@amutable.com>
Subject: Re: [PATCH RFC 09/41] bpf: use fc_init_pseudo() for bpffs
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
Date: Fri, 13 Nov 2026 11:03:39 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-9-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-9-4c998976c6c7@kernel.org>
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
> Initialize bpffs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0kernel/bpf/inode.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index c6f328e4752e..57cf3775c076 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/kdev_t.h>
> =C2=A0#include <linux/filter.h>
> @@ -1197,8 +1198,6 @@ static int bpf_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	sb->s_magic =3D BPF_FS_MAGIC;
> =C2=A0	sb->s_op =3D &bpf_super_ops;
> =C2=A0	sb->s_xattr =3D bpf_fs_xattr_handlers;
> -	sb->s_iflags |=3D SB_I_NOEXEC;
> -	sb->s_iflags |=3D SB_I_NODEV;
> =C2=A0	sb->s_time_gran =3D 1;
> =C2=A0
> =C2=A0	inode =3D bpf_get_inode(sb, NULL, S_IFDIR | 0777);
> @@ -1261,6 +1260,7 @@ static int bpf_init_fs_context(struct
> fs_context *fc)
> =C2=A0	opts->delegate_attachs =3D 0;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D opts;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &bpf_context_ops;
> =C2=A0	return 0;
> =C2=A0}

