Return-Path: <linuxppc-dev+bounces-24351-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3755C4451B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 17:05:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1xBD1FLzz3c1w;
	Sat, 18 Jul 2026 03:05:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784307940;
	cv=none; b=WQbfSpadB+/GlvsoQfiPxwIHfiGqbtw8h0WevoddPTTvFf7zQdMIuAg3hiXEMHq1yBwiA817wQFjGlwnnAMvcfj4TdUO84VXQgrBgNkbh5qc1E18M4TIkKffRz64+5MSNLlaGnUsH9wYjKpi0CgIoeEteDXpeOa6iRJOh6JZ5SjqyJfB6FDyMWv4zZ+p8V1uCa1VbDO47+oVcYN9RhiL4J78IQ7at4ul0ADhfnzhSR9Z8Qi9JSDG8T3OTXtyAU5g8r4xV64PcPKSBCMVkRCqFFjvzUXyZuf3RdAseGWwo1Peoq48X8XPnoZ+gXUTCNTmcPQM2QYavyVzYRzbK/KEig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784307940; c=relaxed/relaxed;
	bh=43Rqns9o7zuxB8Q2tRjk8vnUv6HyspLxI1P0dak7QN8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J96dasuL6GV1LByf+QKbaK9hz+G5cUAh5CAW++YT/ZC9uG/7Z/9H8zUErzakIbAHWr3KxBbxOgQFUT95lkVK8z3MHO3OUn95Rahjpb+GdJVNIZ6Fe2IPyncpbinuu3jwFc19CseCIAPeROSXtwut93692KhUXLtePRYTmo0TYxOf2fhVDn4gMiErujGOvJh4Cr+jHIcEj0zQyrzazSMIjov1C36NjDXVp/6LA6+ZO76OHn/edHiJxfcBC7It7HgJEzB9WilodFTPrLQP5cKtShdffPkfcv/cR0GG7PDHbKSqLsU8GpmZCpkorVr4VyuLInNcYZ80ldecPTWIDLTNdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jY5iqSWN; dkim-atps=neutral; spf=pass (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jY5iqSWN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1xB84qRgz3c1S
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 03:05:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784307938; x=1815843938;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kO8aFzuGHwtDypuu15ShB7rQhwfq0S6rbdCVU3OLqX4=;
  b=jY5iqSWNKqV4gHHtLbhWsuvED8FUClu1SPuuiTzGFlC/yvW4jgD8xIDO
   Nwriq3FH44fARDhG5xafLUUxTZeXDgtu1TiyIjauUHOfayk7qnsW4E5Qy
   HBW3VIayK8RYdZ6t4r+Tnza184KG2gbEvdY1nhPwxFiQllY7U+hoqOyjG
   KjueoJa4Q8/5opl0fCWqlQJcvTR7KukF44ii8McJ3Ct0cDebIpqkAe2KT
   X85qC6rU+2vkRP5c+9yes2uJpErgK2qDyrCUWGtoqLfqJQ4Yk3Odf8O0w
   bsG0QJFIX3R+gvyA9mUF9oqE33aCP/pOUkw/a1XSXzef1g7DIU6BpUod3
   A==;
X-CSE-ConnectionGUID: 7lJRqeCRS62ZvNv4g4Lscg==
X-CSE-MsgGUID: TAuN8tIQQISs5ZWzdknKnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="88660701"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="88660701"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 10:05:31 -0700
X-CSE-ConnectionGUID: eUr5wEqQRASVPpk+SZIHHw==
X-CSE-MsgGUID: KJ60gS9dSwGhwnT/tiyPxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="295027652"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 10:05:31 -0700
Date: Fri, 17 Jul 2026 10:05:30 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 6.6.y 0/6] cBPF JIT spray hardening
Message-ID: <20260717-cbpf-jit-spray-hardening-6-6-y-v1-0-e04f1b2893de@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIANleWmoC/yWNMQvCMBCF/0q52SttlAu4iYujg5s4pMmlvQ4xJ
 FUspf/dVHnT9x68b4HMSTjDsVog8VuyPEOBdleBHUzoGcUVBtUoanRLaLvocZQJc0xmxsEkx0F
 Cj1Qyo7FErP1B7bWDchITe/n8BHe4nm7ny9ZSTfUMj/+eX93IdtossK5fuD+rQZIAAAA=
X-Change-ID: 20260716-cbpf-jit-spray-hardening-6-6-y-ac66e7f4237d
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

---
Pawan Gupta (6):
      bpf: Support for hardening against JIT spraying
      x86/bugs: Enable IBPB flush on BPF JIT allocation
      bpf: Restrict JIT predictor flush to cBPF
      bpf: Skip redundant IBPB in pack allocator
      bpf: Prefer packs that won't trigger an IBPB flush on allocation
      bpf: Prefer dirty packs for eBPF allocations

 arch/riscv/net/bpf_jit_core.c        |  3 +-
 arch/x86/include/asm/nospec-branch.h |  4 +++
 arch/x86/kernel/cpu/bugs.c           | 50 +++++++++++++++++++++++---
 arch/x86/net/bpf_jit_comp.c          |  3 +-
 include/linux/filter.h               | 15 ++++++--
 kernel/bpf/core.c                    | 68 ++++++++++++++++++++++++++++++++----
 kernel/bpf/dispatcher.c              |  2 +-
 7 files changed, 129 insertions(+), 16 deletions(-)
---
base-commit: da47cbc254661aa66d61ef061485a7080305c4be
change-id: 20260716-cbpf-jit-spray-hardening-6-6-y-ac66e7f4237d

Best regards,
--  
Pawan



