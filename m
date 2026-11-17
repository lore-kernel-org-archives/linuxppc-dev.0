Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27CA606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 20:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=djuXOdnr
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTbpk52bwz2xl0;
	Wed, 18 Nov 2026 07:26:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::835" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794947166;
	cv=pass; b=CA8e9ugZRDxkDSd+zwnqyMuhUdlgq+jddZ9odamkQX829fivbhOsF+dfbm9YGp4Fc1B4IGSIpA8d62SGCvXu5Fhlw2akQo9NsLuIDY49XiOLTS8jxSTM5EZYT7TqptsHxTRJzioz5QgrDssyoEW305u1Tme0u2Lgdal7WNCJ18pjIaObn7wb+gPnsbO17TRb+3cZtJ7t1w8uG/DhOf1FKG35CNXkSCKnHkL9JXC1btyYkyvANjDcHYtYp+NAH3xvvQWDjzqhaqJtkdOfT7llHNXpyag1wdAtNYmydN1RiuX2QlW5NQfbG/tRWbWN/oXTy0eJS+wKP+/vRqI4EkwxNQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794947166; c=relaxed/relaxed;
	bh=ZCWHnnwEVxO1omjU149A2BWvg6ai6vFpainl1qSCuX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDxGbp3rqieiV4utI0dc4jNRu9Js1o5fw5hflOX2owwR/Uw2LovVCKD3nREkD9B1RbrYd+pXh//AOiuthLsb1VT13WGvFpVenUiogSbUd3l1M/v/LOvKHTDKrcC1hOjEhXXlqVD5wPZ70ddjR2pA00y6bREZwB4UUnNFCXE1W13zWUV1FYbBhP/DtWQtZ4sXcVxNc1ceLo7smDsXWAZ7CTD/kVNhyS79TlKSBkMzDDmFCP59OKZeLQa3b149wm8Y7DPXyCXOeQSq1UQ3OLoGwj8tUX/mWPi1ewp1iZipno7dGnfGKLZ/Fu+G2FVAHy4dx2GipunB/MQueR8f0q2pOw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=djuXOdnr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=djuXOdnr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTbpj1cPyz2xcB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 07:26:04 +1100 (AEDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-55be673e029so921cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 12:26:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794947161; cv=none;
        d=google.com; s=arc-20260327;
        b=K7Kd2ZpyZp/T74d6Sg8mzPPsnvGGxL68tfLvD2IuJ9tD7lM0rDhEYgET0UbsVK0tpj
         LrCBNOhJtY5qG9o9hb0QjZLu4ZzndC1m06bdRAtCzn6pD12GR87Py8qHR8QGM8lXW/OJ
         sMRTFW5vxRk8Jf/2g422EUEA53TI/TgrDkxkg8DNtXETNq9odgZr+jfS1I/wr2+R/318
         KBqXzrPfF/wrGojLyOjj13paxMW4clbHE7qBuY+vujgkFxL7APEPaNNJ7dxgVa6eLM4b
         hWsplH+RWxGNJiFMsTfY2lwfWEen/dp/H0j9QlXasegA4xiejY3q3XwpA+reEgajDWCI
         Conw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZCWHnnwEVxO1omjU149A2BWvg6ai6vFpainl1qSCuX0=;
        fh=1BE1OKj6oczuSQpKnzlI6oD6H662/Y9aJaTtgcCZdmQ=;
        b=RjUNkqOXDZgYUsV1xjZUnTu1BO2c0AyDnejKZRjKX9BgYT3qKGMNJ28H6iFuL5FFrS
         KraGTyyUJcPYClMX1dNUf48Zv37D/fzs9WgVGCfYnnQDnH7CkNBpRbKSQc4kMRt3H2qA
         3luo4za33Jvw0lcqLZvEyRyJGhZWvzm6CX++cl3rsLjQtZlfQju0zNvGqUk3GtOyJhMK
         /DAmNqdQjZYRguXr4U8fM2W5eH8FMvJub/XMEZ6pbyyLT09FzuOk7XmULBQXfCb6tCsU
         ufT1SeC0mBOIoTlZUSRcN6CtfHgEQDtHAapg/fpWrWnjXlyfzfgBFtMHr+bIXYRurK+P
         6sHA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794947161; x=1795551961; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZCWHnnwEVxO1omjU149A2BWvg6ai6vFpainl1qSCuX0=;
        b=djuXOdnrQaqBY/DYoSEjNHNvjFYWO9yJvkLfFL9WZuhMath7la9VabDHFq3GF70KSY
         oHYMpuknFIu0I6Do31y0xeKoK0Jh3OPiRZz0xdpzaxJRAys4YBl+YF62AZ4NDqF81XE4
         zu2qSlDlxuMintVBJE2didERsVkMPyTG2iIm3MaRmzdW1mmvXnXc2fqWTG46rXePFNSl
         112LU5zspCy2Jq9CmabtWIAuyVgls3HmAq079zYBrAMbKeEHp+g+tJ5wWJk0EOCLGyd+
         UYkHW8wDQPmPiIdNQkWbdC0CN/kkdQnv7psc9zSCZziV+3fOAyHIGrTcteuyCqxSwEm9
         hjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794947161; x=1795551961;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZCWHnnwEVxO1omjU149A2BWvg6ai6vFpainl1qSCuX0=;
        b=zhEY3YxjaCvzP2mOrZdsOo3qU0fmh2vghMjs30GDbSLBjVaQ7dsi0fsmGUbMX1kTt/
         JVFgdYVIDr2rLmmg+EKy1LeVbCyEygwl2PpttoL10Rk5iqD2PSsklDP/ZmOH8gHqQ+rb
         FKz4E5EDin4ZvVEyfRx74NZEe6h3mLZXkHUuw23xcwgaBg2Cj0cuaabUpF5ut1fjltKm
         ZirviygnA5dBTocQTAw19u81WfKVKTh3Bc6dHjUjz9PNCDguhtZlVoyWjimccWSRT3Xp
         Ug7FZbgLrfjwPqDJQYzzG3jSeCMxDqUrJIX23vhhRpi/q5f1LSbyoj/joDYzAkNcDvTC
         +w/A==
X-Forwarded-Encrypted: i=1; AL+hErGKU3LcODEhze0bpGx/Q1enHpim6MKCO7c7s3MB0y6iqp48YibZj32GcM9xbnErH1mbYBz0Dc3dhwU4h/Y=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8Rx0BO2fbVFQV5gwMGaaBFgTHZpPjK5OCmAUfZ0G7PReuNK6u/
	IPmh4HjjlRhX9rWLuvRo/VS69GhUyoxY9EN7JXx9xUlVeIriDnWW2UHDj5c5TPSGXibAwVQeiQm
	D6bvSZ6zdQAHZfBLPPOQdXODP8HorEZy7+wNcuPU9
X-Gm-Gg: AYBFou2no15ZBpoHoDXVLeqIRctHRHwVGJeXT653ELIGM+FZo6YFsuxklvSPZkQ+pzh
	MkO7YNq0S+AyM+G/nf2fpLShhKV+4Rff6/4RgoyNBHp+gMYHE+zPQfKj5gkfBm7S//zafz3FTP1
	ZZuOhnGH2/JvM80uyF3WvTcHKJkCYmHe/8ypg0KZbOJp52C1p4QxmQ4urnVF3ws7Tt4QMZ+mvwx
	EbufpcuhhEsyscOpuhSiMhQ7D93uSforTgadplQ7tSImyhMItOzcvR25i4jBBpCjQR7wnXHwnnW
	b8On/kcDJQjcCSjnc1TKZUleY0IKzJls0lXPmgFgI8ofrQGtkrUYIntdYse9Z61vjB0MlqDHJ/W
	MEgmQSzve8fY6UAXnXPSTQo+I5f+gR8pho/h3ORDBJAQ7BVvEb4S/6lwnjGGaGPgcQuvrixZKFF
	fPr19+2Sa+NhU=
X-Received: by 2002:a05:622a:4c11:b0:536:6ae9:f55f with SMTP id
 d75a77b69052e-55d5c25ac0cmr168991cf.7.1794947160746; Tue, 17 Nov 2026
 12:26:00 -0800 (PST)
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
References: <20261108223913.3624571-1-irogers@google.com> <20261108223913.3624571-3-irogers@google.com>
In-Reply-To: <20261108223913.3624571-3-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 17 Nov 2026 12:25:49 -0800
X-Gm-Features: Aa3M54rgKc4_PudcaM6yszp5Mdw4isGgsPgTnvL2ClaE7ml053-JZnxk-RQJF-U
Message-ID: <CAP-5=fUQvqpny1CrYVUqg9SQo6VpOuUqfOK403BxK_vWCDU30w@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] powerpc/secvar: Add missing kobject release
 callback to secvar_ktype
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Nayna Jain <nayna@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, driver-core@lists.linux.dev, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 8, 2026 at 2:39=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> In add_var(), a struct kobject is dynamically allocated with
> kzalloc_obj() and initialized with secvar_ktype. If kobject_add() or
> sysfs_create_file() fails, kobject_put(kobj) is called to clean up.
> However, secvar_ktype does not define a .release callback, which results
> in a memory leak of kobj (and a pr_debug warning in kobject_cleanup()
> when CONFIG_DEBUG_KOBJECT_RELEASE is enabled).
>
> Provide a secvar_release() callback that calls kfree(kobj).
>
> Fixes: bd5d9c743d38 ("powerpc: expose secure variables to userspace via s=
ysfs")
> Signed-off-by: Ian Rogers <irogers@google.com>

Gentle ping on this patch (moving PowerPC maintainers to To: in case
this got buried in Cc:).

Danilo offered to take the full 9-patch kobj_type::release __must_init
series through the driver-core tree with subsystem ACKs, and this is
one of the last two patches awaiting an Acked-by. Does this look okay
to go via driver-core?

Thanks,
Ian

> ---
>  arch/powerpc/kernel/secvar-sysfs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/sec=
var-sysfs.c
> index 395399bbab2c..f3f6ac25ea78 100644
> --- a/arch/powerpc/kernel/secvar-sysfs.c
> +++ b/arch/powerpc/kernel/secvar-sysfs.c
> @@ -126,7 +126,13 @@ static const struct attribute_group secvar_attr_grou=
p =3D {
>  };
>  __ATTRIBUTE_GROUPS(secvar_attr);
>
> +static void secvar_release(struct kobject *kobj)
> +{
> +       kfree(kobj);
> +}
> +
>  static const struct kobj_type secvar_ktype =3D {
> +       .release        =3D secvar_release,
>         .sysfs_ops      =3D &kobj_sysfs_ops,
>         .default_groups =3D secvar_attr_groups,
>  };
> --
> 2.56.0.455.g6c5a503b38-goog
>

