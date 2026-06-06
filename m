Return-Path: <linuxppc-dev+bounces-22153-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE28CD8C88
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Jun 2026 15:47:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gXjPR0588z2yRM;
	Sun, 07 Jun 2026 01:47:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::630" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780760874;
	cv=pass; b=W+ETekJY3jyFHZ4Qd6dshdhpvd2sdMmAiPd8rloW0o9VXxPFzKKMnKFT+00+PndpCtI1oSqmEJOK03FzfjZvXwwppKPoMJ8zGsiWCeAX5+SKaAToz9p3cb8ZIrDLXm6ZSPyLSRjTJfeMnTOaGah5hkIgyrq8L8NEVUq7ecJ4wiTMfGevMd2kONr/224zhxppvNMZvQ6XsgguFEAAlZufWk4YJbpjWghenRjdoCBwwcGpssMriGFqWbj3k7tsldvPhLFFq/vPvB+/xko3vtpxM0xBP4wVzBlVohjxBy9+4yjPje2xnpr7TckZ4zBmJnKqlCjZ10X7XlbsKRn/KMOaaw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780760874; c=relaxed/relaxed;
	bh=5GJqqoNLqYQ4v0lJXutWeKyal4BUzmhJxcxqQU5UVJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SgjiyFstcR/SMT+qXwNP4/BIbjKSUEEI0KzgRAVkyDi/eK0w/W97HlPMjXaxhuq7LiuUPovJ5qkb7hUJlgUUNy3J/gBvpHjcnFjfh4DvYKfKYROKBL8dexKcto2O3e/21/vJWJgGdANmoR6awsIMcojU7vdilPaT4eIaj/32ODTlGXiBTJrO7JF30sHpb61qUcKVnDi1GtlKzgdEI4UFBMU9MLvejwY4jTCTeX6S+TfHk4wZikMjMuMTaVwZeAUxHP77EpwpVRRwMnbthjOfsfKo1PanOZFGU1Z6CIZmhf2RTn50UdCfZ2Ew+hBhxy2KZBAKAwa51jDYG3gI3nmyyw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RMDdkIaO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RMDdkIaO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gXjPP00J2z2xHF
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Jun 2026 01:47:52 +1000 (AEST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2c0b1a48855so218485ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jun 2026 08:47:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780760870; cv=none;
        d=google.com; s=arc-20240605;
        b=fb+NL01DQv/RLYJkBPBJFDG4HAGZ6ItBvGKfuNX/O0USOY7eflv0bB3//axR79gMPl
         twBIfccVHE0Jq4Eh5oSzgoh51qkYQCiWYP+FnstppLTkC8s8W8p5opwdiX7J5lMO6v/c
         cTosE2TrUO8lt80eKeUkUUNdlUquChkuI+bxDio77E0HM1rnvg57QgI6RC4isfRigSUl
         9CxL8An2Z6Oxb/FOY70SfG5PcICEGgNUW+qW+ctRgSvj49toTup/4Ht0ULfQyaOqzrHg
         FnZ4ONI9coivYqBkmhLHsZWecuWrareTcBb50PYdcUWvJbC83Oh83nuqQivRCQmmVxD1
         lvhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5GJqqoNLqYQ4v0lJXutWeKyal4BUzmhJxcxqQU5UVJs=;
        fh=0ZpdunZjj5bZ4GyLxgbNK5bzTTqGiIOmEcEvk1O5wKg=;
        b=ahwdkA4UrLWMENNmGIAHqtdeB2Sj/9FKjP12SW0HsVFptaYp3Nu5x2C8TOUz+GvhPd
         fohPOu/tblYyVuAxlHbnHs595Em+W3h0NDeJdY/DPQnOk9saRPQ2nF2ifeUMgOsP+Bih
         nJqwJCJrLgC5U4vPNUiR0IDtLCQQr4dDd6R3s3cQSRxi3LR/bZxuIr/gRioJXBYDsulV
         PIdstMKw9zHHja9yXME7BME6KuQ6xMOblsZX2UxAo5p7XcuyfKeyKHlFiI0osJeKDEcF
         Ga7KSkFCSIuIWj7T75X4DHWzcvi2RwENvxeOXemc/jl9c2AoXVkksigiPAvZ9+I70NH0
         pdYw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780760870; x=1781365670; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GJqqoNLqYQ4v0lJXutWeKyal4BUzmhJxcxqQU5UVJs=;
        b=RMDdkIaOCE7NfmBv3mZh0+ZnS7RxbitshKCBIUD1O/ShsPUaSc5OERrKfR1UzdCZG1
         43AYsyf/bOR31hkYQMMuz1XRd8TXUtS7tzPuTXlWznJu90owYsfjMUNjfdaPLgKF3TKm
         k7RBoHBeLH7plfkZ1LbmPvDy2TjzI5feUxAoy8Na19e06403GlWUWKS+o+LOeX+KGxf0
         zhXlI9VEszFv+0g1qk+AqQMczZOjkvtMH9vxsNKM18UcQ0gaUn+dnRmlROk4lM+9KMnA
         3yu1hfKPUpvyvwZxIEu54fDwxlt7r4MW8I/0B/q4inLaS8ivN+Zbvf1taC6Ei+KrMPLV
         Bbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780760870; x=1781365670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5GJqqoNLqYQ4v0lJXutWeKyal4BUzmhJxcxqQU5UVJs=;
        b=cjVKJL/lg5a128BXpafN6Eiek9MlnkkxaJRD0igjpOXvjHNwV3mv32411EUvhHL6pG
         vZPeUngrlFDCPcZiKmogXfXm9W0Yxb8r+IdFERTJvB5h3LHRl5j8sxm8mTsBIaE7aVT0
         s0MZpNOKhIwYRPbyBPBgozVAHPvA41n5k2lQo63Au2dkVAFaZqvBf32SPg8nlaXBjl9F
         Msnb2nFcSfxGNfFTIpo7nXE7UfpHKGE4IuR1SawSizm0W9a4tImqFWNV7W0aczx+J2WB
         +w4kGFiNhYl5ojDpVddfPvOlL1xjd16PRFqe0Mn3aM4TQPxLaiEvM2lQTV2poS0O1dnc
         YIig==
X-Forwarded-Encrypted: i=1; AFNElJ9pQNndNWwwDy5HvYuxGxWZLiyYFHc9uv84mXZHixVvWhmiRwmVFmDCOG9ZWZluNsau6FsYDVxROIZBQzM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzVzbVMr63JwLQIVNy6EFg8j5hu4zdixY+Xt1AqKoBtNkVZJE3X
	F7B0A35LEYoLevhBaA+i7NPrzTYOGCv7KOkoMIHPZy9CQRfiJJN6BMylGcEZ34gcRsdXms2MPa8
	6Ij9HaD91cADhD9RG1nSA4yvXRdw0hon2fBE0CWL8
X-Gm-Gg: Acq92OGkZHwkLBTe+w4DFNgUFF8GgxLpUKTyqfdLpiuow+O9VFwI48RDKW29IlYPdVf
	HcumL5xVGjQPfV3ofBy/s3pmYa0Co5YOHleesj7eggxwofnypIdc89MHeCnc9useKIaHLymqtcj
	oon+wB+DE8mn30guDn+qzMJlyAl5XGHdSEseYa6eC0XqGohYLaXiwpOWxdrUiRpCmAytEFDTRMn
	xFcwnMBDWouSxSBiwQn0Idl7tv1cpChGhTIr546u7RPIHYZnBM8rOTWf5yJUyYliJOAW6JoI0Eq
	eXs2ub6QLE74d1BzDGE=
X-Received: by 2002:a17:902:f708:b0:2c1:ee6e:be23 with SMTP id
 d9443c01a7336-2c1ee6ec5ebmr2669175ad.33.1780760869291; Sat, 06 Jun 2026
 08:47:49 -0700 (PDT)
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
References: <20260606121528.406919-2-tshah@linux.ibm.com>
In-Reply-To: <20260606121528.406919-2-tshah@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 6 Jun 2026 08:47:37 -0700
X-Gm-Features: AVVi8CerL-6KbYuo2zlnlU9te7dDWQC60u93ZneUxymer8R9JGeLarJSQShqAs0
Message-ID: <CAP-5=fUOUtbfXXtGdSYrg1SfuTryNqFPknKWDc=4MxK==m6+VQ@mail.gmail.com>
Subject: Re: [PATCH] perf data convert json: Fix addr_location leak on
 time-filtered samples
To: Tanushree Shah <tshah@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com, 
	maddy@linux.ibm.com, namhyung@kernel.org, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, atrajeev@linux.ibm.com, hbathini@linux.ibm.com, 
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 6, 2026 at 5:20=E2=80=AFAM Tanushree Shah <tshah@linux.ibm.com>=
 wrote:
>
> When samples are skipped due to time filtering in process_sample_event(),
> the early return path bypasses addr_location__exit(), causing memory leak=
s
> of thread, map, and maps references acquired by machine__resolve().
>
> These references must be released through addr_location__exit() before
> returning.
>
> Fixes: 8e746e95c3e4 ("perf data: Allow filtering conversion by time range=
")
> Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/data-convert-json.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-c=
onvert-json.c
> index d526c91312ed..6a8d00c80394 100644
> --- a/tools/perf/util/data-convert-json.c
> +++ b/tools/perf/util/data-convert-json.c
> @@ -177,6 +177,7 @@ static int process_sample_event(const struct perf_too=
l *tool,
>
>         if (perf_time__ranges_skip_sample(c->ptime_range, c->range_num, s=
ample->time)) {
>                 ++c->skipped;
> +               addr_location__exit(&al);
>                 return 0;
>         }
>
> --
> 2.47.3
>

