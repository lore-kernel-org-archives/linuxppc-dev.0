Return-Path: <linuxppc-dev+bounces-4026-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B56EE7717F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Dec 2024 07:07:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y83Sy6lnqz2xDD;
	Thu, 12 Dec 2024 18:07:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733987266;
	cv=none; b=fF2B/MyGO7YsbRyc8DttZuMvLhCMSd7myQMZqAe2RgxT+xvzHo9jGhGArEUZ5ixjGr4q11EXMBzAyfGxP0Sg2ZV9tZkZBfYmQiWwRdxZwdY07Z+SQWXyvVceiKkI5Yql0VZsq9B+hL5q0doMf6rr6tIknVrO8OQlgehTr1e9dD3ip6UJM5WJkgM0+uS3VZp9/hXKh3sjbolwsm9W6cxUAaoJMLr/yQ7KeLS0u5N6iRidoLcnygGbqvOpcphPVC+LV4r0DmHna+CcUCMqPFqvQKz9/OvOzfeGaNNqAi9fCQEh7GmGpNTB2vSlqEF0WteB+WnzKsUs9Q3fFSTPOpHMgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733987266; c=relaxed/relaxed;
	bh=czNGr/DU7gRVEdl0HxMxT5dZZJFC2RwRSsXv2Eux3UU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kBnqLUMhW26y2UFY4ktP2MhjoYe6I2JDZ+CiAFkaDcrVuNkGcI9wA6h8y6p/5vL/NZXSjSuI0GJ1vTSy3ClGGnwqiTIfC1FXBQ5mvOmfo7BvYQZsLTqo3wBqQ+SKU9r7MjV67IO7w/NojqJRnE/kONNQHUi6vKbRGjmLs5KrK30Wlr2dpaVedSZNVG5I0lnD3jx/pEwjp8xooeENz+jFyyKdjhR0KPxWcm377T4n0hrMmS0Gw0pZm/lM8MX0my8mv2jD2kqfRlwEDzWvOorZXUAzncp73LzsS4/rtVV/XOMugJnhq96sqp6pTATs7zuKQx4jQVvGedv4jfnagMTg7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PZs5ksbe; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PZs5ksbe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y83Sx0zndz2x9T
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Dec 2024 18:07:45 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 73054A425CE;
	Thu, 12 Dec 2024 07:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF1DC4CECE;
	Thu, 12 Dec 2024 07:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733987260;
	bh=BPlTTDNDzZrp2N3by7TZVYWXY230hjPm+o9JsvANubQ=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=PZs5ksbeH5KXdOE1XARgM6Gy1gtWiwPlj7cOlo7L0hfjXd4ha7b507N+ENCRvT6GW
	 hHYy/TgKP1cmHNBqukeWWCMLsQEjQr93zhTFKeMsCXkCNZO3l5qW/ANf6P7mBFd4Cs
	 moXR/T8OdAjN71T8n2kSQ2C7PTwIZ6HRQUPnUUF3+ix+imhcxTp/pKNSQXbTWiGf8a
	 bGYqgo6xNIhqIxPhUnSlT1BO1VZGPbVU6mdnYE8uJG/zcbXRcvfAUfz2rAwjdxQt0c
	 sc4CWQcPcKFsfzWKfjq2UCXsENI2EjAD05GO+7xGTz0e0HFO53QeWx9bLywnSgOBpt
	 H9yUh+liNr37w==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com, maddy@linux.ibm.com, 
 atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com, 
 disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20241205022305.158202-1-irogers@google.com>
References: <20241205022305.158202-1-irogers@google.com>
Subject: Re: [PATCH v1] perf test expr: Fix system_tsc_freq for only x86
Message-Id: <173398725978.3728083.17030127353710822170.b4-ty@kernel.org>
Date: Wed, 11 Dec 2024 23:07:39 -0800
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 04 Dec 2024 18:23:05 -0800, Ian Rogers wrote:

> The refactoring of tool PMU events to have a PMU then adding the expr
> literals to the tool PMU made it so that the literal system_tsc_freq
> was only supported on x86. Update the test expectations to match -
> namely the parsing is x86 specific and only yields a non-zero value on
> Intel.
> 
> 
> [...]

Applied to perf-tools, thanks!

Best regards,
Namhyung


