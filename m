Return-Path: <linuxppc-dev+bounces-24273-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4C4C44507
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 19:00:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h07sb0Gqpz2yln;
	Wed, 15 Jul 2026 05:00:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784055602;
	cv=none; b=Kv1U77xBJMzlLGGOV+8RbolWZ44U6wj5A+859BR709Cdpy9YPgWQ5k3DCgVSfm0z2HVTumtJTqSh4wPgnjElAWcMrcpChxLxkDplOpDKvyemM2CyIgpKdDplPb/puraWcdfg15ctx63QdXdHP+7vM+p4G8TfwimATMcDlpI4g3FZGh/Ukws+Q6v7fN/A1M2DGos6Yb5GXygF4ilspT5tM9bJjciplnZ9en7KmiUTZub2m+CbrYKbCu2fftuwDgsrrZJBTh9eDnfzWBf4Cmc2PtKfuO2AEZb/6duu1kDcGI3a65x1Duep/yzSzNgLrpMbu+xAyiYZnptmKlhLm8n14Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784055602; c=relaxed/relaxed;
	bh=QzZVFbgbmv1vCUvZWeyfyaG2u155mvnyt4yNEuC5u+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wt/Ji7U5A93wec9VcTIKjir08veyqQ0FjrLY3bbvn8T90Ul6lZ0PbS7wYT1EY1mlC7VtRGeNDB3tMw08tqCnrhAycNSdjqHxYxUkl1C2ET9dQ4DEscnA+XJkSFLgFI7tI5OR/x0zKm6Trm9DhFdQAEIodR9be+rxtFvEGIMIqzWz0MEw/QWW0+55OrWtlGsNXOp877glQ2N7+3sJaySwn20Kl5RRg7LOWoRnP2cAHumA6hbmCH4UXj2k5UBw4dYZRjqZoZnq3mO0H9cL48KgrMRGlPHcXJ5zxmUwV1ndrdsuuSAmAABeIn285UiPKJ4/yP2QfMWYhaKVl7DqcEgbvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ilb+DptL; dkim-atps=neutral; spf=pass (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ilb+DptL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h07sY4J3nz2ygX
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 05:00:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784055602; x=1815591602;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ikwe3QzBMYqyLtMu8y0CioWHL4Q5Qo0Uc8ghNJ9gyv8=;
  b=Ilb+DptLhW2FEq9e241hpRQXOaJWyyqusfZoLEt+Vzwyul21Vf4mZgt+
   4Ois9n8edY+icTow3xZ8p5c5UAQUqisNHUCMhDkp8zDx4Z01hq8o/mezk
   nMqnHrCphpyTvaUrrPPgMeJDNhUJCRtIL/vLAWPAlK5a8Q5KCyNPrj512
   E0OGekdpt80xsN+k7O7SYMdz8YTRVj8wkOariTIPGzLIWXWeE32rkAld7
   KKxhy0GuCgrBX0rdKSZoKeebGbiqTWyelXA519+mqrYq+MrJ1K2n+dCmd
   oalRVUtx0jhhOyl93vZFosDqZ3gQ8OqA/rqF4x2mkkVIKl+J51iHio00A
   w==;
X-CSE-ConnectionGUID: yHsTRwiiSQaKMQ++KbuUcA==
X-CSE-MsgGUID: Im3IezTESJ2kCHRVGCTP6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="102241388"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="102241388"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:59:57 -0700
X-CSE-ConnectionGUID: 95cGieXzRFy9UhU+YBoKFQ==
X-CSE-MsgGUID: kfliOx19SOG+1mAaLyHOnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="279225339"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:59:57 -0700
Date: Tue, 14 Jul 2026 11:59:57 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6.16.y 6/6] bpf: Prefer dirty packs for eBPF allocations
Message-ID: <20260714-cbpf-jit-spray-hardening-6-16-y-v1-6-2fc3e16263ac@linux.intel.com>
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

commit b72e29e0f7ee329d89f86db8700c8ea99b4a370a upstream.

The pack allocator only flushes predictors when reusing a dirty pack for
cBPF, eBPF allocations never trigger a flush. Currently, eBPF picks the
first free pack, which could be a clean pack. As an optimization, leaving
a clean pack for cBPF can avoid flushes.

Prefer dirty packs for eBPF and keep clean packs free for cBPF. This
mirrors the existing cBPF preference for clean packs: each program kind
prefers the pack that avoids an extra flush, and falls back to the other
kind only when no preferred pack has room. eBPF reuse of a dirty pack is
harmless since eBPF being privileged does not flush.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 81ba423d0f8e..0bed7fe9821e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -998,10 +998,10 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns, bool
 			goto found_free_area;
 		/*
 		 * cBPF reuse of a dirty pack triggers a flush, so prefer a
-		 * clean pack for cBPF. eBPF never flushes, so pick the first
-		 * free pack, dirty or clean.
+		 * clean pack for cBPF. eBPF never flushes, so steer it to a
+		 * dirty pack and keep clean packs free for cBPF.
 		 */
-		if (!was_classic || !pack->arch_flush_needed)
+		if (was_classic ^ pack->arch_flush_needed)
 			goto found_free_area;
 		if (!fallback_pack) {
 			fallback_pack = pack;

-- 
2.43.0



