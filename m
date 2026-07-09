Return-Path: <linuxppc-dev+bounces-23976-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9188DC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 22:24:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx8dw2B17z30DY;
	Fri, 10 Jul 2026 08:24:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783635876;
	cv=none; b=Qf+QvKusoM2vNqPSkn3ORr21b6aqB42Q6YTgRZWDQLqPaL+V4TDKEnw3TZGi/HsI5G3t2KNPpNRzVxR4IIUb2oIvhG5MkT2lkYbjVaz0mGtayESjx+HmoGfrxwon3ZibwHVvsFWLeKmWE6p6fDOBxv6Xekxq7W1tuK7Xpnc+HSwbimLGJNvpm/CnsMys24W0H591QzP67xk+DwgeDIcp/m9SsHqqJitCEVqBItV3ylaw4UAxSk+GDhPJRMFRgI0SlafewT+SIBY5Q3VzCEMPd84xXR/367q9s3YaMy8/Tub3JG0EpqUKnWf7UziadbrT//g3LsJoN52qkGXMJJbbAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783635876; c=relaxed/relaxed;
	bh=uWGr0EY0lEVs67uxyqq5zX2WhA4ZyQeiyFpiJkV+zUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3jApiUoeezwkvUx63o+RgHvkoXTIiEB5LlJuMkP03XM/yOQDHbZFFW/S69y2TsFTCyrPNdbDZ9tR3Cyxu+qD83tKMKzamsImb44F37UGsZH1Lxf4buGVN2bID+6S7FD9KgQOM6FHlzquuBwhvDSx4ZSPUaUm6P5lT0TUBgg2kxGmgsg+El/Z/cVatrs/guEX1Q5sLYUWHAzeHBpUrOU9P5mxt3S3Tg48gaJu8/38qKZVbtQB5n2g7vQ2Lw1DXNdqc9mDniStbp8SzRhaASUF6I41ZJFRzyYFzA8YtAWp+QEGgPN7ARyN5hXPIe7JvsfrTOwA8kzhACeAwuQ68aujA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MKol99ct; dkim-atps=neutral; spf=pass (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MKol99ct;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx8dv0dVkz30DK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 08:24:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783635875; x=1815171875;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S6jcatq9rAz67HKNH8gbg4m4YYp2XfxuWPzu2PZTxAk=;
  b=MKol99ctWLybeEI9BXlukHZVjK2zMD8jaKO7nmVJSrcfxxFQm2GAYuzl
   0HhKS99NcI5NZxWDn90BF9dO1qP+ThsBjC9jwOnQlo5RA8W/YdCZifh33
   c0HRNJJynmoe1tr+mxQpjdEsMmscs0nj00Ai10D82ryyFaj+d/MNA1gs6
   oeTfEoW6GT/4GKLtA9fKpHabYzXOHkPY6omNmM56JQV+EPUx6S2MZ3ePS
   fj4CkblQmKMObEcLiCN3a+n97quLYlT6Wc0fLi/FWVS0eCBXwjOXan4Oi
   sg0RwV0KYL2ZiMFRpHbzggfjHlepg+1IOIcS7J9WFNJvWzuV+1t4PC4aB
   g==;
X-CSE-ConnectionGUID: TXXXE702TfuVRm1UhkEXtg==
X-CSE-MsgGUID: 2OigYrSwQoSyG2zNEkKDDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84213765"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84213765"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:24:32 -0700
X-CSE-ConnectionGUID: pUlEMESESPa21fZcMt/3tA==
X-CSE-MsgGUID: btpjP1nmQqezXE7bXxYJZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="248335696"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:24:32 -0700
Date: Thu, 9 Jul 2026 15:24:31 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 7.1.y 5/6] bpf: Prefer packs that won't trigger an IBPB flush
 on allocation
Message-ID: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-5-5ac5a2d6797f@linux.intel.com>
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
index 1bf4b8dffe91..bba4acd61d41 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -948,8 +948,8 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool was_classic)
 {
 	unsigned int nbits = BPF_PROG_SIZE_TO_NBITS(size);
-	struct bpf_prog_pack *pack;
-	unsigned long pos;
+	struct bpf_prog_pack *pack, *fallback_pack = NULL;
+	unsigned long pos, fallback_pos = 0;
 	void *ptr = NULL;
 
 	mutex_lock(&pack_mutex);
@@ -981,8 +981,29 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
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



