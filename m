Return-Path: <linuxppc-dev+bounces-20146-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AF4FF8850
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 05:43:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3stV5bQTz2yLG;
	Mon, 27 Apr 2026 15:43:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777268610;
	cv=none; b=a8wwfXyFRleD+DMSX24RpBDv8QkdNTodyCSnaAW1gH2B2IYyIUVuLMp5aJTO5X2cZihU01Wy/Oafg+nMKVjz5CJF5KOFMZeuxLS7KUqYjwRlF/N04HQUmjAxC3cgYMu1ifxXl5KyI/3UGFsbq7+XauyxBC0b1wQW8n0Nljxkh8anqLTqOmoc//Mb7XUVzsRv1IF1rB3Madw6Q5oimb3PUF3WBC82/v9cT6w9TOd5Z7L8sdF0+i8K0KDLg1rUjwG8cDm8lWCbof/+tLPu/0osFGDTdQt+LMw9pZGA09dcytG+sQcSChWvFzIkJlmvMj1BuE8QLrbQY0eXHKWbaI984A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777268610; c=relaxed/relaxed;
	bh=b9ufQWSier3sDmtgYRNwZpPbfrF7WrG3rNMuRgB2/tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVm5n7oOttJhzltj4cnT7N6cJKdEITOPth4LMOhCxHIn8yqHdLagpaAfUJjBDUEqYkyjsd00hIEqHAXwxVV8LKeYCED2t+hcoo/5lHQUYXLXN6W5fnHl0hjjWWIVSxq7r0xxszFlg4n+KaI7DMuWm4opKqKrXpZflwGJDk0GtjKZll0IJ3re8iJ20iIIVtdcSDXH4pcZgXoMpPBMOz9oV10bi8g5cJ7ifMkntZLk4ZjChSzsXZjyEcRhklMWuINEuIGLP2VjJgvSMgm1NUKQLU/iFfHigllVvbYLYWuWCse1c5wyso4ol4ZoF9xHm3szgBGnFIbGhYhpp5ThWnB87g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LNIymlgd; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LNIymlgd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3stT1ypKz2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 15:43:29 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EFEFA60145;
	Mon, 27 Apr 2026 05:43:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2A2C19425;
	Mon, 27 Apr 2026 05:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777268605;
	bh=obypYOrhKWdkyuMYPEbMk0GcWvupxXNCqCmfQ4rsGRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LNIymlgdo0oTA3eNJtxUlaMLmLsWJ5k2PxW1BocXrWDQU/fGnZwd7XyiKIKDHP6/S
	 3W+LkC0Wm7Yf2bOM6g45mUO/k0bxqheNDEw12cW0uEAFV6mRjVTSKvhSuI+3tFPfWh
	 z77yIlKB8CcG1ClkoZPQBWKPi/qKNPnMJrU4XeGOzYJi7a/eXI1lB8z+yKLDO3FZsI
	 jYO6HwLV4I1W7sP8sRkkmtBmEDH1att1jnS7nm3XgTVS+llnClS8tnMbjc6Elq73ah
	 2y5bonhep+xtECwts7P7cZJa/DKCBZy88riEG1lV1xwRSr5l7i1DEQIF4TIW6XzkXe
	 MwW+WQGwc+owQ==
Date: Sun, 26 Apr 2026 22:43:21 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
	Shivani.Nittor@ibm.com
Subject: Re: [PATCH] powerpc tools perf: Initialize error code in
 auxtrace_record_init function
Message-ID: <ae73ebdFs8hN98u9@google.com>
References: <20260426064301.90614-1-atrajeev@linux.ibm.com>
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
In-Reply-To: <20260426064301.90614-1-atrajeev@linux.ibm.com>

Hello,

On Sun, Apr 26, 2026 at 12:13:01PM +0530, Athira Rajeev wrote:
> perf trace record fails some cases in powerpc
> 
>  # ./perf test "perf trace record and replay"
>  128: perf trace record and replay                                    : FAILED!
> 
>  # ./perf trace record sleep 1
>  # echo $?
>    32
> 
> This is happening because of non-zero err value from
> auxtrace_record__init() function.
> 
>  static int record__auxtrace_init(struct record *rec)
>  {
>         int err;
> 
>         if ((rec->opts.auxtrace_snapshot_opts || rec->opts.auxtrace_sample_opts)
>             && record__threads_enabled(rec)) {
>                 pr_err("AUX area tracing options are not available in parallel streaming mode.\n");
>                 return -EINVAL;
>         }
> 
>         if (!rec->itr) {
>                 rec->itr = auxtrace_record__init(rec->evlist, &err);
>                 if (err)
>                         return err;
>         }
> 
> Here "int err" is not initialised. The code expects "err" to be set
> from auxtrace_record__init() function.
> 
> Update auxtrace_record__init() in arch/powerpc/util/auxtrace.c to clear
> err value in the beginning.
> 
> - Clear err value in beginning of function. Any fail later will
> set appropriate return code to err.
> - Even if we haven't found any event for auxtrace, perf record
> should continue for other events. NULL return
> will indicate that there is no auxtrace record initialized.
> - Not having "err" set here will affect monitoring of other events
> also because perf record will fail seeing random value in err.
> 
> With the fix,
> 
>  # ./perf trace record sleep 1
>  [ perf record: Woken up 2 times to write data ]
>  [ perf record: Captured and wrote 0.033 MB perf.data (228 samples) ]

Sounds like you need a Fixes tag.

Thanks,
Namhyung

> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> ---
>  tools/perf/arch/powerpc/util/auxtrace.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/tools/perf/arch/powerpc/util/auxtrace.c b/tools/perf/arch/powerpc/util/auxtrace.c
> index e39deff6c857..fe1ea4e222f3 100644
> --- a/tools/perf/arch/powerpc/util/auxtrace.c
> +++ b/tools/perf/arch/powerpc/util/auxtrace.c
> @@ -71,6 +71,19 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
>  	struct evsel *pos;
>  	int found = 0;
>  
> +	/*
> +	 * Assign err value to zero here. Any fail later
> +	 * will set appropriate return code to err.
> +	 * Even if we haven't found any event for auxtrace, perf
> +	 * record should continue for other events. NULL return
> +	 * will indicate that there is no auxtrace record initialized.
> +	 *
> +	 * Not having "err" set here will affect monitoring
> +	 * of other events also because perf record will fail seeing
> +	 * random value in err.
> +	 */
> +	*err = 0;
> +
>  	evlist__for_each_entry(evlist, pos) {
>  		if (strstarts(pos->name, "vpa_dtl")) {
>  			found = 1;
> -- 
> 2.47.3
> 

