Return-Path: <linuxppc-dev+bounces-24157-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC5BC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 01:11:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzh8v10xvz2yY0;
	Tue, 14 Jul 2026 11:11:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783991503;
	cv=none; b=TrHetqVYEtFf5lH1fLuM8UANa6f9fzTgn3/U2TH/Eufc46tLLScSQC4teew8qnP1png5UiRiiaqcNvgP3r2p23EgsKjb86NZNpK8z1BMpL+XfhSGqeG6Hb3tXt9gLBrzFsqxbXCt2/CYIPrXMfSjy42xCMNE+/cV22jC+30pu5fOoiCgq5Jo4SRn5PjeWutUn7LizRrQba15yWezgQMtr7ZNOArcwcQSfOPaP5x6wZDq9e6kErX2LGlU+355empyGPrquqoQsX6VZb4536qR/ge94npU5NUUThwW7tgshyPlAaSDONgdSAh7L0mODmUcgzfM/27cbdpk2xsAnNDimw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783991503; c=relaxed/relaxed;
	bh=08RhN+2TRsmsiYsYrOyVjZu+e7bUGlF7U64vftMpBDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJE+gnqyVhj7yCKCGzuaGyr0uhh863Vop/YuoGBrEgweEyCFhfHLu0uVS0ieGO9BSScxWStpPjw6sCwNOAnnGGSw60vJxLYLSBnd7ZSQRtvIkLWuIWdEEZN7FM9a8fsnD5MHbB7cCdmGtxBtixnsVGsaIDp8kPXhoU1f6WRQ7aWHrnTLlwsY6sVz09en5Rtru6lmbe2NjxWyCghVgq9rXGoPSL+I79fzzmBg5qEc47ScsHSNMvl7GMsQltxGVSfEjcS98JAx6T64Ep1ipphxsEeE9BJ3i5j4Vl9E955/wlZPuXYFW1XiLS+ZqLqvN6NY/EHLw5We7fSmHPMNbwET4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fIilw1lZ; dkim-atps=neutral; spf=pass (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fIilw1lZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzh8s6SPlz2xVY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 11:11:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783991503; x=1815527503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vYbHs9pltJAf9fQekJyJFrJwYGZJwbzoYkT7ZVAvPLg=;
  b=fIilw1lZDIdB+KLpqpD0cFwquqy+rQE6fO5cJLepYTafZOJYJmDMBWp/
   r+J902GhJcHXVUVt862pg8rk2Qw8H0Xajhwc0JM9ncfRyvL7BPUAuN+xN
   1mmSDD2UuriPHpb39OA3NlkdN9RVhR5oIRGLSU+2S5oxC1Y/YF25Q+zO6
   7eS1PfvVKnRX/8Ula4SLYuzotfTDvHc9iBOYFyrhrOzx7XGT2vOMC4G7p
   50ERF+NeRij3eCIpliWG+IYZQ2xE62F8EQQ21uGMu/mJqI0kNRjtqMa0d
   pmC8gvH5x9gKexT+zA94tdBTBR563pHG++RyZ/AXdU9jHnMmJKYFnSAZt
   Q==;
X-CSE-ConnectionGUID: rVp+qhmvQ8yqttBtwtvgHQ==
X-CSE-MsgGUID: GSmjbKxlRLuqJeY5+MYPBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84702156"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84702156"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 18:11:38 -0700
X-CSE-ConnectionGUID: KLNRoagGSHGCfDleXv+TiQ==
X-CSE-MsgGUID: n+yv9uzrRqiCr5v5QaZ84Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="252318610"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 18:11:37 -0700
Date: Mon, 13 Jul 2026 18:11:37 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.18.y 1/6] bpf: Support for hardening against JIT spraying
Message-ID: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-1-755f60c55705@linux.intel.com>
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

commit 96cce16e26dd02a8678f1e87f88a4b5cdb63b995 upstream.

The BPF JIT allocator packs many small programs into larger executable
allocations and reuses space within those allocations as programs are
loaded and freed. When fresh code is written into space that a previous
program occupied, an indirect jump into the new program can reuse a branch
prediction left behind by the old one.

Flush the indirect branch predictors before reusing JIT memory so that
indirect jumps into a newly written program don't reuse predictions from an
old program that occupied the same space.

Introduce bpf_arch_pred_flush_enabled static key and bpf_arch_pred_flush
static call for flushing the branch predictors on JIT memory reuse.
Architectures that need a flush, can update it to a predictor flush
function. By default, its a NOP and does not emit any CALL.

Allocations larger than a pack are not covered by this flush. That is safe
because cBPF programs (the unprivileged attack surface) are bounded well
below a pack size. Issue a warning if this assumption is ever violated
while the flush is active.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/filter.h | 10 ++++++++++
 kernel/bpf/core.c      | 19 +++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index cf7a0bce1bb6..3c4dd718bece 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -22,6 +22,7 @@
 #include <linux/vmalloc.h>
 #include <linux/sockptr.h>
 #include <crypto/sha1.h>
+#include <linux/static_call.h>
 #include <linux/u64_stats_sync.h>
 
 #include <net/sch_generic.h>
@@ -1266,6 +1267,15 @@ extern long bpf_jit_limit_max;
 
 typedef void (*bpf_jit_fill_hole_t)(void *area, unsigned int size);
 
+/*
+ * Flush the indirect branch predictors before reusing JIT memory, so that
+ * indirect jumps into a newly written program don't reuse predictions left
+ * behind by an old program that occupied the same space.
+ */
+void bpf_arch_pred_flush(void);
+DECLARE_STATIC_CALL(bpf_arch_pred_flush, bpf_arch_pred_flush);
+DECLARE_STATIC_KEY_FALSE(bpf_pred_flush_enabled);
+
 void bpf_jit_fill_hole_with_zero(void *area, unsigned int size);
 
 struct bpf_binary_header *
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 931a4ddd8530..a043fccb917e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -21,6 +21,7 @@
 #include <crypto/sha1.h>
 #include <linux/filter.h>
 #include <linux/skbuff.h>
+#include <linux/static_call.h>
 #include <linux/vmalloc.h>
 #include <linux/prandom.h>
 #include <linux/bpf.h>
@@ -864,6 +865,15 @@ void bpf_jit_fill_hole_with_zero(void *area, unsigned int size)
 	memset(area, 0, size);
 }
 
+DEFINE_STATIC_CALL_NULL(bpf_arch_pred_flush, bpf_arch_pred_flush);
+
+/*
+ * Enabled once bpf_arch_pred_flush points at a real flush routine. Lets the
+ * pack allocator test "is a predictor flush wired up at all" with a cheap
+ * static branch instead of repeatedly querying the static call target.
+ */
+DEFINE_STATIC_KEY_FALSE(bpf_pred_flush_enabled);
+
 #define BPF_PROG_SIZE_TO_NBITS(size)	(round_up(size, BPF_PROG_CHUNK_SIZE) / BPF_PROG_CHUNK_SIZE)
 
 static DEFINE_MUTEX(pack_mutex);
@@ -923,6 +933,14 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 
 	mutex_lock(&pack_mutex);
 	if (size > BPF_PROG_PACK_SIZE) {
+		/*
+		 * Allocations larger than a pack get their own pages, and
+		 * predictors are not flushed for such allocation. This is only
+		 * safe because cBPF programs (the unprivileged attack surface)
+		 * are bounded well below a pack size.
+		 */
+		if (static_branch_unlikely(&bpf_pred_flush_enabled))
+			pr_warn_once("BPF: Predictors not flushed for allocations greater than BPF_PROG_PACK_SIZE\n");
 		size = round_up(size, PAGE_SIZE);
 		ptr = bpf_jit_alloc_exec(size);
 		if (ptr) {
@@ -953,6 +971,7 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 	pos = 0;
 
 found_free_area:
+	static_call_cond(bpf_arch_pred_flush)();
 	bitmap_set(pack->bitmap, pos, nbits);
 	ptr = (void *)(pack->ptr) + (pos << BPF_PROG_CHUNK_SHIFT);
 

-- 
2.43.0



