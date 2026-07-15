Return-Path: <linuxppc-dev+bounces-24309-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CB3C44507
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 21:29:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0q7H4p0Jz303X;
	Thu, 16 Jul 2026 07:29:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784150955;
	cv=none; b=X2fdPwcAD3e+1WhATzP7Z/STJyZAa+FPw1FEObpvigq79Ot1LZNRoDQt9hGXMVGZDIe5d+aPImiTh7/3RXGudJBPb1LubgAXAFwPZLQyf+oNiW6gqEowN98KWXazYcMAx/bMjMixjPYcP3ai1p3N/uz3yna5nqqPrZtGnyUdhAr/i7wqImCdLQFsVXLmkqfPSKUjN2bDUQFg+A9hCGqqdDGrQmeBE0VhSZ2TwG81AGM8RQ6iyyUjaDQECMRhiGVZCuTzVKGrevJFm2cJjcz+jteK03td6gcMIw7qkmMAHL5puHiSIxysXh6oVwO0keXi83KdtrHBrAc/zoWV/TT1dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784150955; c=relaxed/relaxed;
	bh=oFbrdS1ZnHWLy4eHMzggHVidMa+q5j7UyKEvqy0jdjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBcD59m0JxYXdq51qo2TlGt7iRxhBi1lO4OJz/JwUWDI09fn/ivkhev8XxY7WMcLVV8ezpeUbupOrPmo6822pOL2OLjyz2D52BJUImQzkXEf4v/Tu/JrcFae+ysBw3h+DkdODvMSODbiDeNT69Xk9rm2sIiYJEErrSG+YlkHimi1J6mBduAwZ3Qpt33jb7thk7pGcCU3h4H/gep39hqeJ7EqiqCjdCs2jKef+RSfWxv3rzH8OK+I81JdlQ4hWgTnVOZhPIXV+MiP8al1MhZ7ZTXbRlMCVWKGheYFrJJyoqWBRW6Llms5foaBi+m66ZgN+Jnq3t2CJ9SrrpTcynNiwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aahzRCGb; dkim-atps=neutral; spf=pass (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aahzRCGb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0q7G2gDbz2yl0
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2026 07:29:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784150955; x=1815686955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wDb0ezA9eFyOvG4pCNK3eJil6YKm7mNmDWs3yGdmdkc=;
  b=aahzRCGbyqGg3cKkJZHcrcy9MXz+9RG0sIsA4XsV/a5x9DDuCy1tjfEa
   P0tPWPy8BcCmdzzAdpLWHpXC3Gfqy7lJBQSKbuy8qdsQfr8/oFw8rHlMH
   DQt2pt2GGWcPXcA3gf5j+TD7YSv5bqFVhpERmZ4IigoXbsuNYjijd8PTD
   aYe+DoKZanQU0QBWKQyf4E+6s+l2AKYAsM9Y3waVzi07y5NHh4bnodrIa
   bQylV/g3oT/wW8BF9mDgXaTRJcgWb74rVCY0FCrb0VDNklfopyU3Vyl1C
   TEPMaAOB36vwupDu17ZCl/cRSvMg/W8z5VnsEo9SLtkg25lP470vGNHrQ
   g==;
X-CSE-ConnectionGUID: 03+TRQzCRE6IoY7vQNKE5g==
X-CSE-MsgGUID: vnqBEy2TQv2RMWLM4DLKHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84897319"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="84897319"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 14:29:11 -0700
X-CSE-ConnectionGUID: j2zqk8J3TmyP7lamzXyFAg==
X-CSE-MsgGUID: sHu8xZFPQjSTg5dDdA8UPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="260616267"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 14:29:11 -0700
Date: Wed, 15 Jul 2026 14:29:11 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.12.y 6/6] bpf: Prefer dirty packs for eBPF allocations
Message-ID: <20260715-cbpf-jit-spray-hardening-6-12-y-v1-6-d8585a9aed80@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260715-cbpf-jit-spray-hardening-6-12-y-v1-0-d8585a9aed80@linux.intel.com>
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
In-Reply-To: <20260715-cbpf-jit-spray-hardening-6-12-y-v1-0-d8585a9aed80@linux.intel.com>

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
index 665f8423b760..d9131b235f79 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -998,10 +998,10 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
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



