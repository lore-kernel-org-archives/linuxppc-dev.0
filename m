Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37661606A323
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 23:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=p8cYu1HM
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRD7F64PPz2xsW;
	Sat, 14 Nov 2026 10:32:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794563704;
	cv=none; b=TgP8TA8QqFeAN08msghPqeso2UxjCI3oqyiORCH0JRlOXGZ+SZITG1eOsp0fAH8CMbK+NjGyGuCUro6R42U/EOzitIwrvAjl9M3/P8/CA2JCY9DA/tVjwZhOavYi7GODzRoQWsGrGSUMbrxkCn5xmJpawq2T4/pHcz0PCfTXlVayvKMcztbxhOvbkRXFUVslED1tlmTQrqd3wSk10pYY5/xorHre+soulSp2b/oqk7a1n17v9/y9QWZ3mxnQq7JGDLwZMXV2QWt/gmhSVMV9pttru7b24LozYrjh4v1r/XmMc7uiTrqVNb1WOJ9/7GuUF+yLkoIguHjlDUmSnn6xwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794563704; c=relaxed/relaxed;
	bh=G8DmFU4pJwAPCJlqHBF8SKasEEThxtJNlC1sg/CSkLw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=edI8gMkGjPVDrfbftzim7j6PFfxuRVFXtKy4SKJllkYxXTEhvsjiCns+UYTGi4HBHl/dc5P1ciW34uweGcizv88UNBdMGT2AjPyXtB8XgyjsveNkr1taE1uu7fnsVMXvMjiCJpPaAjyarfZ7L0ZD3/matMrgx/G2OA1SDy3+u+FkEA1ofuFA7cAvhHXfsFjd/I9PFrNuMrZ9Q2fsqCEmwZMNMDlQ1g2s9X2mtOg7br9SJNiH2/qP++lOvYUs6yxfl4skausA5lQ4o1YVgABjr7GS2NocVt6bRWHldh7fE3g5X5RK0jMo7zHJnXOiwjaKLg98znUOXKivENWZLIoUaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=p8cYu1HM; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=p8cYu1HM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQt0Q64Tnz3bYG
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 20:55:02 +1100 (AEDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-c5083bc0e28so142296866b.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 01:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794563698; x=1795168498; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=G8DmFU4pJwAPCJlqHBF8SKasEEThxtJNlC1sg/CSkLw=;
        b=p8cYu1HMRE+1uxIb918MvbGeMcfPcxop1zS6jRqo486O366tyQibpf2w12r0TQe+Vk
         r520b5DFHfwRKenZMFmsO4x2Mv7UztbBvP+YIunETdbkhUeCiP6OF41LBYv+61IRle22
         5Pl+U+CSx/6JyT45+B0WfYzIkQR8+hLSVHYpsYhSS8VahwX//KVuj2zoFp41qOjwKb2h
         YhnxsLaM4KVn5ojEyLIk9hKVhYWlB/exWVjyDclbKUuUUJTiiAYyildeCJQ9ajHqVkJE
         m4ppzRdJTS25Z+2iUvxhVzXW344oW9AeHhJGU2bG/8JxdrEUXGKCKjuZ8ZAGGPM9igSG
         ZhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794563698; x=1795168498;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G8DmFU4pJwAPCJlqHBF8SKasEEThxtJNlC1sg/CSkLw=;
        b=IYeiosxFPGHPsGeXbFfGpkCefOzmQC8EiVvgpXBT6CYCqkqK7xjdMt93yN8qKuHZse
         T2mo8XOdszl0oNja7fxUyqw9I3X7Fnk95AHyKOzCdtALfbrHcDghSxSD4gQ6FKQizJZ8
         jAEV3B5kevMezsHRppD6Y3CWnUW9fe4pw3nU2mI+TXoDEtRDDAEHWI7gy55PwfqUSs3V
         bhXieGhfr/Xir199KU52rk43V05gWk3khf/rO6VnJL0d+/jb1GQmCEeSwDELlUPNYSqA
         fvi7Bxuiq1RFZcPdRgp8Jh6MKMt53KrQumyTd+r7YBJTf7Qojixm1P9KfNHh9xANHdwL
         W4VQ==
X-Forwarded-Encrypted: i=1; AL+hErHojpvg3qrQWEoR2DsyzpVH9ShxFIe/WmgTyL4UJKemo+QfTILl3RyC9QaugTRmUKiWEz40q8zdPbtTE3M=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/26of4UPBkOsfykSOSYGfFuQjO0Szvy/Mj+mL38Sazv2AsUTx/
	6+28+fWrwKPl1r/8hJJyIFKHbb1HMs1+BW58g5NXL5v1G1FJoM4f5UdFRRNzoP1m5Sso
X-Gm-Gg: AYBFou0ELUdt6w1b8uLy/EVcN/xoQLfCm3pOiXIfPztoBn+1FLIyvga1f8/BOlJveKK
	8ySr07Zf23LW/OaXZUqmoOVfn24yCyh6THeIPdZVTxG+FNZey3cZXHm/lJewtMva8xz/iYiX8jA
	tXyNEPKmno3IphORjIF4I4jTWZ7gPAnruVAU4fU4WoyAkn6Cxy7hFfz6z0n7M0lPL1flj9M18Pb
	tkO/b+/lUKcZQphT/no9qteim9IsJAZNmd/447oV4mebzIWIBDIHTEsJf8dMVYCxhuQSEpIL27E
	YKz3gTaZZxXsQkm95nE7qQuxQ1fw35acM1BsBJQYZFvNBLSlpivOOh8Lmm3FCvzQMNUI2SK5/Fd
	oTXSyZ1DwH6tyw8bfus48N/mh8lPQ0U1WrUZUQIo1jLNpHLycBzCwpRpcHSv9ZL8Aan81GROHYb
	da7UZTsHk2KEMbpSoTniRg+LqipPhcBRWsr/M/61am/5jgogP2OK79YyH1mHJUfvUuCY5P5WCdt
	vvA8yBJZGWijKIuMG9OtRdO/RQtAHXUe6kdhCaBrkL2OyPJXVi02+PT4KkfnqfJIu04QCEg2hPi
	W9SOAOKddo+eQjQ4OMWMzRkN9feGZ3FXQggFQV5m8BPEFpYwdE8nFUI2g9KEEVQ=
X-Received: by 2002:a17:907:ea93:b0:c41:4c20:5a80 with SMTP id a640c23a62f3a-c50963bdb9bmr198299566b.44.1794563698514;
        Fri, 13 Nov 2026 01:54:58 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c50957c6c1fsm75151566b.0.2026.11.13.01.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:54:58 -0800 (PST)
Message-ID: <b42c9f4d29a9cbea66929c95cc8f736f12703c72.camel@amutable.com>
Subject: Re: [PATCH RFC 01/41] loop: refuse backing files that aren't open
 for reading
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
 linux-kselftest@vger.kernel.org, 	stable@vger.kernel.org
Date: Fri, 13 Nov 2026 10:54:56 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-1-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-1-4c998976c6c7@kernel.org>
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
> loop_configure() takes any file as long as it implements -
> >read_iter().
> Loop itself never checked whether the file was actually opened for
> reading. Buffered I/O went through vfs_iter_read() which refuses
> files
> without FMODE_READ. Direct I/O has called ->read_iter() of the
> backing
> file directly ever since loop grew support for it.
>=20
> Since commit f2fed441c69b ("loop: stop using vfs_iter_{read,write}
> for
> buffered I/O") buffered I/O calls ->read_iter() directly as well.
> That
> commit was about O_DIRECT handling and the FMODE_READ check went away
> as a side effect.
>=20
> So whoever can set up a loop device can read a file it was only
> allowed
> to open for writing. Open the file O_WRONLY, configure a loop device
> with it and read the contents through the loop device.
>=20
> Refuse backing files that aren't open for reading. Loop always reads
> from its backing file so a write-only backing file never made sense
> in
> the first place.
>=20
> Fixes: bc07c10a3603 ("block: loop: support DIO & AIO")
> Fixes: f2fed441c69b ("loop: stop using vfs_iter_{read,write} for
> buffered I/O")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/block/loop.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index a3325ceab484..c96e35c3ef42 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -528,6 +528,9 @@ static void loop_assign_backing_file(struct
> loop_device *lo, struct file *file)
> =C2=A0
> =C2=A0static int loop_check_backing_file(struct file *file)
> =C2=A0{
> +	if (!(file->f_mode & FMODE_READ))
> +		return -EBADF;
> +
> =C2=A0	if (!file->f_op->read_iter)
> =C2=A0		return -EINVAL;
> =C2=A0

