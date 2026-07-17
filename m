Return-Path: <linuxppc-dev+bounces-24356-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824FFC44515
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 17:06:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1xCb6nS8z3c3w;
	Sat, 18 Jul 2026 03:06:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784308011;
	cv=none; b=nw9GStUIqAMstDWWiPpJ7NltgebqsqkF/vJmKahVzDXBytsdlfRBWy2SNCT2b+0zSlEVriH3jem4fQ820QycOXe41d/bYMoQfjaaAr4Fk5GmS5xAxHbopX3GNRkfTYb65pY9TLEX5dCY51Fu+C1URfelNkvekmhOwbW9o1Z5uYdZVoD5LRB1By1Shg6N/FLG6M9HAYFf/0l5MTzbq3/jlpr0wUWanfZF1lKN9g/6zwnnSut5fbzxiS7rSPZFYhC4DPa6ZQ/HhFcemYIVUg+HSfAYsyivA7t2kw7iZxLKSreefw/IlaOQgqOrVOfRdI08PltKK+a/lX9S/MnQ+C+nVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784308011; c=relaxed/relaxed;
	bh=sKP8T3NE/1bEG388MC0Wb94zaMTj/h2EIWCB/VMFsRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noVuKthUsTlT0ZHFtXHbXaRXVCX/7Hg5WHCKxyK7Ci+poZHpfeWVpiYq2ABFPJiYu0lhqolOeyuEppF1lOprRGa5R4D/Al0c04EmeJPwt3usC/diXhEbw7z5Xjbj7a9qJHtuQfnIuRn6fLotj5qi+PT8zwFuO88doVyctE1KjNPYaWYGd9+rBxQBOHAJ9QDlYlIeUGXuUgefDTdkIrYgNfUe1e+oZ2GZuolvfLSuedO6cd1opBXR6+yaqR6P3S//RZEP5G27U7D1+L41pCaGV9IUegQ4FxDNg0UGNiRsz6jFQZt9Z8T+J98QgKm4klxNNNUVXVeHinGjKk8ftlgWtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gs+fqehA; dkim-atps=neutral; spf=pass (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gs+fqehA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1xCZ0wbBz3c47
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 03:06:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784308010; x=1815844010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HtYWDJLWJG7fhQjbhZInKTid9UxMtoEjQSzHOJDJ7Ak=;
  b=gs+fqehAXW9JhbFinbK/XXB9Q4f/GZ72JeAyBL7hjbWDLG/6pQ8jv9Ld
   9Mia3OKH0OrCtmfshymXFGNIpMdc6O4L3sXxP1fmUF1OBBaeF9fyUSs4E
   1gbqzqCrL4zN5uaWQ8HwF1xaZAi/xSMPpjKBdGW1aTd8iPHFKoOmmlJYh
   OZpFWmdm/dJSVaYZt8/mQko6bB6ncKHP60Eq5G8btmDTNqHRx3yvUuHPK
   Ht456WNEC1sJ/PY6sHl03RlYhvY6bIoAzQTSGrTNDyfM9FUsxO8pNBKbv
   asj2+6AydX3QEMlwe+Nnb06Yuso2wojTwOfnujrrrFbfJzEdvbuwSK6om
   g==;
X-CSE-ConnectionGUID: GisHBrQ6RpW5hvRdv3JQZA==
X-CSE-MsgGUID: AkCRjVdwRmqOvbiQo42YQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="110533806"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="110533806"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 10:06:47 -0700
X-CSE-ConnectionGUID: 62/6Z53oR5i939U5O/RVrA==
X-CSE-MsgGUID: iogBsboYQ7qeT7Yh3tib3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="286903922"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 10:06:47 -0700
Date: Fri, 17 Jul 2026 10:06:46 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.6.y 5/6] bpf: Prefer packs that won't trigger an IBPB flush
 on allocation
Message-ID: <20260717-cbpf-jit-spray-hardening-6-6-y-v1-5-e04f1b2893de@linux.intel.com>
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
index a2e5684d6239..7dc59570cd25 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -917,8 +917,8 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool was_classic)
 {
 	unsigned int nbits = BPF_PROG_SIZE_TO_NBITS(size);
-	struct bpf_prog_pack *pack;
-	unsigned long pos;
+	struct bpf_prog_pack *pack, *fallback_pack = NULL;
+	unsigned long pos, fallback_pos = 0;
 	void *ptr = NULL;
 
 	mutex_lock(&pack_mutex);
@@ -943,8 +943,29 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
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



