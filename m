Return-Path: <linuxppc-dev+bounces-22064-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D03CD6E6E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 21:29:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWd473zcpz2yQG;
	Fri, 05 Jun 2026 07:29:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780608551;
	cv=none; b=W+XPgoTVRH6nQnopQgvivt1XazqjHTeMkfuZx7CMt3IFY+7NNbDIgkRFTEK7v1muGVQTibRPcfoJtclz0SYzsfvpcJC1Lrvx8crxm3cicmreJjqGmg2p404gwzch9arHp/9wdeEjUNTraQoGE8WidI1WSOTJqmaVx6f0jFthHKPi3otDQuTcfrCkUaZo+omLqmRUkps0xLV8tZteSfrokQ5o3IK0i3SRzhm6w2tGU2ENqM6o4/wN/M/lkF48zwxJMFMVeF8t1Ci1EXmWwnje+fHJu17emg03gk5hNK2W3JzT2dk3OCcidlfrQ4Sv94ONMKwm/1jrs9Lx1upoffpz9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780608551; c=relaxed/relaxed;
	bh=c6ckXz0jHSF7OlhU8goFIPNCoGt+kO4377K8w7qudg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDjHuIq+1sG0Qqde5ZLbO1xS93z2rpb4v6dl0GlsugT/iMp+BeDZkaOR9df/ZgBwCiknmr4Z6G9Z3gxGcKSikP9jlgIry3A6ukY/vNGT06PYDHXCDC223j2o/ROxxiUr82WqjIy05HoOJ5izP6tKCt1I9K3e3ESEwQnI17QYHjlUd/S8lBSLIh5+Urp9jT9Yz8zLrvTD1bFFjUxW0QyIinj69cSdBw8ezIPJTLfbFrf2dSMnRxh3L7kBDJGPPYTO2sRQ8JLUO5b4Kot6e/i+N3LpM/aBX1tfY16iE1/ajTT8pH6N/M9Mml0Lfb925C49FIazIXWluFmSqCBhVsJu9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gK5jpFJe; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=acme@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gK5jpFJe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=acme@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWd465rDZz2yH5
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 07:29:10 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E2AE760052;
	Thu,  4 Jun 2026 21:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0483A1F00893;
	Thu,  4 Jun 2026 21:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780608547;
	bh=c6ckXz0jHSF7OlhU8goFIPNCoGt+kO4377K8w7qudg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gK5jpFJer05CeHIirHxe9UPKOJ6T5GPCa3iSNqlkx7TksW9YKGzBHWezDJrSeEETS
	 qwTI1ZR2jMJPv8Aza2SoSZnxJXb+hrpcnVb3Xxj0yvhFXieHoJNcYQcqIYMshrRTBh
	 q2MxsFDH/17We1QV0FxywgE+OwFg3VLih228G5tRmJHdXy5fm8cvhbfWD3k13eihQO
	 mr+AN4G8ef36B/B85WZe/oIIBW19HoVZKK+1z/ZjHFbtTnLOOJR23J9Ec8f56I0fvO
	 o1P3JhzrMr8AnQPpqcu2ezRSlg4itkyQ5c9ICBq34a8oTHDDNMr23IXjTC14zRYhxu
	 QU2do/HWbwvUw==
Date: Thu, 4 Jun 2026 18:29:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Tanushree Shah <tshah@linux.ibm.com>
Cc: jolsa@kernel.org, adrian.hunter@intel.com, vmolnaro@redhat.com,
	mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
	irogers@google.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	atrajeev@linux.ibm.com, hbathini@linux.ibm.com,
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
	Shivani.Nittor@ibm.com
Subject: Re: [PATCH] perf data convert json: Fix trace_seq memory leak in
 process_sample_event()
Message-ID: <aiHuIBAIgv3L6TI7@x1>
References: <20260604065519.112101-1-tshah@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604065519.112101-1-tshah@linux.ibm.com>

On Thu, Jun 04, 2026 at 12:25:19PM +0530, Tanushree Shah wrote:
> Unlike the in-kernel trace_seq which uses a statically allocated buffer,
> the userspace traceevent library's trace_seq uses a dynamically allocated
> one. Therefore, every trace_seq_init() call must be paired with a
> trace_seq_destroy(), otherwise it produces a memory leak.
> 
> In process_sample_event(), a trace_seq is initialized for each field when
> formatting tracepoint raw_data, but the matching trace_seq_destroy() is
> never called, leaking memory for every field of every sample processed.
> 
> Add the missing trace_seq_destroy() after using the trace_seq buffer to
> properly free the allocated memory.
> 
> Detected with Valgrind on a perf.data file with 2,729 tracepoint samples:
>   Before: definitely lost: 55,537,664 bytes in 13,559 blocks
>   After:  definitely lost: 0 bytes in 0 blocks

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
 
> Fixes: 9d895e468429 ("perf data: Add tracepoint fields when converting to JSON")
> Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
> ---
>  tools/perf/util/data-convert-json.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
> index d526c91312ed..6dd9349ab10f 100644
> --- a/tools/perf/util/data-convert-json.c
> +++ b/tools/perf/util/data-convert-json.c
> @@ -257,6 +257,7 @@ static int process_sample_event(const struct perf_tool *tool,
>  				trace_seq_init(&s);
>  				tep_print_field(&s, sample->raw_data, fields[i]);
>  				output_json_key_string(out, true, 3, fields[i]->name, s.buffer);
> +				trace_seq_destroy(&s);
>  
>  				i++;
>  			}
> -- 
> 2.47.3

