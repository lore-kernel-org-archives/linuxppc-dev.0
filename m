Return-Path: <linuxppc-dev+bounces-24355-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2B4C4451B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 17:06:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1xCJ45cnz3c3D;
	Sat, 18 Jul 2026 03:06:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784307996;
	cv=none; b=JUECC/uSNr6zfpZwY7HDFDIkcARKDmnKTU+AtCVcJ18JnHdb+KwQZ4MybxAdirgOSq+V1CtMxFNOUx4jku7i2Oeyd//YdWuMPiil5tXfaEeW8Aw++DZDB+6C+rL4Uad1Pe4vzIZireZawgmCH7rcBkBovLIT9ETV1KNm2bCU81xY/shbkf6qJ4xDfylPCBBhl6oKI4vMxyXVAj7XD07uXRH9E1L9c/PhDJpBsf74bCFodc6nPxSWdhjDdZh7GUOwjbNMU5fhTFyr5wcLYA2XVF+e76CekNrAP89ut6rEo1BggyTuNU87KhH4u1iBMpwXQ31yvtlW5PxA87kKU0xS/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784307996; c=relaxed/relaxed;
	bh=dOTORUj/HSM6KL0+ect8B7CYlUCECWEXltkf/xl3GwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Huf2b/RIRWEqGi4F3rb+2DJLNXanwFV6b8ViXnEU5wBi4UlgA3KVRz0NO2thN3PYN/OBKr11PmvgEQyZAuxmhb7QGnINcjgXwgHFl3jsMaRG+uTWxxxD+bpdDb1yCkX9B9A3rhiQ/OehTllEQ6dTXbsWBP4W1U4Iq25byg8eObcIJf2quaJBkt8uEsSxhEv4gHmFsARNFuudI7JaLjofnn5tmo7Jy20o301VOaUvpUPIRwYH8WoEJg0hXZsBRkPfy6KLcBiKlPf6qt081yoUvCRa60pFbpoxe9j4bQg0aQVAE+ntfOWcw1i8/8abb7pzFuMmB5uU/hrDPYo0M/9EnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gaBDLgt+; dkim-atps=neutral; spf=pass (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gaBDLgt+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1xCH2yyrz3c2L
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 03:06:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784307996; x=1815843996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rONpXb9oW8OPj3FBvfBdm+Rp5+4wO/sYuo0vcpGBnuM=;
  b=gaBDLgt+5b0An1ZTjDh1Q+MaJEo2SYpPOYozessWTFD6BbAEe7S8zKCM
   lGBhNYl4kN1XZf4nA2QrwiH/jSMDd2t1SEmxb6KKD+mwgppjKzQUw90mR
   yAEKGfihmLBgqJaIEutbQ228HKhW/C95mqKEk9U/feAA1EbwoYAlRUDp/
   tHt7saURejIg35TMGa7LpMIlbqHgxFJrj4gSv9sJkdtWSQ4nnzdqXCWO0
   NWj2EbyjsKGkUfINPtC+ZceUj7ZqVN+Y4LyWntoRVdWapA78I76h5WbOd
   o98Sm5tMj09p4VUBHt/T8LeF84ll8XCW7dxhKSl2k8A6h1SHZYiAIX365
   w==;
X-CSE-ConnectionGUID: MNd9TzKsRw6aY2wIMZTY6g==
X-CSE-MsgGUID: IFeetH0mTmSz8QbPGZcddA==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="110533752"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="110533752"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 10:06:32 -0700
X-CSE-ConnectionGUID: XSAC+DpETV6yB3MNtcR+cw==
X-CSE-MsgGUID: GgbsLVAVRKWYlWFo0XeHOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="286903817"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 10:06:31 -0700
Date: Fri, 17 Jul 2026 10:06:31 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.6.y 4/6] bpf: Skip redundant IBPB in pack allocator
Message-ID: <20260717-cbpf-jit-spray-hardening-6-6-y-v1-4-e04f1b2893de@linux.intel.com>
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
index 509f1b9c2b2e..a2e5684d6239 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -851,6 +851,7 @@ int bpf_jit_add_poke_descriptor(struct bpf_prog *prog,
 struct bpf_prog_pack {
 	struct list_head list;
 	void *ptr;
+	bool arch_flush_needed;
 	unsigned long bitmap[];
 };
 
@@ -906,6 +907,8 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 	bitmap_zero(pack->bitmap, BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE);
 	list_add_tail(&pack->list, &pack_list);
 
+	if (static_branch_unlikely(&bpf_pred_flush_enabled))
+		pack->arch_flush_needed = true;
 	set_vm_flush_reset_perms(pack->ptr);
 	set_memory_rox((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
 	return pack;
@@ -952,8 +955,15 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
 
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
 
@@ -991,6 +1001,9 @@ void bpf_prog_pack_free(struct bpf_binary_header *hdr)
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



