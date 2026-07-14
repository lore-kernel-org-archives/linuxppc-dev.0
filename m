Return-Path: <linuxppc-dev+bounces-24159-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA801C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 01:12:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzhB31gkHz306N;
	Tue, 14 Jul 2026 11:12:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783991563;
	cv=none; b=Bs1wKUPB5zDi6e34UkkXddoSdx4m1l0ZdZR6h0VtsePZY9uwtaJs42FU+fDB8igkgIs4TqtywgS5HB9/zvhJHMa+e6yfbcfAN3FA8yhedI7b2Ke6AGITGo28jn/qNVGsb0a6FLA/TjATRb+LvNvdLinYU5BQ7ZeXoN6Ld+/PWDnDW+o9cARZHyZnKzSf/ukziY/BlJll8VvI/7otcBT7qD5U6VF/6gW2P6qq6tFPG0ik5l9SS3/kRzqJA+yYRNywn8jentr6bCysXicqPYbcgrQSxnB6XwKytxMQJM494hSMVzzFRfYy1ZEJZ94wrEuvK+NN2BLcBYP0Vzf/564DcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783991563; c=relaxed/relaxed;
	bh=dG6PtlI3EzdAZ4JmfTk0xRZiR7+NpRIymAUo67cV3DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/ZpuBhcVcidSuR8aT9SQJyb7kH3PFSTRBPhKHAc4MSOVe+iliRE0n4ydfsdyg5VIpTGwYgSUGN+fBk/gikwth9VxRj3xUQQwbrEdtBpJntwA0dFyTkuC2FA10BoZS8GGfU5/gX46koUmduILfE4rPJAZIz7KFOalv7AyGmPSC8nkUMzdLSevvcdH1UaKiDFU9NC+mEWgElOnrmjEiVYeFPd315aMm7w9vbExtHY4LDj831MltosX+YM6VYKH3NWRwVOX9nfsj4awMpJgv6KT01Udz/L48bxf4EiMvdpgRhBjjTBnTbVAG3uiFNoV/I9P1JOpdDuqv7TfRwGPU2U/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hnCSuMWb; dkim-atps=neutral; spf=pass (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hnCSuMWb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzhB207syz3078
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 11:12:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783991562; x=1815527562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lgqs5fO6HrsSGee/YaRNbNfzf74wKB78RIStwdOfbZw=;
  b=hnCSuMWbbxPSJpmxczXwI6KW5jShO4g82Fw6P61cjpu7/9Uumnunp0PP
   9+k92VXIhRY0oZjzS1j7FnEFuvG5LI8D34M7FRgoZetxQ0IZSeoHVwUYo
   NJfb2pP0B/xm3g+uxjzNAM/6tBheFavYBDa+r1KWqZfk2PAhDrbRFV5vr
   4KLFwLp3LsbdRZmgg+NNi9KomT1rh2ATx7FDx0AA4YkDKLzAo/WQ68oRR
   RXQFJFAUPwWxp8hlVq8T//IhKFpMVDJJayUoVx+UkDpHWy4reGGN22Q2U
   Js4jT0jZiu9LutXs/U9BEpa//XjrAeFmdruX6VcohyPhXwhP1a0Fd95qX
   Q==;
X-CSE-ConnectionGUID: Vc2HLyFDSuyktRtLoFHxWg==
X-CSE-MsgGUID: 7UefWAI+TP2GwxxMC4nusA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="110154762"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="110154762"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 18:12:39 -0700
X-CSE-ConnectionGUID: SgC6yYhtSTCWiC/aqctSTw==
X-CSE-MsgGUID: Xk4gyZBRRV2IRlDwJbduXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254583841"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 18:12:38 -0700
Date: Mon, 13 Jul 2026 18:12:38 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.18.y 5/6] bpf: Prefer packs that won't trigger an IBPB
 flush on allocation
Message-ID: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-5-755f60c55705@linux.intel.com>
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

commit a9b1f19a6a673ba06820898d0f1ad02883ea1639 upstream.

Currently BPF pack allocator picks the chunks from the first available
pack. While this is okay, it naturally leads to more frequent flushes
when there are multiple packs in the system that weren't used since the
last flush.

As an optimization prefer allocating the new programs from packs that
are unused since last flush. When all packs are dirty, allocation forces
a flush and marks all packs clean.

Below are some future optimizations ideas:

  1. Currently, the "dirty" tracking is only done at the pack-level.
     Flush frequency can further be reduced with chunk-level tracking.
     This requires a new bitmap per-pack to track the dirty state.
  2. IBPB flush is done on all CPUs, even if only a single CPU ran the
     BPF program. On a system with hundreds of CPUs this could be a
     major bottleneck forcing hundreds of IPIs to deliver the flush.
     The solution is to track the CPUs where a BPF program ran, and
     issue IBPB only on those CPUs.
  3. Avoid IBPB when flush is already done at other sources (e.g.
     context switch).

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/core.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 49ca543a4111..e0ffdd985eb5 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -930,8 +930,8 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool was_classic)
 {
 	unsigned int nbits = BPF_PROG_SIZE_TO_NBITS(size);
-	struct bpf_prog_pack *pack;
-	unsigned long pos;
+	struct bpf_prog_pack *pack, *fallback_pack = NULL;
+	unsigned long pos, fallback_pos = 0;
 	void *ptr = NULL;
 
 	mutex_lock(&pack_mutex);
@@ -963,8 +963,29 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
 	list_for_each_entry(pack, &pack_list, list) {
 		pos = bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT, 0,
 						 nbits, 0);
-		if (pos < BPF_PROG_CHUNK_COUNT)
+		if (pos >= BPF_PROG_CHUNK_COUNT)
+			continue;
+		/* Flush not enabled, use any pack */
+		if (!static_branch_unlikely(&bpf_pred_flush_enabled))
 			goto found_free_area;
+		/*
+		 * cBPF reuse of a dirty pack triggers a flush, so prefer a
+		 * clean pack for cBPF. eBPF never flushes, so pick the first
+		 * free pack, dirty or clean.
+		 */
+		if (!was_classic || !pack->arch_flush_needed)
+			goto found_free_area;
+		if (!fallback_pack) {
+			fallback_pack = pack;
+			fallback_pos = pos;
+		}
+	}
+
+	/* No preferred pack found */
+	if (fallback_pack) {
+		pack = fallback_pack;
+		pos = fallback_pos;
+		goto found_free_area;
 	}
 
 	pack = alloc_new_pack(bpf_fill_ill_insns);

-- 
2.43.0



