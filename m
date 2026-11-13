Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAC5606A895
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 23:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=S5AkPy2K
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRD9q6LWXz3bnJ;
	Sat, 14 Nov 2026 10:34:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794564365;
	cv=none; b=aAtevkHyPr0LYziTOWzR10joLaTMMb2mXGKWTaKO2JLJfqIyymrrqspTNbPghXRug+wwyrymJXOEpQR6ePfrjUyYr5OQz8xhN+a2ikxaxvlMgFVhYMFJXxaWdC7CmWpODbOF/svaa2/kI6k9en1r18rGCdkaf2CZC1/8BVmvE+toOvHbn2UJiBnOdkSDdyAFjDJo5GT4mk1BKK/V9a5ywrZNWSOkBgiF8Bp3BVi9rwuch13n+pwovuNrFQS4qUWWY55SGpnvF9sR3L2ZJqMlBiPEkaJryhWL0tBmsGdjeAb7/xaOQ3RrtFOymmNIm/AEs33VSZhjszBRvBCpM9ewhA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794564365; c=relaxed/relaxed;
	bh=TjkCmA8zoLhZK8u7U4HhR7QcElVzore/o+jClE5BdRs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eYYmQ1VFa9w+Q9n10V5mc8tSykIBy51fY29lRrnG0A+0BJmb+6SW1WrIaO2Ja7WpOdXh9IjBzWShS/en24bdFc9TKy3+Lash2YrMGJWnTLppr3KsVZs0OE1LTmuCwh4KGKo+otPsQJAnXJw4KNqZ6KJPN7MSaurUqfcah2L/gk+gToMl+gXjFp9/WJc3MHWkUv7oJZ13hKVFiVSZ5PsidlgZtBrAuwpSlShdxaT4VtxJDuOR4UdHap1rsjZqmW1qp4Gy1Fzvwt3hCT3HHa2Qq1Gga502NFNJhwg2DdFNd7CAA9Z4hQiXFlPfhAkSK0MsfxDX0KtZ37bkqXsXQDsw6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=S5AkPy2K; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=S5AkPy2K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQtF84Zbbz30V0
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 21:06:04 +1100 (AEDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so1445742a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 02:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564361; x=1795169161; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TjkCmA8zoLhZK8u7U4HhR7QcElVzore/o+jClE5BdRs=;
        b=S5AkPy2KWqcASAUwxmEchF/Y1PsmoVlSSZdAX2UfipwQbFMsQd4D4wyuqeHX1GH4gz
         F4hfrZm1STJRsq3AqMbLjAPtuX2SghN+djR3hbe7PnOCBSh9hB+gy810/vDFgpQn/UEP
         23DyKM3/gBO7yeBKTxKHcPNT8kXEAYghWCsJVsUvK8yYQ8+ZyJNa+V71Sp/dPeKvPo+X
         bieG1WuMo/Z92cZ6OkwUHYQt0MUkaCVZ2XkSj+4bEbHiMoR2GF2Go1wsnuXhiKetyfbI
         VXJTAU3pxO1l26qClKkxdUF+Z0xFTgvRVkeFaAdwzRT2McHYJR2JtgR3tteUZ7R/bJhz
         aYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564361; x=1795169161;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TjkCmA8zoLhZK8u7U4HhR7QcElVzore/o+jClE5BdRs=;
        b=w7b4Bg3oIxn8BojHuOUZVqhKuIyXkao71zSP4ddBQnDIQWS6GvmgUp3zQlEYsq4mIF
         14DE718H8fs3AkGn+OfLFlwfISJvvkHBcQX/4cmep9Of+0LvCE1l2HXWAHzu/hVfOOHS
         zFfFSOZjpdvvZ4n+7NjryuwKlpafUoJPa9Vynn4T8rL6CwjlPUZrbVW3z7UyLv0myOlg
         i+SaCx6bLwJIzSdBLqcdodp0oS1vgLWdMgWR3k95wHrff2G34YXn4dwlcKQwJGbEGTKO
         n3j0WrDVOtAOwmCwH+LGUetM4GVvXpIli+e5o+XvK4Z73DztZp+Oi3WukXwAN/1cdFMh
         TWiA==
X-Forwarded-Encrypted: i=1; AL+hErEQt4sBO8r4vYr5WhSzCoHW50YX6UX1oMuNz3uTf0VQ3iTMF8rcW0bwwh61pGyZ/UHaTB1B/FkuOIvBOio=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/kdIBo+xnQ5z/v9ohbyBBT9xxeOHOoN28og2V3reZi0COCuoib
	nCa2kCacMiKg6XEGhnmc9NFNypjUTpWSDvFjXt2+0CUookBli0dQm0872XKLuROXpdPt
X-Gm-Gg: AYBFou3pjiTVIo1Dutq4gLId9Wd+T3aoqLXelPcjNlkhdZMF2G34eEoLy8ihZczyxHG
	CZQmwZlkWM+LgGGSM+nycH3JtfPmnUU9160ygNQMt2aukU92gZgw9CUd3DkJkj0XrZtV/cSNg/b
	KQUnW0rbAP5q5g6lk/O7U//ZAlDeJYknpjPMDEwvcWUGZq2HzwFoiEE+NIPb/047pZkslNisTW/
	IkjMqFL+0CamU26tjDONkkFF7Uz2wonhkSSDm/6Xa1WPbQd8OacHc9eMBpD7Vm54tDVkW+WnXw1
	BOiUeeTIq9vw5d2xILYgQdUUC+6Jqe0eVOGI0pEbeC2uJPN7IicLvsRoGDe7HZ4ie1ZGwj/c+v1
	a+PmsIUu4A/er9imSwMthCW+7ACk5ejpC2KAmONGv7+X6MQ1npdY9M+Kt3griN9T1Vp8Wpjp4+p
	bYygEVfOp+gcYLZYr427sAK52CPrTQzBt5qTPb1+HuBwznki5OQDKYvBKluxMNy/Tb2toAnywdV
	TGBhIWd/MtC1kV/W2wsZNnVe8t48Dp1/DNU8JhGWqE9NMagQWJAUgtD9jqYS140JthoLhT7aj6Y
	K9hlFA/ClCDM1s1NAV+aTSjZLhgON6V6uurXhzDQ7tTLyT0TTW1gOvjk76/DcWo=
X-Received: by 2002:a17:906:ef07:b0:c4d:5820:325a with SMTP id a640c23a62f3a-c50963dc627mr169588066b.39.1794564361325;
        Fri, 13 Nov 2026 02:06:01 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b8651bsm73693366b.78.2026.11.13.02.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:06:01 -0800 (PST)
Message-ID: <e8b71a2778d7d7797d433e7bac1a37ee64aaa30c.camel@amutable.com>
Subject: Re: [PATCH RFC 15/41] tracefs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:05:59 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-15-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-15-4c998976c6c7@kernel.org>
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
> Initialize tracefs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. tracefs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. The only tracefs files
> that can be mapped are the ring buffers and __rb_map_vma() refuses
> VM_EXEC already.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/tracefs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 5020365ca704..e04febd868eb 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -12,6 +12,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/kobject.h>
> =C2=A0#include <linux/namei.h>
> @@ -510,6 +511,7 @@ static int tracefs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	fsi->mode =3D TRACEFS_DEFAULT_MODE;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D fsi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &tracefs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

