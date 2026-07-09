Return-Path: <linuxppc-dev+bounces-23971-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3729CC44501
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 22:23:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx8c93yz0z2xKh;
	Fri, 10 Jul 2026 08:23:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783635785;
	cv=none; b=VseucZpDjVAVBVGG3RzinK0KnE4dDnxpA9oT3spbFjlV+PZ5d/IbqKi1wm3tDqwvq4vz72O//JsDbRV5QYMdMS7/XajpPl0+ocJ08COyLfWKvpstHhNrh5CHiTrExW6cfgqGNgOCYfomrSjw+UTERA3FW3cXnO+2Q9c6E0PdEN+qApfusvfXucAGx39M9BpKYOlR12y6DpBzT8aIqtXM0wK+aTlWK1kLoi8BQeI2H3xQCCs12K3t2KeQnwZM3FKDsJ/bxTD52/icPanfrp3UqFpJ2U+lGkNpiK97T4QA9DGlK1UMZoKgk0SvcroM29O3dKQLmrLYjpHZ7TPNZRhF+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783635785; c=relaxed/relaxed;
	bh=pKPqh8rNQNGDPe0dJo7Bzjfau+DIOrukjSQBqeVYUF8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fM4nViBZfTGRbx9V3ugMrxA5vCf3YP31We6GVlJykv2o4JKc0LwmBR2e4yGfJbRyuBT3wdlO1RbIa9sPRuQXeb8u2Kc+pDAFtPjP50emiM2wlnf/AwY0QosurINKK48QKU+aYmA7aWvTPK87yNC2EtLUJVRRrc14Qel/tLLDNGyYDZiraIGi+HWE9HCXRRdHn1APydxNZfcY72/Qfj/LlMUXouTnsUN11Ttv/SxcyzzWq+lpzZ+s10fQbci5dBjiUT0mUH/jaZuQJcUwg1fuXBrYFu3B8lByDEukoJ/5Fw0k7DbAN4eoqGYDyf5H+FOi/WMOdcdXvViHpdEBLQmdeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RabGjHB7; dkim-atps=neutral; spf=pass (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RabGjHB7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx8c64xYZz2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 08:23:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783635783; x=1815171783;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=x97uFTIjXkGA6Az31J4eQq5SV3sdoZkgFYZLe5sZj3o=;
  b=RabGjHB7QTmBuwzzacC2v5Z22lqmMC3onUlPJd39kYhhIGqThskG5pou
   m7WoNWpy8XHIutKmv3KXHaQEH+BnLx7xODdNXTi/mIzEFThBgJMe/MwDk
   JLGc/7E+ATvJUL+K8a3Ti8/I/DwkAsvqZYG+a+qiBu0qwzd1zQxtjhxti
   nyezKiWyAWgkmb08wdsWbRnwfP8Dy0DBJ5XfdZRNu71HCc3KBp9abSwUz
   Ew4PKopyMTUqr1M3HAqdt1LSUjWyX5hxIho+xmzTYfrCRy2cNv4Hnemb9
   fAg/gSP2vHU3C28MP246d/542laPxT5cFCaAlfQu1215mc/PoQDlzH4a1
   Q==;
X-CSE-ConnectionGUID: pKIP8+IuQpq1E2yL/LG4Vg==
X-CSE-MsgGUID: HxkFpJFUTDO7qapEHdaaDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="109881429"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="109881429"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:22:55 -0700
X-CSE-ConnectionGUID: wvvVwSEEQaq78hYluA9Epg==
X-CSE-MsgGUID: iOtP4/thR++qD9bVJxDDWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="256638305"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:22:55 -0700
Date: Thu, 9 Jul 2026 15:22:54 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 7.1.y 0/6] cBPF JIT spray hardening
Message-ID: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-0-5ac5a2d6797f@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIADQeUGoC/yWNsQ6CMBRFf4W82Udaaqy4ERdHBzfj0JZXeAyVt
 GgkhH+36HjuTc5ZIFFkSnAqFoj05sTPkEHuCnC9CR0ht5mhEtVBaFGjs6PHgSdMYzQz9ia2FDh
 0qFHijFYpu1de1pqOkCVjJM+fX+AO1+Z2vmyrLmU5w+P/p5cdyE1bBdb1CwOyz3GSAAAA
X-Change-ID: 20260709-cbpf-jit-spray-hardening-7-1-y-b33b43f197e8
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

Note: Patches were only build tested on x86 (they applied smoothly without
any conflict).

Thanks,
Pawan

---
Pawan Gupta (6):
      bpf: Support for hardening against JIT spraying
      x86/bugs: Enable IBPB flush on BPF JIT allocation
      bpf: Restrict JIT predictor flush to cBPF
      bpf: Skip redundant IBPB in pack allocator
      bpf: Prefer packs that won't trigger an IBPB flush on allocation
      bpf: Prefer dirty packs for eBPF allocations

 arch/arm64/net/bpf_jit_comp.c        |  4 +--
 arch/loongarch/net/bpf_jit.c         |  5 +--
 arch/powerpc/net/bpf_jit_comp.c      |  4 +--
 arch/riscv/net/bpf_jit_comp64.c      |  2 +-
 arch/riscv/net/bpf_jit_core.c        |  3 +-
 arch/x86/include/asm/nospec-branch.h |  4 +++
 arch/x86/kernel/cpu/bugs.c           | 50 +++++++++++++++++++++++---
 arch/x86/net/bpf_jit_comp.c          |  5 +--
 include/linux/filter.h               | 15 ++++++--
 kernel/bpf/core.c                    | 68 ++++++++++++++++++++++++++++++++----
 kernel/bpf/dispatcher.c              |  2 +-
 11 files changed, 138 insertions(+), 24 deletions(-)
---
base-commit: 199c9959d3a9b53f346c221757fc7ac507fbac50
change-id: 20260709-cbpf-jit-spray-hardening-7-1-y-b33b43f197e8

Best regards,
--  
Thanks,
Pawan



