Return-Path: <linuxppc-dev+bounces-22429-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8838ACD98C7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 20:06:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbGxz1ncLz2ysW;
	Thu, 11 Jun 2026 06:06:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781121991;
	cv=none; b=LMkQGOzPerYMxSrruLL16Zpb4ppfCzKZf0sZjL3U8r8LwRUxP1XQyfnhg1kCWO5aROu9J4WJV3bYSldAT6lI30z2+0wkfCMJd37Qu4lPG0C5sIIjbFC3bKLDYd4tigPuvRd/OhtPeDgG5UB6b2EfEOh302vWaujUEN6aUYTdKonbRCTNe7JqjLEI4RKaxnSo3LDWsihtoBv+lE1KE/gRrNaatmWSgAEiixGCpendhjlFe2XvHL5BCfi5d2zOlily9OtA1+pQoYz6M0F91l4tXqC/pJ/a/dMigtgX5cpBU64mGzGyXAPWbiet9tlXcwvET3FVa41KpMNOu481ShpHfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781121991; c=relaxed/relaxed;
	bh=rCaUEECqrgHzs+l+C2U3sMRyDVHTVG4HuRBcFAotcnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghA2EcvPS/dBo1m/KAEACAykaG/5m/UTwj78AWTpW/E96W6dJDTxUZZ8mUAgQg0qFMpvy3jCCEiRoKIZw7CXOWzJPW6yYKZoIXlC4KPCpM69J0b6F0mvmVtcDtIYxEL6QFJmq/2W4ZQsR1Uy6Pe6opadSjfSNpkxODFRZ21PjJ0es3Ai5y6fnnZP5UILt6x8ri+Ky7mSyGPb5FxfAcFfhKCpuyaVL2sssONOaUW01N6/R9Kt++FeG+r+wwwmFUaZrsVMl4FzRgvekxJk1jJHDuyZ2arIQga/T+/RDV6xSxjjs5qErUNmPj71UZcuMhXM39nNZ2Tzabx6XHNoGNJ8+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RHDmgsSO; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=acme@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RHDmgsSO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=acme@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbGxy1TdZz2yfD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 06:06:30 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 73E27601DC;
	Wed, 10 Jun 2026 20:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478291F00893;
	Wed, 10 Jun 2026 20:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121987;
	bh=rCaUEECqrgHzs+l+C2U3sMRyDVHTVG4HuRBcFAotcnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RHDmgsSOwly/2yH/0h6ucWMbtmVDE3hlA2WdgHnUUfP9nObgl/QU6+Nh5Y7KG/qgO
	 lJXFWRCEc6INDgb4b2j1RY5ezoW+HyXcDUF2Y4+gFc8WirYMQZgGCeswYcHvLBg347
	 YIJNwHmCgbSftZhQ6hHyXgFfzWIVYnX/F3LKZ1F5ApL28E1XG1kj09ROXphb8oXd/h
	 9+0h1ch+u0lrVLwXyMe94Vx4G/NSIw2DWC7Rl4YTlRgkcpLv7mvc/X4vlC+4Q8QQB2
	 K9KQjBEnqGViPa4qXl5Sr4J+GPsGxAQa97fgMqI9hSKOQB5BJqoSoeDuWjcHaevDtM
	 MR3aV5PS9NkjA==
Date: Wed, 10 Jun 2026 17:06:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Tanushree Shah <tshah@linux.ibm.com>, jolsa@kernel.org,
	adrian.hunter@intel.com, vmolnaro@redhat.com, mpetlan@redhat.com,
	tmricht@linux.ibm.com, maddy@linux.ibm.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	atrajeev@linux.ibm.com, hbathini@linux.ibm.com,
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
	Shivani.Nittor@ibm.com
Subject: Re: [PATCH] perf data convert json: Fix addr_location leak on
 time-filtered samples
Message-ID: <ainDvxug5fvibbbR@x1>
References: <20260606121528.406919-2-tshah@linux.ibm.com>
 <CAP-5=fUOUtbfXXtGdSYrg1SfuTryNqFPknKWDc=4MxK==m6+VQ@mail.gmail.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUOUtbfXXtGdSYrg1SfuTryNqFPknKWDc=4MxK==m6+VQ@mail.gmail.com>

On Sat, Jun 06, 2026 at 08:47:37AM -0700, Ian Rogers wrote:
> On Sat, Jun 6, 2026 at 5:20 AM Tanushree Shah <tshah@linux.ibm.com> wrote:
> >
> > When samples are skipped due to time filtering in process_sample_event(),
> > the early return path bypasses addr_location__exit(), causing memory leaks
> > of thread, map, and maps references acquired by machine__resolve().
> >
> > These references must be released through addr_location__exit() before
> > returning.
> >
> > Fixes: 8e746e95c3e4 ("perf data: Allow filtering conversion by time range")
> > Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo

