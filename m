Return-Path: <linuxppc-dev+bounces-24307-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C305FC44507
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 21:28:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0q6h73Xkz309r;
	Thu, 16 Jul 2026 07:28:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784150924;
	cv=none; b=jZNGbPbzQuVr7hbFkddeBG7FSLfJtkTIlZK4j8hfLb37E8MLsJG0GcmmKnN8JxBTFJifN1O9PB9VFu6a10TCWr09ObxseXsBKsO2RRXMdxF4raNpfjVz7M4o8ni1DBf0on24Ptxrd87Zhpgu8RBMs7h8a87yXZguPKU1vJffL/WWogfDRIbN2u239d5fMcJONeuNVMCw0w3XqPyxvrQYsXFPhPjwkAXOTjqHYXi0SFpmhL/W5NaEwRddpcbcw1GpPHlcPuCA2Ken0YJE2KByrWr+FUEWe1SGAKjH++KUh7Hcn3JYO6+HMsNpxsN2W6ZhyXKSEOI1rWt9k4IJVS/kyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784150924; c=relaxed/relaxed;
	bh=VqfqHKHeMUeENAmz7Beo8gKkc/p8bGV9Xvtavlvowa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEUPue03NmYlbc6vwOdyRmMz3VOJGYHuBkdFNGaeLcPGSM17mM+oSe6UilqCl+05irJY1ywOUuc5T/kZq+pGiUgjoNgaCtf4vgzsZDTS2r+PYRerHp7rJu+B5csHl0sxIrgQjI4KUuMgx4GUodWNvtLOC7pTLPFqAaBzqIbDVYLYP5WH9ZwAv7rTkjq7dspOfoH4g1I++u7LXO7IQnHh4gxWQEol/n4RoCRDpY8bdGXIX5FcE95lPNCjMXLWE4+TzORvNCfuMIw81U92zDZZU5UqH3YWCz50OT/BIYWKOT/JvnvUVqd5PiSCsmUaOOUlVG6D7KdsNtnUKsDC51OqOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cU3D9ybn; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cU3D9ybn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0q6g56wpz3092
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2026 07:28:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784150924; x=1815686924;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=27ZyiUUnfe91sw+h1R5+n4J6XxVV+ocs/Xfa8+j0PDU=;
  b=cU3D9ybn7GEdl8sP6mJQqClzEkDEsmteVU4v15mLCJBwJHiInZxso3H6
   KbQKdXIXWp9LX7eLYJe2XPSppXbBCK3zKagT3n59+m2C2aYPbUK7zxa56
   GYhSajEpFP+FlsOpMbgT10CkwBAz/D9JBPLs+53aRDc9uNGhOxBZXAriw
   aHNBn1BUf9UqjXrOwfTbN8lw/crvhl3A883O3zTaq7HZEQ6NXF34pMs+p
   YTjLui9VkTA0eTpaI1bESdKu2rwDj/OR8D3faNE0CJNbw2HiHGdEjOCAy
   kQ8aGIlmbQHkXjhr2hLxEH31v0esFvltgepn6fUPIEaXZCiG4GAEIoQNH
   g==;
X-CSE-ConnectionGUID: kq0JXeJdTZuJhQ67ycPRPw==
X-CSE-MsgGUID: 5YS53PeWQSqMSPKZmxWBxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="107603313"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="107603313"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 14:28:40 -0700
X-CSE-ConnectionGUID: XzveoCyATtCPwz9eJgp1xQ==
X-CSE-MsgGUID: mka0u/GvSp6KWpK6NxjxQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="258270635"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 14:28:40 -0700
Date: Wed, 15 Jul 2026 14:28:39 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.12.y 4/6] bpf: Skip redundant IBPB in pack allocator
Message-ID: <20260715-cbpf-jit-spray-hardening-6-12-y-v1-4-d8585a9aed80@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260715-cbpf-jit-spray-hardening-6-12-y-v1-0-d8585a9aed80@linux.intel.com>
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
In-Reply-To: <20260715-cbpf-jit-spray-hardening-6-12-y-v1-0-d8585a9aed80@linux.intel.com>

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
index 29d39092c457..357af07b9ba4 100644
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



