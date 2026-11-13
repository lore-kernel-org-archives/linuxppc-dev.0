Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3B8606A339
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 23:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VhRlpcFv
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRD8K3c0Jz2xsW;
	Sat, 14 Nov 2026 10:33:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794564143;
	cv=none; b=ZF7nJpRyPbXlSjUX+DmNkJRt+dJlun8XBeBFBSnxXg++Bbh4ZnCdvYy/Kona3fsaYZ91LZidjbDFy6uFK9DXOMayranBdoDLXzeiYsu33e79s14sr2qBFquv2zLFS3nvWfwdkzv+dwpx6qpUS1jtJfl+v98bxP7r4bCRrsEmD3LHtpmdgeeYpjOb48dJAabk4k0aVIM8HPSuoolrUCntNyKm17nWrl6KyodTaGI1aiethN2DvPAQZqwE2kAgnChpZ3EdgSyJ46tw0EP+AWULzoYdVYno845W0SffRqK0+T4h3E2qyyHv487fv7Oh1/d0JGJJY0tdIssomlbEbbCs6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794564143; c=relaxed/relaxed;
	bh=Ee4ggwaa7pvqsvjnONVsvhhjx7Blw4b1QTFG8P7u7TE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cHSDZqQikkAACCxnesEK48ehkAHEFuhpX9l1PJCHvH6mqvDl9E3fFKTwj4/5IxIVhM3zfhLY9zExMZgBFx7fYekntyIxdoUYgM853OMWcemumDiBJ+RQXiUv9kV0LOMsEx00CuTrneIv162JjrX4BzsixuD9Z+2FDCn5bStmJ1j6xasN/ep78YDANPJKtspeYnSIXlRJxdflF7fkeaSMCV48kGhqa9APe+sfDKUkTNFAaYqoBO5FWdAdcUUVoUT4bxxlNRwsNjxCjW+US7VzOs5Ep95UMadn9+tXWA/9xsBPcp9Ki20Ame+p5PoOO6F7KgSU7F9Z1Ki4a3cSme922w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VhRlpcFv; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VhRlpcFv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQt8t3f7yz2yqs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 21:02:21 +1100 (AEDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-6b587591414so1162411a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 02:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564138; x=1795168938; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ee4ggwaa7pvqsvjnONVsvhhjx7Blw4b1QTFG8P7u7TE=;
        b=VhRlpcFvVbnjOlvsnK5JSDm2hhARLY5vKJaifqRAdV4U7ohU0jJl78Fy/o6RHY/SS/
         WCYGK2Idan4xAAEFuVY5DJE21hh0I037ly75mWToenaF9Dkj4wqU8qYCU0870xwgidVk
         ZNERmUDxzm9hM32Pxilxcv7Ec/Tbmcc+LWzZWcCnbXTNscywC51jpHnnTXV7wnUWJPFN
         3QW+o7FUyBm7fcJWVbnD2thZ2xU2sXZ04zuJaUuIDSB42sdQ9VVUfiHSEbq+onMTbvRu
         sxRuv4U5Q8Z2yVf294W12m+T0isHSgHTM0iOZxtGAUHLcDvcQ3BnS+myoFfUloj7AAMe
         TJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564138; x=1795168938;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ee4ggwaa7pvqsvjnONVsvhhjx7Blw4b1QTFG8P7u7TE=;
        b=oLk1Rbe5PPcIFiRRW2kAzVrd/YRLo2YBXw3EAV3wsqkVOvH8n1McL8/RAF9Gu14AQh
         SKI/M0VHD4mHG+pR3rvvyxcsyPSyXaAOGr0NY0U7ex9BkAV+cu6FKw2eEKuhxpFLhqZG
         e3aMlR7h1IotrPjXJBSwAaC2i8P0SQEVKIZGN5fyPKL1Aa3EG+U5eG+31kZN8J39QSJl
         xmIzTdttZyw4Br2bP+LModk/oZnggB6AcHwbXUYDPzoQcmyLBqyDJR17noTagm8wt5o7
         QKadQM3q4kTvdM57sfk6oYV+RdT1xfnluxLQr1VK5NXc7dFENOf8lNNNbjflPEui05qa
         kVfA==
X-Forwarded-Encrypted: i=1; AL+hErHFTKNmgd/cnlgV0goZsQNgtAahfJM4CbbPh9tM+6cg9sk/TZSziTTA3a+gaoD+xt6tvQlyeUbfCUZstP0=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/aD4OxDRDrIGxslh7ccnhweUld71M9ksokSilAzH6w7DzbI+IH
	I8apzUHT97/EU9jW90SGX9paN3Hh9txhCNnlGNbi8PdFJMPqmQvQZPbnPy8fKWrpdgD7
X-Gm-Gg: AYBFou2/d6+uCmXcamc7m3xCX8EaTOpqXm3UVuV4aJVnxpgeUfdvm4+662rw+CpnfIE
	sCRA9+rjGRONZIjGkQ0IdgjYnLq8aJ/7t1hRVqPusRBDj4lBqbwLkAMh7Rh+NtjSARadRfw8QfH
	ZghMksalMP9iqGIRlVfxxJrSmhjEKV6Kl9n39JyCJwa8g70pRR4LZWAGhMOSzZbkaoQRv3eMz2s
	cBXYzRMLhazvcrRS8uHj+Rab3LM4W7C7S7mOKfp6mxAhPwUE15vJQJejYwEdNJf/kZW4208Vk5x
	QLP+F6d5N9EgyIAcnxyXjIkZ3B78/J5Vx8lb3OxRIxaq0AXVETNWfdU7X9Qzo8bF3XjDFQjrnWs
	VNdLxsz9V4mgRPdmYX7A7xE9hmQ47ueHBZ/FunVUHJybhKL2jRyeJuScmAC6VsnwO2uxN5OXGmR
	t4KB2pWPDc5cAPi4Tzq18s66c3hdlrXyQGqYbXfBXCnE2FJu9YeguMmjeq2PBR+LF0pwlzO44TH
	M8p6c1IeiAf8aXVCumYElniWefWjR47rD6+dSWOY3g4k48wg2M5sAz+Zi6HZCfoDurgLfFYVc5Y
	/p0Ri3hMRbpaxTGiTSG5PNXlKG2/uqCemuTnAkYTcXmDwUeNn4OLL+l9Kmz4gBk=
X-Received: by 2002:a05:6402:c4e1:10b0:6b6:eefc:ae7a with SMTP id 4fb4d7f45d1cf-6b7c088f8ecmr1236733a12.4.1794564138223;
        Fri, 13 Nov 2026 02:02:18 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c23c672asm734155a12.15.2026.11.13.02.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:02:17 -0800 (PST)
Message-ID: <f4ce8239f22046e90cf4807853282a570c73707a.camel@amutable.com>
Subject: Re: [PATCH RFC 04/41] fs: add SB_I_PSEUDO
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
Date: Fri, 13 Nov 2026 11:02:15 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-4-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-4-4c998976c6c7@kernel.org>
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
> Currently, there's no way to tell whether the files of a filesystem
> store data or whether they are kernel interfaces. Files on pseudo
> filesystems such as procfs or sysfs generate their contents when
> they're
> read and writes to them are commands to the kernel.
>=20
> But a few places in the kernel take an arbitrary file and use it as
> storage: loop, zloop, the nvme target's file backend, the scsi
> target's
> fileio backend, fuse passthrough, the usb mass storage gadget and
> erofs
> file-backed mounts. At most they check the file type and whether the
> file implements ->read_iter() and ->write_iter(). That's not enough.
> kernfs provides both for every sysfs attribute for example.
>=20
> Add SB_I_PSEUDO so a filesystem can state that its regular files are
> kernel interfaces and must not be used as storage.
>=20
> Pseudo filesystems also never hold executables or device nodes. But
> currently each of them decides on its own whether to raise
> SB_I_NOEXEC
> and SB_I_NODEV. Some do, most don't. Add fc_init_pseudo() as the
> common
> initialization point for all pseudo filesystems that raises all three
> flags and switch init_pseudo() over to it. The following patches
> convert the mountable pseudo filesystems.
>=20
> Nothing checks SB_I_PSEUDO yet so no functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/libfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +=
-
> =C2=A0include/linux/fs/super_types.h |=C2=A0 1 +
> =C2=A0include/linux/pseudo_fs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 11 ++++++=
+++++
> =C2=A03 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 96a6e9b1535f..8c8789489fdf 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -735,7 +735,7 @@ struct pseudo_fs_context *init_pseudo(struct
> fs_context *fc,
> =C2=A0		fc->fs_private =3D ctx;
> =C2=A0		fc->ops =3D &pseudo_fs_context_ops;
> =C2=A0		fc->sb_flags |=3D SB_NOUSER;
> -		fc->s_iflags |=3D SB_I_NOEXEC | SB_I_NODEV;
> +		fc_init_pseudo(fc);
> =C2=A0		fc->global =3D true;
> =C2=A0	}
> =C2=A0	return ctx;
> diff --git a/include/linux/fs/super_types.h
> b/include/linux/fs/super_types.h
> index 72f4288e16c5..472200bdf081 100644
> --- a/include/linux/fs/super_types.h
> +++ b/include/linux/fs/super_types.h
> @@ -359,5 +359,6 @@ struct super_block {
> =C2=A0#define SB_I_NOIDMAP	0x00002000	/* No idmapped mounts on
> this superblock */
> =C2=A0#define SB_I_ALLOW_HSM	0x00004000	/* Allow HSM events on this
> superblock */
> =C2=A0#define SB_I_NO_DATA_INTEGRITY	0x00008000 /* fs cannot guarantee
> data persistence on sync */
> +#define SB_I_PSEUDO	0x00010000	/* regular files are kernel
> interfaces, not storage */
> =C2=A0
> =C2=A0#endif /* _LINUX_FS_SUPER_TYPES_H */
> diff --git a/include/linux/pseudo_fs.h b/include/linux/pseudo_fs.h
> index a651e60d9410..0ca408aa60af 100644
> --- a/include/linux/pseudo_fs.h
> +++ b/include/linux/pseudo_fs.h
> @@ -2,6 +2,7 @@
> =C2=A0#define __LINUX_PSEUDO_FS__
> =C2=A0
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/fs/super_types.h>
> =C2=A0
> =C2=A0struct pseudo_fs_context {
> =C2=A0	const struct super_operations *ops;
> @@ -15,4 +16,14 @@ struct pseudo_fs_context {
> =C2=A0struct pseudo_fs_context *init_pseudo(struct fs_context *fc,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long magic);
> =C2=A0
> +/*
> + * Common initialization for all pseudo filesystems, mountable or
> not. Their
> + * regular files are kernel interfaces. They don't store data and
> pseudo
> + * filesystems never hold executables or device nodes.
> + */
> +static inline void fc_init_pseudo(struct fs_context *fc)
> +{
> +	fc->s_iflags |=3D SB_I_PSEUDO | SB_I_NOEXEC | SB_I_NODEV;
> +}
> +
> =C2=A0#endif

