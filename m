Return-Path: <linuxppc-dev+bounces-22065-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A64CD6E6E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 21:52:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWdb44ddCz2yrw;
	Fri, 05 Jun 2026 07:52:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780609952;
	cv=none; b=kHhy9qK5eyhhhG0riVHsor/I1QaTP5vr6dPUIWhp9f7PQTEkXuHtdThg1+BwRQZuZDPsEAqmTXQg11KBGM1pd1+0evj7G27bJLY3JiqTX4apXj3bSwUs7QW9Si6gs4HzyED8Ukolb8okKatxQtUuAv8Yl8bsBdw0jyEBPaAwe8ioM9iPcFOrMEacSMg+b9CSdS644BfyLaOnuQFkiNSBJLv+qpi5DqT2bGFg8zSQI0j5YhXOMB0si0CB5bxvDoXYv7l1eUVmLOjMGVgT7enAkAk3+0IgD3kmSX0T06merGV5rXOmo5jbNSHoQf5R0NS5H9tvUNwcSC5RpxdcE+MoqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780609952; c=relaxed/relaxed;
	bh=fEjGHV8Fh+4Wvs1j80TCC9VXLoykQeG085QL6MDeL48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSgMlMJ96jdf/jD9rtTWyVKXmQo4sNWeOKT4eoDV/5sY15mqg0QLDVk+I2afVDsRj1EwrxCrQqvvryrBe4xhKLUPPlwEb8oMNR11DmHb9QfShJHcv3oQnwp5b6LBEDkJvDatpL4+tlEWo4L5y9H235fAskFvty/1EzysAK96cWRDgpQzwv4eXtRDk9hnTNkOSU0jl+K7GP/+Ez+/aXfDnXDb1ZAjtaG6O+uAA8FQBvLjUWF9b8YxS6sUKOBCyP1mTb29geEVoUp5FHVcUVctBJF+vfYpwLg8gRhBkJ3h2JcBkDOnLdIHXpoV9elUlmww1rpjy4A1RE9SPZ93TSeWug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i92lQs6h; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i92lQs6h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWdb35R5Pz2ybR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 07:52:31 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0ED8140A5C;
	Thu,  4 Jun 2026 21:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0DC1F00893;
	Thu,  4 Jun 2026 21:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780609948;
	bh=fEjGHV8Fh+4Wvs1j80TCC9VXLoykQeG085QL6MDeL48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i92lQs6h8zWfthmQ+p5z3z+wlWuCZc3L20OkLbLNFHFZYQwh660n0A3HPg+o4Fz7p
	 O//xcHsTpMk7nDQ+xlo59mTNgu+gP253y2BNM1UBhL53mMVu6CQRcvCRAsWDUCUsrd
	 O3WNqjQS8+yfyV7P507ddrSYZ75HJMI3+Od3R7ZurIQU5TtbHTszNX+m6uwHKdLUYw
	 35/cJ9HBBLoBiZJ7jquAYVrX36l4EuudHoPmi5Fqyp2xgno9FVdIfRnwO/KfMYGvGB
	 Jrw5+17mcFgFqW+V7lZXLK1/w9ESNn+tyRnHJoncKADWrdx3kEPZ6auH9Zu8YGFX7C
	 zWs8Ck6WuiCKA==
Date: Thu, 4 Jun 2026 14:52:27 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
	shivani@linux.ibm.com
Subject: Re: [PATCH V4 1/2] tools/perf: Fix the check for parameterized field
 in event term
Message-ID: <aiHzm5SJskW1FbSs@google.com>
References: <20260504154205.21394-1-atrajeev@linux.ibm.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260504154205.21394-1-atrajeev@linux.ibm.com>

On Mon, May 04, 2026 at 09:12:04PM +0530, Athira Rajeev wrote:
> The format_alias() function in util/pmu.c has a check to
> detect whether the event has parameterized field ( =? ).
> The string alias->terms contains the event and if the event
> has user configurable parameter, there will be presence of
> sub string "=?" in the alias->terms.
> 
> Snippet of code:
> 
>  /* Paramemterized events have the parameters shown. */
>        if (strstr(alias->terms, "=?")) {
>                /* No parameters. */
>                snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->name);
> 
> if "strstr" contains the substring, it returns a pointer
> and hence enters the above check which is not the expected
> check. And hence "perf list" doesn't have the parameterized
> fields in the result.
> 
> Fix this check to use:
> 
> if (!strstr(alias->terms, "=?")) {
> 
> With this change, perf list shows the events correctly with
> the strings showing parameters.
> 
> Before the fix:
> 
>  # ./perf list|grep -w PM_PAU_CYC
>   hv_24x7/PM_PAU_CYC/                                [Kernel PMU event]
> 
> With this fix:
> 
>  # ./perf list|grep -w PM_PAU_CYC
>   hv_24x7/PM_PAU_CYC,chip=?/                         [Kernel PMU event]
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
> Changelog:
> v3 -> v4:
> Updated commit message to show real example
> addressing review comment from Namhyung.
> 
> v2 -> v3:
> Split the strstr correction in a single patch
> 
>  tools/perf/util/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 23337d2fa281..0b8d58543f17 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -2117,7 +2117,7 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
>  						   skip_duplicate_pmus);
>  
>  	/* Paramemterized events have the parameters shown. */
> -	if (strstr(alias->terms, "=?")) {
> +	if (!strstr(alias->terms, "=?")) {
>  		/* No parameters. */
>  		snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->name);
>  		return buf;
> -- 
> 2.47.3
> 

