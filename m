Return-Path: <linuxppc-dev+bounces-18327-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097AAFED9EB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 16:09:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZxjT52Qzz2yhV;
	Wed, 18 Mar 2026 03:09:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::631" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773763757;
	cv=pass; b=lD9Z/zsSMqXBeqZ+Qj8qp6uAkYNIDl9oNJSqRP7ZLdfQSXB97EjBtTiJPhUy9ZiogyauKo5HPEo8OAei/3olkz6BsH92+9xmh6aq5Z92ZuzVAuGEC+7AtfIykA3k1rbuc8LYwNRT2jAiy46o7g1x15fx7rSJld7RkLy5gkHkLOH8QUYUi1fVY/i9Af2QFfVE2l1pKc48RsxArpaDgF/ydS0/0n0jtaBnj1l301fgaaOTZemaiB2//+pWko1UXSoRL0uWpkBddUBeJbZOz1IzxdND9LtHLXjxbS+Sh6CBqYAj6LjtsPAbVyrYOLTvvYOogtdPpBsNKi6ggA7bIZR1vg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773763757; c=relaxed/relaxed;
	bh=TwZHlgO1CKayfhFJ9zN5osc6AEr+794S0iYzUhNA7a8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fA3Z3gx0E1rcF/Ft0CjoS+HU9yiaIDoAxiRV4pML/XOKx/AKvA5gn+OiFhvwH2OruHOqDcQGe6yFYwEZH89MMr/vbl+bCTdIv0H1ay4SXZHVbbrHbXVBaaPuLP4uDuebAAMqPN9XoXIkLcKStZFRpLsNf+oOHVI0qfWmdwRyXl/ByJAP8S4wcCSGZoShNCI2Qpx0zuKLryGbqf/73YmD9tH5r6SQ9YqxHjd2aoWr0vS0/jg9beYMdDJhvaWFsOFGciWN0qpVcBO0zYUG8j4AnXHRAsZTL4kbxtx6hkqPuhE5LOu5qUvaeptcDkVIrQcGdDa7jDMAN5zSuOBtTk+iJw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VfjSvMtE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VfjSvMtE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZxjS5HjFz2yFd
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 03:09:16 +1100 (AEDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so96295ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 09:09:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773763755; cv=none;
        d=google.com; s=arc-20240605;
        b=Kb9pLWfhgsQH+bofN4EcDdpIDZaAUfT5dH+LxEcB8/zsu6uxTBxkKJPgRY2kHMgwXz
         TwVJbnxUMcIS4+YwUr8PYeKmpZ59bYHcvh33v33vQ4E3u34fSJ44UcYi89wgrM36uyI7
         3mmoU6S56xZvkI5rgpMj1sxQjfOSVnDjAfi1hNwkOgUHQZ29p9OsQmEWmKbEN4Z76C7U
         yAI8SwO8z5aTPTI0C3N15ce0BOh9O/lyW4EWfsR4Xmwp0BSe+tv6ypNpEylPpjlLMz1o
         J3s/DSUGazBQ/WDf9LQUI3aeUzngRr0DLRl0JBlwYUNcN1dnJh27SEU1a1wH8CTnhoXn
         3kBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TwZHlgO1CKayfhFJ9zN5osc6AEr+794S0iYzUhNA7a8=;
        fh=6aRDPYgJQci5yuMzVpEIMiPcGf/kT1g1oGQu+LWwO74=;
        b=c8ycXJ47cUa2QFJPgqeMeXHpo/XTYnBMsZOIo62Cc49Oi0MBOXcy56A+RAkpzg82Qx
         eGXz6kW2WSUuOJfLLy1KQoFZMeLpc/hcmRXonzF+9cSx08ku4cAsoSyPdvPTS58+hG+R
         ZmcCcjazqGEkQ9RffnvaecgfFqz0VVkHeG9Lok2ShqdLnMDgNm1I/qZ26wO2/D8F1YwG
         w4XAM+jcwlpQECivW77kBnL0YGT7zRyDSQUBwh5AMZNpLEQWtj+dkJLyzncyemjM73FN
         HvW8ice4iRtKIZxg76W9YgfXYBxVrDKbnhlnaij3WvtyXg9KJkbf80S8eycsQ+GD0I7S
         g3Lg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773763755; x=1774368555; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwZHlgO1CKayfhFJ9zN5osc6AEr+794S0iYzUhNA7a8=;
        b=VfjSvMtEx2HRshiRjLxxZ9aP4RlRt6i0X2u6VzaMyQ57PeF8TF1XLhRWC3FyKTAi6d
         BPtX09rpSv/HaUh9N5faFkzpRtKs1ZEzZBDBs6jHnkc25fcMPXgAFkmtktN1i7iKvjXr
         FVtHCb/Maq4DqYv5C6dJmpFJ3rFkq0Xcoa8K169GlAHmPChhfApdxl5j5oJH0esKkQoR
         0RCaPjJUok05zZ68lRXePtOJrjxTPtGAkTrZ7+/givj716QCGgg12g4Ko4Dl+SZnoog9
         NJqD0rh0Vygg/uuiAkVmucRPUlBNCzUs/N2S03a2V3YH9Z3EUL1/idZssOaoV4H9f55n
         0edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773763755; x=1774368555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TwZHlgO1CKayfhFJ9zN5osc6AEr+794S0iYzUhNA7a8=;
        b=XX+QOZrc9skUlQNAO5LFgSZD/afgDZU5YqciI89K3vpv6qoNOh5ZS4wYLkrS2oinUw
         JLT4qyYrbzoczCDLDUfPk+v8pAVPa8rk9foJLK0ewqvIoCbCI4nl1KWKXYtV68ve481M
         0yNABPvpqUYsRR4GC3UeKNsXiJdwYQ9C9BARiX6MTsa8SJI2oT3bK2QW3n+KIWROhe/r
         e8kbDokCyI/WQPZnrpJwY8iKg7AKUbBm4IbOsckk7U44GJVx4J7t0fTwFo43cGnkosNO
         QfnCzoYVkvNkCZn6+mSLKHySB1u0x/lXJuGAwYc0jYwrfAxgzdZOR9gIgjmquDLq8WU+
         Jocw==
X-Forwarded-Encrypted: i=1; AJvYcCUyUBoVNMWUuzcXM82M35oZz1PMw9hS1PCYHgG9qQSibukfYj6CMaVT3/FHqSUejmoviUOmntYl79RM9MY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxOv6zkBn2FRIerOgjwo2d5+EmcDnZFkJ6o3mwdqrh9U7rOXZ7k
	NEz71cN++/tVKJGMrHXEbihAqu7WypWtvlWqiWs2M2NO3m969R2tdw0KoBJMYVb7xAgwQ4vCJgJ
	E6KXt8LVCharJbpbgMoRi2ajHKQbZeilQdedc6TQO
X-Gm-Gg: ATEYQzxVkXpBQd3idu1RzUpwSrr3MAy4t6DEfiKKug/v9wvQwkItBxwIICa7ieAkInT
	BFXc9EWixAdFKOJtGJWRCZ2m6vDq+OFTJ7vTTNOPB9xMcBzje068R2SCKHL9sOCR5sTbV7+H04q
	EdrL4hOSIi2rZCyrhwd108iMAD4SmjwnN7IkgGsVahzVFt8zI6Vqk3j88l0Z45yjDfD8DfFZh1I
	gSFe0LRHHumvMoBPHHKdanpSPzQIzKQ4H4n10dtvz7OfI0umn/NUWuVz6xQeE/Kg/jxZ6Bjo5q7
	d1iLkr7ZU5RL5qg3t/Q=
X-Received: by 2002:a17:903:b8e:b0:2ae:5d57:c94f with SMTP id
 d9443c01a7336-2b06402f708mr3429925ad.16.1773763754307; Tue, 17 Mar 2026
 09:09:14 -0700 (PDT)
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
References: <20260314083304.75321-1-atrajeev@linux.ibm.com> <7D255F44-3588-460F-ACFB-6ABAEBA152DC@linux.ibm.com>
In-Reply-To: <7D255F44-3588-460F-ACFB-6ABAEBA152DC@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 17 Mar 2026 09:09:03 -0700
X-Gm-Features: AaiRm53nq8oPXRj0zgp85S66JPVlj4x0AFZ4dunl72riUQ7loIf52pJrwRVofrk
Message-ID: <CAP-5=fVcWpBTALH1zr7dL3qH9j24c3t3L0zvExaWbnC-2tXjcg@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: Fix the check for parameterized field in
 event term
To: Venkat <venkat88@linux.ibm.com>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>, acme@kernel.org, jolsa@kernel.org, 
	adrian.hunter@intel.com, maddy@linux.ibm.com, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, 
	Shivani.Nittor@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 1:56=E2=80=AFAM Venkat <venkat88@linux.ibm.com> wro=
te:
>
> > On 14 Mar 2026, at 2:03=E2=80=AFPM, Athira Rajeev <atrajeev@linux.ibm.c=
om> wrote:
> >
> > The format_alias() function in util/pmu.c has a check to
> > detect whether the event has parameterized field ( =3D? ).
> > The string alias->terms contains the event and if the event
> > has user configurable parameter, there will be presence of
> > sub string "=3D?" in the alias->terms.
> >
> > Snippet of code:
> >
> >  /* Paramemterized events have the parameters shown. */
> >        if (strstr(alias->terms, "=3D?")) {
> >                /* No parameters. */
> >                snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->n=
ame, alias->name);
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
> > Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>

Thanks Athira, Sashiko is noting in its review:
https://sashiko.dev/#/patchset/20260314083304.75321-1-atrajeev%40linux.ibm.=
com

By inverting this check, parameterized events now proceed to
parse_events_terms() and the rest of format_alias().

If a parameterized event uses a built-in perf keyword for its parameter nam=
e
(e.g., config=3D?), the lexer parses it as a predefined term token, which s=
ets
term->config to NULL.

Does this cause a NULL pointer dereference in the term iteration loop?

list_for_each_entry(term, &terms.terms, list) {
  if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_STR)
    used +=3D snprintf(buf + used, sub_non_neg(len, used),
      ",%s=3D%s", term->config,
      term->val.str);
}

Passing a NULL pointer to the %s format specifier for term->config might
cause a segmentation fault or formatting corruption.

Can this also lead to a stack buffer overflow due to how snprintf() return
values are accumulated?

snprintf() returns the number of characters that would have been written.
If the event names and terms are long enough, the "used" variable can excee=
d
"len" (which is typically 1024 bytes).

When evaluating "buf + used" in the same loop:

  used +=3D snprintf(buf + used, sub_non_neg(len, used), ...);

If "used" exceeds 1024, this creates an out-of-bounds pointer. Modern
compilers can use this undefined behavior to infer that "used" <=3D 1024
must be true, which optimizes out the safety check inside sub_non_neg():

static int sub_non_neg(int a, int b)
{
  if (b > a)
    return 0;
  return a - b;
}

The compiler can reduce this to simply "a - b" (or "len - used").
If "used" is actually greater than 1024, "len - used" evaluates to a
negative integer. This negative value is implicitly cast to size_t for
snprintf(), resulting in a massive size limit.

Would this cause snprintf() to write past the end of the stack buffer
without bounds checking? Using scnprintf() might prevent "used" from
exceeding "len".

Thanks,
Ian

> > ---
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
> Tested this patch, and its working as expected.
>
> Before Patch:
>
> ./perf list hv_24x7 | grep -i CPM_EXT_INT_OS
>   hv_24x7/CPM_EXT_INT_OS/                            [Kernel PMU event]
>
> After Patch:
>
> ./perf list hv_24x7 | grep -i CPM_EXT_INT_OS
>  hv_24x7/CPM_EXT_INT_OS,domain=3D?,core=3D?/ [Kernel PMU event]
>
>
> ./perf stat -e hv_24x7/PM_PAU_CYC,chip=3D0/
>
>
>  Performance counter stats for 'system wide':
>
>         2018866563      hv_24x7/PM_PAU_CYC,chip=3D0/
>
>      229.938231314 seconds time elapsed
>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>
> Regards,
> Venkat.
>
>

