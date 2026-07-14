Return-Path: <linuxppc-dev+bounces-24271-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2E9C4450A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 18:59:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h07s15b9Sz2yl0;
	Wed, 15 Jul 2026 04:59:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784055573;
	cv=none; b=Xa9o1MwOAww6NA0RfyJK8nqFkcycxKFM1U8zWnEhmjK9f064aQVCq0JfBhfX3qKx8icDikBzVbq5iPt1UhjgpSqfSq1R6ljQGfnpeUhjRHBQ5ppIHEcjITT313yYBDAPkFl/EMYuboqMjn+jAP/Mz2GLyXLXVDkRfiexhBlFuz6h5RhPqGXB1RrUdXvXbMeU4414DF9stdzyrIOOfCHR0RRABiXB6I4TgE6mDnRsE9/+i4+AgQ6NmphlMPY1d/kbjsnbkHDTn1OBP3XxU88+dhSMr42xnDN1lz6DqJWxXDvTE9Z2SyYj4B6T/sj/tq75BD8jNXat0iP1naxiLEOE7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784055573; c=relaxed/relaxed;
	bh=YsfJUwPQciWuHCW7KJS9+MVE0bbw26pIVNqKVxhuiSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tg+fnqmgD5h8TC9P4KSKyqvW9sJgUe300V9DrGyHwNb4Q7LOSTq3rcjtNmfA7Ql4TMVqH1mnLpp43RLFRLnKQFwM5uUvYX4BrImb4nduOFGYqGuGHKsQX9B0ffWd1Y1w5Bxs7aJvCYQQ2K9S/gpaozy0f/XWiTIZd8D2RLxR6mj4rWBQah7NFBEaARm7qRY56zbHwZkThVU5+iuX1PhDLtJSlbxu9wO5XDawFO/UYdRYO0WrvfuCija4uJNn6Mfh0iyGxbbQml/cYKQZldQzP51aWUWeuTS7ItKUF+A19TwieQMfqJjcTcoeiI+xLRY8xwtVTxE/3L9PAWwyi5VLHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T20GfwMx; dkim-atps=neutral; spf=pass (client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T20GfwMx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h07s03dZdz2yZf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 04:59:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784055573; x=1815591573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+XeoTue884A7t3GJfD8FvT8jZHCVJOdHW2hRNYvWNfY=;
  b=T20GfwMxi4NRUruk4FCsPJJ4t+uiQNDjMXq3FlNhta9etkJOMlxJrk4J
   EwcrgENNax2RbSCO4XO5niHvcEpdsmmCWxTVNSOXA7pBi7haXJZCYpGxZ
   qBKiQKIuDCn9oo9BnE1Xd2KQAqlfp4lYt6JNd5CfdURXldtprfqIm3G2V
   XgPCi0dUpUR5sf4y1otxEhtUWECYdWEl+AwdkjfcSwapwpdkk1t5UjzfH
   2EaTwCfDoj49GsjbXprIRlbHDmPYyYBR4saaavWdBm7sUyjb+ptTd1kRX
   MezDz4McDoDHUCpHX1+ZuOq3rQYQIlpoUH06NxLQMA8NTT6Iv6Vh/X3F4
   w==;
X-CSE-ConnectionGUID: bwqMSYW+Rhuu7xT0Q0N0TQ==
X-CSE-MsgGUID: SWQShB5dS3qgH07sjzREFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84708173"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="84708173"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:59:27 -0700
X-CSE-ConnectionGUID: pFSGXzHkT5+lUEyqkpz+uw==
X-CSE-MsgGUID: MiN61Di7TpmJkTg8hiI/ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="254209921"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:59:27 -0700
Date: Tue, 14 Jul 2026 11:59:26 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.16.y 4/6] bpf: Skip redundant IBPB in pack allocator
Message-ID: <20260714-cbpf-jit-spray-hardening-6-16-y-v1-4-2fc3e16263ac@linux.intel.com>
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
index 63569d23cfa0..9fc2decac07d 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -885,6 +885,7 @@ int bpf_jit_add_poke_descriptor(struct bpf_prog *prog,
 struct bpf_prog_pack {
 	struct list_head list;
 	void *ptr;
+	bool arch_flush_needed;
 	unsigned long bitmap[];
 };
 
@@ -938,6 +939,8 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 	bpf_fill_ill_insns(pack->ptr, BPF_PROG_PACK_SIZE);
 	bitmap_zero(pack->bitmap, BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE);
 
+	if (static_branch_unlikely(&bpf_pred_flush_enabled))
+		pack->arch_flush_needed = true;
 	set_vm_flush_reset_perms(pack->ptr);
 	err = set_memory_rox((unsigned long)pack->ptr,
 			     BPF_PROG_PACK_SIZE / PAGE_SIZE);
@@ -1000,8 +1003,15 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
 
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
 
@@ -1039,6 +1049,9 @@ void bpf_prog_pack_free(void *ptr, u32 size)
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



