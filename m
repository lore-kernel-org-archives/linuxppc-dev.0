Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB06F606A88E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 23:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DWJUqibd
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRDBQ0X51z3bxf;
	Sat, 14 Nov 2026 10:34:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794564730;
	cv=none; b=MuysxtoOGPPmtQhzH6didbA99FIw8y/8x7YQCB5uE0XSa+hLAUCUMI12iCrehS4CQHUfcXw4T/dRTenX5HuewW14GIOuEHr/6h2+B9onVh9oae7RFs0wxr4mk0Mizcbk5SIpNbOLGIMU+QHCcjFbKpyLo/feyrp+u0PQVqS9fthoaWGwhVcEFYhbM/MY821njdPVF8cYf/Pp8P6zJmwthUMhboWWHKa+ccSKKvMXMIHYWmb/w4ipHabpkvujKli0DLUJgiE+bVVTAlMurt5qbD8mh+aGKpgJ/WkcITOQysTckJVolsxBeBtaSoz2knzOrs7HacvMUQmGfg5MoJ2rcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794564730; c=relaxed/relaxed;
	bh=C9TZKYRayQVC7UyXoancZRI4bPIYIHY06/n7s/4tB9k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DxNUe8sZek+d9Z60KSB8+/Fu8IoaM3lYz09pMkpY+SVFiPVzrDAO++Cqx/TN6dH+iVQZff9qVxR5o/sa2b5rAFuyvRo2G3SEE6aoIhAFRaVGBdnPbkcqCX2MZuqZIWjNpodKqjKObGwQZnnBNbBQvOjUkV3G+1O33PNjvZ/twoA7RtXf+6r+k8DpLCaFEb6Jgmd/4dDi/B8rN6bEknKoWT43ZRuH6oRrE7c3eqZT6NtGqlo7yR8wjfoOaXAFLIrpQOUyMnXDyE7Dcm+BGyGjd/lAthLP3q81y6Cf6i/pPA5b90f4WQsZuqLvC05NiA8PMhN+lVSFuJVLp6yJRTghBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DWJUqibd; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DWJUqibd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQtN94wxkz3bdQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 21:12:09 +1100 (AEDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so8032575e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 02:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564726; x=1795169526; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=C9TZKYRayQVC7UyXoancZRI4bPIYIHY06/n7s/4tB9k=;
        b=DWJUqibdnmhI6H/ZHI88ZNyQd9GakBE1CiFzbjYi/43Vo8s8GQwdv/X83a+D61Uiqx
         Rkfnoztudd7RS5jKi7ears3xginvJnzHM60XZn5aSOUKoAkBeKKBbprsKAH7XCuGbIG6
         7cRXF7BjZo+W8Do7bUBVYHgvh95p3oB7UwEOLjlTVG3LY/D7f3ijY3a/eCoiK6w/4t7a
         1vHfF0wPXfJw3/vMiz5siLwt1o+uqXfOK/qRUi0lu0GMrPP1DOiodTZ0/RNIKazAYKyE
         01Knzwlx0BvgqYx2kF+AtloHjCngmh0TQBNIr1JfORrkj+RAvlIyxwfk0RMz/dDJUdmS
         zZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564726; x=1795169526;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9TZKYRayQVC7UyXoancZRI4bPIYIHY06/n7s/4tB9k=;
        b=lcs6ctuzWub/Z6AYx+pBqHojY8E0vAQmOU0kc7uJfNd6qH2dJv5lZ+ZSxkICeVHTk8
         ruhqNmyl5aC5fGgBonGVbSYSgdPdVvjOtqfOBcKtUTuIBhZ3yZ7jgGZvmzvOtqLE0Cr1
         3Arsu58AS/33gu2RDDDFy8C9/XbEJnyX0S/W+wQOVeS/tXP8rDxOpqJTQBd8HmuZq9Ap
         wpYVUNQRnJB24ySQdamO6QicVg6T4K6ODGLl2KxT5kZhSsxxXutoZ8uyfHt+l5bb3GtO
         Hc2vKR4Dg+awlRFl9gqkSaJPXttK1DP7gUvXp/B78iQ0AtjVZzOLgiDa/NuyTr1ohmzu
         aqGA==
X-Forwarded-Encrypted: i=1; AL+hErFDNeNQITtKwB2iuQM086IxJgQCbv0xELHjgXaa+Efe9IxlKjKgOqxSMvC9fhyKjkIJuoSn3remurkd8e4=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8nD6KTDMVxtZ9xX5+6LdTXOTbGCn5EISYv/RmcgH/t7M3Kk0u5
	Q1GUespU8ekF3HMKu9X+8XO2NrYG68NB1T+088olWi35yF1AnUn096jqS/Cw3wIKx9Da
X-Gm-Gg: AYBFou02zr8dMpKeZmz/4peIJAYy8h5BKjPkM5CNxdAg5tn1LK4BXh6QIiNOmbRGzL3
	NmnhWbqfuYTHvlWqP9fbhG/GCGs2rJ5zRC3KPzono8u5oz0D1KZxnyR5ZEXVGD+NUr6t9BBO0Su
	EP0GrrfGeVsXWU3j9WkHnbwHhvfpWrdxqSF+70kbKNW7Fr2dVJaQ7Dyhs+TREVZwB+0yNQZEAxL
	L19eTMcbaTHqENCrcmyciDsMKrCOD8kWE6Oy+QTR0aWhW9H9P8l4pi/xvx8nYo2Xu5Fc1jUB2mg
	/DQ+lkVVzAYJj3KQ4gG9FfxVQvU8AuqacyeT59pjhNs3fBPnA8iiE1nxN/x3qLcnXjTjVZUqsfK
	rscVNBI3eVBlbJlNOrK6lkWo4T32VnROLl7G6q9kI4fyuLF5Us6hnYq6Uky1+rAGTXIM+ITbLcx
	UuKEgL504KTzPxoM0kFhX8D3cgieitUtpW6jPiQxD5MYW2X6axAED5XRkwUpt4qR8KlSHd1Gn35
	x+sDzEXVDASoRS7tUmXjDHXvIdk4KlXhs9HB7wy6SVGdemET79ZPtyGp2DezX6OcS5Ql7eG+mRY
	8ogvWbutQ8iteyHshZR/YHI8tWHX5pIdxug/vGlogdvJma6nK7boM/+8zZtXqWF+uNmOWNdAzaN
	5SrXlDN3g
X-Received: by 2002:a05:600c:c4a3:b0:4a1:6992:f861 with SMTP id 5b1f17b1804b1-4bb55a02932mr40317635e9.1.1794564726124;
        Fri, 13 Nov 2026 02:12:06 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2842e6sm142085915e9.4.2026.11.13.02.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:12:05 -0800 (PST)
Message-ID: <82d691d2db7579d9630bf89f73132e36124bf74e.camel@amutable.com>
Subject: Re: [PATCH RFC 19/41] smack: use fc_init_pseudo() for smackfs
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
Date: Fri, 13 Nov 2026 11:12:03 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-19-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-19-4c998976c6c7@kernel.org>
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
> Initialize smackfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. smackfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0security/smack/smackfs.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index a72bc7fabea9..4a56bbeaeca3 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -25,6 +25,7 @@
> =C2=A0#include <linux/magic.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include "smack.h"
> =C2=A0
> =C2=A0#define BEBITS	(sizeof(__be32) * 8)
> @@ -2880,6 +2881,7 @@ static const struct fs_context_operations
> smk_context_ops =3D {
> =C2=A0 */
> =C2=A0static int smk_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &smk_context_ops;
> =C2=A0	return 0;
> =C2=A0}

