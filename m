Return-Path: <linuxppc-dev+bounces-23977-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2892DC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 22:24:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx8fC53Wqz2xBb;
	Fri, 10 Jul 2026 08:24:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783635891;
	cv=none; b=hNyjzapKx3sDPnrz+7yCi9m1Re9Z9R0GMzJEMNgWtvX5qejjfz95p+IV280qVsjNMMDW3h4p98E0T3WkzdM5D0N3GH/LMoZ3/lUzCxKZcch6KGGAKxjYQJ3sEYenMX/sqQfcUPw7ppaLl4G9K3ii6FqmRL4Dn+bIlnTrxsCEB2p1B9AoWnYj5afQ02xIj+pzUdpsQa4utsbzgYcTnADzo94LjxTYyHZ34fpvbmWtPM2NG3XcOu/qMi2ZHowE3YPM+aic9oRqxTTGHdX1CUWi3MwmILLJvEm0dln+srLb9prPjRn6MNUIMjo6vdjuUUIBT/VVyHsW5g+YqI38FAmCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783635891; c=relaxed/relaxed;
	bh=zQzu8TqPo/8WKDkjNpGW8PmCmUjGaPVPmoP4PnbHCE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjygNfwisC6YZ+CGa6WodkyhhdgzeuBj9/kbF6Ap4C65hJ2eIxH6wQ9HX8vncZWIgHRfKDrVQxsK4DVLZ1tU3UysIflSSrq6BkW4hPoCVC76ZGaEWIdMQb+rHLNrNtYJKzaNk1rLSuc/ynFYbqF+bnSs82fM81KYfX6J2OeHzsUW5qer5YNTly6wrZ7SnfdFHwIHMBoiKwO2iRfzLLuJ7d0N8vgihF1nvsuPhCZNUC/FwzHKUB0DJCXLeW5qAHlMv3+wn/85sZPTYQoCPggXh53+Wx3fgjDrkvDc8I6Iwzg5LF+v+tFXk09sTKFR79VKVQ5dAi85P1wvpzQp9A77Iw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aD9ejhsX; dkim-atps=neutral; spf=pass (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aD9ejhsX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx8fB3sVgz2xd2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 08:24:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783635891; x=1815171891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j+SGpxnxcXP2jP/D2FzTuZpBaLImj0yoHLCpJzVrAQQ=;
  b=aD9ejhsX2GoFU96Cv/Bxj+IeOU5ICBcKILPaKVLUcyQ0aDm2VgVc3ojs
   ME6hRl8fKOxITIS1khcIN5UI2YSRDQemj5L/Wz1EX/V/Dn6TmOWvNNJvo
   R3Uj7YN0XFB3kIndDA14y2UEFLvMjJHH20/KCiGWIxOVMSKnsccyyWmFk
   PKtyaE3Cdo/Sn3kig9LTggFBXcXe4QNDrIYUMzx8ip+GbwkfIhLLfxKkc
   ebCmlgWN3rERTdBWD2mLj5apJTgskUoHBmxrk+mAeCMAuYkHOlPjISc3k
   KwlUFp6N1tY9Avn+eJa3fsrHwsKZueFCei2PCuEeQYjH/EdInCX8XVAfr
   Q==;
X-CSE-ConnectionGUID: CvUnTn+JSZ2beZFYj6XPGw==
X-CSE-MsgGUID: yO/OohlKRRKuHUE2IVhH5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84213780"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84213780"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:24:47 -0700
X-CSE-ConnectionGUID: ibAssKHeRbmUZQiMyyryAg==
X-CSE-MsgGUID: ffWZe+IPSh2xsAc9y1Tnaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="248335750"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:24:47 -0700
Date: Thu, 9 Jul 2026 15:24:47 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 7.1.y 6/6] bpf: Prefer dirty packs for eBPF allocations
Message-ID: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-6-5ac5a2d6797f@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-0-5ac5a2d6797f@linux.intel.com>
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
In-Reply-To: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-0-5ac5a2d6797f@linux.intel.com>

commit b72e29e0f7ee329d89f86db8700c8ea99b4a370a upstream.

The pack allocator only flushes predictors when reusing a dirty pack for
cBPF, eBPF allocations never trigger a flush. Currently, eBPF picks the
first free pack, which could be a clean pack. As an optimization, leaving
a clean pack for cBPF can avoid flushes.

Prefer dirty packs for eBPF and keep clean packs free for cBPF. This
mirrors the existing cBPF preference for clean packs: each program kind
prefers the pack that avoids an extra flush, and falls back to the other
kind only when no preferred pack has room. eBPF reuse of a dirty pack is
harmless since eBPF being privileged does not flush.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index bba4acd61d41..de61e1894452 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -988,10 +988,10 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
 			goto found_free_area;
 		/*
 		 * cBPF reuse of a dirty pack triggers a flush, so prefer a
-		 * clean pack for cBPF. eBPF never flushes, so pick the first
-		 * free pack, dirty or clean.
+		 * clean pack for cBPF. eBPF never flushes, so steer it to a
+		 * dirty pack and keep clean packs free for cBPF.
 		 */
-		if (!was_classic || !pack->arch_flush_needed)
+		if (was_classic ^ pack->arch_flush_needed)
 			goto found_free_area;
 		if (!fallback_pack) {
 			fallback_pack = pack;

-- 
2.43.0



