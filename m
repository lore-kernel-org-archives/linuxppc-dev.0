Return-Path: <linuxppc-dev+bounces-20798-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 124B2CD343F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 00:58:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFZnv2F0qz2xrC;
	Wed, 13 May 2026 10:58:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::122f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778633891;
	cv=pass; b=oGOa3Wsg6tVqLLlQ081E3H+Y3pHpqiqL5w7aRcj/pYVaynul1lcxgfmNw0MdGdSEpVsTG3NlzyAwfxt9zzG0OYdRa4RcLMy/umLlJ/L1xEFJvphi6fYS0G16vCXyqKvv47n0qfjonc6QAg1L+7Op/yIq7epD1OBnxtkAz1kA5P/6xwioZZU11v+ILaimNpBoRs1jynKBpzUA77Ru/kUeKG3AWahq3xwZnbvRxb1PIZWYGjiN3CTyFyoh2ROBeiPn2cetvNuV4LOVccij8JgfSyzyXD3d0z2fG0WGIw8L+teoFX8UaEw7wNRh8cRRZIdZn6fTN7Y7BepC/NHJlzUGOg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778633891; c=relaxed/relaxed;
	bh=LRO2poXnMaPTIgvnZ9fKozT82zPK5BjJ+UF96zATU5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7vRsZ4rg3KREPGnhLxyzyqP6QKpi+NjM6DV/VmZ2Q8suJ3kxLCvNMfa/pTOT8L0mjqUrTzyFlaeFKUSTz2WDlCNEuXcTyvl/VGSK8p2Nrrr6XWt+3kLjJymVcESkBKviEDCiD85WbkPSohQ+IxhrGRt+cz1cyWKnBMntWC5Ih9mOXZZF+69hb6J1ACSo3b2UohzWgkhs6HoXpGKGbvG2QCy2lYjgGIC0EpZss+ZF/MKNL27Czbv61XVaPndHgZXH9gpDy+bjYZCmV4GMznVqzIOG2mOHFVKlesIDRzi0WlbX420K/RG3Yt8u/Udj/iiJp1B3Jgi4PxH3STXMaO9ZQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=h8mSu9DL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=h8mSu9DL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com [IPv6:2607:f8b0:4864:20::122f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFZnt0Sjkz2xpt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 10:58:09 +1000 (AEST)
Received: by mail-dl1-x122f.google.com with SMTP id a92af1059eb24-1336742714fso104c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 17:58:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778633887; cv=none;
        d=google.com; s=arc-20240605;
        b=JAnXVxSzNKokdzHmWCnrUJcao0Xm1GYJ/Nz3SaJ+VBGYCJyhCTaOqt9dHloEdfe2QA
         Kq4g/rm+dTjcvNXnFWU+eRRluCXTRBAyJijBuAWiu8s+c06p29hxw/pXsWzr9u9iNCMI
         sVGH0/sUe7rvfklSNLkK9zazqIGPrQwLjjcRb9LL1OCV9h8A5MpQX7YlQ7Wxnr0dQ6BE
         /7qKPF96k/oJ1RhaLgR6WGU5wd1AQHrubDt+UVeWcI7S8zXVjDh+MyrLBsCdJUcl74EC
         uZbwvq0QpJBVYUEQyQNqi4SmqfZ+Drl7Ls12ltxNC13ZUJBDeeabqMhmehd0ObTCpsKT
         Tsaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LRO2poXnMaPTIgvnZ9fKozT82zPK5BjJ+UF96zATU5U=;
        fh=nwNZAm1xrI0UgjfgOBrVvgQw/Y2ZV4Ajgl2qmNAbjdM=;
        b=b6yB6RLmNNBSIAaFT1LVlG0R1i6x2LYVymDvYQC1RuJEACL5Xj2wv3N5BLUUJBSh4W
         FY3k3aJlg3X4uvWmmKMcET2Btnq5ziEITxEniR2caEbjHaAfiClsI5MofoyDIx820qG1
         Rvf8uL/K99cy3suAQKCd0gONNMl0FNOAqS//9HrLhd50OLM+KFOdQzu52xUDhV+uFgWw
         CdOnHe5qqZvfNj6YwIoPthuvtE0HrMpUwb4hqJebV2+ujCCtPOV7AaI5AOupn6EjXL4T
         JO5IKa66QnSjGfl80SiBGqhgkQd/0lUHZXsI4g1G60IwtISSeFiIY4En/VN7+9OE4xfX
         HGCA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778633887; x=1779238687; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRO2poXnMaPTIgvnZ9fKozT82zPK5BjJ+UF96zATU5U=;
        b=h8mSu9DLKR1Gflk4kAO60dxaBgVIUxQi5lpsjks1DeFlpOqupXK6yTpLdHPsiC+4E6
         yQUhIXV/LPHSEYi7uVALiW3r/i+oWsf9IxVlbHhL2CLtP7X4RmecEJDvkSX3q+dTLb63
         3Shs2IYyaJe2ltGiqz5HhufX1wYYhfdK+hBCNF6tkq7KeMwBTbxJnUQVOw7vImSIGSbq
         u9RHblWhyx5N12Rde7KP/SUbbVlKidCdvFirNp8Ez10vB1vHLqBfk60Vi9za7PcFj7lE
         QTOBdd0UcNkUlFNuu577Pdh/X7swT/Xo21ppUECJhTv+8yeS3cdw07bdr4h6ifF1QG1G
         mPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778633887; x=1779238687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LRO2poXnMaPTIgvnZ9fKozT82zPK5BjJ+UF96zATU5U=;
        b=UQXIfcSHQLplLbi+mqL0pEALC0ZeLJ0FR4OlyIkY6MFJaZDj52PYYhstw/A6EeIIZ2
         AU/0Hgy4ufQDpU6g/X8IrEfYrE1wQIZfZZrKGmzaZXZgp/gIXkk1AW6ZlPjRlqA2w4sT
         qJJ7eJ4TqDmn9Cf9joCMOH93QS2cbid1eomxqqDZd5doX3gWhqAHG1GjrtXc4hMftJLx
         M6+JxITyoeFD4G9bo5V5J0F/64whpw4nYBLddO+/XwNzQhG2wWt8oRr5/Hi28UvF9Tj6
         h9eXRiXZG97xH25/MEUsOe8SkyW/Kyy1oaZFj6YiJncrkH/p0PWnmHx0kIG65HebV5IZ
         x7AQ==
X-Forwarded-Encrypted: i=1; AFNElJ+NSTN7eajMDU1d6/av9PXPq+48Hd2EvNgXc48h699TxmKutdkSFzs8UleAyPfDHp7xoORaw0ETFaDihgU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwpoqV+fvR8XuWbX5ScjPkKTtGsqqHrt9Q8nyG1jUpqldViesWG
	zcKdptW4cjqYlbwnV1sJtjVRhp5O8JHf0RLkxEW6F/NYMwXiHkCzH3v4q1vyrbISDyAGZ0P5KrQ
	BktjSnVXnaTEgUYgNuLHYBchVzfBhZ9AVDQpfAof6
X-Gm-Gg: Acq92OGtLxVnEp2ntU+rS6z2sRvKMvPrd/C5BpjbgLHSZHjx/ZtEugKQdj9cdk2Nhnv
	wW8X08Og1rD70gv8VICpcT9wKGXlvUCrJjMruLGkag8kvsCmHsABGzf6bwdj2pTevjeCdOZF8Hk
	/wYR0sxFtnk7lM78CUj2QpB1THyrwbnqXIxWNZCqW1tVJCpYX/W+Vs2nQOTD9XOntxV0EMbannS
	PEhEqYi/8mbbCQrDxICOj3m+QvCEvZUb2FysbiY8jGZYK8I5Poj57d6e3LJMh73lcTFIsSL+0Rf
	gCNAT3c5uRbVWo8Ca5U=
X-Received: by 2002:a05:7022:6086:b0:130:5c2c:d255 with SMTP id
 a92af1059eb24-13489daa204mr50475c88.21.1778633886492; Tue, 12 May 2026
 17:58:06 -0700 (PDT)
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
References: <20260504154205.21394-1-atrajeev@linux.ibm.com> <0FE86BD2-554C-402C-80A2-C8F86FC2F685@linux.ibm.com>
In-Reply-To: <0FE86BD2-554C-402C-80A2-C8F86FC2F685@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 May 2026 17:57:53 -0700
X-Gm-Features: AVHnY4Iu_AOdMqdqvEdJ7IC4E2i6EdbXj_msN7yrwjVaC2EmP4ZJe5hojHarpTc
Message-ID: <CAP-5=fXeZxvikfUf5--Zc7bNBDu7gs27sRj4WoGAyQPJ79mq=Q@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] tools/perf: Fix the check for parameterized field
 in event term
To: Venkat <venkat88@linux.ibm.com>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>, acme@kernel.org, jolsa@kernel.org, 
	adrian.hunter@intel.com, mpetlan@redhat.com, tmricht@linux.ibm.com, 
	maddy@linux.ibm.com, namhyung@kernel.org, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com, 
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 1:53=E2=80=AFAM Venkat <venkat88@linux.ibm.com> wro=
te:
>
>
>
> > On 4 May 2026, at 9:12=E2=80=AFPM, Athira Rajeev <atrajeev@linux.ibm.co=
m> wrote:
> >
> > The format_alias() function in util/pmu.c has a check to
> > detect whether the event has parameterized field ( =3D? ).
> > The string alias->terms contains the event and if the event
> > has user configurable parameter, there will be presence of
> > sub string "=3D?" in the alias->terms.
> >
> > Snippet of code:
> >
> > /* Paramemterized events have the parameters shown. */
> >       if (strstr(alias->terms, "=3D?")) {
> >               /* No parameters. */
> >               snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->na=
me, alias->name);
> >
> > if "strstr" contains the substring, it returns a pointer
> > and hence enters the above check which is not the expected
> > check. And hence "perf list" doesn't have the parameterized
> > fields in the result.
> >
> > Fix this check to use:
> >
> > if (!strstr(alias->terms, "=3D?")) {
> >
> > With this change, perf list shows the events correctly with
> > the strings showing parameters.
> >
> > Before the fix:
> >
> > # ./perf list|grep -w PM_PAU_CYC
> >  hv_24x7/PM_PAU_CYC/                                [Kernel PMU event]
> >
> > With this fix:
> >
> > # ./perf list|grep -w PM_PAU_CYC
> >  hv_24x7/PM_PAU_CYC,chip=3D?/                         [Kernel PMU event=
]
> >
> > Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > ---
> > Changelog:
> > v3 -> v4:
> > Updated commit message to show real example
> > addressing review comment from Namhyung.
> >
> > v2 -> v3:
> > Split the strstr correction in a single patch
> >
> > tools/perf/util/pmu.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 23337d2fa281..0b8d58543f17 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -2117,7 +2117,7 @@ static char *format_alias(char *buf, int len, con=
st struct perf_pmu *pmu,
> >   skip_duplicate_pmus);
> >
> > /* Paramemterized events have the parameters shown. */
> > - if (strstr(alias->terms, "=3D?")) {
> > + if (!strstr(alias->terms, "=3D?")) {
> > /* No parameters. */
> > snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->nam=
e);
> > return buf;
> > --
> > 2.47.3
> >
>

