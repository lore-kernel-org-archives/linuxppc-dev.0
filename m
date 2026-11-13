Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA4A606A336
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HEUZ8uOn
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRDBF1gM5z3btn;
	Sat, 14 Nov 2026 10:34:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794564707;
	cv=none; b=bKmn4dfwpbyNOw4Ad9YRiiFHKNJjNZpK133zp35Oo8ohgFE6Kxtbtct8XWF0yXRisYhQ4gY0hrcc6NfbJX0xjloApEc5cl9W1eZlkwmzbpRq8VqozNiwN50eowUPXx2H9ZlxoGKTceHHkSlr5rSctOf9piWU7E4onlTMma/j24zbfZuJptyW2VWA8+qTOEUr2nH8ovJ+cIFTbepM0xXyPzQLW91sqw6/ZwQpkG1baC7w5XsPU/9S4vTmCQbSO2UnJb+JTUomBz9owM4GyWrKkRUem/vhaY9osNSsJBLC7IkdHpSjMSh/lglSBPr3ULmAvBcaDbk5VM9sfKhMIFYTxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794564707; c=relaxed/relaxed;
	bh=gXMsjTg9KyNTuX1cuQ9yr2iJq2/VClhNCtHhh+FL0ZU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M2KRKzKm2KBG+P54D+NR0snj8LjW3AOVsQT/3zE+r+iCSrk2cB0mtwT1SaL7PRJt0XLgVVLu2ph/J75bbEW5oEf8H/bYGfHG69QCCOoKcGVGk4TGOWQ1acs8NbsVGfeT5Mn3xCJwS4bGd1JQSnXESk2SxIqBmv6m3r1QsVUhCydcbIodaxyhilWkvAT261y9UL2iwUm2PSn75+WV+0U1UkSqcHthF5rZWZWH7Lh82LX1IzYaoklO65+ZFCJVFOhMMayVrsN4PVEa8SBwxZ/qUsI0pYOVebSi3VfupUq3DG5eftCPz++bNPIB4iRXO48Kqjfm2wheZDYOyrmrzrGf9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HEUZ8uOn; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HEUZ8uOn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQtMk2k50z3bdQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 21:11:46 +1100 (AEDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-497614c95f0so327663f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 02:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564703; x=1795169503; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gXMsjTg9KyNTuX1cuQ9yr2iJq2/VClhNCtHhh+FL0ZU=;
        b=HEUZ8uOndbcgGtx7/JlC6TkiVOuc2pKtQUUFRCE1W9Y3Hs9mrw/oRFEdJezDCiAWy2
         LRaitE1nkJDqGR4cfd7TEFgag2jf1WYxZnRcgHsCwqcoEfmvydkah2ooFH0pVuYzuDUt
         CjMYOD+3P+hqXnAKBYwMYL8z3dpvUDc54/1Wun8qCHo8IYuaAQjlbKpCkBhXO8/LqOgE
         TeBlzxpavYs+SWXkzJHqEcMWpS7MnFHbRjFw9LYzwJd4QxHoBUDwrRv8fh4vzaNUmQoe
         ht9ggiT/wxNqoij6zbpByWXBh25ajhxGE7gj0TMnLQrJ0BLeIlDqkx/lNcBh565C2w9w
         XOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564703; x=1795169503;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gXMsjTg9KyNTuX1cuQ9yr2iJq2/VClhNCtHhh+FL0ZU=;
        b=rXnwNfuMtZHWw6zqpXjpnF/JsrIbQScORJU2mpohKACEhxmiIvcDSvKSCT9fT4/d9S
         NzZOXYfO77WmZCYZ/2VfxepNN0WsQLVfDoTyO2BkRfKUCjfZdraKZEQFEpCMQr17w5TU
         CMcx1xizmD/puhlqLb88dQ42TheXCDpQ6S0VmVhcgcKzNBJJDXdOW7AVfxe9U8+F5M5p
         XzNM7sYGLMd7cPO559piFHeDfSpvFxjB56Au2Os9IT/dxmrTubDAXyxd3fHjBfc4BOUn
         g/6pgbwh2gcMU98ox0xrhXAZg2Cpbj7DbQMTZLf62whrsDv3R/Qo7A6B+GHFBx1y6v3M
         FuSQ==
X-Forwarded-Encrypted: i=1; AL+hErHs7eqmgA/bN/ruihf5USUx/6qCtDowAT+RWSdLHLwr269UU/Ma/4+fRyaSGU4F9TqY5kFapmkAZ6LvTjg=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9m/uv4zBbEeAxlrzg46Fj9fDkMSmhhLYJw4b3wGlZOrX9jJIZT
	WstRrpz08qjNVe7sJLN3vxMbry+z1iYVDQPGX4diapXLY4XKbZSCamVcRVFDBdHS2VUA
X-Gm-Gg: AYBFou0s37JN2qRfF3oW/2fs+lNO17ojP8csrXuWbcMowXvWWxKjMdUhPqrNsRV0Nua
	rkm7coUhFhOa5EWh/B8Nc7TU0d7sl2tIGnx9NWpY9mSq/E71bu5/7UGArcYljz/IX1qV+LyMETL
	suamATs1cbuOfrepvj+3ECjN8Rz6WPXUNXh55ytUQBSrahADFoyhAbFzzZeWyEjvlRyi4GcFfsC
	Km0Yda0xgz06hMeRApnK1feanP22A2jk6UmbPjYdg6qkRWUUtEe2ZA9dzKV9PRPWyD10VhCfA2O
	BRkJ9l47Dj61vdAR5NL6Wo8MsGGLwFz9eHN97sH6qpwE00AJPA+/fdRnO4r8g+6j0NRfjMi2YVe
	KehzmoJ0leJSfJ7GP4ZNYvSZmqTur+LID5qYgU17tDTMdVqV0+GwhOjuiT2ADc642NjIncPHuGO
	sGbirhrjGVjZipvE8IBYr61q3jirM6wKUb0JxlmVyO/RweBmBmyxHNWjMQWTq3HBH+u/HsPN+t9
	LQP/4jPd06+Y+/AznNFIDipfNXNcuPJOdPdXtpaFk8Ks5qnSW+XY8fSbxxDXyMThPUXLB1OxsbZ
	KLRSktc43qfu7C1uVBaH/lHzmVj+3DXtkRPvj9Or6k6Gd+CMaOonw7O0f5gBs4E=
X-Received: by 2002:a05:6000:2501:b0:488:88ec:59c3 with SMTP id ffacd0b85a97d-49c73259cc3mr5012611f8f.14.1794564703010;
        Fri, 13 Nov 2026 02:11:43 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c1797sm4931434f8f.11.2026.11.13.02.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:11:42 -0800 (PST)
Message-ID: <ff6d2a8c8623f5476d5c352dac1ad98ab3da303c.camel@amutable.com>
Subject: Re: [PATCH RFC 18/41] selinux: use fc_init_pseudo() for selinuxfs
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
Date: Fri, 13 Nov 2026 11:11:40 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-18-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-18-4c998976c6c7@kernel.org>
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
> Initialize selinuxfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> SB_I_NOEXEC. selinuxfs never holds executables. SB_I_NOEXEC also
> refuses PROT_EXEC mappings but the status and policy files are only
> ever mapped for reading.
>=20
> But selinuxfs needs device nodes. The kernel replaces file
> descriptors
> with /sys/fs/selinux/null on exec via dentry_open() which doesn't
> care
> about SB_I_NODEV. Android init however opens /sys/fs/selinux/null by
> path as /dev/null doesn't exist yet at that point. So clear
> SB_I_NODEV
> again in sel_fill_super().
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
   I.=20
> ---
> =C2=A0security/selinux/selinuxfs.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/security/selinux/selinuxfs.c
> b/security/selinux/selinuxfs.c
> index 310e19efff1d..d7ae853b6d68 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -18,6 +18,7 @@
> =C2=A0#include <linux/vmalloc.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/hex.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/mutex.h>
> @@ -1852,6 +1853,9 @@ static int sel_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0 /* last one */ {"", NULL, 0}
> =C2=A0 };
> =C2=A0
> + /* Android init opens the null device below by path. */
> + sb->s_iflags &=3D ~SB_I_NODEV;
> +
> =C2=A0 ret =3D selinux_fs_info_create(sb);
> =C2=A0 if (ret)
> =C2=A0 goto err;
> @@ -1955,6 +1959,7 @@ static const struct fs_context_operations
> sel_context_ops =3D {
> =C2=A0
> =C2=A0static int sel_init_fs_context(struct fs_context *fc)
> =C2=A0{
> + fc_init_pseudo(fc);
> =C2=A0 fc->ops =3D &sel_context_ops;
> =C2=A0 return 0;
> =C2=A0}

