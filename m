Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5881B606A8A4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LkcgeCEd
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTJ450VBwz2yNj;
	Tue, 17 Nov 2026 19:36:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794904597;
	cv=none; b=bhxlJPttOZZx33/VLfCtPR/p8FwsGoI7+FktazKKsSUCB/365Cxgo16tUXxsZrpHLdVZUMv9AENCoiZZKf5oBuNTETP8siK6HmeSbpi3vxOK98ux3YFtF+G5rcTROhqY2AeLrdoycoj8co3lMAjKDLBbLpePwx0nOP6GPovaeXrkTp7gglUArwN6vVBC95FNXNL8bOMkrZLcBDYEJUchtkuZtjNgodRepoKuqNX9oqZC/4VGg8sqa1MhPbv8sSHz9MXtFJ4zrIwzDIhiecqnVZukI212taojrdWbPJJSl2QsT6OsTIGZsufa4+4v/wcsFz5/xy06JlmAUbf5rhAs7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794904597; c=relaxed/relaxed;
	bh=u/hxpfxH2Ygjpkkpn+gEQ4NFMpeA+YPAHTw9d0qdSc4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ffa66FGOcLW1aaywqhczRgw1Hs/za8n0v3sfx5xYmyax27BgoOqDvynCZDZ0Vv9REjamkAdM0abLjFly/hHVWG74kcDAETCPnn3CnFiv2+vDkL0tpI7d0ziVYX2rfQYvlonpoTfEH7oZS5iBrNMkXhM8fyG5zNbXvXtPuIPwpQ9C7GcHZHKNVtQYTKgs+5DPtQ8u4uyUy5CAA/5VLUqIrefyv8BhlclGdkqnAbEEPrYUHT78fZf+AoHyvVnVbswvTUTsik9sYjdxAFfH+vZ54y53nom6JoC/MHtzXV/W8gTjntrKcUd1sVdkaPUZyxtgKjEo4UbN4EIOsJDsxgLB9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LkcgeCEd; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LkcgeCEd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTJ436jmpz2y8m
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 19:36:35 +1100 (AEDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so21992395e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 00:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904592; x=1795509392; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=u/hxpfxH2Ygjpkkpn+gEQ4NFMpeA+YPAHTw9d0qdSc4=;
        b=LkcgeCEdz/Eo5KqDZpcHWimoYtQapaBuaKxGv6pGP4aSFj3xQDipkbZAGgzRn0Kcu6
         KxqbQBXHHI2+yHOZtG43xIBZapUMMnP9Wu8vyuFPasd+YQxUcuV1ekSf1lwILG7T/1dw
         I7+XO79e1GpYn0oSiMl7OosGABumQVEOSG7ZtDpr3LwxNbMbBE44GbqeSracXo+otK8z
         1JdSXWTV+RTu1Ck5AhclWmarGTsErn0r/IG/ECd44vVp+URFj/KtcKZ3n7O96pAyY1kR
         WLF4WR+l6l/JyhIzcxZQ/RR+vP4SXJPUXaLSl50tQdd8wLlfYmkxUa43YBNIdLm/t8pa
         x9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904592; x=1795509392;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/hxpfxH2Ygjpkkpn+gEQ4NFMpeA+YPAHTw9d0qdSc4=;
        b=zoAGU3Cvmvdqfcp1XKyF4z83VVjvV/tDs70QDUPsVrtSlG1mV108EJbqz6qpCGhJ4W
         gOuwcts0DXAY8i3r0oVFM1hwg3XdGaLuKrP22GlFpXw7G0j47b2DF2twjPqpAJVKOlJC
         /bGDVLQu/EiaTy7JfrysUVtEWZGv8aTTCjXYUjxtmh+tY/wvJ99qH3dbb/0yQoZVtEFQ
         BU9nnKMBPo+lyJAacRTIurjbZN9P25HX5U1sTMnhSkU0gMYzGHPvmptFnSNP9l3jbpaZ
         IdYqppVTOef1hMw6c0CIFfN+RjEkLOnyRkHc/SYBCcV2TIZL2dGP0kzEjIX33Rqv2FmS
         mETw==
X-Forwarded-Encrypted: i=1; AL+hErEjJiaNObTy7Ep/gIm6PzbIk1mNRihDYclSHaNSHH7eReei690tDs/gJ0yAx/0EcL9Rxc3Q+l1yR7nQwy8=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9LhucC2GupAvbI/aRUWum6zfGmLwBKs2ARoyI6eXbJS1zk7+74
	3y5kSfXcz0YWWXVsVBRYqiq4zoK4dC/AlIdIpDjb608BdsQFGd3LKEAVfktzFhQQUYE4
X-Gm-Gg: AYBFou0zrUkACHPnQKYgK08BRMDezrSmITJWVhM6UuQWg4FVV3F/YmkfQJMZnza0obu
	bZQ6CuBu0MEpv5oH8ZwafP+2B0ZlJPUwCPz2o7ZSGOdPe7ULwmsBl88NZZ2QsRNFhNaniqDnnWZ
	yojKm4divPRRjotJcCJelIW1b4amaVqxD+jlZHk1ocoyKXSu5Ujy8YA5VklSpyIAbUhqHWA8PlB
	HoUSTfFdGQ1O7Xz9MYg8izBTrOwY4ve9JwEG3LAM0ynYw3Uqjp1dF5S+GAh8ADcnulK5V403vTS
	j5fISC5B2x/mjwIwAUGF5Gmc0VcL22augYb7EqlF/71HZZQl0vuxvtOsu34rqZkxLjohke2B5xn
	oTmWz4POuhbo2BeOsGSUUYTSVcXfVbisuJRGmfqPMd6NKI+ef9afJxttERXa7XV2dbPSTWuWqyo
	gHLfibE91N9be3dPV3s4RBJ+fvb5Jo8CPVg29ILf1yk3ir+fKGPMTXjlzZSK0K8lBqlFrr/Ebyc
	7YOW0lhyGDTlQrqthwpM+uShhWnTGV5N/YxMqvVwTWB7zzY7ZWmVX1A3CxLzeLAcUU1INCMKjm8
	nBS/W+6GOm0w8lEvwN5l/MZKq+P4TX1ZS/2tnxOeEpTPRf3HD+WyCWaXmL9dusNiGMvs3K5mDY1
	algfrYwxNWBGf5B5NSW+OvCnOSYg8COS+aMt5MjPc3AzsAGO0Yv4MNZCF
X-Received: by 2002:a05:600c:1f90:b0:4a7:76fa:87e9 with SMTP id 5b1f17b1804b1-4bb55ab281bmr266345525e9.21.1794904592167;
        Tue, 17 Nov 2026 00:36:32 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78430752sm52548565e9.12.2026.11.17.00.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:36:31 -0800 (PST)
Message-ID: <411502f9a4f940c223b2b88d7e19fafdce63172e.camel@amutable.com>
Subject: Re: [PATCH RFC v3 29/44] s390/hypfs: use fc_init_pseudo()
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
Date: Tue, 17 Nov 2026 09:36:30 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-29-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-29-8cbbea1cf34f@kernel.org>
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

On Mon, 2026-11-16 at 12:05 +0100, Christian Brauner wrote:
> Initialize hypfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. hypfs never holds executables or
> device nodes.
>=20

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0arch/s390/hypfs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
> index 559b011e68800..8662169de477a 100644
> --- a/arch/s390/hypfs/inode.c
> +++ b/arch/s390/hypfs/inode.c
> @@ -12,6 +12,7 @@
> =C2=A0#include <linux/errno.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/vfs.h>
> @@ -301,6 +302,7 @@ static int hypfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	sbi->gid =3D current_gid();
> =C2=A0
> =C2=A0	fc->s_fs_info =3D sbi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &hypfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

