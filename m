Return-Path: <linuxppc-dev+bounces-23322-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8F9C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 21:20:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grCbC0RMTz2yfs;
	Thu, 02 Jul 2026 07:20:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782940806;
	cv=none; b=OQZJznnGMW2wrwe6oRPflDwMlCJbkdA7RZxpym66awVSF61mU3f1BfrDiRjy3GT6c+BRYQRZRBmmFD/6zLS4HShqUBn9Zs53ob2FJpqxBEsm2cAWk7Iw94/XViwnsv3IzulvjfscUr6MqNsSY824SI2lJYYwc9DDQCN0kzFiFf5kezLATPDhuJMBWLfA16tD/pJCdNFNNERGbMSSak620GiaRqA2S5BbOFz0kxsIH1a6REX1fim8QaBBAH90XPVX/f9Ad80CfS6EE1rNbms6s7eRwZ5TY3xCpL5GbtuybW6/hAVC9GHdUCY3lPrqLwqoPredp6o0iuzAzziqrMxYwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782940806; c=relaxed/relaxed;
	bh=/2e/5ZFdXtsnqMPhULM83nX8C7FvyJkqUqwDCFA6SkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C95+xXslFYt1sL+5lpVwLyTJBMwJsZoB56BQsUrphzdZ6FyCI4Y28fqePDpSLxLxgeLcpSr1LK3RqoSZmRH71CPozHrukW3j/MTXOaUQ8DPo6WuJd7OyBjUqBnPMpwPf0fTIwJVD01oj9tFEAl0GVsHiK+eD43Wsh4gZK7WBTORoOYfZUuOOTnRA9ynLT44UPi1sOvQwWS7FEEScufliR2TgzRuFLrU9vPam0zEDq+LHypo5hAP74XwHiijmMXRU4PV+43V13g3zBReKi0j1x57qb3xTRJTgnnmoWxsO08VM2wOmkz6yWqZkFikIGlg4nTbaZa5o6eWlvLH3n/qnIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AbO/bPUo; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AbO/bPUo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grCbB0XKDz2yfH
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 07:20:05 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 03BDD6001D;
	Wed,  1 Jul 2026 21:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F95C1F000E9;
	Wed,  1 Jul 2026 21:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782940802;
	bh=/2e/5ZFdXtsnqMPhULM83nX8C7FvyJkqUqwDCFA6SkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AbO/bPUoyA7dXdNuXTJuzhNhIxDsx40WFfG0ZBEW37z8KiKWMhNu48iOuumjPsca8
	 mNTLY7Ya4feQoExh82KHndpMHCdsWcHGLJvUJft8oKnB/iQFJNXnExGfp2jk7uZ6TL
	 i1SQyqbj+XdC31NKTP2XXtzidHU3/jycIKN7sus1wE9EsSDslcJnhKsRKIouskL56Z
	 qpIV5a7Guv9CaRIjRdq8Q8T93NGDOLIxSuLwFg2uAiCbJaqZ3e7EXuaTYTHl0kubpU
	 Y79BSO5Ds+3bqeKwG2N7z6pZDrLYjxFC8nb2MmeS67+ldlxTDR0n64L8oykG3zBpnH
	 jlr25bAsYwR7g==
Date: Wed, 1 Jul 2026 14:20:00 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tanushree Shah <tshah@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, jolsa@kernel.org,
	adrian.hunter@intel.com, vmolnaro@redhat.com, mpetlan@redhat.com,
	tmricht@linux.ibm.com, maddy@linux.ibm.com, irogers@google.com,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	atrajeev@linux.ibm.com, hbathini@linux.ibm.com,
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
	Shivani.Nittor@ibm.com
Subject: Re: [PATCH] perf data convert json: Fix trace_seq memory leak in
 process_sample_event()
Message-ID: <akWEgMBK7Y39sgc8@google.com>
References: <20260604065519.112101-1-tshah@linux.ibm.com>
 <aiHuIBAIgv3L6TI7@x1>
 <f6937d04-6346-443b-8054-6f8a801a4fd8@linux.ibm.com>
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
In-Reply-To: <f6937d04-6346-443b-8054-6f8a801a4fd8@linux.ibm.com>

Hello,

On Thu, Jun 11, 2026 at 05:23:45PM +0530, Tanushree Shah wrote:
> Hello Arnaldo
> 
> Thanks for checking the patch. I cannot see this patch applied on
> perf-tools-next yet.

According to the other comment, I guess you're supposed to send v2.  No?

Thanks,
Namhyung


