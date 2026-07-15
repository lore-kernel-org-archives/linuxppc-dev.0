Return-Path: <linuxppc-dev+bounces-24303-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65CEC44501
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 21:27:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0q5g51jWz2yl0;
	Thu, 16 Jul 2026 07:27:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784150871;
	cv=none; b=NmFOYQHe/I06GSkVPT7oIRCrF/dXfno4NtQM5rXZiSkdJ76Xss4PkrNYLkJNljLkUF/CJN6peUWFEZcMMBeyGbPgwJEQ+Evof4kAr4mgkP6p+4t/tIwWyR0FqYo5jdMYx2LzS8+g6/uu+aoX47IDVueKlUsvqdvB16qm9MXAgNu0aHouM5mh90uZOPftHCZei8y3Rb0oyhKgsZOi5vjn1FSeyP71xZVNIdgVSedSXGGePz5xHZwaUfgfNf/77pUyI1icvXcmOFNBYglCid4A8ZRKP5rPIRrslA94kXe5SVs4uP3Kq087wAixvVBJ0PY6hMuEu94n8jTxQ8IokQHUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784150871; c=relaxed/relaxed;
	bh=GTlIlgSZPByv4eAEE2x71p1IKay+EOZkljJXLymjOJM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OeZ42IGQb4m+ydxs1MU9+wR0PKB+Y0yRxwAexAucVkQoQBEl33+sAySPHld6RjgOzegNoW9yp9axne+LNTFm6TA4AjDi5tKwZB3to4zS3LBMDWjjxExp/7P5hd9dkahm87GXVA6PjBYP5HLWwFjL9LWw0ka14DKCShMb0K47yZlsVo900ct5yaAn+N6mHxTMNA+uUU8dyOpnPigdTs4JiXiaRy2DUMmlZDgNa6tV0tdNsbOIYrxN6pl+E+zzKtPN/g91ZW/DsmlQC7xJKSL3yucod5qWi8kHRlvk+4KN2j6bPs+mpe60VhJDwDLZ7b942L1EwqTE3UIaTi2z2eNQOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CVM/GD97; dkim-atps=neutral; spf=pass (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CVM/GD97;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0q5c0FD8z2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2026 07:27:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784150868; x=1815686868;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Zcl/hJP8vOoXfaWvVzA1OXL0SRddDjKbhCcj2uRFlLk=;
  b=CVM/GD97LoVqyiQc0XvtyxIQCYJ1643cWYlAoOHA68WDWVMSYXSkEIx+
   VvRo2jB1vX+Jpcx/lgjvYPH4pBY/38eShxTMKa5NMUjJoYlL0ozkeucCe
   SUDkAUBvdLJXZFPI/9YCE1e2giqjjxeiLM/f4RLkDEGIBhjsxE4QRaQY0
   OXtnYLOZD8H2YS09TTC+TWQFBJUuU2xLtOaedAckBoEcjFKgw86c9G0Hh
   ZhQfNIVmWbYmPtevKm3GspH1jHlymaOlkZnF6Ezh5qO99vk9sKSBEXlef
   Z4ZQvEMl+DXe6shD31+An/oyPpJnp42Y8UQDRn1gP4E7Fz+7ztUnnGy+C
   g==;
X-CSE-ConnectionGUID: sKpaM8whTZKa87f7Oa1KLw==
X-CSE-MsgGUID: CjWYHvjkToKI9yu1EcgOqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88481982"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="88481982"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 14:27:39 -0700
X-CSE-ConnectionGUID: r4pyfzu7Q7+IwAqhuwZT7A==
X-CSE-MsgGUID: c+t89wMuTT2M218KSPaJIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="286384073"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 14:27:40 -0700
Date: Wed, 15 Jul 2026 14:27:39 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 6.12.y 0/6] cBPF JIT spray hardening
Message-ID: <20260715-cbpf-jit-spray-hardening-6-12-y-v1-0-d8585a9aed80@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAPf6V2oC/yWNsQ6CMBRFf4W82UdoIwXciIujg5txKOUBj6E2L
 Robwr9bdDw3N+esEMgzBThlK3h6c+CnTSAOGZhJ25GQ+8QgC6mKShzRdG7AmRcMzuuIk/Y9WbY
 jKhQSI6qmFKYuha6aGpLFeRr48yvc4drezpd9VbmQeYTH/xBe3Uxm2TuwbV9vroONlAAAAA==
X-Change-ID: 20260714-cbpf-jit-spray-hardening-6-12-y-6951c851a798
X-Mailer: b4 0.16-dev
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

Hi,

These backports harden BPF JIT against spectre-v2 class of attacks. Without
a predictor flush, execution of new BPF program may use stale prediction
left behind by the freed one.

To avoid this, issue an IBPB flush on all CPUs on JIT program allocation.
The flush is conditional to spectre-v2 mitigation applied.

Patch 1-2: Adds the predictor flush hook and enables it on x86 via IBPB.

	  bpf: Support for hardening against JIT spraying
	  x86/bugs: Enable IBPB flush on BPF JIT allocation

Patch 3-6: Narrow the flush to only unprivileged JIT allocations
	   to avoid redundant flushes. Also adds pack-selection changes
	   that minimizes flushes.

	  bpf: Restrict JIT predictor flush to cBPF
	  bpf: Skip redundant IBPB in pack allocator
	  bpf: Prefer packs that won't trigger an IBPB flush on allocation
	  bpf: Prefer dirty packs for eBPF allocations

Conflicts resolved in patch 2 and 3.

---
Pawan Gupta (6):
      bpf: Support for hardening against JIT spraying
      x86/bugs: Enable IBPB flush on BPF JIT allocation
      bpf: Restrict JIT predictor flush to cBPF
      bpf: Skip redundant IBPB in pack allocator
      bpf: Prefer packs that won't trigger an IBPB flush on allocation
      bpf: Prefer dirty packs for eBPF allocations

 arch/arm64/net/bpf_jit_comp.c        |  4 +--
 arch/powerpc/net/bpf_jit_comp.c      |  2 +-
 arch/riscv/net/bpf_jit_comp64.c      |  2 +-
 arch/riscv/net/bpf_jit_core.c        |  3 +-
 arch/x86/include/asm/nospec-branch.h |  4 +++
 arch/x86/kernel/cpu/bugs.c           | 50 +++++++++++++++++++++++---
 arch/x86/net/bpf_jit_comp.c          |  5 +--
 include/linux/filter.h               | 15 ++++++--
 kernel/bpf/core.c                    | 68 ++++++++++++++++++++++++++++++++----
 kernel/bpf/dispatcher.c              |  2 +-
 10 files changed, 134 insertions(+), 21 deletions(-)
---
base-commit: 296aabce459470a4c1b68ffd0c0c0920e563aaad
change-id: 20260714-cbpf-jit-spray-hardening-6-12-y-6951c851a798

Best regards,
--  
Pawan


