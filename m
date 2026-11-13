Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B57606A330
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 23:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=TTRR/Acv
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRD8r2r0Cz2xyj;
	Sat, 14 Nov 2026 10:33:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794564163;
	cv=none; b=Juv2mDYRdlDXmBh0NHfgD3KOCHqX154Dnb/+CeX5m/zVQvIDoO1HSol1LxPJU3rsaGrNrQR8PBGoTNHhmptZcDrYNOg/TDlYiApP+G9Ndo2rUDAbbD/9KLZYkv2okxZp7Uhy+6CUPPINk5Z6IXmf3DIoWYtfD1CEdYOXTCw84GPho8ogBTRaX9GTdA1lwmMxcPHD0lav7TgMX7OzyqSjlOnGDjVeifVOG9P5ERMZIeUVNVuUncM1bDO9ZYjzbrDtcLEOnSo0A1Rg7y/pkGT0+Cu6q73mST1/f0/dCROWd2CLkY9x4HaUbUsSm+C+SXRYzYbFZVOGHcK7/cowcrPX8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794564163; c=relaxed/relaxed;
	bh=8oHy35ptJ0fLQb2YrI1vdssfNtJpVRQvJ6BVJKFTHRg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MzJCwqdDbCSYRKxpa7FWhfv4DDDqTFQheHH0tf4ZwD9uJ7wspO7IqekkIovM18G8x7sr8D6LqiBMaqCm8+SSpVD6sVOg3NU9OZrVGx2UqFf7cjFHPXj34T2W9+waMIxqL6EzoiZlV/kg9xRnEDHxIOrsZAG7xx1bYrU0sb2+1qpowZe9dcxvoni5MEA4hHx5S7obOiUPE9ZB7PCnvr87gb/DkJbyto7d5CHrhEZaO0cEJTbj8uzJDlbtcOG+FzG7FPvw5x/e8iwf5fxoFuOANO0+Pnj2pSp3X2ECjEwWiLwc4wx2HUwRoFM1Qag8YmUqlcnK8GEc5thT57+pQH6SxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=TTRR/Acv; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=TTRR/Acv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQt9G6x2xz30MZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 21:02:42 +1100 (AEDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-c5067a2411bso135634066b.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 02:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564159; x=1795168959; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8oHy35ptJ0fLQb2YrI1vdssfNtJpVRQvJ6BVJKFTHRg=;
        b=TTRR/AcvG0TMk+0uGfilA7kQB/p6eTywOGFsf7cSj72Nj2Levg0GIYLjdmUCjNn5qk
         YMewAGfWmP6NBOhDX3Lt3VCV0ZizgeMSmYAuJ8LpUJVW333S8C6QWAJ/CBLi0NSeVBLb
         qaJir4Z8WfNoW+4/JxD8ARjnA50JWi0BkKLYmZSwHizHm610jKLXULbdlQZl+CMmK5rt
         XB+WfS/HGQLwlrX0iKw7JUdToKP3x3dcD1RdcC88TrOlIUDZkguFVDMD8rHfWRYMTR/V
         5Wepsb1fLDpjW+geFqVnKkZJd5NTvBpXis1iNuC+eXi813mQh2OFsmnoraa2EPVoV4ia
         vDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564159; x=1795168959;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8oHy35ptJ0fLQb2YrI1vdssfNtJpVRQvJ6BVJKFTHRg=;
        b=o+SJmVpAvs6sytzp5E4Xlbkfs62h/MxPbHoUFhZaKO+AmTGKdzHTW/f6Vk4M4at4lr
         ih9y1S8Ojd5eezvq0pJEww9BhXpOOuHtFQOdIbXMP/rKhmpOv2L8UDlPleq+01DU5VHE
         09NgNg9bhdEGSF47HxR95HHXCwY41MfYa0eOcwbhtpKWeMhqSX9IQK7FU1vDNzwSUYYr
         qvUYDbPJpxC2EPdYb7tpMLNsYg965MqCGDDD3/YIdp8MtLctgUO9iZTLBLVOCMOGGeOw
         RFqcRrW+IuLZAj6aheP1JEv17WcQ05PXcHNvOTijoBMpVej84wpHWcuY9WMkyfIiwSMk
         KG2g==
X-Forwarded-Encrypted: i=1; AL+hErHEfS58wfMgItp15hccNWHbh/hRVUlZLm7il2gs1LPKuXd9N+nGHTw49IRzMdFDt1PwcfHNuXjttM/aWN4=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9YC2ricmM5kEGcrJdxMm7RVOY9iDsdzm5aFYqLvAffNrc9rbyV
	E4sqK1eIl+TOfR0LQreW5U6zeJpkiMMBpCCgzyYHAygBCrFP1BRaDTE0uJermiL+Osag
X-Gm-Gg: AYBFou1njffsSHCkHlFAajaOQIWFWtDp1yr7eRyIeEEMa3w8HXaZjUHBXU6M6mY6LrW
	GbVOMv7LWfl14m1Nh43tiLXg28ZTYXg4BfAutc75yqlk5VPYqV/fYQ0ApZ6IRmBNdBhe1mFlJhK
	IA6iJvhRcwWTEL5ND4cDGXWmDpa2ABr6M4gBGEva3q6F7F/2jaFWCca/5uDW4FC+iCVktBUZq3g
	W6m94+UOkuIEvrVPozYmzaSl2o1mtl2o1RkcrkDm57EpaboHcrGBd4hNwZMIkyuerDfU69Rv+pv
	57F9g4v3kx61bZzba+z7v02ETTk+X01tToUWG/BdUcMkw5czEPhk92BO/HU6PGMpPV6MpGKEKAQ
	1ZBYmAw1PsvDVnn1MCysZPmirCKa4NIqw2n8qdhu+orwGQ4iAHDly3aRytXWg+7Xi5V2hLpaGVk
	h9DpdMiOsLzOUY87HCXNUUDkImMGu8mg+d+bCbTsZMxkxUgCIzy4Fo4EAKCl/eGIhpyC6+MtVaq
	gdTASE7rp2H6Qx9F37wjXXdiZWTF99VqMmRuYgFVQLAixedHhUSzEVak+Nms7zAcbndV5P0GXmu
	uFmXA0SiTTX9Kg5CXdQxqJwotALFIzj9YO9wGW7nD/7mUV/g/A1Qs7zw3eDCGJU=
X-Received: by 2002:a17:907:7b93:b0:c29:f5d5:5a9c with SMTP id a640c23a62f3a-c509654de57mr163595166b.38.1794564159104;
        Fri, 13 Nov 2026 02:02:39 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23afdsm74417566b.13.2026.11.13.02.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:02:38 -0800 (PST)
Message-ID: <8c51aa1ad231dea30af06ecf761a971f5958d063.camel@amutable.com>
Subject: Re: [PATCH RFC 05/41] kernfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:02:36 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-5-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-5-4c998976c6c7@kernel.org>
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
> Initialize all kernfs based filesystems as pseudo filesystems in
> kernfs_get_tree() instead of raising SB_I_NOEXEC and SB_I_NODEV by
> hand
> in kernfs_fill_super(). This adds SB_I_PSEUDO for sysfs, cgroupfs and
> resctrl.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/kernfs/mount.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> index a0be784bfb06..6b60d212b003 100644
> --- a/fs/kernfs/mount.c
> +++ b/fs/kernfs/mount.c
> @@ -8,6 +8,7 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#include <linux/fs.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/magic.h>
> @@ -298,8 +299,6 @@ static int kernfs_fill_super(struct super_block
> *sb, struct kernfs_fs_context *k
> =C2=A0	struct dentry *root;
> =C2=A0
> =C2=A0	info->sb =3D sb;
> -	/* Userspace would break if executables or devices appear on
> sysfs */
> -	sb->s_iflags |=3D SB_I_NOEXEC | SB_I_NODEV;
> =C2=A0	sb->s_blocksize =3D PAGE_SIZE;
> =C2=A0	sb->s_blocksize_bits =3D PAGE_SHIFT;
> =C2=A0	sb->s_magic =3D kfc->magic;
> @@ -388,6 +387,7 @@ int kernfs_get_tree(struct fs_context *fc)
> =C2=A0	info->ns =3D kfc->ns_tag;
> =C2=A0	INIT_LIST_HEAD(&info->node);
> =C2=A0
> +	fc_init_pseudo(fc);
> =C2=A0	fc->s_fs_info =3D info;
> =C2=A0	sb =3D sget_fc(fc, kernfs_test_super, kernfs_set_super);
> =C2=A0	if (IS_ERR(sb))

