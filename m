Return-Path: <linuxppc-dev+bounces-23972-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B68AC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 22:23:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx8cL5nYFz2ydn;
	Fri, 10 Jul 2026 08:23:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783635794;
	cv=none; b=czSU3wLqch782IkOil1yUaazAaXbj+/g7HcQPSUfBuIOAF5oXLWhFPRXEOKketaV5nb3jzCThpVHc6BCs+GIVW7KwT0V+9iQ2a67GDyewwQS5CxApbE1F1NP5kT1A4CpHxbEi+qjvvqB2svKtlPy6GYyIMr5OZC45E89p5SfgoHIEvtxzOtxRXqGnDUqiNtSndrshoMFQEXnROBhevn5Pjg0ez1ZYzYU6maI5t2wwBCA1TlJ/Wc6yEBOkLUo22NF4yZMnSVgNQm50dz4KUhZgnpA9ecFE4MFK0jIbi4lmFhBxGmUDlFm3auTQHh3MzPzJRVhLtTKt8FUGp/pWNQyTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783635794; c=relaxed/relaxed;
	bh=7Lo8jl80NJ6/XGIwznHdrCsZvqmQGVcW61eO3r1ohOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ci353UJreqmZf3gHJStfo3I+DvUcbQK03xAJ4ZEt6DofLA+Mq7F4dGIQZ/zKJBUhxirOLuz59KAvEAyoDUsncqVLRFQk29jXhOU/fmtu8sv5x9sjeOAleaId4LvQLfC9HIhiIU8rF7MohKtHSDvOcooyyccGql5zI4Q6/d0KLpjrftgPRuCZQXdfa92WKB1qB+gQ+lG1mOdZibgD9wxfx/tuI9APzr9UBZW9N4IwPSr9BZcMshMIjhC/4ShFrRHxnQVZ9aGQnsc6tgMYl//Q4btl3yXtTCaZxW+IlSKPtWBDvaYzTQ7jk+v0AieXJIiJWd31o9cZZmS9eh4D23mcNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Gq9cJQrM; dkim-atps=neutral; spf=pass (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Gq9cJQrM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx8cK4N6gz2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 08:23:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783635794; x=1815171794;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iNoPYktFUtzeVYmRhtnVGztFbFYTj2f66t/NWqaYChI=;
  b=Gq9cJQrMRhdmoMd0d0hFoSfSqboJ4gYWFyDto0/U//PrbUxO415CgO1g
   b2Z3aRE6WuH3BQiwzsvyclM2HkGfXMsFzNVlS7DyiKDNvZxs3F9nzAV8p
   lcDQ8iDPP13+BzTJlBK3Lyw0WcSMM17/Pd/dKUugoTlhvjYcQ3xD/3KQM
   Lw49Hy0B/CsUK0CI5hRgAtSW0WfYHVZ7B9sZAmrRyBj/0dynQjf7/f+MY
   BpmLl8R8InbfUnDQZKW1i7TtaAQ6uYzwaqXeWvbt0+uwbMRxdK0aHdrMZ
   zFn5jRQTOr/JyhWIdXOnb5bUrN1xsvZblAb+gStPS8fI4Z2wMFGZyvKsO
   w==;
X-CSE-ConnectionGUID: s+kyRFH9SgWpJyboHmuVVQ==
X-CSE-MsgGUID: fKTkg1BOSUm9XKtz4Lw8rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="109881460"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="109881460"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:23:11 -0700
X-CSE-ConnectionGUID: LBXou590SlWE+/rozdS01Q==
X-CSE-MsgGUID: OPbev+slSFKC+rdeV0yjiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="256638315"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:23:10 -0700
Date: Thu, 9 Jul 2026 15:23:10 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 7.1.y 1/6] bpf: Support for hardening against JIT spraying
Message-ID: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-1-5ac5a2d6797f@linux.intel.com>
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
index 88a241aac36a..2a7e6cbbbe1d 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -21,6 +21,7 @@
 #include <linux/if_vlan.h>
 #include <linux/vmalloc.h>
 #include <linux/sockptr.h>
+#include <linux/static_call.h>
 #include <linux/u64_stats_sync.h>
 
 #include <net/sch_generic.h>
@@ -1291,6 +1292,15 @@ extern long bpf_jit_limit_max;
 
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
index 6aa2a8b24030..f49b9b23f95e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -20,6 +20,7 @@
 #include <uapi/linux/btf.h>
 #include <linux/filter.h>
 #include <linux/skbuff.h>
+#include <linux/static_call.h>
 #include <linux/vmalloc.h>
 #include <linux/prandom.h>
 #include <linux/bpf.h>
@@ -883,6 +884,15 @@ void bpf_jit_fill_hole_with_zero(void *area, unsigned int size)
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
@@ -941,6 +951,14 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 
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
@@ -971,6 +989,7 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 	pos = 0;
 
 found_free_area:
+	static_call_cond(bpf_arch_pred_flush)();
 	bitmap_set(pack->bitmap, pos, nbits);
 	ptr = (void *)(pack->ptr) + (pos << BPF_PROG_CHUNK_SHIFT);
 

-- 
2.43.0



