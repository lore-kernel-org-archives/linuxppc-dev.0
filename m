Return-Path: <linuxppc-dev+bounces-23981-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7539C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 00:41:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxCgk6tLXz2yYd;
	Fri, 10 Jul 2026 10:41:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783644082;
	cv=none; b=d/xNXb/CFUw+v+vS/UIoHzm3Ke/M5ew8R/D5hiPhbGA0MX/+qj4uQ5XzxcBEDBuQfuNnD3Bxy5C0kqErwNjEViFUxUUc6A1IvtAvs9zF2BbElL9Mic5MrpFKtm8PJYDbgUokwBIEpjg2bgzyi+HyFrNLcgp72/1YxXjf+gLhMBYLYCJg4B2BSSAH73AdpibeFzba3Lzqk9Ta+fIONGu2tv7q75JotcHrf8AX/H7j/3YweoupXwusOYBOTES+vjATFja3GUxMzpyvGePZ90lahIujcPdwsYFH3Fqywecy+NkLLFK7sytj28qNXNu1XEY9h2nTSmNQ9/3eKO7eIJiYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783644082; c=relaxed/relaxed;
	bh=5VzLkHlF85viHKbnz0EyQRjrR1wmiefUtKtHMcklHCM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TRlHttqUg+Ru+lS20UQnUAvFZDOq5hMr+g374ex3JfgTY0fYkYkjVRCIRYNO8HMCuc5QNqPx9PBPxsPQH6X2vEgK/ZaQn1Gd8OZXPdmVzHXFAL/rjfXFijsowDpIZ6lPlfuN7lRKVq1WQnVl06NyrkaIiX65UHQLAYzPV5QJRZPR90HVOSH107a6j1m9j1Oqbs+JJHNVZ/19o19ZdPN6c6dNcndmBMxhvTmF1tTXWCivG3A3s5HXgZQfe9Pp+R02+GX8/I5Vp6vMMUJQM/kbvshIulNOhG2HkNLO/3crgZRtU+4T2zILtUcjVM75rlcxUdi2HL8ADazncXFi7Kipww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FGwPTUFx; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FGwPTUFx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=namhyung@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxCgj6kfLz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 10:41:21 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 32CD641327;
	Fri, 10 Jul 2026 00:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5AE1F00A3A;
	Fri, 10 Jul 2026 00:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783644079;
	bh=5VzLkHlF85viHKbnz0EyQRjrR1wmiefUtKtHMcklHCM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FGwPTUFxKfWwmvUsZH2I2nekEUiKCIKVpeVSpfNyMtvvaZ0n+ZmBFg8oZjnnMTwdD
	 KfPmxnmSuRU/Oo6qnsumCfsoPlHArCyYvpXNm+fOCMHydnw8FKF5CywBAEJEW/omKa
	 f0JO9/lzD5U2awuLdlt4Z+/IpX9iYbsGOA35dHxrJx8gH9loyv8J21Bn1TyWC46oBC
	 pr9YSrpnkQENJAtu6Rvq7JS9zdg6ugYjgrlOt6isGMMg1Ft6e1YLLIRV1FT6mFj4nl
	 lhX8/ZN5ed8am98F7Ok4K/lZ0/oe1ka2MipL7hdQdL7X+CDmRXrHXiJRQ34n9nCrqD
	 bXByme0aqt/hw==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
 vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com, 
 maddy@linux.ibm.com, irogers@google.com, 
 Tanushree Shah <tshah@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com, 
 Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
In-Reply-To: <20260708112607.548304-2-tshah@linux.ibm.com>
References: <20260708112607.548304-2-tshah@linux.ibm.com>
Subject: Re: [PATCH v4] perf dso: Fix kallsyms DSO detection with fallback
 logic
Message-Id: <178364407868.1457655.7985344242070155598.b4-ty@kernel.org>
Date: Thu, 09 Jul 2026 17:41:18 -0700
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

On Wed, 08 Jul 2026 16:56:08 +0530, Tanushree Shah wrote:
> The current kallsyms detection in dso__is_kallsyms() uses the
> dso_binary_type enum which fixes the issue of kallsyms being cached in
> the build-id cache for out-of-tree modules.
> 
> However, during build-id injection in perf record/inject, dso_binary_type
> has not been explicitly set yet,so dso__binary_type() returns
> DSO_BINARY_TYPE__NOT_FOUND instead of DSO_BINARY_TYPE__KALLSYMS for the
> kernel DSO. The current check then fails to identify it as kallsyms,
> causing build-id symlinks to not be created in ~/.debug/.build-id/ and
> perf archive to fail with "Cannot stat" errors.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



