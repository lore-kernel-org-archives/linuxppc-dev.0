Return-Path: <linuxppc-dev+bounces-27448-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9117BC88E77
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 22:51:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hky181Jk0z2xk7;
	Wed, 16 Sep 2026 08:51:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:34::10" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789512668;
	cv=pass; b=FMPG3ijCAXlmErf3efY8fXaAqoGU6ZMu/WwtqpjdQ+MSrDGgb2Hl5Zn3kqX02xJlyaE3+hmrR7oyrtF4vb5ka5mlkk444QosScf+qqDSSzoNFMsymfxdOGeUI9YVz8vm8KA/q1eck0wtHSfqEM7cS+0O9Uq7j4n6DQR4ueB3TfzggDPPZPhdp2B3tluC7Z5Zvvi0pecdMWNzS3knGc1FEud+iPKGTXEt3x5KL9pK/e5BGI/KQIPZCpTyvt/SiPDHkUaEMwaCI1668sFw0HQyv5dl+rsoXkyTeY8TW8NabedWhzMY8kOvlj4ntL3FMN3poC4OHUDpXfs3N93n3NfCXw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789512668; c=relaxed/relaxed;
	bh=ZKEkKJX+O5Pp8TO5M7RsAkjvIvMbh2UUfAikiOt0jdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5KJimVdtNHcaLkohg/Fn6Io0nC4bbrwxRbIdjGrBtsYJ9H1sEY/uKY/D/LVXlSIc3J9iJ/RJvacfJfwd+R5bT7JwdOt/aT8K+0l+Cnyqpd8BwOb/HPV36pK6ggOcMSVzR9Jcpj2gBfmgyBdy6lkN6ifC+U/fO9IzF83B6Jg6UveE108Or/4rTGghKqZz6uY1eLzdQmP08FS03TRNCU5jbvo/rE21FGYOkPQIaDbnOwhxarN6ySVX4VYFnLOS1njQAh21+EFWfkafOt3VG9fCc60HmGktpZNd94ruYxKH/rvAZ/6rzM3SpgQUd+RguerMShJtg1w6936Q/vUXkrf3Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=c6pX0JP2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:34::10; helo=mail-qk2-x10.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=c6pX0JP2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:34::10; helo=mail-qk2-x10.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org)
Received: from mail-qk2-x10.google.com (mail-qk2-x10.google.com [IPv6:2607:f8b0:4864:34::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hky160FGDz2xft
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 08:51:05 +1000 (AEST)
Received: by mail-qk2-x10.google.com with SMTP id d75a77b69052e-530d5fc2cd8so44331cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 15:51:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789512663; cv=none;
        d=google.com; s=arc-20260327;
        b=QroFeGWF37Iq3uprd1MCwJ8l4+U4W4vYgYj1BS38Zj2KrsRRv8I8wIPRXftMpYqrAv
         /5WfYHlwbKQ/62UOr/nUg+BGb5Jp4M6OhZSnhjZY697V82/fxGa4zz9ZlHpy8Ex13gfs
         lfHVYlhRyiwIgq9usqKrTmyJhNMkNSb0oKqqqZBljq/XDiJX4zbv+wixrVp5vxYoLzqL
         cW1raFvIJApSG/+2fczHNATl+MCCRNQZyCnpq/So+3/B/JA8MSF8oG4AOWPqRApzYJ9H
         TV3xfCWc1XSuIb0yZ+ufqVrYpyvyyIV78+DDPXSKLOcJlCfF+Sh1FsVv7wHIchGT0g+H
         UeKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZKEkKJX+O5Pp8TO5M7RsAkjvIvMbh2UUfAikiOt0jdE=;
        fh=cDPMYCCLpD6kYqczaKWOfdWtHAHjPOxmwyOuHzoxUww=;
        b=Scu/msWjlEosn1CwcceMVe/ARVXBfGUPX0OAyvixUUvpXhShud71T+QOOIvTEzXpsl
         d+OJWsFegLIStsQtUjViYKo2vFj5WBURzM2nC9UStj72OBX+7WYbv3EURELocS6j69Y2
         ugCpUze9vZGvxq0ChPmO6lgtGiC4RGmRuABYoRm0kMo3FbB+ZEl1Y/s0RurGuGCYQxxM
         O0Rt0zNXQ2A8gQCN/7l4C1R/mleYtNhp9YwOhJNEUZjFf0TM6moDaJeiDy8/IribKasD
         GPBW4prN7vgGnN/0vz3QTSl3n5hGz4GlInhCmTZ0ms0FaCkcRCqoOuwLgtxCncM7TeUt
         FJeg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789512663; x=1790117463; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZKEkKJX+O5Pp8TO5M7RsAkjvIvMbh2UUfAikiOt0jdE=;
        b=c6pX0JP2M8CfvD/ATX4ZHO5XmvnV0w/XRqkt1jQFzcn7o2tzelc4hPKWKU5wRGP7Rd
         n+Kj1xPKy8TF1N5LMgBRBQx5Wgb0Av+6TNCiSAQrPgoocwEdJ286iJwob3Wp4jD493f4
         8zInan0hopOie3CATnPgSY4G74Eevj5VW1Jl8ZXSkY8ug9EKwWV993b5RwHJBMaPhj7l
         DyziYzz9DmuE82GO4re53PmeitXQi9Fdvfpv58vivsWNy5gtV5eLMETV5y7mtCyJ9Ika
         7GzzwnMUq06gfxQZU9SkDTh89YjEZY8ThGxLKVqzrfF4ZXrxPmf6cGQGnnEX79NXZHIU
         JLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789512663; x=1790117463;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZKEkKJX+O5Pp8TO5M7RsAkjvIvMbh2UUfAikiOt0jdE=;
        b=XoGYQ0ZxJxLViWI3r1Cd2RTuZ2F31Ht8JhqQGKVNlyA3j8VSjfjAgZLOvJfIwejp+f
         qnyh2Hme+zrRvI8LYCe6wfftURcod7dhY5PhqaQ9DpUU1ANtOax41cJ2pDjWJLpfxwqt
         K4Zag/zOm8+T2SiLjkQuP/PKFlNeBRgjkkxRYYUuXlKDX+Sla/1ACZHFY/9BqJtNySm2
         eJpuGgbacVYe9W6HW3yYMcSIYkfa2xr5a1X8ooeJ0vXgwSzy/KpRjQj1kpPLs67wEwAt
         0LB1SODHOXs6Ejm8bmTs4xJQmUh7aopZ4SsYKYpGlR5YT6qGZtvfGkpPwebYg83sz0Dn
         QyjQ==
X-Forwarded-Encrypted: i=1; AKwUvByTL7nxZegWQe3c1ovEtpN9TqMIWkwIO+LxYfk6Bp259iUhPADQUv7S78IospzwJVU69NsftxEeKqADFHA=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kCu17k/O2Yw7yWIhduLU5rQ5utpOjt7vbgNo/9vjqWBwVuQiGE
	sEav7zZYKIbxbcex7pH9eIHv6WAKy/GpQfWB3tg4oiCv6hM0TH56cSZpuEHYFmIQ+q81dKA4avg
	DZExmKBdkA3eQFZe04VwnOO9KI3/gLF4iJPop/SbN
X-Gm-Gg: AYBFou0pW7s+dzCMAT2833+1vI9YqP/yBIlqOj7gPWGwsHqFHusrhgUo5tRwmdznZoU
	HZqqexA1OVXI+n/D0bLjEWNkMG91RRUh5dQDz818P1e+52eBX4csjlw9Pri2LqzoxqZ42oMHgnS
	poOpn6IrYDTAMRv/7orfxGN9ve6E9ET2aa5fIB227xaDPNYclCD+adtKFpzsmHrppVW8VyyqB+v
	2NeLIPxuJxo/5uaLqNRvWylbHrwSYuPN8FFa7DLfmoMEnD/6ukbsEDjF7gcFHPRMa6Omla1ea+j
	SOREOTBK0I6OvrTUG54QJ3/E6CTWv/lBJAzTHrUXmlDa35sUwz+LUvFoxZOhBg0amv/COzww7ya
	4HP+tiN16OiZ0UP8OWo/c
X-Received: by 2002:a05:622a:8c9:b0:531:475:4ce6 with SMTP id
 d75a77b69052e-5327e6ace28mr2653721cf.9.1789512662755; Tue, 15 Sep 2026
 15:51:02 -0700 (PDT)
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20260422173545.73144-1-atrajeev@linux.ibm.com>
 <e6358476-d85a-441e-97e9-80abc9e1dee6@linaro.org> <E2E0C2AA-F6D5-427C-92DB-47777491C76D@linux.ibm.com>
In-Reply-To: <E2E0C2AA-F6D5-427C-92DB-47777491C76D@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 15:50:50 -0700
X-Gm-Features: AcwNN1XIZQl_Fcu5tzKsnk-K7Y_YYEuB6djG-D7hw48Py--fqNBKrneI5cYHQXs
Message-ID: <CAP-5=fV+NMfCNFFLnsySOoKnrE6c3TCJhO+BhZkbKjHitRD8Ag@mail.gmail.com>
Subject: Re: [PATCH] perf sched: Fix crash in sched stats diff due to
 uninitialized perf_data structure
To: Venkat <venkat88@linux.ibm.com>
Cc: James Clark <james.clark@linaro.org>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, 
	Shivani.Nittor@ibm.com, acme@kernel.org, jolsa@kernel.org, 
	adrian.hunter@intel.com, mpetlan@redhat.com, tmricht@linux.ibm.com, 
	maddy@linux.ibm.com, namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 3:07=E2=80=AFAM Venkat <venkat88@linux.ibm.com> wro=
te:
>
>
>
> > On 24 Apr 2026, at 2:57=E2=80=AFPM, James Clark <james.clark@linaro.org=
> wrote:
> >
> >
> >
> > On 22/04/2026 18:35, Athira Rajeev wrote:
> >> perf sched stats diff fails sometimes with below logs:
> >>  # perf sched stats record ls
> >>  # perf sched stats diff
> >>   *** invalid open64 call: O_CREAT or O_TMPFILE without mode ***: term=
inated
> >>   Aborted (core dumped)
> >> Also in some runs, perf sched stats tests fails
> >>  ./perf test "perf sched stats tests"
> >>  92: perf sched stats tests                                          :=
 FAILED!
> >> =3D=3D172375=3D=3D Conditional jump or move depends on uninitialised v=
alue(s)
> >> =3D=3D172375=3D=3D    at 0x10393BD0: open_file_read (data.c:264)
> >> =3D=3D172375=3D=3D    by 0x10393F63: open_file (data.c:317)
> >> =3D=3D172375=3D=3D    by 0x10394067: open_file_dup (data.c:334)
> >> =3D=3D172375=3D=3D    by 0x103942DF: perf_data__open (data.c:379)
> >> =3D=3D172375=3D=3D    by 0x102F7CAF: __perf_session__new (session.c:16=
9)
> >> =3D=3D172375=3D=3D    by 0x100B5E63: perf_session__new (session.h:116)
> >> =3D=3D172375=3D=3D    by 0x100D5D37: perf_sched__schedstat_diff (built=
in-sched.c:4568)
> >> =3D=3D172375=3D=3D    by 0x100D7D6F: cmd_sched (builtin-sched.c:5061)
> >> =3D=3D172375=3D=3D    by 0x1010231F: run_builtin (perf.c:348)
> >> =3D=3D172375=3D=3D    by 0x1010262F: handle_internal_command (perf.c:3=
98)
> >> =3D=3D172375=3D=3D    by 0x1010286F: run_argv (perf.c:442)
> >> =3D=3D172375=3D=3D    by 0x10102C67: main (perf.c:549)
> >> =3D=3D172375=3D=3D
> >> =3D=3D172375=3D=3D Conditional jump or move depends on uninitialised v=
alue(s)
> >> =3D=3D172375=3D=3D    at 0x10393D20: open_file_read (data.c:282)
> >> =3D=3D172375=3D=3D    by 0x10393F63: open_file (data.c:317)
> >> =3D=3D172375=3D=3D    by 0x10394067: open_file_dup (data.c:334)
> >> =3D=3D172375=3D=3D    by 0x103942DF: perf_data__open (data.c:379)
> >> =3D=3D172375=3D=3D    by 0x102F7CAF: __perf_session__new (session.c:16=
9)
> >> =3D=3D172375=3D=3D    by 0x100B5E63: perf_session__new (session.h:116)
> >> =3D=3D172375=3D=3D    by 0x100D5D37: perf_sched__schedstat_diff (built=
in-sched.c:4568)
> >> =3D=3D172375=3D=3D    by 0x100D7D6F: cmd_sched (builtin-sched.c:5061)
> >> =3D=3D172375=3D=3D    by 0x1010231F: run_builtin (perf.c:348)
> >> =3D=3D172375=3D=3D    by 0x1010262F: handle_internal_command (perf.c:3=
98)
> >> =3D=3D172375=3D=3D    by 0x1010286F: run_argv (perf.c:442)
> >> =3D=3D172375=3D=3D    by 0x10102C67: main (perf.c:549)
> >> The valgrind logs and error message from the logs points to
> >> below snippet:
> >>      static int open_file_read(struct perf_data *data)
> >>      {
> >>             int flags =3D data->in_place_update ? O_RDWR : O_RDONLY;
> >>             struct stat st;
> >>             int fd;
> >>             fd =3D open(data->file.path, flags);
> >> The "struct perf_data" is defined here :
> >>     static int perf_sched__schedstat_diff(struct perf_sched *sched,
> >>                                       int argc, const char **argv)
> >>     {
> >>         struct cpu_domain_map **cd_map0 =3D NULL, **cd_map1 =3D NULL;
> >>         struct list_head cpu_head_ses0, cpu_head_ses1;
> >>         struct perf_session *session[2];
> >>         struct perf_data data[2];
> >>         int ret =3D 0, err =3D 0;
> >>         static const char *defaults[] =3D {
> >>                 "perf.data.old",
> >>                 "perf.data",
> >>         };
> >> Here due to uninitialized "struct perf_data", the arguments to "open"
> >> is getting wrongly passed sometimes depending on value in stack.
> >> When perf_data__open() function calls open_file_read(),the
> >> "in_place_update" could contain garbage value.
> >> After initializing "struct perf_data" in perf_sched__schedstat_diff() =
function,
> >> perf sched stats tests runs without issues in multiple attempts and al=
so
> >> "perf sched stats diff" ran individual without issues.
> >> for i in {0..20}; do ./perf test "perf sched stats tests"; done
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >>  92: perf sched stats tests                                          :=
 Ok
> >> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> >> ---
> >>  tools/perf/builtin-sched.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> >> index 555247568e7a..5d2740099eed 100644
> >> --- a/tools/perf/builtin-sched.c
> >> +++ b/tools/perf/builtin-sched.c
> >> @@ -4538,7 +4538,7 @@ static int perf_sched__schedstat_diff(struct per=
f_sched *sched,
> >>   struct cpu_domain_map **cd_map0 =3D NULL, **cd_map1 =3D NULL;
> >>   struct list_head cpu_head_ses0, cpu_head_ses1;
> >>   struct perf_session *session[2];
> >> - struct perf_data data[2];
> >> + struct perf_data data[2] =3D { 0 };
> >>   int ret =3D 0, err =3D 0;
> >>   static const char *defaults[] =3D {
> >>   "perf.data.old",
>
> Tested this patch by applying on top of linux mainline kernel and it fixe=
s the issue.
>
> WithOut this Patch:
>
> # ./perf sched stats diff
> *** invalid open64 call: O_CREAT or O_TMPFILE without mode ***: terminate=
d
> Aborted (core dumped)
>
> # ./perf test -v "perf sched stats tests"
> --- start ---
> test child forked, pid 11151
> Basic perf sched stats record test
> Basic perf sched stats record test [Success]
> Basic perf sched stats report test
> [ perf sched stats: Wrote samples to /tmp/__perf_test_sched_stats.perf.da=
ta.dysu3 ]
> Basic perf sched stats report test [Success]
> Basic perf sched stats live mode test
> Basic perf sched stats live mode test [Success]
> Basic perf sched stats diff test
> [ perf sched stats: Wrote samples to /tmp/__perf_test_sched_stats.perf.da=
ta.dysu3 ]
> [ perf sched stats: Wrote samples to /tmp/__perf_test_sched_stats.perf.da=
ta.p0lnk ]
> *** invalid open64 call: O_CREAT or O_TMPFILE without mode ***: terminate=
d
> /linux/tools/perf/tests/shell/perf_sched_stats.sh: line 67: 11170 Aborted=
                 (core dumped) perf sched stats diff "${perfdata}" "${perfd=
ata2}" > /dev/null
> Basic perf sched stats diff test [Failed]
> ---- end(-1) ----
>  92: perf sched stats tests                                          : FA=
ILED!
>
> With This Patch:
>
> #
> for i in {1..20}; do
>     ./perf test "perf sched stats tests"
> done
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>  92: perf sched stats tests                                          : Ok
>
> Please add below tag.
>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Regards,
> Venkat.
> >
> > Reviewed-by: James Clark <james.clark@linaro.org>
> >
> > I had a quick look for other instances of the same thing and didn't see=
 any.
>
>

