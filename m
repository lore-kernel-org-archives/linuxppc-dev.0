Return-Path: <linuxppc-dev+bounces-24267-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0081BC4450B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 18:58:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h07qs1rZ5z2xyj;
	Wed, 15 Jul 2026 04:58:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784055513;
	cv=none; b=ViEPcW3+hi46qEkHQEmMoxHeb77T2IgBzl3n16TfzFTbsnu5kjCROYdWcH5SDdeJNsrmqm2WCqRi5fM22mnUicydD4DA3E2xXLnd+yN1aZoxwijKdcPOkmm6YhEa1mEvSu2n31Xum3G4/l9pjZ3e+pWUOTaJ+CU05IeMvILrEROYRySJl/KYM4J1BIFoD0Qje2U0zRTQQuZP6s0/VHqPKprnePWXBta/vF4KtFTcMFF9dURAx3F28tXoASArx+hUSkf4Jb/ey2Z2fozZUu0m+wx3mhOt0/meaVoy6LqwI1Rt3gNxWBDUr3t8W6eS0A0AeOnKOfLRe3ew3WWRlZkiGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784055513; c=relaxed/relaxed;
	bh=eanP+BcGSKoSZ9Zq9+AjtXyE2g1OQWVtY+mBFuNF0yE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SGnvmWeZg01ZFYyb8i48LTYnl9R/UU9eATlNhDGEEZSlqKJO9ZhvQEFM7kBZ8gxRxbWphe8VwenRzdLIpgd5bc5o85gxhOrR2iL0i/sT7vZZ06ZFJ/WqQx0TFVawSCXJ6n62V3gB+nETxpJqondPyCgQ5MFjl0LiqeZR4/HK8JdyOyhs2x9nEWXuyvKM9ogO46efQcLUVJLvphieepVNgrDOL3enoZWwRL40imNr3ivT3Y57eEZqgftqh3A5ReSap8ZcaEdqb02OOhasiaQgwQlB2EVD/AY5vpe6yQsnZe1peiuan505JUUeZC3RCKEJaVJPmRp2i3DtoJ6FZRW49A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RVKE7lsC; dkim-atps=neutral; spf=pass (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RVKE7lsC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h07qn5s91z2xqM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 04:58:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784055511; x=1815591511;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DzLA4w38CFwdzu/Uzj79RDIxzZT2AwfMc39nX/r/t9k=;
  b=RVKE7lsC5bN4+0mmYgt4DMT4A2Jj9rKAi+yYbS9kEaJEsa/hOMziFvIq
   AeaW0Yk2IMheYYRuSZzWatvRyckEoOzAvN5+u92yOqp2zBOgcwXLmWw84
   wXR0vYlzMJJahnBSMBstWkx/GM/tf5VznFxU9nTmwnwj21GL3HBSOe/9z
   /HLHX6Vms/KNTKLOBIt/xRtnQ+bY2VoOPRlet6w0KDkjaAiWCYDtVOG+8
   jEGb+fp4+xkCFczOfn5KcyR3+amn2B2JM/1uMWXd7z7LjQS7f0KMvpCFO
   Hat47FjGkiePBXfRt96ojnT9xePk064kyQOY4aW91C7aC11ommDKFsyl/
   g==;
X-CSE-ConnectionGUID: 7K7ZwyPzTbqLXaYh5N4e1w==
X-CSE-MsgGUID: WGH8vG5IRZC8PUyXXkfaKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88586663"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="88586663"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:58:25 -0700
X-CSE-ConnectionGUID: zJdJZMFdTvexCooRz9Lb5w==
X-CSE-MsgGUID: eYih6CtRRc+2gVaty5xw2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="255442489"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:58:25 -0700
Date: Tue, 14 Jul 2026 11:58:24 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 6.16.y 0/6] cBPF JIT spray hardening
Message-ID: <20260714-cbpf-jit-spray-hardening-6-16-y-v1-0-2fc3e16263ac@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAGOGVmoC/yWNvQ6CMBRGX4Xc2UvaBurPRlwcHdyMQykXuAy1a
 dHYEN7douP58uWcBSIFpginYoFAb478dBnkrgA7GjcQcpcZlFBa7GWFtvU9Tjxj9MEkHE3oyLE
 bUKPUmLC2taiqY39QwkK2+EA9f36FO1yb2/myrbqUukzw+B/iq53IzlsH1vULVVaQGZQAAAA=
X-Change-ID: 20260714-cbpf-jit-spray-hardening-6-16-y-5c50449f820c
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

This one is mostly similar to 6.18:

  https://lore.kernel.org/all/20260713-cbpf-jit-spray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com/

---
Pawan Gupta (6):
      bpf: Support for hardening against JIT spraying
      x86/bugs: Enable IBPB flush on BPF JIT allocation
      bpf: Restrict JIT predictor flush to cBPF
      bpf: Skip redundant IBPB in pack allocator
      bpf: Prefer packs that won't trigger an IBPB flush on allocation
      bpf: Prefer dirty packs for eBPF allocations

 arch/arm64/net/bpf_jit_comp.c        |  4 +--
 arch/powerpc/net/bpf_jit_comp.c      |  4 +--
 arch/riscv/net/bpf_jit_comp64.c      |  2 +-
 arch/riscv/net/bpf_jit_core.c        |  3 +-
 arch/x86/include/asm/nospec-branch.h |  4 +++
 arch/x86/kernel/cpu/bugs.c           | 50 +++++++++++++++++++++++---
 arch/x86/net/bpf_jit_comp.c          |  5 +--
 include/linux/filter.h               | 15 ++++++--
 kernel/bpf/core.c                    | 68 ++++++++++++++++++++++++++++++++----
 kernel/bpf/dispatcher.c              |  2 +-
 10 files changed, 135 insertions(+), 22 deletions(-)
---
base-commit: d997d33eb340e2add100eac1222e107cc1396e76
change-id: 20260714-cbpf-jit-spray-hardening-6-16-y-5c50449f820c

Best regards,
--  
Pawan



