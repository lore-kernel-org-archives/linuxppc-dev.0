Return-Path: <linuxppc-dev+bounces-23558-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CECDC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 23:59:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsW2k0YwBz2xKh;
	Sat, 04 Jul 2026 09:59:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783123197;
	cv=none; b=htFlyu0+wXfJWPMrwxNJwTD6iHNNibZ3ymo2Zurl1Vm/Z+s4JeNG6uTP0BM7vNas27zhHCJ6o9dsUL8QXL/Pj67DwtjNLugzthlqEDAJTxA9bFoDaPiPL09qxWEyTp9uZsQnHAo2O0Rxo+Kphkb77Xa2dmnbEv9eAMlNo7Ul8XXX1azK9hFtXGtVWvxkhbYKYKgRAwDbu4Rl+kMqm5xLdP/YpNRP5+7AZgFEH5dp5zBmFgOZuYvG+wSIEYKTk/WXVWJmhOD+vWjnLE7IIaj1EYtzA41KCdPew73EtuhUc2y21kPLQ0Xsoj2sXvkJmfRDGz+Q9umLZruDWKBt6LQNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783123197; c=relaxed/relaxed;
	bh=neDxvJLZqydMYExJ0EqIpg5nFmchQ3Fc9GHFErQRroM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXa9F35AzzYSDcYYBH2qaIC5teB6A4diF9K2LxhgEGmgWzhZr7dhiZZLDQL9OFhvcx8cEdiAqHBa1CP/Rqm+cvWhXCeZVnKH4l5Vo8YHZ/JPE7YHGQtRW/nThjpV6sTjhbJHM1ABvyx0ONQX+sanrBhMtGrnq/hvW/s6JIWa6ZrZjuj73qsqarCSGdWGTjm+ynWo05Jx1jvE6ybrejOHuXf+fWocN8M5jpg771GRSG0+3fW3LE1JUS4h5vmh6RTqrJ29CpVmLcbB/OtFaObzVccEBTCXKlnJJ/e7stlOgTeutd3QpX5fBt4m9UGGNtliWFCAfn6bJAQKnWXquoFjQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VOtSshoo; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VOtSshoo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsW2h5v4cz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Jul 2026 09:59:56 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DC31D600AF;
	Fri,  3 Jul 2026 23:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042B61F000E9;
	Fri,  3 Jul 2026 23:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783123193;
	bh=neDxvJLZqydMYExJ0EqIpg5nFmchQ3Fc9GHFErQRroM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VOtSshooeVOroaoJJmLAj7EQl8rWwHTcwE8RZj7t9eYCwASLt3GnAEzn2EoCxjIct
	 HWRgDNqL4+2EZRUbvKxuLxjMr53ZZNJJemRld6cT3d0M3Ulf4p+fhrk2mvt0hsBizK
	 wV3+4MI8sNLuN9PlXJ1fMTZzBaTOHOStzYRoRsYJ+KtMCRqQE1QZD0WeaFmwxZ07Nb
	 J9ERdleg8J8KpOZBf8dQf+Puqr9cN7YkPFUlA0QccDpuc6HBsEfp4KXlpRhMV9AaCU
	 aQ7SAsegaDT8m60ZnmXJN18QlCllZ0tLT+hPCwVTnUUi3MDAzrBvC9AtC8R816O2vg
	 bMjlizbJ8nHxw==
Date: Fri, 3 Jul 2026 16:59:51 -0700
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
Message-ID: <akhM9-d-tNjZzb-A@google.com>
References: <20260604065519.112101-1-tshah@linux.ibm.com>
 <aiHuIBAIgv3L6TI7@x1>
 <f6937d04-6346-443b-8054-6f8a801a4fd8@linux.ibm.com>
 <akWEgMBK7Y39sgc8@google.com>
 <bf12f3d6-7410-44da-b4c4-32dc21244a12@linux.ibm.com>
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
In-Reply-To: <bf12f3d6-7410-44da-b4c4-32dc21244a12@linux.ibm.com>

On Thu, Jul 02, 2026 at 12:46:54PM +0530, Tanushree Shah wrote:
> Hi Namhyung,
> 
> Yes, I was planning to send a v2 based on the review comments to fix the
> pre-existing issue.
> 
> However, Arnaldo mentioned that the original patch had already been merged
> before I got to send a v2, so I addressed the pre-existing issue in a
> separate patch instead. The patch is available here:
> 
> https://lore.kernel.org/linux-perf-users/20260606121528.406919-2-tshah@linux.ibm.com/
> 
> That said, although Arnaldo mentioned that this patch had been merged, I
> don't see it in perf-tools-next yet either. I'll wait for him to clarify its
> current status.

It's not in the perf-tools-next, and no plan to add it.  Please send v2.

Thanks,
Namhyung


