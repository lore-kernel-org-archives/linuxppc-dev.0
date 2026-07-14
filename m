Return-Path: <linuxppc-dev+bounces-24158-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1648C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 01:12:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzh9m2P0Sz2yYK;
	Tue, 14 Jul 2026 11:12:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783991548;
	cv=none; b=dq1KN8d5O0aZEdutjxMulLOMTZYcO1peFXkZKKMqRP0DDrhKPQplDikupDp5Nw2fI9XFXqmTu68we87Bt1YP/xc5jiV3/sbu/dsKUiXsfYOdNS6EJcbdh6bOZGDRHJshXhNe+pUIwjiO8ZysE8l3cw4O3Z9vF9eo008kkNvJ8Hri1GjBuIIqku9VU6q7nksWPYg5Qk50/m+gzWccO+AdB2hSKn0PJ/jlPDqKLtmtbavua6IkGv6ClzDidVDb5K9JxqSUU3eGt3BdkKpMPaSBiDyKlZ6CMwFMircT92buSGtV4WLEm3L4E8VEOPCIgQwM9uBwHyHhB5VPuKTnzRWC2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783991548; c=relaxed/relaxed;
	bh=1435yBrPZVfFUYJtBccpLcJFeVqUwU18p82pOLl0u2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErcVHG7W0ZuZhQcQ8+oepr7G0a0N+BidDVbeJHQpn23t6lah4I4L2ChwkhwJA7+PV8tC0hZL5NWEjTtXmcjPibsF4yK9BCunP+yPIg0/Z1H8YXSbxT2TLYuEkK6qU36BY4SN1odon/8eKNSBLlOSnLwSknW0/dPureJPTkUYhkRTmPdDSX/vddaKPmvbPUpZNXV0yCi9o/2NmhlpAsWe+ymvrH3yU4GEVQmR1lffmqvU4d87noyWmM6dK5dOmtwgSE8EBIdJpKpGdlbUwEcCKYwMaqIq5BdX+ljGRHMOoOOHbyM4IkPsoBYwL/C+16om2vcsTAjIfhajclotvpaATA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kEknEEBE; dkim-atps=neutral; spf=pass (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kEknEEBE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzh9k5wBFz2yY0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 11:12:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783991547; x=1815527547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SmKDjnU55LbR/+zA1mQnZYgp2l57eMHwgXQgKJ25Xdg=;
  b=kEknEEBEo4G/OzB1eg2OqfbEaofFhg4MhMmQoWuA83Ux+C9V6a6tB1eN
   H1vKyhtM1O2y2j25zVCG4aSue/sw8M+QAhVlMO34Gmmc33ZBR/VR+WCdd
   dpheSXGOztlMG0UK8B2w3NuFPVqFXri/ZZ4vjxn7huyHdONdznuSuRHfn
   4PusAw+Jq15p9mW+PUHTKJmaOZz09hrPTm1xm7i5E1hhZPNgK2fko9uGR
   T2CYKqimkATgR7juj3PYLzri1v+US2QVzBfuZWnxzxz8vDGbaXkM6GINF
   d3+fkE6pivtXTZQFOBXRQ10qaUC/HLNwqbNEW40Y2Bk052FBrzeoLzMs+
   A==;
X-CSE-ConnectionGUID: Is9SIwJiRjCJqgr/DPtU1g==
X-CSE-MsgGUID: dagPXc2+QMS6w0mj0BGYKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="110154746"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="110154746"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 18:12:23 -0700
X-CSE-ConnectionGUID: T5ownYrFSlC5dbM3dudMtA==
X-CSE-MsgGUID: xj2aKYHZT5G8a4mrVazDOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254583509"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 18:12:23 -0700
Date: Mon, 13 Jul 2026 18:12:23 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.18.y 4/6] bpf: Skip redundant IBPB in pack allocator
Message-ID: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-4-755f60c55705@linux.intel.com>
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
index 338a806e25c0..49ca543a4111 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -857,6 +857,7 @@ int bpf_jit_add_poke_descriptor(struct bpf_prog *prog,
 struct bpf_prog_pack {
 	struct list_head list;
 	void *ptr;
+	bool arch_flush_needed;
 	unsigned long bitmap[];
 };
 
@@ -910,6 +911,8 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 	bpf_fill_ill_insns(pack->ptr, BPF_PROG_PACK_SIZE);
 	bitmap_zero(pack->bitmap, BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE);
 
+	if (static_branch_unlikely(&bpf_pred_flush_enabled))
+		pack->arch_flush_needed = true;
 	set_vm_flush_reset_perms(pack->ptr);
 	err = set_memory_rox((unsigned long)pack->ptr,
 			     BPF_PROG_PACK_SIZE / PAGE_SIZE);
@@ -972,8 +975,15 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
 
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
 
@@ -1011,6 +1021,9 @@ void bpf_prog_pack_free(void *ptr, u32 size)
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



