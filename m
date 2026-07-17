Return-Path: <linuxppc-dev+bounces-24357-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72CBC44515
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 17:07:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1xCt0yydz3c2W;
	Sat, 18 Jul 2026 03:07:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784308026;
	cv=none; b=RRr9FHu1SAzdYdfwfboy//w4SU53HHiANdrcoq68RL2Etty5wt4LXu7cNcMISvsHAdPerrfL1RLbwkRsXPenL0cGUfWbpKVIpy0CYe6xVQdYPifigoECl7VUq0l+yX0jdr5TtP+qsUZ4bSM5JA5O1kSW1fzRKrLhslXITcinfWghR1lLF12HSrx3fBjjR/sMRshFWc/Wi/lOilGvWEM4K//toscmFSaE05feHXcpxlnqKvaisERU70dEEbQSG5P8P8dZ2/4Z3GXfTG2iwDaygfYw0hA4uJRQUIQZlXFaIVx/lg2FxAEJdY3oZWBgYtAdMWetztytDKsiKsL8Zm36CA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784308026; c=relaxed/relaxed;
	bh=4HB2y68d9zTsjxxhvRDjyQV1Y8kParH1RZQjPMnJh/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eszA1bcmcxb2fAmbO3VdyM0TVTwMC704sJGI2fyy278hwKpl3TpiFm/2SyUjWTqaOlh2g2zDEXGXpXpsPoYekcaL10ymsr+5iNjZY21ttRNszniUuqr//do7DsuMXjG/kpQHXhPMFURWAKbPrYwaFM1jgJZ4/NajzoXF2jfy3eK2WWGBh+oy1cE+VVmcChW8/gq7FPTgu89XCyoS+GaYQv6roKwxPhYmN3j2SMydvDyv2O1n1XyHIA8rvcuN/9zYHGGZ2Qa+fHVRd+N1DpG3x9dogx3RN2YXBelLV/pGejx1zXFGSI9wEtC+1jc7gi6DLvDzWAW6XkgAoqvmKzCuKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hLM4/89Y; dkim-atps=neutral; spf=pass (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hLM4/89Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1xCr6MLdz3c2K
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 03:07:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784308025; x=1815844025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Vi4XcTkAZJbkjqmtACMfa0Zc5DhaJox1a7m2QlS3jo=;
  b=hLM4/89Y2Jqh2/IxeG2ZnIsg5LtLzkj+PQ7hz4ORoi+VBiqI7+f7ybXW
   4O8rpd+KVPZUyr0uvJpTid+wmo6jmMd15ouhmfwjSMJHzCuRRCCiIVB9g
   lDFzFP/PYWlF3ELEIU27T3eoqJff2p7KSc0WCylA+QS2rNjUX52fLCF0X
   4ARof+3J1w9ALtzQXoyS6+IhYdPmDKKEJD3jGi65pGFAvkd445pCJo85C
   o2F0WRjO2Bw0TJ9EFh7NgXYA2kZBjimgwwz8pVa9gbMumxRcwrdExHney
   aig4GeUObH5DenPv9VPY7TlQ783XbA7fBwuHZdd7qkdKLXg0g18m9LKjj
   Q==;
X-CSE-ConnectionGUID: 4MYiNRCFR1q/FZ8jG6aLfA==
X-CSE-MsgGUID: /qhiu7rRQIKxTkEUgsfh6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="110533859"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="110533859"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 10:07:02 -0700
X-CSE-ConnectionGUID: QsBHxzL7TnG5yB9vKgLUgg==
X-CSE-MsgGUID: xE1DH7+0Qj6GVrNzYrHArQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="286903978"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 10:07:02 -0700
Date: Fri, 17 Jul 2026 10:07:01 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.6.y 6/6] bpf: Prefer dirty packs for eBPF allocations
Message-ID: <20260717-cbpf-jit-spray-hardening-6-6-y-v1-6-e04f1b2893de@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260717-cbpf-jit-spray-hardening-6-6-y-v1-0-e04f1b2893de@linux.intel.com>
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
In-Reply-To: <20260717-cbpf-jit-spray-hardening-6-6-y-v1-0-e04f1b2893de@linux.intel.com>

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
index 7dc59570cd25..4669a57265ad 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -950,10 +950,10 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
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



