Return-Path: <linuxppc-dev+bounces-20148-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E6FFF8860
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 06:01:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3tH108qXz2yRn;
	Mon, 27 Apr 2026 16:01:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777269676;
	cv=none; b=oF2qRvQIHNkf2rJwsEN3lFgzg4ZvAAaJr2Qc4atJXaCCXx9zMeknAU7Tp11j8LILHlVe4s7tD7eiRxXyeJGBmPJaGkptK2zWbzsd3nEHGo21XxojpT1QZORENITSDg3ylN+hJvj5B5Iuv76LJ80r7AY2SLK4+rXbfLjp91Jl1AEub/QZZpXslNDzoYKu6m/2jc1O1GMmlWir+kzQTuDO+cpazhFT3YpvIwCWzbBCl5vSzK0dsrOYJD1SK5z/ItB+2nfRESa0oB8WIEHycLfbJ6Q0eRs7UJGdbPeFMmL01MJ93B61BHSxWfK9w0CQ2r/0DghkyXzT72mGBzgumhhqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777269676; c=relaxed/relaxed;
	bh=ZPFSyJ119V9eY3Bjg3qFcrTFiGdGYRlK/M2LQ+uZfvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+J5i02WcU/31vSGFqwoMAkbHT5h/iIwbzr3jyXLyCFneMPVHomGdWxMC+E3fm95ilKv9qzEsiyP3LtNqFyuHo/rrUJVeuNnnbQOUsiJUl6bbVJCn1eSU6Xfbg/ZwPiHijw/7gM7UVmZlOVMDe9v6i6vr+gajQcIKlcGZ/jdkeJx/PK/F47nr2xviaDBRxjxj2p6amyhkLFI1O5r24VaIfVA41/6IIF0bfqsL6PnjLa/Gxh7Xy3JLFVDfYm/kcB5G8XXuCo53I38WMDWTmGf9b4p+4bzNTlJ4iFyQWMLF5L1L0Wj+nfwJiDyh39WQALfgD3Ju7NYK/2T7EYZpruMVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Dpyqipqy; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Dpyqipqy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3tH007WRz2yLG
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 16:01:16 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B35716013B;
	Mon, 27 Apr 2026 06:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4705CC19425;
	Mon, 27 Apr 2026 06:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777269673;
	bh=g9npv5wxukUs9LKrIQ3ajPslQck8l4k9MLfaWhvJBzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DpyqipqyrIZWukguFhhrEmw9M4POHp3fIV5oe9SsFzJ5e83ykzvESZKvmfAjjCshK
	 XLL39NSCWwT6sq9Sv2t6Z/ey5N1kZF7CQd35rfJEwh7L7DFFwnh0f9/W6YjvdLPAWP
	 SAN5E2QlTZxeHVDgj1gkbiYQsD1D3KMoVd77Ovcfg+1Dxe25/Thvi5wplkbN8vqbxp
	 ij/jZ2sN/6Hfhimj82ZzEXzjfwlYWYe1iLGKUlyNw9RwIQ8CSqlONoMfw7I7D2jwk7
	 fVuAG3MWr64HGDfUo0+xrDVN4y/oWnRPzAsCF37KJRhg3huMMlsqtJc/5Emeza6UWf
	 d0ZnZpARSBT0Q==
Date: Sun, 26 Apr 2026 23:01:07 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
	Shivani.Nittor@ibm.com
Subject: Re: [PATCH V3] tools/perf: Fix the check for parameterized field in
 event term
Message-ID: <ae77o7IID7uC6hOZ@google.com>
References: <20260426080056.16558-1-atrajeev@linux.ibm.com>
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
In-Reply-To: <20260426080056.16558-1-atrajeev@linux.ibm.com>

On Sun, Apr 26, 2026 at 01:30:56PM +0530, Athira Rajeev wrote:
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
> Other changes in this patch:
> - Replace snprintf with scnprintf in buffer offset calculations to
> ensure the 'used' count will not exceed the "len"

Please split this change into a separate commit.  Ideally each commit
would do one thing at a time.

Thanks,
Namhyung

