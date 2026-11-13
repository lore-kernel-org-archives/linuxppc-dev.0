Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF6C606A336
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HHWb0FY8
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRDB75ZRrz3bsL;
	Sat, 14 Nov 2026 10:34:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794564661;
	cv=none; b=L5lVJ1sHWNBGy+zOkpDfbfoFNZ31MD25n4/y/hoLgcwXRp9xXWoFXGKKOkGlaE2TVkNX0UFa0x8X4nSW56cyVZRrfXY1C+WTL23ONLJw8aGDSxLv5V8z6J0VKQhtfbMFkqxgs/YAaQCakqk+XQWujsKtL+gasvXkQYEqqy9u4pcrp+ExKra4OFxaD7B5O9RBYSUnueaYosgPh4coWU3Mse/cfZtTVu2lmwdWRoQYPOZt8zsfCjuzgxcr1jhilpGHlN6IxxadTBkQkI2wUnJqybY7Qr4kZu/24gykjvPZ+dsg7WRokLuANG+q+x8R9XGfH6BjEskZCLZHKEmJkuVjmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794564661; c=relaxed/relaxed;
	bh=RUn5HyOzv5zK74OCIfLVACQcizuS/sHn5qpIQd0Zvv8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hxK9uST/txfpKOrMMSS3vJhR/3zdhhPSxeOJfVqEs4JnBQ+bTsywcGzixjAD/dfI0INPVPdhZstXj6TLZ8A0wlqZ+b5t80QVQgUV/2YMJvg83BRqW9Jm5IAKRuUPZsUz5yG33zeiyC3lf1IgNvh4B/b+FM5J6m9jhY1g13JMWXh+al5Ogj4tiPIUWnIKOhz1zIiu39HXWEVB66iv2P7O11jwuukveSwsf+nHXmBTwJ1cJl7A5i0YbCcU1+RWpQaM7jbp5Ir8KgxICPdZBjkeulkN058MblhBksjuyXye49SsHG8EikwEcKhelwgOJn7ncWlpcYgnHx4BLIrrNoJ1mQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HHWb0FY8; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HHWb0FY8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQtLq4sZMz3bcJ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 21:10:58 +1100 (AEDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-490f38e9688so497680f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 02:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564655; x=1795169455; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RUn5HyOzv5zK74OCIfLVACQcizuS/sHn5qpIQd0Zvv8=;
        b=HHWb0FY8OU5UTQblznlRwbnF9h8XWOlkgY2vu9Z6d4Vr6Nef0THqPgWhFUxKHZlvTZ
         IeTRyehnnQFPJMSTYPKmhgSzRv0lqIWqZ6xEl2UdwLz5krVaFt7jo9gsLHoPEnfJ/xt0
         LMF025ivN6CP+9+4+GsSj+wUNJMfyQZvKs1t+p630z7C+fB4b8Xy+y+hjjO4bjahLBBv
         ozjYs28jKIQgZQOh8DuFLK7HQOXY45U6AKsNY/85zBAYXrmKnKqQJS7t8HR1kjjQx3ez
         NQ0tsrL8JPPEpgo4XOqESrkosPwCPjo6s5L3qNrpQrwvT+QgBJrjJwXpA7DmWz1+puuD
         FxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564655; x=1795169455;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RUn5HyOzv5zK74OCIfLVACQcizuS/sHn5qpIQd0Zvv8=;
        b=JfVX/eSB13mGdft4XjxhLJeuj4jDfdbbsAO6SJezE2XQHO1cDDciBNFLRu2lgQNQi6
         fVJtBQXMPm77hrirfmxp6QJMElfcy/SuGO6ckh6/2WCwwoBfKGE1+GvRWAUzsRW8iN8v
         L9raZG2nEEA8S99tW2B+Ua9zI5c8Z7V1mWYCrXVhC26gKq4xcD2KPOqECWiaZLKhxldn
         q4z3mcXTxG95QcI9rDyLizID3BIuGRHkxCTc3Gc8gzTYW6pW+BV9ypn0z0iisXT2aDas
         DDeEUv6lPpY3IPCc9g6gHrqLo3ZDQFs37zONQsgNl2cgHYnvrTkr2Y+/NYQTFsa5zn+D
         XBOg==
X-Forwarded-Encrypted: i=1; AL+hErFWcRwvSMqW4sqjLlhgRduLjj5xcpWs/wUb2nYYIFUfHo5wM1VNLSskJ7x4SLiqGJtbJrHdVlqkoFtVeks=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9Yg4USRnatI7f8QxNsf0/aNrV0Xe/0h2IxIJR2dAQHwobOm+qX
	Dv40q3ONEfZRhtjhI1rAisP8qBq6wpPaHGsFHd186tlwC73f82f/JD6JvV/qCULIhjsL
X-Gm-Gg: AYBFou0QHr+WtT2ncSPIJSYNHsNct+pgpEFc0TDBmKhxqkibHAblfXfPIFp+ZzMrYoV
	TJ7YsTqWEo33ajHzD3ud+BOdT9odg6jESoBcUweNxvpYvqgSISSyGt4FlkLDs1wun4T4+84tizw
	O9zA1jdAsYiKydAP245jd7UvKV9z2N69tP8fy/wJmfKZcutYdXZ2GWAcoRMPSiBjyFz4MsubphP
	fp4GJzYppen2cMaYb6BjdeEnTmfj6fk4rQ7KdwrfZDo05xNybzlzpEDMiYpgd3h+T+tTEmG+Oaw
	IrHPuuIrfWn73GzGyvsPNl3WAhl+zT46MbNnA43kHQkZ4vMkxePjs6Cue5u2WGy6hNkCKEdd/US
	F/YFFs0WJhRrmpZRIFN2ve7unEYZ1xczQCjM8dZHw1Bn1GJlZeo+bWvZIo3ac98IswxoE5+IegW
	J1NpWgVtXtRnpzEOH03JRZLyVj8Qsr3TFZmLU9mZij+kyl6/Oee3KfvHdXetGK1ebOk1z7BBdVV
	yCbVKgvxgeVFYV/wfMZgvBfj1bHRtzHTLWXfEQWll5oysE2N+m4LGXgBJi6oNWMsiD0DjdzJDr2
	y4+TrnCz6hpDiPzIPefVNHZ9JJ70G9J0WdPiX5SO5s2RpCvkPeTcpsLukbAQqMA=
X-Received: by 2002:a05:6000:470e:b0:499:ffd4:f519 with SMTP id ffacd0b85a97d-49b02d4c2cfmr11662822f8f.23.1794564655454;
        Fri, 13 Nov 2026 02:10:55 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5a32d336sm4988050f8f.0.2026.11.13.02.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:10:55 -0800 (PST)
Message-ID: <0894c601b3f3c5b92008c6c399faaa539b658307.camel@amutable.com>
Subject: Re: [PATCH RFC 17/41] securityfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:10:52 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-17-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-17-4c998976c6c7@kernel.org>
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
> Initialize securityfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. securityfs never holds executables
> or
> device nodes.
>=20
> AppArmor puts a .null device node into securityfs but only ever opens
> it via dentry_open() which doesn't care about SB_I_NODEV.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0security/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/security/inode.c b/security/inode.c
> index 080402367674..93997a9f16fc 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -14,6 +14,7 @@
> =C2=A0#include <linux/kobject.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/init.h>
> @@ -64,6 +65,7 @@ static const struct fs_context_operations
> securityfs_context_ops =3D {
> =C2=A0
> =C2=A0static int securityfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &securityfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

