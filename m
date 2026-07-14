Return-Path: <linuxppc-dev+bounces-24160-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E42C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 01:13:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzhBN0yx5z2yYq;
	Tue, 14 Jul 2026 11:13:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783991580;
	cv=none; b=c0ocnYLKLRjw0LWdaVKvrIzwmGVwws6YyzVnmCselTmzwngMui3XzoZe+bk32qwilYLqWOUBsErS04P9hUBwLBcfadKwYpZsgO5Tebx19ZDjYYv62r3IDESQskvKyZRIrqP/xwGDgcKfx7B0yWiOD8Uqp2E4FbMMEpWXuqp3h5AGf3S1H92Sh5FUtSoz8cxZwMe4RGG1mwAtYTc/XTg2RmmRv9/pJsweW26EZh6bHw84J8xgOChUbi00coB7hKYymTYYd/46v3TYqLhxeX+fOg+Lnjc8qb5Vbt73y7s9XCSsFaL/fN8AqgAqN9GSXleFSsaCUzuas6MakHJ12zjEug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783991580; c=relaxed/relaxed;
	bh=TOak68Ozxs8RlvL+ie9BT5kVCwthM7WBFNj1E5kFguw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcSQ+1ycsOlug/IExCGZmv/nD0oEzWbe8JoSbLdFlHf8uumb61BckE+tmbMIbQChbBLcKPsFCda05Hdkd7LVEzorqd12GmJK/GVjY/ZoUZYysQX/9V3aDXoJNOj19I0j6DTbJLVpb7fRxGfo4+PyhqABc+TeFUaAnYqBfD20awsxokBMHK1KP20pi9dmZSygfKQwpBChy/8scNhfDvy043thiNAD7kkZ4dfxOE/6h2S/VA0xRT+ZNyLkHOTd06JJY+mdg5G/zf2XJ3+TBTZNLyi22hxbl1/FIAxXEmopBSGnUbkbHT0FxZtUHV2xRsq/99tBYjGjiRJhQJCele/UgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Iat+/CKR; dkim-atps=neutral; spf=pass (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Iat+/CKR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzhBL2JYnz2yYK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 11:12:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783991580; x=1815527580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+RTLxExJBFEh/unuxwhi0vcb1IHbn6oEjuCS/eEhK3w=;
  b=Iat+/CKRAcZ2QgPxlm+VSRuwpWPVEfV+8598pFHnMWcU3oUuhwW5K05o
   XfUrdYK8qMWVjCYg/xuSUwPmen3+p+k07a7arxU1iTieXas9+iWpDoOyE
   vvoXOZme0e4P7eTaNi5h0OpJ2TSN14k8d57Vs9YODUVhMMRi2yfgxYxvn
   Ul/uBV0w+r6WptujVrKFfFt/xosD1dcKdzNm0McZATE3F9IGNN0yOp/6T
   HWxdKwxw/k1/bAK2WURK2HBjK2kODqCpKHQZ0q5ReUN0HFx6b+XBE5chs
   VbhZoW6eQERS7seLNiCLjG3BrJcA3jAAV3PJi9B93y7V61vD3QLGMYbFA
   w==;
X-CSE-ConnectionGUID: nAjfK+koTp6G+gJcCeypmg==
X-CSE-MsgGUID: GtGfXwvnSjaQ9ygMr1JJRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94961839"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="94961839"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 18:12:55 -0700
X-CSE-ConnectionGUID: g03EV14ERB63gf8iSRo98g==
X-CSE-MsgGUID: mF7R0phSSyy+jniBTMACKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="249344059"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 18:12:54 -0700
Date: Mon, 13 Jul 2026 18:12:53 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.18.y 6/6] bpf: Prefer dirty packs for eBPF allocations
Message-ID: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-6-755f60c55705@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com>
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
In-Reply-To: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com>

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
index e0ffdd985eb5..b102704f89bc 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -970,10 +970,10 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
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



