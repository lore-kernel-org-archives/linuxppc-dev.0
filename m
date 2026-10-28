Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1E6606A321
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VHtM/wzi
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFBPl1ZYLz2yPG;
	Thu, 29 Oct 2026 02:39:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793201995;
	cv=none; b=ie4nzv57oVom6CNiH8Q5L+PhX7HMVSI5CjOOdP1uxexqjdGoKiMBNyfxKpqO4p9oKVn6B+1zVStiQaJdx4Hn+Q/jNTP5SuPdjex2QpETs/bIWw23lazlKYljCXprIv0eVuSQaq94Ywq0a5Yr7PrQFNyf4NESqifoRm38SR9E6ZtqyEQJe5JuzhPPNecTwr2r8T4tjj3ZlCubTqYYvQYCwK5wtvZOOATexk566CxVUhzg3xPdLxDc65Nh4YGOYpp2E37A0jWmX0YJ6sLOOWB+q+5GUvun91Xe+f/IqAOP0kSlbXFEVo7o6yJCKlEWrOPYmhvzGuOkmp1XtPV4f9uvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793201995; c=relaxed/relaxed;
	bh=v/GrfVBE9REqGlviMjMV9KYA8baC9D3Z4PFL9rDyJNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/1RFDP7i6vNHnHUz9/K1ECY1+j0jMWCQd1H9ZZ3Bq9DAMuAOBL/C4bo/mP2THeaBjjewFobbtAJw0/4bh/l8NYIl1nrh+fkNV+Ws9ZNRPCd8rdU3Gjj5cpny0iktZO+Mj0/w08YYH2hcSlIf2HE8KgCuIP7Gv647PuO8qCdZzQo/JvTxeivWrM7igwhTV910jVm1Nir/1U3CvLztO2q54P6zHryRMGlRlri2FJGb9HH563wzRTQtxOTNMBqEvj5P7kBkvUHOFYCZhumTe6dYEBbx5X9PGBi1r+m3uUs1Za0Hz+6wwIj13G1aRbSt/9cYguPu8KFnsGeyBNFVPWffg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VHtM/wzi; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rafael@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VHtM/wzi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rafael@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFBPk1VTyz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 02:39:54 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D92E242E91
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 15:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AA71F031F0
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 15:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793201990;
	bh=v/GrfVBE9REqGlviMjMV9KYA8baC9D3Z4PFL9rDyJNI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VHtM/wzid4Vjpi1ahtkrCTunBXdpMk588+yxAl/Zt7jPzQ9CgDIh+PYPt+lW+RHtD
	 XBF1ITpY/oCCREN/r3GxTTiasnxkbYCm2mrSb3zmMn23c5zknBvNx/dV5SfeyYM827
	 m45G9IzvrUp2GsXITO1BPz91FS4SrBTRct5fIYPvHF7/uja6GCRbMQHJlEDtcLZFBR
	 bBqsTOILPojBkbqP9c5uFYFLXwvDa2XYT2SFUMxRTuB6ZQzLNkssif/6urHzHO00fk
	 Skgn+ptvjMSTS3VMBezq8yREZJPVwbZdc9I441ADP3crdeclpWj7HnR60MZ9kaBb89
	 e8j26jTotaK2A==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5be4d648aacso1063528e87.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 08:39:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByTnBz1BfDUdRBZR533RvPcC0kXx8fCeECK2UmGeWicFGkSje6KstyUmnWI00B0PlPqgu8vmeqbllBhFv0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYK95t2uMK3Jz2PjLMgOKnv4lbqJ4S86bP67U+fZIr0dJsrZkeB6
	Vbs7/kMfUtbcmyPLbHVdM5K7C5GN5qEjg0QgQ4nXxY8u2lLfcoKlWYl3Zbs3G+ftMoiOBl3BH0L
	5HW0mpgWqK1YltCgUyq4DEeyllhJLm4s=
X-Received: by 2002:a05:6512:33cb:b0:5bf:ba43:f2f1 with SMTP id
 2adb3069b0e04-5bfcad8c081mr1232361e87.34.1793201988873; Wed, 28 Oct 2026
 08:39:48 -0700 (PDT)
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
 <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com> <CAP-5=fWVZ=7-qDRODiEQzRzhpQqribv9Morj=OoAXW_6uaW2dA@mail.gmail.com>
In-Reply-To: <CAP-5=fWVZ=7-qDRODiEQzRzhpQqribv9Morj=OoAXW_6uaW2dA@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 28 Oct 2026 16:39:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i0YoOW+ueh_aZJdYVS0etuCqfrf_S0NTKzCE9_6oKxPQ@mail.gmail.com>
X-Gm-Features: AclHuK-jtq7opXKWd_89haXf76RntnjsmSewB7PcsqPK44QRbhInXeBo-GT0LQw
Message-ID: <CAJZ5v0i0YoOW+ueh_aZJdYVS0etuCqfrf_S0NTKzCE9_6oKxPQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
To: Ian Rogers <irogers@google.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Kees Cook <kees@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
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

On Wed, Oct 28, 2026 at 4:36=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Oct 28, 2026 at 4:39=E2=80=AFAM Rafael J. Wysocki (Intel)
> <rafael@kernel.org> wrote:
> >
> > On Tue, Oct 27, 2026 at 11:39=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > Export cpufreq_dbs_data_release() and set .kobj_type.release statical=
ly
> > > in the ondemand and conservative governors so their gov_attr_set
> > > kobjects have a valid release callback statically initialized, matchi=
ng
> > > cpufreq_governor_dbs. Remove the redundant runtime assignment in
> > > cpufreq_dbs_governor_init().
> > >
> > > This prepares for annotating struct kobj_type::release with
> > > __must_init.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Do you want stuff to be picked up by maintainers, or do you want to
> > route it yourself?
>
> Hi Rafael,
>
> Just a quick note: I agree with Zhongqiu's feedback and the commit
> message needs a fix.
>
> Regarding merging the patches, the issue with maintainers picking up
> fixes is that the series will break the clang/llvm build without them.
> So the maintainers need to either merge the patches (and the series be
> rebased on top of them) or merge the series as a unit. Perhaps since
> the patches align, merge conflicts won't happen, so maintainers
> merging and landing the series is okay. I don't have the experience to
> know.

I'd expect the driver core to pick up the series as a whole then, so
please feel free to add

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org> # cpufreq

to the next version of this patch.

Thanks!

> > > ---
> > >  drivers/cpufreq/cpufreq_conservative.c | 5 ++++-
> > >  drivers/cpufreq/cpufreq_governor.c     | 4 ++--
> > >  drivers/cpufreq/cpufreq_governor.h     | 1 +
> > >  drivers/cpufreq/cpufreq_ondemand.c     | 5 ++++-
> > >  4 files changed, 11 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq=
/cpufreq_conservative.c
> > > index 02bfd46543e9..146a2353b1a2 100644
> > > --- a/drivers/cpufreq/cpufreq_conservative.c
> > > +++ b/drivers/cpufreq/cpufreq_conservative.c
> > > @@ -318,7 +318,10 @@ static void cs_limits(struct cpufreq_policy *pol=
icy)
> > >
> > >  static struct dbs_governor cs_governor =3D {
> > >         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
> > > -       .kobj_type =3D { .default_groups =3D cs_groups },
> > > +       .kobj_type =3D {
> > > +               .release =3D cpufreq_dbs_data_release,
> > > +               .default_groups =3D cs_groups,
> > > +       },
> > >         .gov_dbs_update =3D cs_dbs_update,
> > >         .alloc =3D cs_alloc,
> > >         .free =3D cs_free,
> > > diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpu=
freq_governor.c
> > > index f3bd3dbe7c41..f8b5aca09b6b 100644
> > > --- a/drivers/cpufreq/cpufreq_governor.c
> > > +++ b/drivers/cpufreq/cpufreq_governor.c
> > > @@ -419,7 +419,7 @@ static void free_policy_dbs_info(struct policy_db=
s_info *policy_dbs,
> > >         gov->free(policy_dbs);
> > >  }
> > >
> > > -static void cpufreq_dbs_data_release(struct kobject *kobj)
> > > +void cpufreq_dbs_data_release(struct kobject *kobj)
> > >  {
> > >         struct dbs_data *dbs_data =3D to_dbs_data(to_gov_attr_set(kob=
j));
> > >         struct dbs_governor *gov =3D dbs_data->gov;
> > > @@ -427,6 +427,7 @@ static void cpufreq_dbs_data_release(struct kobje=
ct *kobj)
> > >         gov->exit(dbs_data);
> > >         kfree(dbs_data);
> > >  }
> > > +EXPORT_SYMBOL_GPL(cpufreq_dbs_data_release);
> > >
> > >  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
> > >  {
> > > @@ -488,7 +489,6 @@ int cpufreq_dbs_governor_init(struct cpufreq_poli=
cy *policy)
> > >         policy->governor_data =3D policy_dbs;
> > >
> > >         gov->kobj_type.sysfs_ops =3D &governor_sysfs_ops;
> > > -       gov->kobj_type.release =3D cpufreq_dbs_data_release;
> > >         ret =3D kobject_init_and_add(&dbs_data->attr_set.kobj, &gov->=
kobj_type,
> > >                                    get_governor_parent_kobj(policy),
> > >                                    "%s", gov->gov.name);
> > > diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpu=
freq_governor.h
> > > index 806d8fb4dff1..1026712bb79b 100644
> > > --- a/drivers/cpufreq/cpufreq_governor.h
> > > +++ b/drivers/cpufreq/cpufreq_governor.h
> > > @@ -150,6 +150,7 @@ static inline struct dbs_governor *dbs_governor_o=
f(struct cpufreq_policy *policy
> > >  }
> > >
> > >  /* Governor callback routines */
> > > +void cpufreq_dbs_data_release(struct kobject *kobj);
> > >  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy);
> > >  void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy);
> > >  int cpufreq_dbs_governor_start(struct cpufreq_policy *policy);
> > > diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpu=
freq_ondemand.c
> > > index 9942dbb38dae..7386d043c665 100644
> > > --- a/drivers/cpufreq/cpufreq_ondemand.c
> > > +++ b/drivers/cpufreq/cpufreq_ondemand.c
> > > @@ -374,7 +374,10 @@ static struct od_ops od_ops =3D {
> > >
> > >  static struct dbs_governor od_dbs_gov =3D {
> > >         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("ondemand"),
> > > -       .kobj_type =3D { .default_groups =3D od_groups },
> > > +       .kobj_type =3D {
> > > +               .release =3D cpufreq_dbs_data_release,
> > > +               .default_groups =3D od_groups,
> > > +       },
> > >         .gov_dbs_update =3D od_dbs_update,
> > >         .alloc =3D od_alloc,
> > >         .free =3D od_free,
> > > --
> > > 2.56.0.313.g2479322e68-goog
> > >
> > >
>

