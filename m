Return-Path: <linuxppc-dev+bounces-20392-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4258FFF885A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2026 01:47:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g84JS3QGBz2xnk;
	Mon, 04 May 2026 11:47:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777859224;
	cv=none; b=A17k0fDIht+9VVpCoksrIVdrLsqZnyMq12Zlxe0bAOPBxR9PQ/4D99JDoY21HnyE8+2Y23mSBma5rsDFrS5vlmRTAW6KOLQbHpEdmAjDkkOJGHkim5QfyOwsFEi1w3fpUgTa5Nb2cCEpYTsIq4gsn9NElf/V+OKwzw9fygbjZpW7nvoknTgnTLhJfuD/qk1nhBAAuWdKjwNKbzdfdaHWble4Iz9XiRbjkFuCJJYIy/v8blyH/HjAjfit3W/S1kR69aYkqEOILQcMLXv4pfxx+C3NItx81eOJExNhXeTQRxaiQdeewUgUkA2047bjg9r+Mg6LQsLGjkz4gB5oe7tuow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777859224; c=relaxed/relaxed;
	bh=l83JPblI2xpPWiUuHLQn3dqCdXQh0232jGQ5cbj49RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDAktv1Nshfusq/GTMQjJk4TnQdZ2EvEinpRdv1vxzaCcMdtLvstB8leTqsmoKMqqoXem9zIHEa2nq5tULr34UrHcJBh+AygFR3GINXfhoemCa3DbzGEkdyhz3tYQ5vt8Y/wkUXtkrD4QV1ZP4kHIiXhlthAbWPuIutzDTsXUZDeVkZ4kBEj+lmOYD7eNdoKQZQyCc4IoAQ3f2k3H3W/PFod627fuorelxi+NuC1gg5HLmwD7JG41CGMaQil1eObLiT/MizGwCcEBbTAq5/MrL0EadHSbVAD6pHMrc6INDgt2zlrqwUFxfs//fIXaT1U2e/uGjer85zndBFIzFCZJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SYPcucvu; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SYPcucvu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g84JR42yJz2xS3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 May 2026 11:47:03 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3595F416E2;
	Mon,  4 May 2026 01:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B05CC2BCB4;
	Mon,  4 May 2026 01:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777859220;
	bh=LISybazuiphZ0cqm05s0nNTtnkzBdC2nqyKFogowcyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYPcucvusnuc5wQGdLTQTBCtz/zPPDAYs9L3s+CHsjn7nA1YcwOHCiAUQjOgAiKhJ
	 l9JWNGAuvTt24GtAITaCHwn/myE1iJ8aSTrhqTHzAHSgwpKUHrUCqnu+npxPkkMQro
	 +d74GEqqWekX8HX0JkJ+Cg2C4EerRXpl0fbU2wV52s8sCBPgJCCu0Ess9dMFf70E0Z
	 TwIZLUIVCcPKIuojOLWVxh/r6yWFl7Y/yP0lTpvY3CVapgHeM0o5bDJcikuV6R2nzG
	 E777Wa5G11D1NXJSElD3CLKZr022Ia8w2QOszCpa/Bj9YD8k+WHukTnGORy/Bfc6pt
	 aA0naU+aW7Q+A==
Date: Sun, 3 May 2026 18:46:58 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
	shivani@linux.ibm.com
Subject: Re: [PATCH V4 2/2] tools/perf: Add kernel-doc comment to
 auxtrace_record__init() function
Message-ID: <aff6kjIr-KL3Onuw@z2>
References: <20260502143237.23456-1-atrajeev@linux.ibm.com>
 <20260502143237.23456-2-atrajeev@linux.ibm.com>
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
In-Reply-To: <20260502143237.23456-2-atrajeev@linux.ibm.com>

Hello,

On Sat, May 02, 2026 at 08:02:37PM +0530, Athira Rajeev wrote:
> Add documentation comment describing the parameters
> and return code for auxtrace_record__init() in util/auxtrace.c
> 
> Using "struct evlist *evlist __maybe_unused", gives below
> warning with "scripts/kernel-doc".
> 
>  # ./scripts/kernel-doc -none tools/perf/util/auxtrace.c
>  Warning: tools/perf/util/auxtrace.c:912 function parameter '__maybe_unused' not described in 'auxtrace_record__init'
>  Warning: tools/perf/util/auxtrace.c:912 function parameter '__maybe_unused' not described in 'auxtrace_record__init'
> 
> Updated  parameter as "struct evlist __maybe_unused *evlist"
> With the change, there is no erros/warnings with kernel-doc

Hmm.. this is not what we used to have.  I'm not sure if we want to
update them all.  Maybe better to leave it for now.

> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> ---
> Changelog:
> v3 -> v4:
> Addressed review comment from Sashiko:
> Update return value expectation for fail as
> non zero return err code.
> 
> v2 -> v3:
> Addressed review comment from Sashiko:
> Update return value expectation for success and fail
> correctly.
> 
>  tools/perf/util/auxtrace.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index a224687ffbc1..9e11cf4299b8 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -896,8 +896,23 @@ int auxtrace_parse_aux_action(struct evlist *evlist)
>  	return 0;
>  }
>  
> +/**
> + * auxtrace_record__init - Initialize an AUX area tracing record.
> + * @evlist: The list of events to check for AUX area tracing event.
> + * @err: Pointer to an integer to store return code.
> + *
> + * This function looks through the @evlist to determine which AUX area
> + * tracing hardware is being used and initializes the auxtrace_record
> + * structure.
> + *
> + * Return:
> + * a) A pointer to the struct auxtrace_record on success.

I think you should mention that the this function should set *err to
zero on success.

Thanks,
Namhyung


> + * b) NULL with @err = 0 if no AUX area tracing event is found/supported
> + *    (not considered an error).
> + * c) NULL with non-zero @err on actual auxtrace_record__init failure.
> + */
>  struct auxtrace_record *__weak
> -auxtrace_record__init(struct evlist *evlist __maybe_unused, int *err)
> +auxtrace_record__init(struct evlist __maybe_unused *evlist, int *err)
>  {
>  	*err = 0;
>  	return NULL;
> -- 
> 2.47.3
> 

