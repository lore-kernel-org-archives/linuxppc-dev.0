Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32534606A334
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 23:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=d3It+h+p
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRDCD6hyPz3cLy;
	Sat, 14 Nov 2026 10:35:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794564921;
	cv=none; b=OO6a7uaV/Uf7tkt6K7TTS576m62tswdZ4iP/gQ/8WzcZCtRkbKwUWcStJx0E5qCtpsizlFUb3IJZEyncO2MvxqSSKlt+SU0FtFvW5/FUf4LXXWAgfItTIPGKhPGax8PTKtCQ6tP2dl+ZQ8WyVcHkRnvIX2OfWSH684pAgN2HkU9YJhTwth6G6GuLVUHehCfzToo8vJ1K4k9hK+8bD4N7QJe1yhx+6WCyQorXFDx5PVPYg+dJoe73xNIkac8IkeI7OuApR/6WeTiSK2xkVn6VFHEODsYzZn6spGnhRA76X1rC1ZdRa4poQaaBCt3if+d0QZDQ5JmHgaeZc3XgEq0qcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794564921; c=relaxed/relaxed;
	bh=QtOsdPCKGJ1fBhMqXd/zLQfd50NEx4L7veNiE/G2OUE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dnW6l6Q/XgPiu0I8If2tNAeH3gA8vgAwGgbf0XRrt3e9fRZ5WSGbmdV+f7BUZiEdmRhHJu6yBSWKxrf0ivcZVSkKrO91n9rbBpK6+bGxJRW6a8KUGi4aGYnExuBMNnP4dzb2iCmDyZLwW90FdiXiFmpXDlEIA2ngv/NNPyU+REk+I2SsA0vW4pWnKH8kQyPyYu7qgzNxy4OMsCeHTl12chcL53BeB6F5lPNnSchYr8ymeVlOtz86Wdb7mqElOvv+svMPE+Z9kzL867slEgdiJ9jw/QHLp7jRIxcz8G7jhrn4YjUghISMWpkO/DsciQbxXYKvWV6sKksuyDFeZMO7bA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=d3It+h+p; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=d3It+h+p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQtRr4qp9z30C6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 21:15:20 +1100 (AEDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so5374035e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 02:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564917; x=1795169717; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QtOsdPCKGJ1fBhMqXd/zLQfd50NEx4L7veNiE/G2OUE=;
        b=d3It+h+p9XA2/Yo1IX1XnR6mSCxMCHg9LLJiNvOsL4YwTL0CdpmrLoqoV0/P25B4Jd
         EvW2AV/dJju/61vd1hS5CTFwAL7cHqpKzsCr0OfYjndpoBu/3VZMvxb3FqUSQlfE7urU
         /xJYuzHdBYaTrdfNy2gE2RNEJkMgDrQJlW4Cr79lNll4qXTNPuWwCFZkqTbo+XBhcTxI
         inyA54BmMSHIt9j+bM3VeRgdU90DCyzhc6RefpE2eQRi6oLv3UOUdAmNjrCDYTPNa+Xu
         wii7pqCW+zG75J9XiEl4VA3m9TzUgO5QjKGIcUJKPe5qxrG8bRy7qJXSqE8ekbu9MCIN
         hjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564917; x=1795169717;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QtOsdPCKGJ1fBhMqXd/zLQfd50NEx4L7veNiE/G2OUE=;
        b=yZQDeBkXsfrIUallaTW9SXlHlDf38EioC+zYBOtkCRYf5MW7fWWguLxpLS7Nf3aZMl
         E9yaa/xs/7awVV9+kfzWDM+zbCIeN86XTbnr9iuEnNbWf+kFZKU8/qLeHFPqLyJ3rSKk
         7KPsERdU94MeGG6Wf4jUjXU9LM3UxEzV2yRdvVJfvExHvPt9Jai4S2w1ztPMyRSttt2E
         e1rYKCJ4yC+Ym8TYU2y8iNGh3q4qDys97+h7ZD6aeD6Qyanp39JobFJVeYf7jaE4/TfD
         JzooipfsH/TZPxFOqAiSI1xa0Cafh30Kyfkvi/2ubCzCa4HItiFiP7Nni/SqPK2RZ3uY
         cnfA==
X-Forwarded-Encrypted: i=1; AL+hErGKo3K2MOC1+qQwrwHGr/1ctEYjICk+t1kBLdiT7idoDqDxoOKM7dtB00bYD4BFupWgkutTwfOOIIPpIcs=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9x++D3s8nbHJW4nBn9tYUA009+wX3LIPz42KmTfKgzwEYW1qfK
	MCpeVS16iMvu4hwLlh2ZLOiAi7uMte+cRYyA2Nhhplr3w2JcpnXKv5OhVgQ9iuUeLEzZ
X-Gm-Gg: AYBFou0wfSXAv7TS2/mJlrvHSCDY78v2l3dgD+MKN6VWvY4OcKgwEZXiphrdonoCq6X
	LGhZbggGpvgpPKlWEMw2JfjA72Z1PhXWlvTOX6DJTUwgE9Id6ttXnh5kKcxNo64m5IeOr/St6j6
	yHyYnCbtb7Jf1E0DVukcuHdDF1+Pepx6wfFOkP6ssLOTa7XcB408+o4aR1PT0gEm0JyE07ubV6U
	cq00XC73zkJn78ABtjn1PNzJ1IcP8gy8U+9ccEgAomEVuvZ+s+gKUoyHe3XNaNnzhkeW0cBQqDb
	F7Ux0N3MnQsu/3kgSzy8ncFVEJGYNMPmwEDN1MzDuR+Ne2towdOrmVQxvPcex72BZZtQebs0Myc
	jxSthFNWAVAzLVunJ6yh3nudY3BATSM3MPJayHYYo8ad7Hhpu+GXfeg2XBnTj/N2KtCpccb9iV3
	fU6xbJyifhAoWRRUuR9BJQ9n2kzg7L1gvAgFzFoJeNzx/wJKAIAvXaK4K+1f7ZHX8yj1GxMA5CG
	27Wbn3t+n6jYI6wV9zZzZA0oCl+j0aijZv2TkIy9o/kYl3ycDSOgMtHF+GZfE3t5Aan55Ow64fk
	/U6adNgsRMk+OJEJpnyRO6ID3IZYhQFchhaz3A+p5aOwaqvvVSLgy7KdPWAMRKo=
X-Received: by 2002:a05:600c:4f84:b0:4a7:7f3f:6f8e with SMTP id 5b1f17b1804b1-4bb5599ade1mr43492835e9.0.1794564916955;
        Fri, 13 Nov 2026 02:15:16 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb56680ea9sm31982365e9.0.2026.11.13.02.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:15:16 -0800 (PST)
Message-ID: <e2edfa06d185acd86b46945622b6eb6dff97b307.camel@amutable.com>
Subject: Re: [PATCH RFC 33/41] fs: add file_is_pseudo()
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
Date: Fri, 13 Nov 2026 11:15:14 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-33-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-33-4c998976c6c7@kernel.org>
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
> Add a helper to check whether a file is a regular file on a pseudo
> filesystem. Only regular files count. Device nodes on pseudo
> filesystems
> such as devpts, binderfs or the block devices on bdevfs are what they
> are.
>=20
> Look at the inode that actually provides the data via d_real_inode().
> overlayfs accepts sysfs, cgroup2, debugfs, tracefs, configfs and
> securityfs as lower layers and reads of such an overlayfs file are
> served by the file on the pseudo filesystem. Checking the overlayfs
> inode would miss that.
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0include/linux/fs.h | 12 ++++++++++++
> =C2=A01 file changed, 12 insertions(+)
>=20
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 99caef43ff3c..407ffb6342ec 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2553,6 +2553,18 @@ static inline const struct inode
> *file_user_inode(const struct file *f)
> =C2=A0	return file_inode(f);
> =C2=A0}
> =C2=A0
> +/*
> + * Regular files on pseudo filesystems are kernel interfaces and
> must not be
> + * used as storage. Look through stacking filesystems at the inode
> that
> + * provides the data.
> + */
> +static inline bool file_is_pseudo(const struct file *file)
> +{
> +	const struct inode *inode =3D d_real_inode(file-
> >f_path.dentry);
> +
> +	return S_ISREG(inode->i_mode) && (inode->i_sb->s_iflags &
> SB_I_PSEUDO);
> +}
> +
> =C2=A0static inline struct file *file_clone_open(struct file *file)
> =C2=A0{
> =C2=A0	return dentry_open(&file->f_path, file->f_flags, file-
> >f_cred);

