Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA9B60A2608
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 23:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MD2K3k9e
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRD9f3gWdz2ynW;
	Sat, 14 Nov 2026 10:34:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794564340;
	cv=none; b=LZJ0BQTtpPsdPEPh4tTfiSfms5BsCK3iVwIfJQnA385hAbhVP9aLKBAhBOvL+p1r1E+wRUhapaGAQs7ZJe0fn2W9C2swFIug0IRJ6Uma3VamZ+RbqA+VDsyedTB0g+sfLwFRSlyqJ3YQmJhNsdsqsJZ176I3N4zJFIXRHDKO9w3zVg4D1Gkwc425YvR8oaQjngdHpXLydPiuZoBXG7Oyasx8qa/wKU7KPJ8a9zye6bqQc79w/a/xtD+eHQEoTJT/dtQzRF2+t8hSzV3FDvLO0gN3Ma5VTvZg5sCWBIGv+UQ5SnJxRDcPvezkVeMys0YuubdFCHjYSEqI54d0dv29BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794564340; c=relaxed/relaxed;
	bh=fNM18G1T3F0ezY9f7dMoEwC6d3kOVWk14Z1vuqkOGWM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XK+m1tuFVwcRG4owGOnU7SoW0RXXVt1EKj9n+mKSqCy/OECtl2jKBEz+vGRol+ZrRfV/s+LkubbO2wTDlRTxCo9Wxbg5hxon652M3ebqwHeYxkJHYHCqLjm2ZbqX2fCHS8jbRNfg79qXAEXMFnNoGp2X5USEKjvYh1YAVdwqmai0TORN0WqEb7Atn3ehmXAAM78HKGUsIZYdOd3SYLS8aYDt3+WpmsllIWaJPMugM3FIHI21Fr5nP1x/Z2qCsGNpFEEoY81M5aAEKERogKKyCAcVlvmleMBKNsOpSw+FIHoafjQNf99aHrbdUh5gJZFqfXDEZMwJDFDpzgN25fyjLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MD2K3k9e; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MD2K3k9e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQtDg3NPZz2xlP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 21:05:39 +1100 (AEDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so1356712a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 02:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564336; x=1795169136; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fNM18G1T3F0ezY9f7dMoEwC6d3kOVWk14Z1vuqkOGWM=;
        b=MD2K3k9eOD5vy390FSjndCNl2fr6XeZe6JAIZSL+EAsrC0Gtnb3T74I/ihBEyL91SD
         VsOuC8f1J0PcAz/qz2QFTXbVCk5gJU/KFqOb53r50BYCd0/efPbs/nVQ67zRfBN2yivp
         56/G9qni811vPMt92JEko4Q9E5MGldYkqGKPMX7Yf1QGOpqpHiDLQTCHZjNSbuS5Mgo3
         6b1rZPE+3j73d2afGdNdGrqX+P2dYFCFdqHBz8OpVu4OgYtvRAnQTSpt2twoM2bLfEPh
         VGtNsCQtJhpz3Sd3ZgoSY3iCiDXeRKDGX05M9CeVGaTsDJrCqg2wTmGekwPwCZidPjXZ
         7hDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564336; x=1795169136;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fNM18G1T3F0ezY9f7dMoEwC6d3kOVWk14Z1vuqkOGWM=;
        b=ryaeGJIeCKUvScVupDOW9dwEtEH+OwGDlR84fyjDEFF07d52kHmXMYJZLBdhMT7g49
         847LGiZ74BWBWQ6qYCN/VyvusdgHG0hH9AGL89DgZ207S9uZP3tNQElBQgBjxJqGe8ZC
         xjOYZoosixt6gT00vS8EL3jF/btCUe5eQ4FpEq+KWZUGvq7MCLhNLakdHeXmHPjuRwBT
         mAduSB7l3oW2i19m1AAe7WySv+LDmWeLLLCpLK/S9o4B5vgtVGaMYoEl60jZftcsc9lH
         EWKzFKjiaVvZYQt8QXsypxzlI99EHygvCqBk1jTL7xxoTYuvy4d/M77H9HE+zD973eEv
         gcBA==
X-Forwarded-Encrypted: i=1; AL+hErHYVfqZ+13XZSjWwMWRIUyI0CD5Hmy0vgbownUG5BJKKRDSg+jAvLh7++MxcF1rWulTYGGIQeQVYdTWBBk=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8HOd+C22n95lzr7rSk1dmfPE3BBonHqdA+sT3w+BV/CmQPQgwh
	lDFQ7DsgNIvnZikeogF4WqXWzDfD4Q3XxA1J/zsWZMlmSQDrrmAZOQmez+1SEp1VEmBk04lYtU/
	pFyBoO7UCKJU=
X-Gm-Gg: AYBFou1FwuDRMda7w6J1iXUu9uOcby5LdnM7BXCQO1YZdA17eYK7HR6OT2sjAhxG9vG
	UGQpAgwWkC0i3RNebRrLv9CFHe9rtjx5ZOYFV/xOwvOjtjaTZ39643ELTWdAUliAXMDNbA/aI3I
	btKkTwGFusUaciZK8QCboXseUemcr+nBGdrxHN1tZ/nOFxAUmvuOcGMjrdgTZlAVx0e2OUASVvt
	OjovsuDXvX2KDgiohumzNq0RFQgonatROofdCczAF0FWY7MjR0KPXPj+yqkMOzLnMYudKLKx53U
	NNtN8+LmgFZAw6FIarPILN19S2tALkRLaMFm4JuyFbOW0fz4xXXCeEi9VhFq+6KrkuTPxgkSarn
	pw6xLtauwavet7y18SrzyiawJlVb5R5OJoG6g0TBKTybnHxYLsl+Nzt2Bh8BHXXyOFC4uQ+N9Iw
	VLgZAvhKnCZczjxZBIS0VPVl9tc0vyFwDuy3UTqDmJpKC8V01KvsibIJkgKfYcIjDFcHkrH5ngC
	ob72RZQzBU/l6KEcjlKj+baimz6R6jphMMEKmAnZWnAH4OsmDNi5T9p0gnNgVER3NW2nrMmqwsw
	iCyz6sw5jMZxX+qPPuBYGaHrKwh6Sk7EwapObG+nkzVzhjRgWZSr+k2tI82IMjW0UzI1lahWuIQ
	Q3+ftiRRL
X-Received: by 2002:a17:907:608f:b0:c43:eae5:ee80 with SMTP id a640c23a62f3a-c5096398b03mr148720566b.17.1794564321873;
        Fri, 13 Nov 2026 02:05:21 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b7b2c9sm75811766b.73.2026.11.13.02.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:05:21 -0800 (PST)
Message-ID: <08fa1be263cf4a3db6b3e5ec2847107fba7acfba.camel@amutable.com>
Subject: Re: [PATCH RFC 13/41] devpts: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:05:19 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-13-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-13-4c998976c6c7@kernel.org>
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
> Initialize devpts as a pseudo filesystem. This raises SB_I_PSEUDO and
> SB_I_NOEXEC. devpts never holds executables. devpts_fill_super()
> keeps
> clearing SB_I_NODEV for the pty device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/devpts/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index bd1e8eb26edb..47ef12241d92 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
> @@ -13,6 +13,7 @@
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/sched.h>
> =C2=A0#include <linux/namei.h>
> @@ -438,6 +439,7 @@ static int devpts_init_fs_context(struct
> fs_context *fc)
> =C2=A0		fsi->mount_opts.reserve =3D true;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D fsi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &devpts_context_ops;
> =C2=A0	return 0;
> =C2=A0}

