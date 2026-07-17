Return-Path: <linuxppc-dev+bounces-24352-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5DCC4451B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 17:05:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1xBQ35Qmz3c20;
	Sat, 18 Jul 2026 03:05:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784307950;
	cv=none; b=GvRT0Yw3941eoHp6PasetEZtavO7MzwPLFoFurQ0YNwcjOEJhMKPZJjyfFd6aOpJM96UuXto5DB5JFFgi0ybMB3NwSrZFg41SD5RIR9Ae4IuE7xKIgO01aeEp+Ym96a2UXQCnYdrT8nG1M5Fboyc6fVVJbb5MhzdbJ4PienEMsnooGPArspZ9o/MAqFSLJo+7zjwwXHlb/hig4spdmdox/C8zIcSIxPYD97Flc2NQTnUTyNR1BujjoIkUlvzhPq88t0NFgf3QueBTO6x8UR5KZN6skqZ0uWU7yWgh+axcsYqMkj4ATpOEFCJ+VwqNvcXMDc7O2OtiMPTd34kEAHB3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784307950; c=relaxed/relaxed;
	bh=1vbqfb3MtWj5E2OvfVEi8YusMBhvVyIdq215n4RkVCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEZ7PHbwLO5oQokSt1I8gIhSo+vxPq/ofKm6ICrQmrpb3hizpXDPCYllCeumHH93Kw2ZYXk9o3Fk4YrwPvY89sAwVUZlri2VeGst3ZPsXakVAIkRAN31XA622qFp/NI7HRfRvO1zluomcrUAX9NcMJKygYG/3e/f3RJ9wZWu/yESTA/bemQvzPxsWNP/+40ohP9pFoP/SAmnG5xnrcYH/f5nAtlCAs6qk5W+9FzTiv0WIbWjyHOzHwGYM20chbYXKqocXX519UYE9Wj3uAsvYsLVakIqoPK7uJ3aT2u8Iz8yDXPHb7uXzNYX9P6xItnWumLLEOAErcYZuzR3+SSWJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ImMZWPNG; dkim-atps=neutral; spf=pass (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ImMZWPNG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1xBP1Qchz3c1S
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 03:05:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784307950; x=1815843950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nox2vi7xeGeBAh4HlPAiv3uYoQFRi5UH10LNP9CkYjY=;
  b=ImMZWPNGW0aPcEOETGo4MKpZ2KrH8w24+CmoaFKfcBSpU4N2AA1fvae1
   CHBoT+EK9P6ONkHonB81VnJifmLoan/JCOCDN3VSCOiJaxoyfbdToC+gH
   awrLg174kLKru715ZWIfq9UkOMl/2my9vY+AMEgG14ozlzNlHozGF0y8i
   AiUCujHwzNxue5c5l8UxUt9jRfGTykPaZSYWCeWCYj4u/LbBWq/r64h98
   LlYCBxUzDzkUFeDr4AoXC843uPmJuajrVID19z8XnV/IFO+uh7+MTsJRR
   MoFX3eMrNGU+BNMS8wWKRwA6ZguutlvAcPnFET5Gwt1iRKT48mgpJMB27
   Q==;
X-CSE-ConnectionGUID: xcVXdo94Q4O7pNsfx1CzvA==
X-CSE-MsgGUID: uwZMFY/qTbuxfp1mIz7sfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="88660742"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="88660742"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 10:05:47 -0700
X-CSE-ConnectionGUID: 7kU3f0i6TKeEiOJm79RroQ==
X-CSE-MsgGUID: /yLMYbBJTjiRJkAUW0Gp9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="295027723"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 10:05:46 -0700
Date: Fri, 17 Jul 2026 10:05:45 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.6.y 1/6] bpf: Support for hardening against JIT spraying
Message-ID: <20260717-cbpf-jit-spray-hardening-6-6-y-v1-1-e04f1b2893de@linux.intel.com>
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
index 30fe140d4888..72926bc394ad 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -22,6 +22,7 @@
 #include <linux/vmalloc.h>
 #include <linux/sockptr.h>
 #include <crypto/sha1.h>
+#include <linux/static_call.h>
 #include <linux/u64_stats_sync.h>
 
 #include <net/sch_generic.h>
@@ -1041,6 +1042,15 @@ extern long bpf_jit_limit_max;
 
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
index d708cf3e6207..0d8008711629 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -37,6 +37,7 @@
 #include <linux/nospec.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/memcontrol.h>
+#include <linux/static_call.h>
 
 #include <asm/barrier.h>
 #include <asm/unaligned.h>
@@ -858,6 +859,15 @@ void bpf_jit_fill_hole_with_zero(void *area, unsigned int size)
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
@@ -910,6 +920,14 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 
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
@@ -933,6 +951,7 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 	pos = 0;
 
 found_free_area:
+	static_call_cond(bpf_arch_pred_flush)();
 	bitmap_set(pack->bitmap, pos, nbits);
 	ptr = (void *)(pack->ptr) + (pos << BPF_PROG_CHUNK_SHIFT);
 

-- 
2.43.0



