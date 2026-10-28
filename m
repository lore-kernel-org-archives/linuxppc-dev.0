Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BF5606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3aBNqqF
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jF5431p8yz2y8p;
	Wed, 28 Oct 2026 22:39:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793187555;
	cv=none; b=Vnlt/sf3wpXepkUBRbkbUfGEwf1i+5tfOSJx2raQQaKC2/NNmJd2p+xKmSqlb0ShHowGtToLrPRIKVC4/SqkdQ1D7yQt0NlvMp7cx8O19tm0665irI/ZMSVd79UjqwZJRADHay6ZDSFtxCO4RPqvjx79QmHCad8J7g3UEmATNJ/pBE3rqZHkmyIavtGLw0LueogpkUIG1781qFYpFxA0ijiTO2I3VXPq88K9RNDHLOiIMbQkYNmrEFMCBMSpwzBZCJ7rOwRHbFFgCebi0cTp1jzNJZZjPUv7KDMLyXeHj8qLz7daXVKM74tlsawS00ZobNStjtfq6OJabQi6uuxwbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793187555; c=relaxed/relaxed;
	bh=sOScShlNJOoFQgumDsqaC2sVgmpV4+y6Yzg+EW5P6X4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vu/gMK3bI5rYIF4DCtoZKLvgzdopOokpbukYeaMWOTZzuvwGpuqDOM5fd+3KvG2mZeRqzUduKpIMupLyvBEOaifJuP3G1XtA7eHRxFl+IslvUs5YaItASxK/FFTj/AaGMtF/XAphP16QQJ8Fme9Az66wcEdyazgPzlZptjoEvAKpgGCE/QaNqdkeOxXOIv0os70mtrTnxfiC1ZLaadCZlbbDIv1dlWmjnInpmQLvp+6sWfMWKOQdUGiPvGGx3CChRvjKiK1lfpB/5irfsKQ2M0H9/tnTQf1Ib8U01Mz1h9nEOOns4cnOb4ancGFa96NTQhl3CwoVWCaIXVEAD7cfjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3aBNqqF; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rafael@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3aBNqqF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rafael@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jF5420JV2z2xB1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 22:39:13 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E82C260120
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 11:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED3E1F031E2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 11:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793187550;
	bh=sOScShlNJOoFQgumDsqaC2sVgmpV4+y6Yzg+EW5P6X4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=V3aBNqqFFHK8/iCpvfjUC4nqv71d4gzLapwxCef4YXC24PEvK5vHB+xdOeL7szLll
	 P+FI7kOVX15iyVgW6L5BqB5j66cUsU58EFNBVc4ed1gRumoqiCbC4e+4/fMtoPPsBi
	 389uKh3znOcDxhFOO4xeIVuJHUWRavRXaxLHJn2UManYPCHBMECjV9wAGJYHfg7uRm
	 oE9BZ712DtB2yvqohWmRmnKolH9LeojudIZ3GAkE5g2bjpf6/E/ujmhxw0Acr5Ue7J
	 /SryS8fSPLV7LahdfJR0nny8tZNZQ0l6lyXB4kclXqeLy9UOpL1SeAi4UciWGJrnY9
	 J8Z5+YeM8O4VQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5be4c78e8caso903747e87.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 04:39:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxlgTJQbfUTBz2gS7wFlqG0BIp6mjS3pzXJhLaDM3zYhIvdNjKBu3YGdEWUmFReAunZ1inBouvhqWcRG1Q=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIKC3Bc99gAD4TP7QkWFQ9vewx96TjQ+Ndb5uit5tm5oSVmEt6Z
	BK8NXj2QPw6EIuCl7INMH8trcUUfWJhpr5PiczLLsi3sHIAuq0luBpAzP+fS2Doc+ndHc9d71oG
	KU180LePAfGz1k/kJZseEPSiyOMbONP8=
X-Received: by 2002:a05:6512:1111:b0:5b9:6603:d451 with SMTP id
 2adb3069b0e04-5bfcad31c8emr697328e87.3.1793187548999; Wed, 28 Oct 2026
 04:39:08 -0700 (PDT)
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
References: <20261027223847.652884-1-irogers@google.com> <20261027223847.652884-5-irogers@google.com>
In-Reply-To: <20261027223847.652884-5-irogers@google.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 28 Oct 2026 12:38:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
X-Gm-Features: AclHuK-NXF3tWCMDzaNjIN417c7ZMuQGYjVHoQ_x6BSITeW_KdKoI_jbnClXt6k
Message-ID: <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
To: Ian Rogers <irogers@google.com>
Cc: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 11:39=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Export cpufreq_dbs_data_release() and set .kobj_type.release statically
> in the ondemand and conservative governors so their gov_attr_set
> kobjects have a valid release callback statically initialized, matching
> cpufreq_governor_dbs. Remove the redundant runtime assignment in
> cpufreq_dbs_governor_init().
>
> This prepares for annotating struct kobj_type::release with
> __must_init.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Do you want stuff to be picked up by maintainers, or do you want to
route it yourself?

> ---
>  drivers/cpufreq/cpufreq_conservative.c | 5 ++++-
>  drivers/cpufreq/cpufreq_governor.c     | 4 ++--
>  drivers/cpufreq/cpufreq_governor.h     | 1 +
>  drivers/cpufreq/cpufreq_ondemand.c     | 5 ++++-
>  4 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpu=
freq_conservative.c
> index 02bfd46543e9..146a2353b1a2 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -318,7 +318,10 @@ static void cs_limits(struct cpufreq_policy *policy)
>
>  static struct dbs_governor cs_governor =3D {
>         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
> -       .kobj_type =3D { .default_groups =3D cs_groups },
> +       .kobj_type =3D {
> +               .release =3D cpufreq_dbs_data_release,
> +               .default_groups =3D cs_groups,
> +       },
>         .gov_dbs_update =3D cs_dbs_update,
>         .alloc =3D cs_alloc,
>         .free =3D cs_free,
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq=
_governor.c
> index f3bd3dbe7c41..f8b5aca09b6b 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -419,7 +419,7 @@ static void free_policy_dbs_info(struct policy_dbs_in=
fo *policy_dbs,
>         gov->free(policy_dbs);
>  }
>
> -static void cpufreq_dbs_data_release(struct kobject *kobj)
> +void cpufreq_dbs_data_release(struct kobject *kobj)
>  {
>         struct dbs_data *dbs_data =3D to_dbs_data(to_gov_attr_set(kobj));
>         struct dbs_governor *gov =3D dbs_data->gov;
> @@ -427,6 +427,7 @@ static void cpufreq_dbs_data_release(struct kobject *=
kobj)
>         gov->exit(dbs_data);
>         kfree(dbs_data);
>  }
> +EXPORT_SYMBOL_GPL(cpufreq_dbs_data_release);
>
>  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
>  {
> @@ -488,7 +489,6 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *=
policy)
>         policy->governor_data =3D policy_dbs;
>
>         gov->kobj_type.sysfs_ops =3D &governor_sysfs_ops;
> -       gov->kobj_type.release =3D cpufreq_dbs_data_release;
>         ret =3D kobject_init_and_add(&dbs_data->attr_set.kobj, &gov->kobj=
_type,
>                                    get_governor_parent_kobj(policy),
>                                    "%s", gov->gov.name);
> diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq=
_governor.h
> index 806d8fb4dff1..1026712bb79b 100644
> --- a/drivers/cpufreq/cpufreq_governor.h
> +++ b/drivers/cpufreq/cpufreq_governor.h
> @@ -150,6 +150,7 @@ static inline struct dbs_governor *dbs_governor_of(st=
ruct cpufreq_policy *policy
>  }
>
>  /* Governor callback routines */
> +void cpufreq_dbs_data_release(struct kobject *kobj);
>  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy);
>  void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy);
>  int cpufreq_dbs_governor_start(struct cpufreq_policy *policy);
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq=
_ondemand.c
> index 9942dbb38dae..7386d043c665 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -374,7 +374,10 @@ static struct od_ops od_ops =3D {
>
>  static struct dbs_governor od_dbs_gov =3D {
>         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("ondemand"),
> -       .kobj_type =3D { .default_groups =3D od_groups },
> +       .kobj_type =3D {
> +               .release =3D cpufreq_dbs_data_release,
> +               .default_groups =3D od_groups,
> +       },
>         .gov_dbs_update =3D od_dbs_update,
>         .alloc =3D od_alloc,
>         .free =3D od_free,
> --
> 2.56.0.313.g2479322e68-goog
>
>

