Return-Path: <linuxppc-dev+bounces-20393-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2428ACD3424
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2026 01:49:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g84MG4f8Hz2xnk;
	Mon, 04 May 2026 11:49:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777859370;
	cv=none; b=LrQVJO21K4trqIewuc9JUJQ3Ra92TtnlvArAPdEUVOq/E8lZY0mIhnlk71M8a/CsnvPI+Umu7OSMISJYHfGobYQN7mMhKFJRMfpvJlqXPdJGbPOfA/TrbxBXDAItXQ52kRQ93CheOh71YhhLJ31kpDgDP4FgYbuSaQfEupu99XtaKrSnxcNXwlW5eT+jxOEvAz9m7crop/3jz02iJhjeknmNTSi08V2X1zfLiZG1/gM7K5aOl5aOvJKZOYnqLZS/Hi/uCgv9KyJRYMNbSD+n+yDGdxKUMBwE/7AzwYxrgszdqmxv0n6ZFm0A/TIxySEHHAdemedfYi78rdN1IheclA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777859370; c=relaxed/relaxed;
	bh=Qt81eO8NNS2KfY346h3c7m4OLVhwp1AcpRVIMvcwKH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfIYFImLKHQ8Mi7ZgtddD+csnczgh7yHZC05UUhiQ2j4WVfU0tlCLngbmgFgwwZI+huJDcBqRz2jwgWgpw2WG4Sq23nSN8NqZSYM6X4EJovA0p88++0EufK4Tf+5T51xNQ0KM+54Nr0YYiJsf/7KaVBEkbQwBKFCwGi9ULlBlmXR3JR4KV6dHHnIFjau8/17irrByC2MLWCGvuTBo5RozzmugPK5jfB7X2NxGOOM1Mpi0FlKriH3u99uo6LmsZQjqEE18dPcbZzd6RtwasBB13vwINHet7NiVs5EdrPy6lJSfgg44fygAHTwEgXT4icpbbw5kKNofkyc9tt+etNsjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kJncZUcT; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kJncZUcT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g84MF71Hlz2xS3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 May 2026 11:49:29 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4DB32436C4;
	Mon,  4 May 2026 01:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D21C2BCB4;
	Mon,  4 May 2026 01:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777859368;
	bh=UxNq48/xbu0OvKDwkGIsg6liRabxxjbEHw+/9JiWl3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kJncZUcTdPQY5pjU3vl2D7/Zzm4ANjgyl8Al7X26x4TXYHwAMNXdBCIICyb7s/L9G
	 YP6X2CicFiinb14LdH2JW+195aOaA0Rj0GgYkFde83r3MfvVj7qIWN5UY5cljgs0AB
	 l0rORGmOOxg1dhL/99CC+QJWgNTQSBwedNi1JMflEnl1gVN7Emc1LEZ+8IEH73l5Xv
	 Yod4f/aH7Joak6kKk7VGnWN2EZmQIQMfeImh6gcnE6K4tY4oOSFkMsbxZ+0sKoNGSm
	 PPMP1gLMsSqAtgG0aD2iQkdD91dPeJAyWzeXPFXYUW57tEx5Xh6FKgRIcXbhhVLnVM
	 uHVT54pRnBsdw==
Date: Sun, 3 May 2026 18:49:26 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
	shivani@linux.ibm.com
Subject: Re: [PATCH V3 1/2] tools/perf: Fix the check for parameterized field
 in event term
Message-ID: <aff7JnNuWpj4Mvss@z2>
References: <20260502141258.17128-1-atrajeev@linux.ibm.com>
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
In-Reply-To: <20260502141258.17128-1-atrajeev@linux.ibm.com>

On Sat, May 02, 2026 at 07:42:57PM +0530, Athira Rajeev wrote:
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

Any real examples?

Thanks,
Namhyung

> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> ---
> Changelog:
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

