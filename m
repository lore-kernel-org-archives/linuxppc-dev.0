Return-Path: <linuxppc-dev+bounces-24268-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D3CC44507
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 18:58:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h07r64yCxz2xyj;
	Wed, 15 Jul 2026 04:58:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784055526;
	cv=none; b=h2MGRSNB7yjID4ahs18ru9u/PEayaJbMRhCFyWRrYiFKXLThW927p+ovjjcTDP1pInToektbFhQ95Aqt0fLalvmj5h+GcNkRyf9S/TtaOfr3pP9rQlSEN24GYNxgAfgNeenvI0aNKgMcijQbcKcZ6zaN0kfKR+in8ziTTcfFocfBXAl87S9OH+7LvSftCXBlBmnZQXf++p8PWpsTTFyQAesNSenVItsTs6X8aVs/h8I0mudv3PxbWwz9s+2Vnn22QbTLyQPiccAwDy00Es4sfi048CwCP8N3+3OLLuTnRkXzXwWx64+sJzULbHMI8ewKlXIHnJLKH6XloZTuOkrWqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784055526; c=relaxed/relaxed;
	bh=XOdUCOKL9jQjPta1yxuByr3KaM5gBg1SgC8UBNeZY88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ez+/bN8is7Fxgodh3gjPfTUClZAW+IJ47FWyj8KuyolJiHQz0beYnxyci1smnO+FlZ6mPxx8PfQw/vVrdS3ftvPBvY88pGeN/FM182KpaZ72VtNVQ+YRihI+gbqyHZ6TtDMuFJrpRLaOMbt17VklRlY0Rgf8mLifPUt75Rpn25CCbdzGUeh5Ce51dURq35mzZScNjVID255SouI5B0u4aZsbLWsueLydS85NGkJguoYKno9uZust6MXXiBEw9lJhvOzhUocP8Ngy4wgml/VnjfAYYkwLrqaA5cXRIdfUEet/EO0xGhSNR8DA6AWHe9ZJMR7trY6bORVt1ut63jW3PA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cJwezSp2; dkim-atps=neutral; spf=pass (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cJwezSp2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h07r507wxz2xqM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 04:58:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784055526; x=1815591526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ldL91FHSaPTCR8SS8MmTe3PfK8ednI15fmuZ71fExU4=;
  b=cJwezSp2WXzxVCW3yQzI88YPN9nxqbQJaIC1t3BL0b07FqWBQl2uIO8/
   CfSQvLyRMCCLNQCaE6I/KZAbiTbZSnmu7gi5kcUR+3tq3nmRFd1SmOBOO
   qjI5K9J4h4bJSF3yZpen+fKacnIPZWqKVwxdkBaUTEVBxZ3hDOq/eATcF
   juYwRdH8FPho9EJ12e2f+ejza/LNMA+L8Hs18geftX8DMtFAnQyB2UjLO
   JdCICenE71pQsLdtniiTB2jMLvISTmkIlb35XMuFGm6Um4kHkM2rq2kFE
   qjZGnkvGWofbM9mAP7y2O6n/EMfDzk3u/PnK3zIqbm5AMkAfDzRnKHkZa
   A==;
X-CSE-ConnectionGUID: I4unSbmTR4KLPJiC/0te4g==
X-CSE-MsgGUID: D/9wR183QiOinnGjNkn6eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="102241235"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="102241235"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:58:41 -0700
X-CSE-ConnectionGUID: 6UHUP5zjQMal+XvuHOwceQ==
X-CSE-MsgGUID: U6ORjMIiSuSaLeR+SFouLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="279224620"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:58:40 -0700
Date: Tue, 14 Jul 2026 11:58:40 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.16.y 1/6] bpf: Support for hardening against JIT spraying
Message-ID: <20260714-cbpf-jit-spray-hardening-6-16-y-v1-1-2fc3e16263ac@linux.intel.com>
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
index f5cf4d35d83e..65e2e804a5cd 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -22,6 +22,7 @@
 #include <linux/vmalloc.h>
 #include <linux/sockptr.h>
 #include <crypto/sha1.h>
+#include <linux/static_call.h>
 #include <linux/u64_stats_sync.h>
 
 #include <net/sch_generic.h>
@@ -1237,6 +1238,15 @@ extern long bpf_jit_limit_max;
 
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
index 17e5cf18da1e..48208c3f5814 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -38,6 +38,7 @@
 #include <linux/bpf_mem_alloc.h>
 #include <linux/memcontrol.h>
 #include <linux/execmem.h>
+#include <linux/static_call.h>
 
 #include <asm/barrier.h>
 #include <linux/unaligned.h>
@@ -892,6 +893,15 @@ void bpf_jit_fill_hole_with_zero(void *area, unsigned int size)
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
@@ -951,6 +961,14 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 
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
@@ -981,6 +999,7 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 	pos = 0;
 
 found_free_area:
+	static_call_cond(bpf_arch_pred_flush)();
 	bitmap_set(pack->bitmap, pos, nbits);
 	ptr = (void *)(pack->ptr) + (pos << BPF_PROG_CHUNK_SHIFT);
 

-- 
2.43.0



