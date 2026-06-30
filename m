Return-Path: <linuxppc-dev+bounces-23236-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99034C43602
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 23:36:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqffR4hvgz2yjn;
	Wed, 01 Jul 2026 09:35:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782862559;
	cv=none; b=JYpm3SheU6OKDD6eojIXhKZvKtXjo+HLCmepoKg48gqSY5BwlB2FoXZu0E52MZ05FJa3Sqd0AeyaHdNwyraGNL0uaG/gfY3cXvO5ZTBshD5jD7h2gzcJDgmjl2rQIHs+ph1MdFT3jBnNaMhvnxKMLEy0m17swpU8f1BjX4lUTxTHsWL8NtNdy/d5b80Omtx1tlfGnMcO2zxK1Zq/+BpZ20WSiXAfniutYoRgmbKLOwD7qzelrG+wlKYNCEbe5BaKA4PVmT/piY/ifYQDtM1upgx87dC3eHzTdJFVAVuoAEBSLijyy4Kn/WuVuo0wupFHedVM8llvbcwwWNDbpNdPYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782862559; c=relaxed/relaxed;
	bh=HmFMDFyhQyPzL19OlIThHEGh44G8j5Qf3IksoY5ASOM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KBTCThZv+J99UTjaerMg6ClJv3cPwU4de5qfiMwBJisOppzYbRKfbQ+l4oVpRT0HuEoamoME+cdn9oEBQTfyipZlkjSEqDRZDWLX2edwydE3GkorMQmEGXrZB5xAWD94Tj64MskDKsQuMK7Qz2y38XoHmWQqg7W4Bbc166j0Q52HjQcPGjiaNcnsMwhPclG8UcpxxWBBLh2zwl4Z8wKwwNVD9l7C8c66Pdcw9cYBVMMXZWOd8z9GlWPV5VobzS4c6Ybv9vMqpY3DiHuQqkbGoIx46/8LahhJe+E2dRd4WvzYGdvfzwi6BDxNr2rx+5Lj0ZZYqJ3092vYi8DeprSEqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPQAWvAU; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPQAWvAU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqffQ3999z2yfS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 09:35:58 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D49FC43436;
	Tue, 30 Jun 2026 23:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC911F000E9;
	Tue, 30 Jun 2026 23:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782862555;
	bh=HmFMDFyhQyPzL19OlIThHEGh44G8j5Qf3IksoY5ASOM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=lPQAWvAUrm+RoTwETKNM1dRWqZFMtALxDNmsprBGUZl8yl7wSCs15/DUWraYAir14
	 T+0sDd2nOuOm9Jfi0I5Oxz7cbau2FMeoc2epI5ufD0JXJZzyrsTJ/vJYYeQWopsOBf
	 qhZ5qK/ouu6BCXLhOblGoEXXRykn0YDyoN+aBuky6vqP1770cUt8uKAPg2TuM4eaT9
	 wkuf0RcHplcITd8usAJTzqgB/jnd66hgjErvOli/K492+o/XkLqAgOC3DB/4kMMEig
	 ZNiX/YPDTsu6SnDnexRqWJ7kqMs2yXvcPy+erwjk1Qj8eYyxuscJRc07uszmpuikyj
	 EPvE6lV9kfseA==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
 mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com, 
 irogers@google.com, ravi.bangoria@amd.com, 
 Shivani Nittor <shivani@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com, 
 Tanushree.Shah@ibm.com
In-Reply-To: <20260627090334.67847-1-shivani@linux.ibm.com>
References: <20260627090334.67847-1-shivani@linux.ibm.com>
Subject: Re: [PATCH v3] perf scripts: Add configurable sorting option to
 powerpc-hcalls
Message-Id: <178286255535.2863034.1843900416080780002.b4-ty@kernel.org>
Date: Tue, 30 Jun 2026 16:35:55 -0700
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sat, 27 Jun 2026 14:33:33 +0530, Shivani Nittor wrote:
> The powerpc-hcalls.py script currently prints hypercall
> statistics in a fixed sort order based on the number of
> hcall occurrences, making it difficult to analyze hcalls
> from different execution characteristics.
> 
> Add support for runtime-configurable sorting so users
> can order hypercall statistics by count, minimum
> latency, maximum latency, or average latency using
> a --sort option.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



