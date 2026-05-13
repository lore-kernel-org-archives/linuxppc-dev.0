Return-Path: <linuxppc-dev+bounces-20799-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3479CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 01:03:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFZvk1PMNz2xrC;
	Wed, 13 May 2026 11:03:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1229" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778634194;
	cv=pass; b=DlRVzHFqCHG915P9XdzF//rxHXCan8djRuq1rqxrZN1X5RDOG22yb1MtlRvPWozmVwgGqdmMV/lWkDCuX6KHbqLwsR8vlLhHygiXa6yFcaDZm3cYBxBK7qSHk7x5R1A6o5jlGZG2TB7zVfpSEfYIwdqfAlUjekUWkufVq+vp8SHsk0ldJ3M7H2bEtWBaSRf/fwtkO8RPySQmSuTf6lYFsjNxjvjAFc25B9qBi4aai5wbMmSqzxVYXryXM7B3ae4x56DQzEwDWHIzbEu/sHUVul+4yPGMZfhM4ho0pRoaYGf0/rTiBUQIW3ZIVdGkS9Rrv7EMQWOTU8D12pyp2on+7Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778634194; c=relaxed/relaxed;
	bh=ulhWHKpmSnD058yAqu2u4kJ2BZiEp2EGH+nr0nLUtAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aF/fUGSI5qiCA0X2gTRT5x3nFhgpbxcWzigNjXEyYpHBnwGwXSdXsj1S0AZGuvNK1XtZSpXVD7KgTMYkPzH4vEOsopgJnuhrvu5GSxKuSx7B0HELt/w1/ZawgzykGXTQOKPztu/BWgdygtXn55/dPMJf84IWxA6eCQBTRaREzvzAqGr3OaCW5CEv723xIakPRXu8ZpP1ZIntsvwnYk+jedMwORO0MAP0zS6wpmhh7SQkAWXfrOlXvPqG9NPYwUWuJfe5Sp/Hgk8kV2LOtfNbwb0bASBMKCsr4YbPGR2B00zK0WH1qSFtDAKKlnoiUSfY+kMnBgDmN/fDRxmlbf2HCA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Qb1i9JEx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1229; helo=mail-dl1-x1229.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Qb1i9JEx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::1229; helo=mail-dl1-x1229.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1229.google.com (mail-dl1-x1229.google.com [IPv6:2607:f8b0:4864:20::1229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFZvh6Tb8z2xpt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 11:03:12 +1000 (AEST)
Received: by mail-dl1-x1229.google.com with SMTP id a92af1059eb24-133362c30cfso28c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 18:03:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778634190; cv=none;
        d=google.com; s=arc-20240605;
        b=YlCua+n5uIwFju9GMyzNsfNihOvwVUTIzJvlJNsnNAulGPk9eEg0O2nPSpzl4/8nbF
         ++TZvm0Cqo1O020pbC1ZjYrARX6OpFVL70qE407HmuJzDq7BVd7YCQKJGCh961h/HLfe
         a7Lz3a7vzdpoYqEXeL5cKloCZTq4AsNAzsP7b7n+H5pgDNAHIrLJ0HIWHecHfKSC3m74
         wroEs6mttIuS1I+di22IjYcuQCro8A/FhIGqyIVJ3lnGnnwN/TzUgY36xp9oU62MDuBT
         YMxjf7J2O/OSB1uDeNfCl3CL24GgUq0Nc00eVob/ExeJCrCnGy3vuUHsC85UC96QBJd5
         nxdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ulhWHKpmSnD058yAqu2u4kJ2BZiEp2EGH+nr0nLUtAM=;
        fh=uj4xV6Uk7yJTErKpdbOxaNztUDcp2NtNYANM1RQ32I0=;
        b=UJLyeioIkSEZcl2aipMtNJ7DaR5temlRwd1eGPK/DFZZcjA4hV27jweC5HTpjC8tT/
         RfgxgNVi/LDz/2T4xadldG2NFhDnXZG6tu0OpN3AjAAXoZGSyO0Ij/LjZBHEm2Xxh2cX
         xp9JnnJZtJQKqLZgrxxmhbTMG8gGXgvxCHjIFHJFpTzWj/BDLodWlMNAZ2mkqQH9Ao6a
         qH1LnoiqI53NRdo80y8tnFtKu/Jp6ccVLkwCPrmMfEsZXFChMbSSnpr6P422ThWjDs+k
         4+ExWvLssrFj8Jipqh/VdidFujaD7kxfycPc1ygwoVZyc/wIXFrvshlFwzrsNgChFtlS
         MfWA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778634190; x=1779238990; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulhWHKpmSnD058yAqu2u4kJ2BZiEp2EGH+nr0nLUtAM=;
        b=Qb1i9JExvyvFbYpBAE97GtCGBaS0x0qmuL9kDq0mTkZAcxCrD6uegD1JjImYQDUdxZ
         hmcNHePmhOW8fhPGe4Kd74fTbvTzovbHkhbE3FdAj+3XO0Fq+5XqBWiAVA2OQr/c434n
         RTwqsBYnH6oBBNs4wnx46IF+hT6gIKpLOm4QI1T38a03Et8h+OfIXK9DDF8SxjpMaKLx
         bBQVnH3dzKH40X2bTGaVHNRvXfiSTvdlK1q757IqcANMDlDXP9VHTGNTEJNDp5YpEg+L
         F3/yTWN+V6P3xMaFLhnyhwxpkTqqUbivDO9kP+BVhC9Ofj3Rl3SwlMWIn9kKIwfgX402
         2lqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778634190; x=1779238990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ulhWHKpmSnD058yAqu2u4kJ2BZiEp2EGH+nr0nLUtAM=;
        b=TshK+DClazVDda4RvofUGZwNnM4Qzx1FTvSZEFoAIL3seSHwXZriJ1lzGJa9ANTi6Y
         KIoxAqTm7LHZD/ZRGRC4UtuHbzush4QJxACjpU3Qw07JbBiE9gK1jnsrgd/VdhSWdRv1
         fgzp/FVGEqeASmHXAVfny730S/geDTYa0ghYfgyNbGzPLHkOjKyunoUV1CPXTLNdEGCb
         Wzj8V13OiBTK8EZK6aNH/R6vdlqs2lDfyxfDVZhorhc1n1gH9AeixMxWZj134x0l0E0M
         UKJyMFAth0g2vz6zCvaE0S0L6ItrpNQRhr6x7AHdZgAUfq8y5eCfGVtGQ7663oIMiCj9
         E3Ng==
X-Forwarded-Encrypted: i=1; AFNElJ8B8fKk9I6CtSkXvv0dR0Cw1xRxpgO9zUResBv8zOc8yMexGMcZnASIbg7EmSVXh5t+Vdkt7BYoeHYzubA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YypSlAPVawF79J8C6HiWbhY6bjJRNkyoE5V7OgpxsIYW3zm6+tx
	NJhZrhxRErcr4jkGsCBJx3P8deRdaOsEWaXq59oWYyLa7CU4OxjBEYioMoTF4epbW3vexBiHFPu
	9DbG/1qP8LFZcBvYrPDzIRDW4wHkssJD7tneq5WqL
X-Gm-Gg: Acq92OGaCQjCZPA+3QgPC8H/DxnBOwpK4nKe9T8DKBflzOs+Ax1rzEqBoT78ptzpcMg
	fO2IGmEuTR694Y6m4f9EOzSwlAwfcF2xCLF8wVJ5w6NgOgulGzb/aGY6dLeMzMP2DuxCjFac8Ge
	N0j3jtMcTpqdRdYJFPsszEcKOzj2vVEmTxaG1+lAzivqqWZIB1mkt6TKGxvkbz5vY4vOjcleM+j
	Nx8nQfcBYMrihe1iKiA52CzShjCV1yS7nCKGNTD9FjHVNz7f8iqH1jIpAP3o9toTZnVUhIv3Tv8
	xBV0jpys9kPRNqv3phQ=
X-Received: by 2002:a05:7022:785:b0:133:3bc1:bf2e with SMTP id
 a92af1059eb24-13489ba2e12mr62355c88.5.1778634189086; Tue, 12 May 2026
 18:03:09 -0700 (PDT)
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
References: <20260504154205.21394-1-atrajeev@linux.ibm.com> <20260504154205.21394-2-atrajeev@linux.ibm.com>
In-Reply-To: <20260504154205.21394-2-atrajeev@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 May 2026 18:02:55 -0700
X-Gm-Features: AVHnY4L4IACcJi8qI8F6D66t_-FPiqzis4dycqEsczXQ7zZot14mCrzXc7WlR2Y
Message-ID: <CAP-5=fWWN_+v9h8LDwm0UamHtGv0awg6P+ZZYkBJR18P_TanSw@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] tools/perf: Use scnprintf in buffer offset calculations
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com, 
	namhyung@kernel.org, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com, 
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 8:42=E2=80=AFAM Athira Rajeev <atrajeev@linux.ibm.co=
m> wrote:
>
> Replace snprintf with scnprintf in buffer offset calculations to
> ensure the 'used' count will not exceed the "len".
>
> The current logic in perf_pmu__for_each_event uses an unconditional
> + 1 increment to buf_used to account for null terminators. This can
> cause a a stack buffer overflow in the subsequent scnprintf call.
> When the local stack buffer buf (1024 bytes) is full, buf_used can
> reach 1025. This causes the subsequent remaining space calculation
> sizeof(buf) - buf_used to underflow.
>
> Use sub_non_neg() to see if space actually existed, and only
> increment the offset if remaning space is present.
>
> Changes includes:
> - Use sub_non_neg to check if space exists
> - Replacing snprintf with scnprintf to ensure the return value
> reflects the actual bytes written into the buffer.
> - Only increment buf_used by 1 if space exists
> - If a parameterized event uses a built-in perf keyword for its
> parameter name (eg, config=3D?), the lexer parses it as a predefined
> term token, which sets term->config to NULL. Add check to use
> parse_events__term_type_str() if term->config is NULL.
>
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> Changelog:
> v2 -> v3:
> - Split the scnprintf related changes in separate patch
> - Handle the overflow issues and unconditional increment
> wrapped around sub_non_neg addressing review comment from Sashiko
>
>  tools/perf/util/pmu.c | 46 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 0b8d58543f17..4b9ade1a4cf9 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -2129,15 +2129,19 @@ static char *format_alias(char *buf, int len, con=
st struct perf_pmu *pmu,
>                 pr_err("Failure to parse '%s' terms '%s': %d\n",
>                         alias->name, alias->terms, ret);
>                 parse_events_terms__exit(&terms);
> -               snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->na=
me, alias->name);
> +               scnprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->n=
ame, alias->name);
>                 return buf;
>         }
> -       used =3D snprintf(buf, len, "%.*s/%s", (int)pmu_name_len, pmu->na=
me, alias->name);
> +       used =3D scnprintf(buf, len, "%.*s/%s", (int)pmu_name_len, pmu->n=
ame, alias->name);
>
>         list_for_each_entry(term, &terms.terms, list) {
> +               const char *name =3D term->config;
> +
> +               if (!name)
> +                       name =3D parse_events__term_type_str(term->type_t=
erm);
>                 if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_STR)
> -                       used +=3D snprintf(buf + used, sub_non_neg(len, u=
sed),
> -                                       ",%s=3D%s", term->config,
> +                       used +=3D scnprintf(buf + used, sub_non_neg(len, =
used),
> +                                       ",%s=3D%s", name,
>                                         term->val.str);
>         }
>         parse_events_terms__exit(&terms);
> @@ -2201,6 +2205,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, =
bool skip_duplicate_pmus,
>         int ret =3D 0;
>         struct hashmap_entry *entry;
>         size_t bkt;
> +       size_t size_rem, len;
>
>         if (perf_pmu__is_tracepoint(pmu))
>                 return tp_pmu__for_each_event(pmu, state, cb);
> @@ -2234,17 +2239,36 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu=
, bool skip_duplicate_pmus,
>                         }
>                         buf_used =3D strlen(buf) + 1;
>                 }
> +
>                 info.scale_unit =3D NULL;
>                 if (strlen(event->unit) || event->scale !=3D 1.0) {
> -                       info.scale_unit =3D buf + buf_used;
> -                       buf_used +=3D snprintf(buf + buf_used, sizeof(buf=
) - buf_used,
> -                                       "%G%s", event->scale, event->unit=
) + 1;
> +                       /* Check the remaining space */
> +                       size_rem =3D sub_non_neg(sizeof(buf), buf_used);
> +
> +                       if (size_rem > 0) {
> +                               info.scale_unit =3D buf + buf_used;
> +                               len =3D scnprintf(buf + buf_used, size_re=
m, "%G%s",
> +                                               event->scale, event->unit=
);
> +                               /*
> +                                * Increment buf_used by 1 only if
> +                                * it fits remaining space
> +                                */
> +                               buf_used +=3D min(len + 1, size_rem);
> +                       }
>                 }
>                 info.desc =3D event->desc;
>                 info.long_desc =3D event->long_desc;
> -               info.encoding_desc =3D buf + buf_used;
> -               buf_used +=3D snprintf(buf + buf_used, sizeof(buf) - buf_=
used,
> -                               "%.*s/%s/", (int)pmu_name_len, info.pmu_n=
ame, event->terms) + 1;
> +               info.encoding_desc =3D NULL;
> +
> +               /* Check the remaining space */
> +               size_rem =3D sub_non_neg(sizeof(buf), buf_used);
> +               if (size_rem > 0) {
> +                       info.encoding_desc =3D buf + buf_used;
> +                       len =3D scnprintf(buf + buf_used, size_rem, "%.*s=
/%s/",
> +                                       (int)pmu_name_len, info.pmu_name,=
 event->terms);
> +                       buf_used +=3D min(len + 1, size_rem);
> +               }
> +
>                 info.str =3D event->terms;
>                 info.topic =3D event->topic;
>                 info.deprecated =3D perf_pmu_alias__check_deprecated(pmu,=
 event);
> @@ -2254,7 +2278,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, =
bool skip_duplicate_pmus,
>         }
>         if (pmu->selectable) {
>                 info.name =3D buf;
> -               snprintf(buf, sizeof(buf), "%s//", pmu->name);
> +               scnprintf(buf, sizeof(buf), "%s//", pmu->name);
>                 info.alias =3D NULL;
>                 info.scale_unit =3D NULL;
>                 info.desc =3D NULL;
> --
> 2.47.3
>

