Return-Path: <linuxppc-dev+bounces-23975-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E79C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 22:24:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx8df1dGDz2xWY;
	Fri, 10 Jul 2026 08:24:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783635862;
	cv=none; b=mFv0E5N1gfXRHgBmHc4SRv/mJifoyXJPzVVZ0PHlrG3pMOYvtpsgcBN9zlNASH6usHF4YaABlhQV22LLwak/gby8Wqp213/P/Co6Zit/rdm6BomUJ0GvRlBcj1D3YwhbtCyfhbTvKKKgGV0vQ0+L+J3os3XrZNhpH/Kp+wsqBUi8M9pAxuKs41cnyfzpTx5RTAgpSudvn936HyWyx3NfGg4BrSQPPmOVWplBuiUlYn7vgVV8qPO91zUCdjc8Y6ht+4+rvYYLle+60JhfSmV8jnDMzsqjck2+td2ApTE01KSvpLqBG0liiojdqAketBxnE48PqRWS/fwrcOCCvHKenQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783635862; c=relaxed/relaxed;
	bh=57eiUjUaFCdvUIA37WRQDRfWH/rwYy7WUQvwbU3B5RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoLcIiJv3d9EhNFK3rO8Q+FAIsnpINeemnn6U6Gatmr+meZ1d7ytiUGtWfaMQ9QbeJQWWuOWiOEBPLCmv+hD1iBQXyU9c53LGRIc/cTPyuRtjKAGjJ6pBpqO09LNJNFe90/nsmzST6o4zXjfa6sdWzsflisggGGaBjs+yAeJ4Af+0XFT2Y886r9TWCm9hwnCAnGS8gIu3bZFvAs/gLskqzaOowPaIyJ1HC/5UM/CjsA0Xhlm++wGixrdz2P1/YQRWUTk3tb6oqSTswlJii3z06p8+BJvZgaL+cbJEvrXR5axSPFAF412m010XVT1gBgQy4l5Kf5yQkQ2ABBbi8oPIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RKuCoScL; dkim-atps=neutral; spf=pass (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RKuCoScL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx8dc2NfBz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 08:24:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783635861; x=1815171861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vmkP0yQw4l/AwIxIqFDbAQio17LtOdykU5QuvODGdUQ=;
  b=RKuCoScLBLCJ+5Pp86nAo9EVBKsM6xyhKXEr9OF4tGC/s9GsjlmLA3m0
   m5MlRTBwxpx36s6VQPDuUl66YUszYfiBaOsLqOJ4ytuDf19NkjCWOErFH
   FdtKqgYW1P7OphLeZcnsEPq3aZwS2fzDVOQDLjfvU2Ny92fwVu86CVEPR
   yJ+QWTvjz0k8BJyMeeKLm+OYHKAWeEi/hA6a3yGWYvzD1HPeCM0Lx7lKH
   OPcCN4ko/+AYZdagWdHqqiWPcyNVw9qjIfYl7zV+lFnRSgOdyf9Q3kgpW
   1NatuvBWtor1Rcv6sFt4X0MbwVGAxxp0znkbc3dsy7iwaOeRgqqVD6vlR
   A==;
X-CSE-ConnectionGUID: k0FF1kOrR2mvFDqwlN0BBg==
X-CSE-MsgGUID: RpkNgdiaTZWwbctX3ZcEww==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101886005"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="101886005"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:24:17 -0700
X-CSE-ConnectionGUID: 1JRy3pUPTIukZZL50LIqNA==
X-CSE-MsgGUID: TrxwbYv9SZa+fOOrPTfkBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254226918"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:24:17 -0700
Date: Thu, 9 Jul 2026 15:23:56 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 7.1.y 4/6] bpf: Skip redundant IBPB in pack allocator
Message-ID: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-4-5ac5a2d6797f@linux.intel.com>
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

commit a23c1c5396a91680703360d1ee28a44657c503c4 upstream.

bpf_prog_pack_alloc() issues IBPB on all CPUs on every cBPF allocation,
even when reusing chunks from an existing pack where no new memory was
touched since the last IBPB.

Since IBPB on all CPUs is heavy, Dave Hansen suggested to track allocation
since last IBPB, and only issue IBPB at reuse for the chunks that have not
seen an IBPB since they were last freed.

Track per-pack whether an IBPB is needed via arch_flush_needed. Set it when
allocating a chunk, reset on IBPB flush. On reuse, conditionally issue the
flush. Since IBPB invalidates all BTB entries, clear the flag on all packs
after flushing.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 1b7e74e63bd4..1bf4b8dffe91 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -876,6 +876,7 @@ int bpf_jit_add_poke_descriptor(struct bpf_prog *prog,
 struct bpf_prog_pack {
 	struct list_head list;
 	void *ptr;
+	bool arch_flush_needed;
 	unsigned long bitmap[];
 };
 
@@ -928,6 +929,8 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 	bpf_fill_ill_insns(pack->ptr, BPF_PROG_PACK_SIZE);
 	bitmap_zero(pack->bitmap, BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE);
 
+	if (static_branch_unlikely(&bpf_pred_flush_enabled))
+		pack->arch_flush_needed = true;
 	set_vm_flush_reset_perms(pack->ptr);
 	err = set_memory_rox((unsigned long)pack->ptr,
 			     BPF_PROG_PACK_SIZE / PAGE_SIZE);
@@ -990,8 +993,15 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
 
 found_free_area:
 	/* Flush only for cBPF as it may contain a crafted gadget */
-	if (static_branch_unlikely(&bpf_pred_flush_enabled) && was_classic)
+	if (static_branch_unlikely(&bpf_pred_flush_enabled) &&
+	    pack->arch_flush_needed &&
+	    was_classic) {
+		struct bpf_prog_pack *p;
+
 		static_call_cond(bpf_arch_pred_flush)();
+		list_for_each_entry(p, &pack_list, list)
+			p->arch_flush_needed = false;
+	}
 	bitmap_set(pack->bitmap, pos, nbits);
 	ptr = (void *)(pack->ptr) + (pos << BPF_PROG_CHUNK_SHIFT);
 
@@ -1029,6 +1039,9 @@ void bpf_prog_pack_free(void *ptr, u32 size)
 		  "bpf_prog_pack bug: missing bpf_arch_text_invalidate?\n");
 
 	bitmap_clear(pack->bitmap, pos, nbits);
+
+	if (static_branch_unlikely(&bpf_pred_flush_enabled))
+		pack->arch_flush_needed = true;
 	if (bitmap_find_next_zero_area(pack->bitmap, BPF_PROG_CHUNK_COUNT, 0,
 				       BPF_PROG_CHUNK_COUNT, 0) == 0) {
 		list_del(&pack->list);

-- 
2.43.0



