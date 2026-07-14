Return-Path: <linuxppc-dev+bounces-24272-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127ADC4450A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 18:59:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h07sG5T1mz30B0;
	Wed, 15 Jul 2026 04:59:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784055586;
	cv=none; b=UC/Sr6LVAlCcnPwjuNd3WvY2SepInHpvQE0wm0DmO0CqboQKmTEKl5biHzsvqAmamOrffpNstwbKCo1TjPWFJzul1jy62wapK1ouem29JQnsvbfmh7uu18uW3uUzyqXhyRYRKy4g2qcmQTXGMEut60b8Bo8IeJv03ZMK/4K0pK3bt02G5IX+QxJgmEga7NcxQSsTkTGsbv91ybxWIsrYx3f4v+Pbhj2GX3zVxLflQaRY1cnyP9oEn/gxeC0FNZ5Vov9TwKN5rZ1E+cVdhtdj2DQ1TWFnxAxPWGzjFAfCZdcVZezuOB+4UwylVde1FfHGI36H3r9/jiyyhoblqb+OiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784055586; c=relaxed/relaxed;
	bh=kjrPDLamhtiQksra8U63XstlCbee7Jnc9xH6tT0c40s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJjyatELIjf+bqoo8X/h+LgK2woSgrs4IGl9bPYtMS+Ej7NI2cX81bnXtTqtuaNLZTdyZhUgotf1dM1/b2c+7IxTHEnA3Grhg4H3fRmxtd7ve3zmbp814ruOPlUnyM4sMiCgU91hPV2rp0o6y3oVGZA9H8MvIgid8QKBYPN5vw/3njh5V6WlV3R3xlNb7xNWWTmnsv6Nkq8RfT6oOkY6juyHwWzBFG/hc76fvwmvzeTmIg0f4lzC5lOTqXDSrQzoj7WyLvOqFskAUklzikD+k9EN0uimh8aNZSsTWzIpPqsBva65jt9SZiLZ2pVqKdOALSr8DpbNA7McDl4lSVQl0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iD/BLX6A; dkim-atps=neutral; spf=pass (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iD/BLX6A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h07sF0FQGz309w
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 04:59:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784055585; x=1815591585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EL48tV43ROgTCeGKJswJcHR68o7GyiAksiGkAuzjGrE=;
  b=iD/BLX6ARSe5rc84PS40fG54T4a2GUTDWEWWhtaCtXtIAQzOhTytNlnt
   dEtbZCpXmz8bKhtJ29cp5MeOCtq7YZqEQx0LV6vzwzO1hTMEwMj7e7xS4
   gAaz+6YxTau1j0Q6fbi/ye2eXsiwCefqJLZQQlv8LeglU+RBJRm8ncbel
   Eb+m+qptDF/61n5OmI1QrsPit3k+q0v5ucPv7Qtl2FQFEo5E9YVsbYDSP
   3+svLmXR2T3LvVxhwPoAolZMY4WqySrn+vb+DTaU0/wOwnIVAh2uZ4VjV
   UnOv5t5NFmWEY3uuyQffJ7Lk4vfQHIm9FzvVyiQ56YlZklaSxAuTfNir5
   g==;
X-CSE-ConnectionGUID: vUuV08tSSMyuj8kOLEekEQ==
X-CSE-MsgGUID: uUANLhGVTfSClm9xnqoX3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="102241368"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="102241368"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:59:42 -0700
X-CSE-ConnectionGUID: K5N3FSsZS/aTUinwoJXA1A==
X-CSE-MsgGUID: CMRlSfjkR+ytfUYZIayAKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="279225280"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:59:42 -0700
Date: Tue, 14 Jul 2026 11:59:41 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.16.y 5/6] bpf: Prefer packs that won't trigger an IBPB
 flush on allocation
Message-ID: <20260714-cbpf-jit-spray-hardening-6-16-y-v1-5-2fc3e16263ac@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260714-cbpf-jit-spray-hardening-6-16-y-v1-0-2fc3e16263ac@linux.intel.com>
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
In-Reply-To: <20260714-cbpf-jit-spray-hardening-6-16-y-v1-0-2fc3e16263ac@linux.intel.com>

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
index 9fc2decac07d..81ba423d0f8e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -958,8 +958,8 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool was_classic)
 {
 	unsigned int nbits = BPF_PROG_SIZE_TO_NBITS(size);
-	struct bpf_prog_pack *pack;
-	unsigned long pos;
+	struct bpf_prog_pack *pack, *fallback_pack = NULL;
+	unsigned long pos, fallback_pos = 0;
 	void *ptr = NULL;
 
 	mutex_lock(&pack_mutex);
@@ -991,8 +991,29 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
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



