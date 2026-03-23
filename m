Return-Path: <linuxppc-dev+bounces-18638-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE15F483E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 18:48:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffhy84WtCz2yWK;
	Tue, 24 Mar 2026 05:48:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::122f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774291696;
	cv=pass; b=dNBrjY4C9f7z82ZtNqjJzkCBZCOagfeiZpVQbi2hQMgKq8/WfmtM19wXSo9vljV0gho+HXUfHBjFC9j+lLDOhXR/bfkQLwQt0vPHVghXA3Zi+3pUTl5Y//dNzmyeGTJaII0c/GpNmaFK6rPzmjHhHghwu/nFm5ie6I1XZw/UcYWCrGJ//8sCdYEfQyBnnrN78LB5s4rzBCE54npTQQnSLwEgjgiXPJJR4+brkC7ZER5Cob1er1XoY9PH28QMnfzErG1Y836OXFlPS2utc1l9TSipKw+FRX27oZu0C8gCy11/s3ckwQBitYb50emqIFCgfhNRkmgXYd3zAb6T89dXYQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774291696; c=relaxed/relaxed;
	bh=whjjvimScDBVewyWwcwuS5G66IL1vUadauaQxpQ3HnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6tJ5i+2byj/saDLzCySLw+ekONyvQSvu0I0LVRNMiV5Uj4Jqo23c1ilftuzaCgu4rvlvDw7Sv/GeomGIRo7hSkcIo7pRRcSyAzyeDYNjp4mgZ4JC8QWYnQvtm0fxiWewTkqZ6q/7aGTHr1T9Rih5QIHe9ZPD8tAqzxf8hbEbesIvJpuYVsU/o3YC8cSdeKIuyWVT5d5ACiY78BKv3q4K+QFeygC0R+2coXQ63tJi06FMomJrbeCPkTtti8tDls/RpcvzoXG7as77rMfiTPqMXtV4XBtnDwe/4OWSsyRRq5n/T2KhilYjP7bDNesYuWbivXpN01GFBQldedfieWD4w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=vNj0tN11; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=vNj0tN11;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com [IPv6:2607:f8b0:4864:20::122f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffhy63Txpz2yFb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 05:48:14 +1100 (AEDT)
Received: by mail-dl1-x122f.google.com with SMTP id a92af1059eb24-1270fc2bdf2so1965c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 11:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774291692; cv=none;
        d=google.com; s=arc-20240605;
        b=c7C2bb32E8KkLBYvMxRWpvZq3Bc3HV3P1J6SNE0xY2iMsv2N04T0+pmAVUL/n/VxHO
         Sg/+vAzzLjimliqhVFkBpanF05ha5EwHLLFno6l+NkqASrDbaFJzr/e5+hfGcq6Qfk2J
         Jw56nJ+kRIap0OK4vRT0yFeqt4QjkEWaHcx3wwsoc17TwOVBwW4gVIwOoLcyba8FbzJk
         n6sknEXwUdHet8MDEXfqEo/oN/qB+CRF+TLK5wF6Ewp0Y89neUKOw6xc/Ks+zc8mHLGd
         douWiuPYk2CmedYfKnTwqwLrwzSpTUv0mvjTup/K8ffzNp+c6fGCy1dyunGgAUKs0VlZ
         x+MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=whjjvimScDBVewyWwcwuS5G66IL1vUadauaQxpQ3HnY=;
        fh=9s/dSjt9z7I/E6GwpDYY1VUmogNvBoXcnfjWr7Tv69w=;
        b=Y+ruSwXVAJXE7pepf9EXOjGwc23dj+SDfNhROnqjxKj77xYTcDK0coRAAxPUGCy1E9
         qGhgoN7b41qd9YndvEr8CgGIuVZX0KvoI4LAYqQsDdXxL34Fv/3BSZS5t6+KHArN8Zr3
         Ee0uwPMdF/Fq1D+eSvoanHnNcrB3rJC3G7hUEwuzWJy355ONdcuzGFNpYQeslYFHxFEr
         KjJkPYosiVIp4GkVVtx9l20hd2Vmojkq0Mu8ia1CeoEqk/RYkMyKyKBaZtUXm079iU2K
         5VILxZJjbyCQY3bkIsRckOwHgR8IGtr9NoEbM8XBvYe74qLYCgw2rg45ldVC9ZxDBve9
         Tujg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774291692; x=1774896492; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whjjvimScDBVewyWwcwuS5G66IL1vUadauaQxpQ3HnY=;
        b=vNj0tN11LebHqbW9r16Ulj1gvqufGOGCaYuCqFOgVYMuT+7AVyxwJew9PV7UKpGL4Y
         4tEUPoO57fddWm1zieVLoPzfq1iX9UVNWWWHux7RudHZU38LfqLVAechUwgaQ34N8gz1
         mjAO2hJG5ChnkASQP82EtfmeuIwdin/wTCFS3nRy7iEIWlgM5Xjkwye2oRBBH4XJRi1q
         2npVH3zB1MEbdUwjObawQQ4EBMwvNcNzb+luxJjknDpSGeZxVV5OIHc8UHt2uv+AOrN2
         vK98taO+vr0hr5AkoBgf61GrW+IBPZ8Pn29WTkw+cotO6rh06ceqzpKeyMmPqJBteEmR
         Asog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291692; x=1774896492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=whjjvimScDBVewyWwcwuS5G66IL1vUadauaQxpQ3HnY=;
        b=RiY7CRje45vUSVx9s0wJ9Pw3c2Q9kuBNQ6fPArubN9CAgMkJLN7aA9FZHy6xLKCuXJ
         UZAJUJBdCuac2tIis8ZJP3UuCpjZD8kn7PSB0MuEtiW68wVkP62L4Z+pExbRO+J5GwIx
         YGUiPhGpjJ69pS68kGI/HJexJaWcYMDDOcilDCUV0YpPvI4K21/7wcOBxrDaHyQuOc1s
         p9WyzFy2v4TFh3jgWvNDl6j3OvCtZDIk/1RyGIi7tNZDsm7zTXEff5xbRVS2nwq9bNBm
         EoH1/l0eFywOyMYfH5Lny66yfgdVwWMQvEik85hi7bPtf4OKmAzwVCw7NPOkWr0o8czi
         gL4A==
X-Forwarded-Encrypted: i=1; AJvYcCXpluwBDt3IpnUBc7wxmsov2kZAPWdVOoVyRCHzbsAw9lV4c7m+asbEdYANQjVfYLKrqXRnGBBtkqy2hNM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxXxi96rij3NE1B9QpnvSeV1wCKY3RlIef2pl30vMqs8FsO4YYi
	ggohnJRzkqeWcscgjPK0kBp0YGIvWXwXRGxN7M+dW4/YcmcDokZLLiQ7zZ0QlTCUE0xmHmtQbhV
	aKTZJS4chJz/ADQRb3o+6YmFGwJCEk57AVZtONMDo
X-Gm-Gg: ATEYQzy7H0XxLl8OZcZHioKDmbXWPpMDoUZUytw/pZMmVbs+82cNxSJ3BD1WUKl7icB
	Nwq9h7bE7rHnlBRUTAV67cYXECqU2Brkd6i6QeEaKLxk2eC3jfygkMCzvap8UTrF6CNzvSPJh8Q
	wpaJ+HZCUBFr+iz6r6O5iFVG9szadTYMdgotgOEKT0Nygl9sEz7jWV57fsDokUoJAosF8Xnziff
	mpGCoBbTcOqzWN3oKhuJWdE4xaKr2dq7Ie7cOOJCRmNoiRxkj37luT+qnw59Ufj7eJPy06xS3L8
	HTNTCPdGPUF0hVYwENBjBIL3AdgK/QwjgxHzaA==
X-Received: by 2002:a05:701b:2719:b0:12a:6ca2:3085 with SMTP id
 a92af1059eb24-12a8e72d8b1mr13551c88.18.1774291691020; Mon, 23 Mar 2026
 11:48:11 -0700 (PDT)
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
References: <20260314083304.75321-1-atrajeev@linux.ibm.com>
 <7D255F44-3588-460F-ACFB-6ABAEBA152DC@linux.ibm.com> <CAP-5=fVcWpBTALH1zr7dL3qH9j24c3t3L0zvExaWbnC-2tXjcg@mail.gmail.com>
 <AD8DAAE1-50E9-45CD-AD81-D9DFF139B362@linux.ibm.com> <8C75E314-2038-4A76-BA4F-F36AE3F30B0B@linux.ibm.com>
In-Reply-To: <8C75E314-2038-4A76-BA4F-F36AE3F30B0B@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Mar 2026 11:47:58 -0700
X-Gm-Features: AQROBzCkCY-gzX_BTnf1QZfpfdHg1WjDHCzE2j3_luUCpN1rSSkLLcz8j3iVv8Y
Message-ID: <CAP-5=fXcZVxKcfV5giqDWxBPm53cNYLGhrTL8Q=uibrqJPmzgw@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: Fix the check for parameterized field in
 event term
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	Venkat <venkat88@linux.ibm.com>, jolsa@kernel.org, maddy@linux.ibm.com, 
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com, 
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 5:19=E2=80=AFAM Athira Rajeev <atrajeev@linux.ibm.c=
om> wrote:
>
>
>
> > On 18 Mar 2026, at 12:05=E2=80=AFPM, Athira Rajeev <atrajeev@linux.ibm.=
com> wrote:
> >
> >
> >
> >> On 17 Mar 2026, at 9:39=E2=80=AFPM, Ian Rogers <irogers@google.com> wr=
ote:
> >>
> >> On Tue, Mar 17, 2026 at 1:56=E2=80=AFAM Venkat <venkat88@linux.ibm.com=
> wrote:
> >>>
> >>>> On 14 Mar 2026, at 2:03=E2=80=AFPM, Athira Rajeev <atrajeev@linux.ib=
m.com> wrote:
> >>>>
> >>>> The format_alias() function in util/pmu.c has a check to
> >>>> detect whether the event has parameterized field ( =3D? ).
> >>>> The string alias->terms contains the event and if the event
> >>>> has user configurable parameter, there will be presence of
> >>>> sub string "=3D?" in the alias->terms.
> >>>>
> >>>> Snippet of code:
> >>>>
> >>>> /* Paramemterized events have the parameters shown. */
> >>>>      if (strstr(alias->terms, "=3D?")) {
> >>>>              /* No parameters. */
> >>>>              snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->=
name, alias->name);
> >>>>
> >>>> if "strstr" contains the substring, it returns a pointer
> >>>> and hence enters the above check which is not the expected
> >>>> check. And hence "perf list" doesn't have the parameterized
> >>>> fields in the result.
> >>>>
> >>>> Fix this check to use:
> >>>>
> >>>> if (!strstr(alias->terms, "=3D?")) {
> >>>>
> >>>> With this change, perf list shows the events correctly with
> >>>> the strings showing parameters.
> >>>>
> >>>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> >>
> >> Thanks Athira, Sashiko is noting in its review:
> >> https://sashiko.dev/#/patchset/20260314083304.75321-1-atrajeev%40linux=
.ibm.com
> >
> > Thanks Ian for pointing this. Its interesting to see this review.
> > I will check through the review.
> >
> > Thanks
> > Athira
> >>
> >> By inverting this check, parameterized events now proceed to
> >> parse_events_terms() and the rest of format_alias().
> >>
> >> If a parameterized event uses a built-in perf keyword for its paramete=
r name
> >> (e.g., config=3D?), the lexer parses it as a predefined term token, wh=
ich sets
> >> term->config to NULL.
>
> Hi All,
>
> sashiko brought up a scenario :
>
> =E2=80=9CIf a parameterized event uses a built-in perf keyword for its pa=
rameter name
> (e.g., config=3D?), the lexer parses it as a predefined term token, which=
 sets
> term->config to NULL."
>
> Existing usage for parameterized events in perf:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> In perf,  =E2=80=9C?=E2=80=9D is often used in event aliases to indicate =
that a parameter needs to be provided
> by the user (e.g., param1=3D?). This information is exposed via =E2=80=9C=
format=E2=80=9D in sysfs too.  The current way,
> how this is consumed in different PMU drivers is: example:
>
>   # cat /sys/devices/pmu/format/param1
>     config:12-15
>
>    # cat /sys/devices/pmu/format/param2
>     config1:0-17
>
> Here param1 uses bits 12:15 in config and param2 used bits 0:17 in config=
1
>
> And event will use these parameterized fields:
>     #cat /sys/devices/pmu/events/event1       domain=3D1,param1=3D?,param=
2=3D?
>
> =E2=80=9CPerf list=E2=80=9D expects "param1=3D?,param2=3D?=E2=80=9D In th=
e event listing
>    # perf list|grep event1
>    pmu/event1,param1=3D?,param2=3D?/                       [Kernel PMU ev=
ent]
>
> The patch here address fix in =E2=80=9Cstrstr=E2=80=9D check in format_al=
ias for =E2=80=9Cperf list=E2=80=9D to display these user expected =E2=80=
=9C?=E2=80=9D fields
> in event alias.  Traditionally, perf treats config, config1, and config2 =
etc as hardcoded numeric
> keywords or builtin keyword.
>
> The scneario sashiko brought up is interesting. Where a parameterized eve=
nt
> uses a built-in perf keyword  for its parameter name.
>
> sashiko review : Scenario where parameterized event uses a built-in perf =
keyword
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Example, having =E2=80=9Cconfig2=E2=80=9D in sysfs format-driven logic. B=
elow is an example case.
>
>     #cat /sys/devices/pmu/events/event1
>      config2=3D?,domain=3D1,param1=3D?,param2=3D?
>
>       # cat /sys/devices/hv_24x7/format/config2
>          config2:0-16
>
>  Here =E2=80=9Cperf list=E2=80=9D will show as (null) or might crash too =
as sashiko review pointed out.
>
>     # perf list|grep event1
>     pmu/event1,(null)=3D?,param1=3D?,param2=3D?/                    [Kern=
el PMU event]
>
> This is because term->config is null for built-in keywords. perf lexer se=
ts this to NULL
> for predefined keywords ( like 'config', 'period'), storing the type in t=
he enum instead.
>
> To fix displaying the =E2=80=9C=3D?=E2=80=9D in =E2=80=9Cperf list=E2=80=
=9D for keywords like config2,  format_alias() function needs to handle
> null term->config , ie by using parse_events__term_type_str() to map NULL=
 config
> pointers back to their string keywords
>
> But this only will fix the =E2=80=9Cperf list=E2=80=9D part of it.  =E2=
=80=9CPerf stat=E2=80=9D or record will still fail since
> currently these keywords are not considered as placeholders for =E2=80=9C=
?=E2=80=9D values.
>
> If a PMU wants to use any builtin-keywords in parameters and want to ensu=
re
> it is set by user, this could be useful.  Again considering this as a use=
 case, we need other changes
> to allow these built-in keywords to function as placeholders (e.g., confi=
g2=3D?) within a PMU alias.
>
> I am adding changes which I have identified needed for this support.
> If it is better to post this separately as patch set and discuss, definit=
ely will do that.
> I wanted to run the idea of this new scenario with everyone. Apologies fo=
r the long text.
>
> Thanks and looking for comments.
>
>
> From 21179a76be97ef81c69a9492f0f432dec5b5361c Mon Sep 17 00:00:00 2001
> From: Athira Rajeev <atrajeev@linux.ibm.com>
> Date: Mon, 23 Mar 2026 08:38:30 -0400
> Subject: [PATCH] tools/perf: Enable parameterized values for keywords lik=
e
>  config1
>
> PMU defines events that require user-supplied parameters (like chip
> or core) are packed into specific bit-fields of the different config
> registers. Traditionally, perf treats config, config1, and config2
> as hardcoded numeric keywords, causing it to bypass the sysfs
> format-driven bit-masking logic.
>
> This patch allows these built-in keywords to function as placeholders
> (e.g., config2=3D?) within a PMU alias.
>
> Changes includes:
> - Updated config_term_pmu in parse-events.c to recognize string
>   placeholders for event terms. otherwise it will expect those to
>   be of type PARSE_EVENTS__TERM_TYPE_NUM
> - Updated pmu_config_term in pmu.c to make sure if keywords are used
>   as placeholders , they pass through sysfs based format logic
>  (pmu_find_format) and pmu_resolve_param_term() logic
> - Modified format_alias() to ensure "perf list" display the parameterized
>   events correctly
> - Replace snprintf with scnprintf in buffer offset calculations to
>    ensure the 'used' count will not exceed the "len"
>
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> ---
>  tools/perf/util/parse-events.c |  5 +++++
>  tools/perf/util/pmu.c          | 37 +++++++++++++++++++++++++---------
>  2 files changed, 33 insertions(+), 9 deletions(-)
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index b9efb296bba5..282b0a0a5340 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1051,6 +1051,11 @@ static int config_term_pmu(struct perf_event_attr =
*attr,
>                  */
>                 return 0;
>         }
> +
> +       if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_STR && term->va=
l.str)
> +               if (strstr(term->val.str, "?"))
> +                       return 0;

nit: Since the nested if spans more than two lines, could you add
curly braces {} to the outer if statement. Could you also add a
comment explaining why the runtime parameter causes an early return
and why you used `strstr` instead of `strcmp`?

> +
>         return config_term_common(attr, term, parse_state);
>  }
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 23337d2fa281..2c4503e1a11b 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1442,10 +1442,19 @@ static int pmu_resolve_param_term(struct parse_ev=
ents_term *term,
>                                   __u64 *value)
>  {
>         struct parse_events_term *t;
> +       const char *name =3D term->config;
> +
> +       if (!term->config)

I think you meant "if (!name)" here.

> +               name =3D parse_events__term_type_str(term->type_term);
>
>         list_for_each_entry(t, &head_terms->terms, list) {
> +               const char *t_name =3D t->config;
> +
> +               if (!t_name)
> +                       t_name =3D parse_events__term_type_str(t->type_te=
rm);
> +
>                 if (t->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_NUM &&
> -                   t->config && !strcmp(t->config, term->config)) {
> +                   t_name && name && !strcmp(t_name, name)) {
>                         t->used =3D true;
>                         *value =3D t->val.num;
>                         return 0;
> @@ -1453,7 +1462,7 @@ static int pmu_resolve_param_term(struct parse_even=
ts_term *term,
>         }
>
>         if (verbose > 0)
> -               printf("Required parameter '%s' not specified\n", term->c=
onfig);
> +               printf("Required parameter '%s' not specified\n", name);
>
>         return -1;
>  }
> @@ -1494,6 +1503,7 @@ static int pmu_config_term(const struct perf_pmu *p=
mu,
>         struct perf_pmu_format *format;
>         __u64 *vp;
>         __u64 val, max_val;
> +       const char *name;
>
>         /*
>          * If this is a parameter we've already used for parameterized-ev=
al,
> @@ -1507,7 +1517,8 @@ static int pmu_config_term(const struct perf_pmu *p=
mu,
>          * traditionally have had to handle not having a PMU. An alias ma=
y
>          * have hard coded config values, optionally apply them below.
>          */
> -       if (parse_events__is_hardcoded_term(term)) {
> +       if (parse_events__is_hardcoded_term(term) &&
> +                      term->type_val !=3D PARSE_EVENTS__TERM_TYPE_STR) {

What is being guarded against in this case? Could you update or add a comme=
nt.

>                 /* Config terms set all bits in the config. */
>                 DECLARE_BITMAP(bits, PERF_PMU_FORMAT_BITS);
>
> @@ -1576,7 +1587,11 @@ static int pmu_config_term(const struct perf_pmu *=
pmu,
>                 return 0;
>         }
>
> -       format =3D pmu_find_format(&pmu->format, term->config);
> +       name =3D term->config;
> +       if (!name)
> +               name =3D parse_events__term_type_str(term->type_term);
> +
> +       format =3D pmu_find_format(&pmu->format, name);
>         if (!format) {
>                 char *pmu_term =3D pmu_formats_string(&pmu->format);
>                 char *unknown_term;
> @@ -2117,7 +2132,7 @@ static char *format_alias(char *buf, int len, const=
 struct perf_pmu *pmu,
>                                                    skip_duplicate_pmus);
>
>         /* Paramemterized events have the parameters shown. */
> -       if (strstr(alias->terms, "=3D?")) {
> +       if (!strstr(alias->terms, "=3D?")) {

I wonder if it would be safer if we did a `str_ends_with(alias->terms,
"=3D?")`. This likely applies to the other strstr usage.

Thanks,
Ian

>                 /* No parameters. */
>                 snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->na=
me, alias->name);
>                 return buf;
> @@ -2129,15 +2144,19 @@ static char *format_alias(char *buf, int len, con=
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
> --  2.47.3
>
>
>
> Thanks
> Athira
>
> >>
> >> Does this cause a NULL pointer dereference in the term iteration loop?
> >>
> >> list_for_each_entry(term, &terms.terms, list) {
> >> if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_STR)
> >>   used +=3D snprintf(buf + used, sub_non_neg(len, used),
> >>     ",%s=3D%s", term->config,
> >>     term->val.str);
> >> }
> >>
> >> Passing a NULL pointer to the %s format specifier for term->config mig=
ht
> >> cause a segmentation fault or formatting corruption.
> >>
> >> Can this also lead to a stack buffer overflow due to how snprintf() re=
turn
> >> values are accumulated?
> >>
> >> snprintf() returns the number of characters that would have been writt=
en.
> >> If the event names and terms are long enough, the "used" variable can =
exceed
> >> "len" (which is typically 1024 bytes).
> >>
> >> When evaluating "buf + used" in the same loop:
> >>
> >> used +=3D snprintf(buf + used, sub_non_neg(len, used), ...);
> >>
> >> If "used" exceeds 1024, this creates an out-of-bounds pointer. Modern
> >> compilers can use this undefined behavior to infer that "used" <=3D 10=
24
> >> must be true, which optimizes out the safety check inside sub_non_neg(=
):
> >>
> >> static int sub_non_neg(int a, int b)
> >> {
> >> if (b > a)
> >>   return 0;
> >> return a - b;
> >> }
> >>
> >> The compiler can reduce this to simply "a - b" (or "len - used").
> >> If "used" is actually greater than 1024, "len - used" evaluates to a
> >> negative integer. This negative value is implicitly cast to size_t for
> >> snprintf(), resulting in a massive size limit.
> >>
> >> Would this cause snprintf() to write past the end of the stack buffer
> >> without bounds checking? Using scnprintf() might prevent "used" from
> >> exceeding "len".
> >>
> >> Thanks,
> >> Ian
> >>
> >>>> ---
> >>>> tools/perf/util/pmu.c | 2 +-
> >>>> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> >>>> index 23337d2fa281..0b8d58543f17 100644
> >>>> --- a/tools/perf/util/pmu.c
> >>>> +++ b/tools/perf/util/pmu.c
> >>>> @@ -2117,7 +2117,7 @@ static char *format_alias(char *buf, int len, =
const struct perf_pmu *pmu,
> >>>> skip_duplicate_pmus);
> >>>>
> >>>> /* Paramemterized events have the parameters shown. */
> >>>> - if (strstr(alias->terms, "=3D?")) {
> >>>> + if (!strstr(alias->terms, "=3D?")) {
> >>>> /* No parameters. */
> >>>> snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->=
name);
> >>>> return buf;
> >>>> --
> >>>> 2.47.3
> >>>>
> >>>
> >>> Tested this patch, and its working as expected.
> >>>
> >>> Before Patch:
> >>>
> >>> ./perf list hv_24x7 | grep -i CPM_EXT_INT_OS
> >>> hv_24x7/CPM_EXT_INT_OS/                            [Kernel PMU event]
> >>>
> >>> After Patch:
> >>>
> >>> ./perf list hv_24x7 | grep -i CPM_EXT_INT_OS
> >>> hv_24x7/CPM_EXT_INT_OS,domain=3D?,core=3D?/ [Kernel PMU event]
> >>>
> >>>
> >>> ./perf stat -e hv_24x7/PM_PAU_CYC,chip=3D0/
> >>>
> >>>
> >>> Performance counter stats for 'system wide':
> >>>
> >>>       2018866563      hv_24x7/PM_PAU_CYC,chip=3D0/
> >>>
> >>>    229.938231314 seconds time elapsed
> >>>
> >>> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> >>>
> >>> Regards,
> >>> Venkat.
>
>

