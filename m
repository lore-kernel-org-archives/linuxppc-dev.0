Return-Path: <linuxppc-dev+bounces-24156-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0C3C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 01:11:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzh8h58W2z2yYK;
	Tue, 14 Jul 2026 11:11:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783991492;
	cv=none; b=mx47wuwu6LNYPvgUVz/ZrfSkiUCXQ59EqpdPA3za/u9xfjTnd0Omsx/qbVWgDsBFVhzMY2X02QXwzzwTD6sH8SDQNmrEHhY5l/BNUsqK1TnThj24Xm8RSbRsi2Sm1HwQMWtas51zO7n3Y9R+3DeqR3NpppXNp5wMjjtxg5G4HhhXGL5gsFMFQpnQFAE3526PVmvVHrVUdagmicqpRyyLCK0qpENdk37JCjb/8yDY544yVm81nQh0zcxyRn/nJgh/kVqiQYq7Rb137x5lgJonQwjRGIrdY/b4X5cxnhwjKlAhMABo2IDKocVKLtI8XqxDUi8qNSWSG0upbzRQXi5F6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783991492; c=relaxed/relaxed;
	bh=Uyu6UWSikG2Cbt5OXdKC4BoFkWW7kbNKN8/sWUzYl+0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UsqlzkUVRuG4t/wjcQnk3v044oL4Cxmz/mqfX/r+buZ/oZF/2EtNSCVpQTCBOUtpgtjkWsKvECAfQ+qsK3P3kZXRGFJDb7LogWM7idZZ/8BHmQXkcv5rUOs4x80bMUb099wkjqolBWgswniEJAynXzN3q1sryQuq6XpD1+9WSZq4BRlydKeVj4w8XG3Ym5iJRbGXxqDuoUjl7/WmBDSA8f9vaQsTywxq/nyuSgXyp/tZYKCquu/PRrYwZSEeTxUpEK7Y/VtwrfLqSKi5vrkybMg9jDlhPMQYE+0HWW+2KIzBw5uuY7Rl5txDth/w+quIwygSaJyXRLmL8acaNGcPgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ifULR15r; dkim-atps=neutral; spf=pass (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ifULR15r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzh8d1Bwzz2xVY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 11:11:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783991490; x=1815527490;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DCbMgnamWUlHK3HfeBnVqU97YJbvkxfbDCJ2xswtGHo=;
  b=ifULR15rRoctgkb1L89xsFjHOGw9/WzQ81QJoM6BzF/UB4A+IbOCxKPZ
   tX8rIUIyO6bq9fDWRe+SwnCpGx8dtPDPbDvnGOuoOK1dHgUefyLuNx8zw
   j2S85WZ5mCvJQQ+QrIqvtqgVQOx+UlDI4mElCztQhBVr5pyVAQD9hIio4
   bvUEzSH1JchMXV1DOFNzPm/0fYQe3Bb6F0ExcINamnYySRP1LfNLt1kmh
   tZxoW97tD1FlMT3Tf70ZFa0yyVCHYpcSv/eEg8PWNuJc3mhTjPZjR0iKS
   1K1Qs/d52QIbfXChT9so5KvkZeBzsmbWaToduulf0jGU52IYXcBF+tZjX
   w==;
X-CSE-ConnectionGUID: iVMsdejKSLm4O5SEMEqSuw==
X-CSE-MsgGUID: e3Z8clJUQxKYFLnrt1USsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84702130"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84702130"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 18:11:23 -0700
X-CSE-ConnectionGUID: X0NUj8UzT+uuLyJCHusJHg==
X-CSE-MsgGUID: LMEMMUp0SqmapMABq2oo4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="252318584"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 18:11:21 -0700
Date: Mon, 13 Jul 2026 18:11:21 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 6.18.y 0/6] cBPF JIT spray hardening
Message-ID: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAFWMVWoC/yWNsQ7CIBRFf6V5s68BTAq6GRdHBzfjQOlr+zogg
 WokTf9dqsMdzs3NPQskikwJjtUCkd6c+OkLyF0FbrR+IOSuMCihGqHlHl0bepx4xhSizTja2JF
 nP2CD0mBGK5Qx+uB0CZSXEKnnz89wh+vpdr5sbVNLU2d4/Afp1U7k5s0D6/oFVLm6h5QAAAA=
X-Change-ID: 20260713-cbpf-jit-spray-hardening-6-18-y-a028879c779c
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

Patches 1 & 2 had minor header conflicts. Patch 3 had a few conflicts in
bpf_int_jit_compile(), majorly loongarch bpf_int_jit_compile() doesn't use
pack allocator, dropped was_classic hunk.

x86 builds and boots fine in a VM. I don't have build infra for other
arches, relying on the bots for the builds.

---
Pawan Gupta (6):
      bpf: Support for hardening against JIT spraying
      x86/bugs: Enable IBPB flush on BPF JIT allocation
      bpf: Restrict JIT predictor flush to cBPF
      bpf: Skip redundant IBPB in pack allocator
      bpf: Prefer packs that won't trigger an IBPB flush on allocation
      bpf: Prefer dirty packs for eBPF allocations

 arch/arm64/net/bpf_jit_comp.c        |  4 +--
 arch/loongarch/net/bpf_jit.c         |  2 +-
 arch/powerpc/net/bpf_jit_comp.c      |  4 +--
 arch/riscv/net/bpf_jit_comp64.c      |  2 +-
 arch/riscv/net/bpf_jit_core.c        |  3 +-
 arch/x86/include/asm/nospec-branch.h |  4 +++
 arch/x86/kernel/cpu/bugs.c           | 50 +++++++++++++++++++++++---
 arch/x86/net/bpf_jit_comp.c          |  5 +--
 include/linux/filter.h               | 15 ++++++--
 kernel/bpf/core.c                    | 68 ++++++++++++++++++++++++++++++++----
 kernel/bpf/dispatcher.c              |  2 +-
 11 files changed, 136 insertions(+), 23 deletions(-)
---
base-commit: e46dc0adfe39724bcf52cea47b8f9c9aed86a394
change-id: 20260713-cbpf-jit-spray-hardening-6-18-y-a028879c779c

Best regards,
--  
Pawan



