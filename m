Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D0560A261A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=d5dLw9R5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFBKQ0gr3z2yPG;
	Thu, 29 Oct 2026 02:36:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::836" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793201770;
	cv=pass; b=J+II48kLZ4lUYrq3ZKACQhHWyWiZ5g67xVfjQX9zRqIINAukGMW9l+2Yb1lvmbXYoAJ62A3T5dFYkxjgWYWU98Qxd+S5Xdfe36cqk0TtzCsB4+HPXYOSxd9fQAMj3jy8zWaLtkuM+fToqX9i/DL6pZqd/KjITsj/PN0PL6iYDtFVnZPJlVyqD21PUdsdtWjKMdsy0jKg8oTrZKNw2KAIUimbQvrEsZRzKluFLsEdQavvU9aAxMWLo4Wbp9j4iTZpyi+40uGN89O1dULzOyC54hvyi6Y0eFIlkMAcVvMYL/rKLMrjBWybtFYT6Z2AvTiO/3K0kjYUnTjeHvWGqqDdbg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793201770; c=relaxed/relaxed;
	bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hh0VKSoH7ZVZNBl8Aryd5aBA81ao3z0qoaA30Ve8QPRfddIuYNE52ao3FkdzCp28/tI1t9GwRMUkmVMzJilqW7WBw2UnshcthVSYy9tQPye76riRx9kAb5TwFC1cMeY8uZ70GKbEHLBxWxO4A4Wkvyrq/MLxT3ddA2xfjrofO+wYX7hjFYaJ2MvouiNo1abmxhpaTCrOL17elNyFRK5FC1zA4+dxKnLe+lv95w2sVsBFo1yh1hj/g7EIx6MsXM5ktk2lZ+l4GWBhcP6EOAeZtmN4GdjDa23lV/ETTDvbY57Z9W8Zt4bXINDXo8M5o+gMQ0WypDkjk19VxA7QUyhPIg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=d5dLw9R5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::836; helo=mail-qt1-x836.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=d5dLw9R5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::836; helo=mail-qt1-x836.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFBKN0z68z2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 02:36:07 +1100 (AEDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-535f598d126so291801cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 08:36:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793201764; cv=none;
        d=google.com; s=arc-20260327;
        b=f8KrvSaKckPBVrxHCS34k2275ZpRf3H6e3XDsmOcDS2BK6wuFvyNZiaxOWQvivkYo9
         T5M7AYAdMNUQw56BaqXr3NqnvjyLCcrl7nHGnRcA7Ckt/xhpmM4h9K/5BLgEzaLQNu+g
         jA2v+qxxwp2vNgfa493Z0PVBxmxzOCzjC7GrHbks89DJkFDRcgX1kzoY8v7PAtJNRrP9
         sEBrrJNNw4yV2ugNRAkrfY+jZPS7xlwg7gN/pnUugPe9InPzEeyKD3Iq0tcWzh5dvFtN
         lbUTijUPTD4dExRl5L/W7wm/vT4rWZBOr8v2bcJdHrTj/vxA+ilf85Q9O2xTVvrwwWeK
         W4Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
        fh=XO3SOSzjJvB4flvXu+9UgihKj7C+mQgQEilrOl64Y00=;
        b=U/4A6pf12N9LlLWK3OWdcsTdV2eZ9mH+0KBq1OXu/aSTIFLB7/2RMAuFuIPp8WnFCw
         Oa23gkdva+lGaPh1th0J9vejDJOwTWl6FjSztz2I7l1LzjXCdSpU8RDgimTbm9daRpn2
         32aoSH47UnO28VYkPeASkOY2//2LcFTrf4vcUr+FIy9s9nN951ZQkVnhbV9qrzgs7r12
         49hbFMYBmRbxlbKQapB2ywInN/nsTnVm+h5UmaJ02D8QmU4q4iRMkoZcvQUEVnbzF5ul
         AGsd2oXQNIkmWXr3ZKdr4G6rXCXK84fh2gvGOJGpteFIimsMfBRTgNgwn7KBAS/drRLU
         ++fg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793201764; x=1793806564; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
        b=d5dLw9R5fR+llIMepD27zqRWhtuAjXsA7E47jZKj0LUg73ZDXqOwZY9XQxVFdNeQ8U
         a9F5pYKF7y2hGCBryjP75B8KVsiCMH5Vgv8z7mvQIVQx3wnVTweYvOS1qisCr3cexcvA
         aZx+8yCBydsdL69Dz9FpDHBgjKcuJWqVDydO3ghr49dxk+LE9CbEgF1FfZZyWDNrxRw0
         SsbSfyZCbwSktjRCjpppK4ILTXayIogbdg+6bwIKgqsEsuL5SU7AGdSFYcNh9p0b6sLB
         Nwp4pII/nS33FwuXR6M4Ilb8za27v4/tm3hS4JWsiCyRCo/3DzMvimgaf/LDB0bcc2BB
         jMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793201764; x=1793806564;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
        b=VM8fPtijJvdg7D/h3MUOgsIPJb9kNUjYA5R4eMfqWMTvgoA2L2Q5IoJpCCxE2ApktR
         QRlK1JTsMv2Nn8quJ44llv3bIwPess/CY5CeDDX6HYmpsxfr/w/R2/qDB/BwxElrduj8
         ELSEIl9Rq64pLRDo7yvYnnilY3XfoxyvwbOGhXdvV6C6hgEKMIJsw5F1ixCBNmMWm5t2
         l2tQP+ZGntP5F2AVhQ3Q5NiEwxfM6TM2sSzuDBP41qvwTo5gACdKa5kYdoFpTVteV9mR
         3xHW2f91gedFo7cPVeNWRm5SBZaG236kUjVS5rLW0ZaiQdhfYMp23vqSpq/24fMfov1n
         kVlA==
X-Forwarded-Encrypted: i=1; AKwUvBz1t0ZAmBg9o34pjHwcEAdKsRzXA5Eb4meaAQC21mMwgzi15mBQudtOBwhCdANdFTJ5suWtoz6rT9PSseY=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYK5JjjCihBHKJlLiUdF9/Yl8aDf3YvFUgD0zLZdRN7Ome0YHjZY
	L12JY+Es1eftpzYr839CjFpLQQJU/aNo3gwg+yw5Kg3wRIVFsdHZNCsog4V8fg7guOlOpCyYQck
	FzX0Ob63TBBK0VSJHhGU9gzdmzExWvGNOd8QLT1Cz
X-Gm-Gg: AYBFou29u42NG3jnMjE589ogbOvpa9UPr10MXJzfZL1Cjh4W2DiYXeQKGdopbyu5DEK
	1cg1WitWfTJD7QL+uqi2VdBDjxj0Cx6sTegiFoUf0rZunccyTM/qApBF2okxuWx846vYMMfS8lS
	/US++TDoJ5fpH1kBD2IwtsAJ8/ZwkRsDzyK09Q6zX8RDUATWGNbFukumigblK3crXqiy/kB2PEB
	8ETGl1L3/p3800dhvTVDvRs9uI2lqR5pnNiaO+UYOb2W8ZwRjIwNeGNIy6K5XO41hJRalBUE9iM
	UnwFIVpchtBgV365MANwtQnRfzGTI474B4k69g9qdJNq92h15zhU4/b1ipKxlS3tVmn3ptTBlUf
	HAup6AE8hcy+eMkZkLvzmGuAmiefLWrAwNrlnhjtDmrtenFx4YdDsxMwQXaQ=
X-Received: by 2002:a05:622a:22a9:b0:536:97c0:dcd0 with SMTP id
 d75a77b69052e-53fc2aa1fa2mr21345071cf.4.1793201763129; Wed, 28 Oct 2026
 08:36:03 -0700 (PDT)
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
 <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
In-Reply-To: <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 Oct 2026 08:35:50 -0700
X-Gm-Features: AclHuK8Z1SdNi4k8-UQceLsnqDJD6d9aTo0cl8IQ7vlO1Fmucv2n8goL0VFX4iw
Message-ID: <CAP-5=fWVZ=7-qDRODiEQzRzhpQqribv9Morj=OoAXW_6uaW2dA@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
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
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 4:39=E2=80=AFAM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Tue, Oct 27, 2026 at 11:39=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Export cpufreq_dbs_data_release() and set .kobj_type.release statically
> > in the ondemand and conservative governors so their gov_attr_set
> > kobjects have a valid release callback statically initialized, matching
> > cpufreq_governor_dbs. Remove the redundant runtime assignment in
> > cpufreq_dbs_governor_init().
> >
> > This prepares for annotating struct kobj_type::release with
> > __must_init.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Do you want stuff to be picked up by maintainers, or do you want to
> route it yourself?

Hi Rafael,

Just a quick note: I agree with Zhongqiu's feedback and the commit
message needs a fix.

Regarding merging the patches, the issue with maintainers picking up
fixes is that the series will break the clang/llvm build without them.
So the maintainers need to either merge the patches (and the series be
rebased on top of them) or merge the series as a unit. Perhaps since
the patches align, merge conflicts won't happen, so maintainers
merging and landing the series is okay. I don't have the experience to
know.

Thanks,
Ian

> > ---
> >  drivers/cpufreq/cpufreq_conservative.c | 5 ++++-
> >  drivers/cpufreq/cpufreq_governor.c     | 4 ++--
> >  drivers/cpufreq/cpufreq_governor.h     | 1 +
> >  drivers/cpufreq/cpufreq_ondemand.c     | 5 ++++-
> >  4 files changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/c=
pufreq_conservative.c
> > index 02bfd46543e9..146a2353b1a2 100644
> > --- a/drivers/cpufreq/cpufreq_conservative.c
> > +++ b/drivers/cpufreq/cpufreq_conservative.c
> > @@ -318,7 +318,10 @@ static void cs_limits(struct cpufreq_policy *polic=
y)
> >
> >  static struct dbs_governor cs_governor =3D {
> >         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
> > -       .kobj_type =3D { .default_groups =3D cs_groups },
> > +       .kobj_type =3D {
> > +               .release =3D cpufreq_dbs_data_release,
> > +               .default_groups =3D cs_groups,
> > +       },
> >         .gov_dbs_update =3D cs_dbs_update,
> >         .alloc =3D cs_alloc,
> >         .free =3D cs_free,
> > diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufr=
eq_governor.c
> > index f3bd3dbe7c41..f8b5aca09b6b 100644
> > --- a/drivers/cpufreq/cpufreq_governor.c
> > +++ b/drivers/cpufreq/cpufreq_governor.c
> > @@ -419,7 +419,7 @@ static void free_policy_dbs_info(struct policy_dbs_=
info *policy_dbs,
> >         gov->free(policy_dbs);
> >  }
> >
> > -static void cpufreq_dbs_data_release(struct kobject *kobj)
> > +void cpufreq_dbs_data_release(struct kobject *kobj)
> >  {
> >         struct dbs_data *dbs_data =3D to_dbs_data(to_gov_attr_set(kobj)=
);
> >         struct dbs_governor *gov =3D dbs_data->gov;
> > @@ -427,6 +427,7 @@ static void cpufreq_dbs_data_release(struct kobject=
 *kobj)
> >         gov->exit(dbs_data);
> >         kfree(dbs_data);
> >  }
> > +EXPORT_SYMBOL_GPL(cpufreq_dbs_data_release);
> >
> >  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
> >  {
> > @@ -488,7 +489,6 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy=
 *policy)
> >         policy->governor_data =3D policy_dbs;
> >
> >         gov->kobj_type.sysfs_ops =3D &governor_sysfs_ops;
> > -       gov->kobj_type.release =3D cpufreq_dbs_data_release;
> >         ret =3D kobject_init_and_add(&dbs_data->attr_set.kobj, &gov->ko=
bj_type,
> >                                    get_governor_parent_kobj(policy),
> >                                    "%s", gov->gov.name);
> > diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufr=
eq_governor.h
> > index 806d8fb4dff1..1026712bb79b 100644
> > --- a/drivers/cpufreq/cpufreq_governor.h
> > +++ b/drivers/cpufreq/cpufreq_governor.h
> > @@ -150,6 +150,7 @@ static inline struct dbs_governor *dbs_governor_of(=
struct cpufreq_policy *policy
> >  }
> >
> >  /* Governor callback routines */
> > +void cpufreq_dbs_data_release(struct kobject *kobj);
> >  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy);
> >  void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy);
> >  int cpufreq_dbs_governor_start(struct cpufreq_policy *policy);
> > diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufr=
eq_ondemand.c
> > index 9942dbb38dae..7386d043c665 100644
> > --- a/drivers/cpufreq/cpufreq_ondemand.c
> > +++ b/drivers/cpufreq/cpufreq_ondemand.c
> > @@ -374,7 +374,10 @@ static struct od_ops od_ops =3D {
> >
> >  static struct dbs_governor od_dbs_gov =3D {
> >         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("ondemand"),
> > -       .kobj_type =3D { .default_groups =3D od_groups },
> > +       .kobj_type =3D {
> > +               .release =3D cpufreq_dbs_data_release,
> > +               .default_groups =3D od_groups,
> > +       },
> >         .gov_dbs_update =3D od_dbs_update,
> >         .alloc =3D od_alloc,
> >         .free =3D od_free,
> > --
> > 2.56.0.313.g2479322e68-goog
> >
> >

