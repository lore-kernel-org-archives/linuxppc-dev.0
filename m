Return-Path: <linuxppc-dev+bounces-26051-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AFAC5B572
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Aug 2026 10:24:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRtZn3y8Pz2xWt;
	Sat, 22 Aug 2026 20:24:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787387029;
	cv=none; b=VJ+sSgunKfWaTjgYSd4nCcvz9PbuvRA5HqkAxL/W3JL3NiFpFv6DzOJobSDihWE5SSqR0OTaJzxBvskEkRfw0/GOgakOgI3H1a3aGElIfeWCXaibSfyqmTC5ruQYDk6GLHqBKaqiN0x/ONBUX1b8fIhvBMQEQyMvHBZKc05l1bIYgh4XT9jokVsw85s00kxFgj9vgcpVWgNXwiC9VHV+f7HHjUb0Xd3FPvsMDWEd1CdLfDPZAakyQYnjcX/hKEGxIrOOU2UkpPobKmAIk9F5ywouqfqgKUGHJdsnFOaWulVaaxdtym3GfIgKCHUpEYiHjjSrKU6QyF7tvPS50gwzBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787387029; c=relaxed/relaxed;
	bh=BArm4VqCUdb37sWWhhxjsesM22Q5CInmbs+jGh0W2pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B65TJ6pr3qx8fAbzUNPVwvvgAGf6yZSS9iFNPSvQNR/sBudCNSjNKePDhRSVjZJvPD5LAh77upO9W3Hvs1YYa0I2RPgx41EAN4KucWXaC45JFnEC+1lLQmck0K2Nfn1EeV3Vh56OCpBqnktj2EPV8X59FW9h8GHhwBZUEke1dSIxaYFucLs9xJnkjC8VXV5Tg8tKAzOGvwUScNvjJHWv/8Z0vQaU77SmuknxkHE4CRj4xqT3OzycWZBytHJCddmigcfDm5i14ULALKrWmBpHgNKKFnDAhkYU8xG1588TxoLuG/cIuU09mZrhWjisEOMsD3hEDX/RH3gCfSLbOPliwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QmyCmLoE; dkim-atps=neutral; spf=pass (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=junjie.cao@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QmyCmLoE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=junjie.cao@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRqvQ1KDVz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Aug 2026 18:23:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787387026; x=1818923026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mKX771uc3lutMQpZFJQnhdt7GyWKMRqSH02u/uA/bLk=;
  b=QmyCmLoELqq1nhrSidyhXHI7ZFCNF3HSv6M8BPpDqKTjlfocj1f44c7i
   9LRg3T4D7rKOjY/Lm90VBC/UnrzQZOB3qAIqCsW6COpxtThW9AcWLVS5S
   CwIcZv4rq6gE1drXUw0lbkTrNe+wIJGrv+Sdt/If/sdDScwMM2pcLJbAm
   fv/nh843a5S4VGCkvlyfxBAV5g1j1INeR8nZ4jmfNeAlpZcG5wrEG+cTj
   uO+7fqORayUb+g0EGrSFnBcwPTTplZz3YyhQoU4th1dYYxUYGTdKQYLTz
   QTuQy02EcotZ70hFDNh8uBXWmjLPJjmx6Yl7AilcWXyIdS/5LCnO0vLOp
   g==;
X-CSE-ConnectionGUID: EKhCff5BSRyWSWLW9qa1kw==
X-CSE-MsgGUID: ktpLQNK5Q0+lVEqx5T5Vzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91796507"
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="91796507"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2026 01:23:37 -0700
X-CSE-ConnectionGUID: /YgIAr4mQsGKCSsoRiV6zA==
X-CSE-MsgGUID: VVsAZtviQCa29IMg3EZXjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,236,1779174000"; 
   d="scan'208";a="265242919"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2026 01:23:30 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Terry Bowman <terry.bowman@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Richter <rrichter@amd.com>,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Alejandro Lucero <alucerop@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Breno Leitao <leitao@debian.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Gregory Price <gourry@gourry.net>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Kees Cook <kees@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Li Ming <ming.li@zohomail.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Richard Cheng <icheng@nvidia.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC] cxl: Device protocol AER injection
Date: Sat, 22 Aug 2026 16:23:25 +0800
Message-ID: <20260822082325.301100-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717225700.3543801-1-terry.bowman@amd.com>
References: <20260717225700.3543801-1-terry.bowman@amd.com>
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
Content-Transfer-Encoding: 8bit

Hi Terry,

On Fri, 17 Jul 2026 17:57:00 -0500, Terry Bowman wrote:
> This patch is intended to provide a method of testing the recently
> submitted cxl series "cxl: Enable CXL PCIe Port Protocol Error
> handling and logging"

Ran this on 7.2-rc3 with v18, under QEMU with a switch topology so all
four port classes are present.  v19 wasn't out yet when I ran it; the
findings below are in the RFC's own code and don't move with the delta.
It works -- one CE per class with a different RAS status bit each time,
attribution correct in all four:

  RP  ras=0x1  port=port1 dport=0000:0c:00.0  'Cache Data ECC Error'
  USP ras=0x2  port=port2 dport=              'Memory Data ECC Error'
  DSP ras=0x4  port=port2 dport=0000:0e:00.0  'CRC Threshold Hit'
  EP  ras=0x8  memdev=mem1 port=endpoint4     'Retry Threshold'

A UCE panics via cxl_pci_error_detected() as the series intends, and six
malformed inputs are rejected.  Only VH here, so I can't say anything
about whether the RCH branch is right.

Tested-by: Junjie Cao <junjie.cao@intel.com>

> +	depends on PCIEAER_INJECT

Beyond Jonathan's question about asking at all -- a bool depending on a
tristate means kconfig will give you PCIEAER_INJECT=m with CXL_BUS=y
and this =y.  olddefconfig produces that from a defconfig and it
doesn't link:

  ld: ras.c: undefined reference to `aer_inject'

Deriving it from the combination rather than asking would take the
broken config with the question.

> +	cxl_aer_einj.aer_registers[aer_offset] = aer_status;

Only reference to aer_registers[] in the tree.  aer_inject() builds
its own AER config space and the RCH path skips
cxl_rch_get_aer_info(), so nothing reads it.  Is it still needed, or
can it go with the core/ras_einj.c move?

> +	cxl_aer_einj.dev = NULL;

Clears the pointer but not the reference.  Every non-RCH arm takes a
pci_dev_get() below; to_einj_ras_base() on a match and
cxl_ras_exit() drop it.  Both need .dev to still point there.  So an
arm not consumed before the next write is orphaned.

Thirty back-to-back injections gave 26 trace events, with aer_inject
run 30 times and the kfifo-add-failed, port-not-found, port-unbound,
dport-not-found and RAS-not-mapped counts all zero (kfifo is 128 deep,
so no overflow).  Four arms were never disarmed.  I can't tell whether
the AER core folded them into one pass or the next write replaced .dev
first, and either way the reference goes.  I couldn't make it fire on
demand -- unbinding cxl_port fails the arm-time lookup instead -- so
it's a race, but it's the one a test loop hits.

Behind it the handshake has no single owner: the mutex is writer-only,
while to_einj_ras_base() mutates the same fields and drops a reference
without it.  Both consumers are live: the CE runs consume arms from
the kfifo work, and the UCE backtrace has cxl_pci_error_detected()
doing it from the AER IRQ thread.  A disarm helper
owning the reference would cover this and the asymmetry Jonathan
raised about putting a reference it didn't get.

> +	cxl_aer_einj.is_rch = (nargs == 5 && strcmp(topology, "RCH") == 0);

RCH on a VH device is accepted:

  # echo "0000:0c:00.0 CE 0 0x80 RCH" > .../aer_einj_inject   -> 0

aer_inject() fires and AER logs it, but no CXL trace event appears --
the RCH branch can't match a VH dport.  Reproduces every time.  So a
typo gets you a real AER error with the CXL path silently skipped,
which reads as "the handler didn't fire".  is_cxl_restricted(pdev),
already used further down the file, would make it -EINVAL.

> Also worth discussing is the commandline takes multiple parameters for
> a single sysfs file

One file also suits the state handling above better.  Several files
spread one request over several writes with no commit point.

> How do we incorporate this with the existing CXL EINJ functionality

core/ras_einj.c sounds right, and the Kconfig above is another reason
for both in one place.  Worth a line in the ABI doc that ACPI EINJ is
a real injection but Root Port only while this covers every class with
software registers -- that's what decides which one a test wants.

Last thing, off this patch: with the registers a kernel-side array this
can't exercise the MMIO readback, the offsets against a real capability
block, or the header log.  QEMU has RAS on root and switch ports but
injects only on endpoints, so it can't cover the classes today either.
I'm looking at adding port-level injection there as a second path
through the real reads.

Many thanks,
Junjie

