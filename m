Return-Path: <linuxppc-dev+bounces-19178-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AC31112240
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 23:48:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmMBB5CBcz2yZc;
	Thu, 02 Apr 2026 10:48:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775087298;
	cv=none; b=c7kCdLdyx99fi3xDWQA08Oxhc0nCH196/taEJpWtdmiGZC+PkwkO4LoBcJwsEoF5rEgnYT0bx4uZvdQnk40YohVz6BaBxhgIYtMBt3fDDCHbjbR1HTS7If9tzC0AS4xPQLbA+MHOW6Z9VOcV9C3d+9zQkbuHgx9lZE2bF8/e2pbGDWFgo4pbCU+d/4S2CL3nB2DxwJ6oHATNtTDcJ94wQ58biBaS88Q9AyCBj45KtNSZ4ZvgN4UbyGqXVHReEfhxwjylTlrWyAWX2tC8XFTbnj8zNzpW4dD+OPKPD2tFuVjXzTxAx1aAo8lTWyOW75c7hcE/pdA8KcNE699ddNaTyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775087298; c=relaxed/relaxed;
	bh=ndnQKZtZzxkSv7mv7ZJyOde3vGaKYjewT1aqtRj2w6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sw2Yaz9x4KUzRd/+pHdbqdCABB3ajVj3KgoRyAjhiXVCBEqL7hgTftbWuBgZ3O/c6a+OXDqCj6Rm9FJ/auj9UMYPOCYPUKJiCbI4uj5S4V7Mhd/hRTX0Ske6zeEn5pLijEDspFyff2apfrg4t9SkjtXj/1Xigna0EF4AZnxJrT0+5KupqtcRPAiHjV8QnjEd5s19he9YP93CC4rqXPbMILUWFnCt0WvYVuEmkBvU+waL6N746Y+39J3HNQwGK1ToXMG3F1BRERD3fm2xhJh8YmfFDi8SgbanHbY4hVVxCqGHeq7+6P4dP0qL/j3bYiX+dOG2rWTO7Wf02CrRSCKGRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=K6mfWRRo; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=K6mfWRRo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmMB96tSvz2ySk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 10:48:17 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 84FDA444EF;
	Wed,  1 Apr 2026 23:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39E2C116C6;
	Wed,  1 Apr 2026 23:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775087295;
	bh=NGZttMNJ9EWXO/Q81Wa5rkHXP+XklwmmmSU7SV71jlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K6mfWRRo+anvEdrq+IIbqrL6UiwyXlPhr70lg2ciUAhs0P+tjbMRbVvay0NF4jRna
	 zGlIFHaNhu+drsEi5vynwiCHjwad0DebcTunXFG+hzgSigh6GQ8/Hl6oyn8tHP7JsF
	 4f9urXtA3wiSxQrm1RCr3YOXZ/1vz7361cq49AN1ymCJoEzPgJuw3Y8oupQWPIa7hd
	 vwrn1Uid5A9vf3rBpe7nA9zZo8bMAGPUJaCVplrVpPd8Gel2j7NvbQaueXbGs6yZt7
	 4t3Fhq8FaH4kGY1vKwIE+C4CEgnkxMCc3pCXfIjQ/7IsesA+qFJfiogJSNhiagpHmV
	 wJnkW6xGMBqjA==
Date: Wed, 1 Apr 2026 16:48:13 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Venkat <venkat88@linux.ibm.com>, Athira Rajeev <atrajeev@linux.ibm.com>,
	Thomas Falcon <thomas.falcon@intel.com>, acme@kernel.org,
	jolsa@kernel.org, adrian.hunter@intel.com, vmolnaro@redhat.com,
	mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com,
	Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Subject: Re: [PATCH] tools/perf/test: Check for perf stat return code in perf
 all PMU test
Message-ID: <ac2uvTXI1iknXwyV@google.com>
References: <20260315105751.86835-1-atrajeev@linux.ibm.com>
 <7B7E5C6C-D15A-4B79-925B-B5F3EDD84774@linux.ibm.com>
 <CAP-5=fWxDouXfCV3Xzk5JdouidUOaNqHBfZaf_c9JoEA8Ft-7g@mail.gmail.com>
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
In-Reply-To: <CAP-5=fWxDouXfCV3Xzk5JdouidUOaNqHBfZaf_c9JoEA8Ft-7g@mail.gmail.com>

On Wed, Apr 01, 2026 at 01:40:47PM -0700, Ian Rogers wrote:
> This looks like a latent Intel cpu_atom PMU bug. Thomas, wdyt?

Are you ok with the change itself then?

I'm not sure what's the expectation when the test runs with a regular
user.  I assume the intention of this change is running as root..

Thanks,
Namhyung


