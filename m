Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246D0606A880
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 20:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zrXPRENf
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSzN03lPcz2xnQ;
	Tue, 17 Nov 2026 07:04:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::42a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794859456;
	cv=pass; b=hpDeBtb+bMUfEvSbe/NLpbaJmjGDz08ceVYlk+ON8dHbpmOkjqEjN5PJOh8yIFcjIllvCtjuK16qIS1I5p8uX4XyOePNUzokJnZIQ8GaZ2BhKGMYk9ntbehVVMuox1VxgvCT6XhjIg4pSeaX+YAlDi6TOVysA6njBiOzWndho2jk5xaWiOsZ+sBIP7WcXIiZJI2b6OFQ4DWJvNxFae3qglFK+LQCWWgmIwirBD+IpwWPZaxLLEuUuK2nsw9SV+GNNWaTZ9iH342rsikdeUHDdtpQ2MrRTcylNAj/9DDIC3kss0fyE+QvxlPm+Mq+//6nIcMHflm0Qm8WAbOWra/8/Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794859456; c=relaxed/relaxed;
	bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AoCQAeiEi6Slhx8HqVDlt/LfuIZ1Z9GtyjvUMNZKN44cRNsLFzm0Hs51Mvuy4QLBXnEMYLce2vi/OvxjOi27atr0XiJhhQG1idichGkz2Ju1r4qd5OnnemifLgLlJnw3+lxPD0QxY9PQMthrhBLUwtiHkyhvF9ROhLhhDZLTXtynpdNI7XP45BvROa+8IH0zeZ0Pl1eFRdLbR7wxH/F4xQHkRf7Y7OXWeaynU8p+oHP0fkkTFPC0+z0U6Fc6QHjg8t1WjVT3hDv/ockYMZJ+Iva5fBmm3Cc9iwtge3q08WtLXqvgmNueyDy32yjxQP1+YTS2wj07En6sTvchyJlavQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zrXPRENf; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=andrii.nakryiko@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zrXPRENf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=andrii.nakryiko@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSzMy58Bjz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 07:04:13 +1100 (AEDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-48e47347279so1838158f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 12:04:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794859448; cv=none;
        d=google.com; s=arc-20260327;
        b=As+CvR7n8qLKpeyVxz/118HVn12tg0igqYVBPJJ9pzRSgnxHa6ocl0of/8Vl2RBoKx
         fijhiBpN2t6b++O1VtU4gpY6x/y6ChdC2cuFHGx5o9GqW8ggbQcca/5rOSbeC4avbCjj
         rluIoMohnyWyr+5ZGUr3J6iyeZOzg9GJ37LyTGuS0cSezhgXVUetalZKpFwj7Z3hZtjg
         vhhcIPaPJDl5vawLHKy0vkuQMPbc7m5HxCZzi6GGDtBOYQ4lankMY8u+rcXCFhPP5OPO
         Jt0u+r1EGXa1pZskFoyK8lYHae4DrHcJ0qfBd+3otgQJ3sxTcVS5RTSWZeMh6uIiH9w6
         6zsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
        fh=1m3VI9gpQNap2lrWyTMAUB1aeAHB0dnHDZJodDI5tv8=;
        b=A2n39S53FpmtraoPPVMMoEQjAAZ+lLC8nQlmS4iznNMBhe3B/nLhAq2IYhTK7uCn0A
         +pVinYahWS5EhNRsLx/ITSR+pkRzxH7PC1OaA3iK1HCQuwIJmlcMx7Dkm8uU/I4aVZt0
         jYbew6cMJAadMnkX9uzucAx38xysZUvJUqyxreBroDa9KgvqRpRaSeaoOTrpViLzc+8I
         SEHkuQmuD96wNOi/NXmN4Vg7NWrQt3sq+0YsUZuxlocJRHAZT+YRF9//r/EjTmso2FRr
         RzuvBLcGNlIRAwQErDNg4jbXT8U25KSV1ViClwS1fE9Wrz9i3AfADmn6tUE5SmxkvCxk
         AYFw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794859448; x=1795464248; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
        b=zrXPRENf/BfgI4+5aC3zQ1MzFoVAOap/SBCCBe4jAYmQC/hvvAKaYWZfEJgS7h8kjU
         T2YQ32S3PsR23mJZr3ZlUXCLu2UqeMcuUiPV8s3E8Fxz3rfTNTLK0RwBqsF1a5a6zRw2
         6xUWssv5Brn22R7z7IUbRjyx8xC5kvRoPO32cCJkLCWHVAjr7eGH0CoVdkVhl7pqvEEh
         TOvQxBHjnMi3NOEFjtlQ0WLB53CfG9JOexRqAAxlY3U/BMGoUya92i8SvhFwNfiFhdkN
         gXQ1jj6gJAn5VSJa4D3jvZV2usoRHynpReIEYt7blLbhWpW6QgGZFU4Mg5CN1+tZcLXc
         ckJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859448; x=1795464248;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
        b=ZRC7uAuStNYjLyMW2EJ3k+oxdeZjsuyQmozc0qgq9g8qlvb/Fu3Xy0uHgmbRpOC8zM
         bG56WAetXOqCAj4MHFOixjmeD+/+p+QRVVE4ZAvldrazAzqdDpLL591K76kNcy+GaF5M
         8y6LlHrKnJXzejTH3hT2yDV63pK5rMuD83dWdzy1EiamK7Ew5JjCNt+GIvZcLdiIkfyq
         T6CZSeQ+4XUGj/3DUD+Er0/0MPCaYXgeDs7skAbblVfi3XTWTcGphOYmWeQ50namSQqI
         0GKRaP6aw6s8fB5o4y9Bl395/dgojouscgIew8sv92jU7oU57nyZFxUyNKwJG898cd+3
         005w==
X-Forwarded-Encrypted: i=1; AL+hErGviXKSBmVdmGL0fCv2jmm4uz8QGHDDRfY8UyO+KnwQ8TW9Cti0c2QgcPfFrIeii+1Pzj94KT5L7OgCTxM=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8/KPeSXPRGXBp0MQsXvGJ9Pxl1jeaIiOO/uUOOevRxPTdHQkPa
	Ba/utDjeSeCbMtkn9fvAusjFfvQKeSAYfgnaM+sHCydwOlJsh7Mb+VFF/BiUp8QD3RGg5pJXmfN
	HWfAAVXFylw4BZUmAGXZEswNW0P4Rihw=
X-Gm-Gg: AZFdTZfnGB0IhVlz1LHBDfLKeTASqXJbPWjZpAb0wZvl2sHnPBdKyVJbqReKlGRXCNe
	MRwPKnqvB6T3x1HftMpMtexZsHL9IBjFM30xwehTGH74ZTfurupV/XDE2ikTPtFvrJAzooPdCd2
	2lpVSk2aEpYl/YsYt3dcFYQkhMbXar6JNdlNO/Bk1p5c+pLabO8RwJLAQ1wddr+23jnFwqfygl/
	edhpw4ewgZoI2LAqrkTVrA8levBjtjQE/p6ydCtNk2DHctINmczwXA3FHSu8YApZGsZUZA7W9gl
	h7dJE8TywzzqfeFCjOiAI0KiXV2JtKpeX39m/7yZXtywbVYiGRa/kPeLvQTC4Gv7pobMRYT4mkf
	CYwlcpbRT9pAYgGXQw3zrbrO+ZgZhb7xFKRQZqCoIk7gNTbFdmdu2j3QZI0o1maJtY0GkRWFnX2
	TMQUpAXJctl202pEnW5pA=
X-Received: by 2002:a05:6000:4692:b0:491:3fdd:af34 with SMTP id
 ffacd0b85a97d-49d61c80db3mr13343868f8f.36.1794859448335; Mon, 16 Nov 2026
 12:04:08 -0800 (PST)
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
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org> <20261116-work-loop-pseudo-v3-9-8cbbea1cf34f@kernel.org>
In-Reply-To: <20261116-work-loop-pseudo-v3-9-8cbbea1cf34f@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Nov 2026 12:03:57 -0800
X-Gm-Features: Aa3M54q6P4M0RFDCKQ8HHGNCWJafItTSPdWR1qNwVGtToDAv2VOv8vDfWHzYR6A
Message-ID: <CAEf4BzbLFVawibuX0wk=8uzy0WZSYHbkgK55d7rqLab2qAM1Fg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 09/44] bpf: use fc_init_pseudo() for bpffs
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org, 
	Alexander Mikhalitsyn <alex@amutable.com>, Chris Down <chris@chrisdown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 3:21=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Initialize bpffs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  kernel/bpf/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index c6f328e4752e1..57cf3775c0766 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -15,6 +15,7 @@
>  #include <linux/namei.h>
>  #include <linux/fs.h>
>  #include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
>  #include <linux/fs_parser.h>
>  #include <linux/kdev_t.h>
>  #include <linux/filter.h>
> @@ -1197,8 +1198,6 @@ static int bpf_fill_super(struct super_block *sb, s=
truct fs_context *fc)
>         sb->s_magic =3D BPF_FS_MAGIC;
>         sb->s_op =3D &bpf_super_ops;
>         sb->s_xattr =3D bpf_fs_xattr_handlers;
> -       sb->s_iflags |=3D SB_I_NOEXEC;
> -       sb->s_iflags |=3D SB_I_NODEV;
>         sb->s_time_gran =3D 1;
>
>         inode =3D bpf_get_inode(sb, NULL, S_IFDIR | 0777);
> @@ -1261,6 +1260,7 @@ static int bpf_init_fs_context(struct fs_context *f=
c)
>         opts->delegate_attachs =3D 0;
>
>         fc->s_fs_info =3D opts;
> +       fc_init_pseudo(fc);
>         fc->ops =3D &bpf_context_ops;
>         return 0;
>  }
>
> --
> 2.53.0
>
>

