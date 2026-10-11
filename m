Return-Path: <linuxppc-dev+bounces-29195-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6A4CA9EBD
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Oct 2026 19:57:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j2rxC38pPz2y2T;
	Mon, 12 Oct 2026 06:57:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791748671;
	cv=none; b=HB+bWRzD9Q8dner1neG3ceDGiJ47uMEtJKJlbj+nf1ek3/sZPkabF9o8/QuJXuH0DEo0J+usM4/++nL3hF1rmzNbrE2hSrMo4iI9mCgNovoeLbTnrQpN9a7Mzflci1VmMjTlwAirwgPB9mxmMWTFgM5rheysw7mcOZ6KSEytzmsRE2mqaDxc7k1BglI1JMMxpnoUHOc64Q9nf9prRyPadBw1tOTd86IninhwLeW7qk2BASDcHkhQ2SuSsGZbBRxtJ4F5Dq5iUzmwq6f8E6U/rPIFx2d8nYYHosw/GkMafdivoPajNpzajTgNaMYvCWKW7BE23vm+meoZ1yWXwDuutw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791748671; c=relaxed/relaxed;
	bh=1nsk2mdhFsso8ym6DQn4vGnG7ZKpsogWBUPuZQB9l70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nBHJPXeq/6J3BM9kHgXupYoKsOqNAIjoW0FAgC3XBrjBSujiP4vR+bl5WfsI2zh7elTIrbjKO2RRdIYogkuGBsnAwgrJS/FL7giiLITKafe3ighKXsBaKw72hU1gU8tvTEzjwmNiPGPZ2YnOt8a3jrMGv5StAlRJiOrmDw2fQtNcyJbQDnMP/ZvwmhFVYmLwLBaBTWkvPZjjpxpVpr1Sb9Mfuuxj2aplrKSaUYH2d2A0jlXOI2T2LdO3jHCar8Dx7IhQW8B50kHpHdQXDHbHAQv/rQP8qBxQzbJhqjLpt0vtUFv3+40CooAJRvXGRGeUqFndQs8KJOinjjrtKDZL/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M3vfnywq; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M3vfnywq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j2rxB3dpwz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 06:57:50 +1100 (AEDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-6a374bea882so1900456a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2026 12:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791748666; x=1792353466; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1nsk2mdhFsso8ym6DQn4vGnG7ZKpsogWBUPuZQB9l70=;
        b=M3vfnywqqlIIzyJwW4Qy9mXwNmsz4VrMvpNwvF0tIOGhh3Tv+JYa39/41pDxLbPApM
         VfztqbgXWZr8VzzWLJpEHhGt/DAVp4qEA+gOj/NNi1MM+UXPoy6W0c0DcBisLy0fOikx
         sjkdp2rJIdGctd2jJRLYuJAPL7uJttvOqLAJoy75kgx233rDnihlJt/mHn5KV0rTrlIM
         Uy0Jv4V2U1p7JlX7fZqUUGNlrEysMsynJIsnKr9Hp91yNCyUDgYWaNb30qdHLFywvriw
         jY4uD1m48ptwuqIZLkLyHWBesGNvgnEEPDTs9Qi41P/OCaXqCjvRuUc8wIhyx7JxFdtS
         WBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791748666; x=1792353466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1nsk2mdhFsso8ym6DQn4vGnG7ZKpsogWBUPuZQB9l70=;
        b=mmc8MOy1deFR/jRgcyi/8fL1A9QVPYtPjDiDobqDxjLcbAd8vgrmaVLXl65oKQNzrM
         68o8YuO4FcGAPrIXFrxg8wOnVDW5mrJ5kBH1vUqb8jwz2n5glsH8mwLIkLAC8rPxEzWx
         BNc72Z1IEtYIOfQtyoLhtFkHG9lP11g9dVR2y9L5oDtmQxLmJcM9af5JvwPpX9xB7krY
         OHVIv8OIcOCaP8ufdJX+bNyv9kZYb6Tnq4hkBdD57wua989semUkVApoJgMTKuHylAGO
         6hjM8bciHBcZAdBNVfvhC2jybB2TIIHzYz6wDMXgrhIS9cfRFTjAUyYyoiTMrl9JaDos
         LjJw==
X-Forwarded-Encrypted: i=1; AKwUvByDw1zM2FrtqlotqvWKKFkxc2Z6COPVtbHRxT8TVabf4pvKxXs+oXFPXnNJL/sE7oeNCLZE5gAeEwQCzDA=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIRXnl2kcGEkO5unX0M1FyWDrKtghbiZLJDPe8YfZKAlXyIJQl1
	bajxqGkPJz5AV3eVC+6Np9yx0hZwEKu99v6YCBJvjEKi+1G1iitMqV3d
X-Gm-Gg: AYBFou2OmMi9Y3TaaX7JL6SS3w9XRAr+mkXQo/TJvYpwiUL45J/lBDDIOQ0v8hYksZ6
	SzMKvPXS2JotfOwc4aNEoPR2S6uYzJqXP0ZlZ8qHugLBXuYyH2xFTyYoGbOps52LNvwlVirmaBD
	H/LHQkPdDTRGffztV2NA+WrHTnUmeA6Y3X3E7bg5yGwgDHxUs6mcrg/di9z97/T+tOkfJRIPt0M
	ZUhvqvAKmMXQ+xw6VncYN3UqFHkJfd0JeuH5E2kjZTJAIpsRvMjwWUadPwxQVJaYL/owhA3h3E/
	c9rQFlz7jVwcvAYjnRWyfBshCJgC9T9I4vdipEXWx/P0KrK9HAcE0CiLDcahBdXKkjsQSPZI/6H
	rcWAie7aVj3pUU0XOyJS2/RJg9xhB8hQ5HDqB/LDRHLu4lIMll5fR3mRxdWrgp12SVvPxKjsmSM
	VL727vD5D+v7VuNgcQcZm9xpbctdsahfFWExxe+9GIa7Zqj+UVt5eg4XOelGvxidTnFdViHiL94
	Xa5R7te38sn3YDp7q/CmBLTifvHp/KZF3+J2mNa
X-Received: by 2002:a17:907:3d09:b0:c31:8cfe:9a25 with SMTP id a640c23a62f3a-c31a9fd33dcmr813951666b.9.1791748666339;
        Sun, 11 Oct 2026 12:57:46 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a3ae9fsm381315566b.26.2026.10.11.12.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 12:57:45 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com
Subject: [PATCH v2 0/6] sparc64: add Fujitsu M3000 support
Date: Sun, 11 Oct 2026 21:55:52 +0200
Message-ID: <20261011195729.981243-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Several years ago I salvaged an M3000 SPARC Enterprise box being
decommissioned at work. The box has been sitting ever since, as it did
not run Linux. It did not seem impossible to get Linux running, but
my earlier attempts failed. I recently found some documentation:
"SPARC JPS2: Common Specification" and the "Fujitsu SPARC64 VII
Extensions", which gave me some of the missing pieces.
Getting this up and running required extensive testing, some
kernel instrumentation, debug printouts and many reboot iterations.
For this, Codex proved very helpful. Along the way, I stumbled upon
some generic sparc and driver bugs that this series addresses as well.

This series adds support for the Fujitsu SPARC Enterprise M3000, with
SPARC64 VII+, Oberon PCIe and a firmware hvc console.
Based on Linux v7.3-rc1, commit cee9395acd8043be0644b25c34bfa86623f2b935.

Patches 1-3 fix existing sparc64 defects in generic clear_page, secondary
queued-spinlock acquisition and sun4u kernel huge-PUD mappings. Each has
a Fixes tag. Patches 4-6 add the CPU/MMU/SMP path, PCIe bridge and
firmware console.

Changes since v1:
- Split the tg3 firmware byte-order fix into a standalone netdev patch,
  as requested by Jakub. It has no code dependency on this series.
- Address Krzysztof's topology review: replace the root-model check and
  adjacent-CPU assumption with compatible core nodes and cpu/core/cmp
  ancestry. Unknown ancestry produces no inferred sibling groups;
  hardware CPU IDs are unchanged. This uses the observed firmware tree,
  without claiming that the root model is a documented binding.
- Address Greg's console-state review: group state by HVC term number.
  Retain static storage for early console use and firmware-visible locked
  mappings; the M3000 exposes one /chosen stdin/stdout pair.
- Replace READ_ONCE/WRITE_ONCE polling-state access with explicit locking.
  A spinlock protects active state and timer rearming; a mutex serializes
  open, last close and hangup while close waits for the timer callback.
- Remove the arbitrary eight-attempt write loop. No progress returns
  zero: HVC retries buffered TTY output but drops stalled console chunks.
  A firmware call that never returns remains unbounded.
- Retain the raw buffer lock because console writes can run in atomic
  contexts. The PROM lock protects firmware entry, not the buffer copies
  before and after it. Panic/NMI and recursive console safety remain
  unverified.
- Retain the service-name pointer cast: p1275_cmd_direct() takes unsigned
  long argument cells, as used by the existing prom_console_write_buf().
- Remove stale "experimental" wording and the console success message;
  add copyright, use min(), and fix the Makefile spacing and blank line.
- Retain CONFIG_SPARC64_VII and its HugeTLB/THP exclusions. Removing the
  option requires runtime feature gating and further MMU work. Retain
  separate VII demap routines: similar Cheetah assembly does not establish
  the same hardware synchronization requirement there.

Onboard BCM5718 networking also needs the standalone patch
"tg3: normalize inherited M3000 register byte order". Apply it alongside
this series for complete M3000 testing; it is not a build dependency.
The two submissions can be taken through their respective trees.

The six-patch SPARC series also applies and builds without the tg3 fix.
The tg3 patch applies and its driver builds independently on v7.3-rc1.
Applying both submissions in either order reproduces the tested tree.

The combined v2 tree, including the standalone tg3 fix, cross-built with
GCC 13.3 in SMP, true CONFIG_SMP=n and non-VII Ultra45 configurations.
Each prefix of that seven-patch tree applied and built. The combined,
uninstrumented SMP kernel booted from disk with eight threads; true UP
also booted from disk. Both reached Gentoo/OpenRC with hvc0. SMP topology
reports four cores, two threads per core and one package with reciprocal
sibling masks.

Bounded SMP fork/COW and remap/protection tests passed, as did UP COW.
Console testing covered login, 100 paired-open/last-close cycles,
hangup/reopen, paced input, idle input and concurrent output. Rapid
pasted input still loses characters. Mocked firmware tests exercised
partial writes, no progress, errors and invalid return counts; topology
fixtures covered sparse IDs, package separation and missing ancestry.
The Ultra45 configuration was compile-tested only for this revision;
topology fixtures do not establish multi-package hardware support.

Oberon MSI and native bridge error recovery, VII CPU offlining and
complete RAS recovery remain unimplemented. ECC recovery was not
fault-injected; urgent errors stop with a raw record. Raw-IPI page
lifetime and Oberon ordering remain audit topics.

Link to v1:
https://lore.kernel.org/sparclinux/20261002161515.932316-1-linmag7@gmail.com/
Link to tg3 patch (v3):
https://lore.kernel.org/sparclinux/20261011194228.981141-1-linmag7@gmail.com/

Magnus Lindholm (6):
  sparc64: return from the generic clear_page implementation
  sparc64: honor queued spinlock layout in secondary startup
  sparc64: avoid huge kernel PUD mappings on sun4u
  sparc64: add SPARC64 VII CPU, MMU and SMP support
  sparc64: add M3000 Oberon PCIe support
  hvc: add an M3000 firmware console backend

 MAINTAINERS                         |   6 +
 arch/sparc/Kconfig                  |  20 +++
 arch/sparc/include/asm/head_64.h    |  15 ++
 arch/sparc/include/asm/iommu_64.h   |   1 +
 arch/sparc/include/asm/irq_64.h     |   1 +
 arch/sparc/include/asm/setup.h      |   5 +
 arch/sparc/include/asm/smp_64.h     |   4 +
 arch/sparc/include/asm/spitfire.h   |   1 +
 arch/sparc/include/asm/trap_block.h |   6 +
 arch/sparc/kernel/cpu.c             |   3 +
 arch/sparc/kernel/entry.h           |   2 +
 arch/sparc/kernel/head_64.S         |  18 +++
 arch/sparc/kernel/helpers.S         |  41 +++++
 arch/sparc/kernel/iommu.c           |  44 ++++++
 arch/sparc/kernel/irq_64.c          |  50 ++++--
 arch/sparc/kernel/pci_fire.c        |  31 +++-
 arch/sparc/kernel/pci_impl.h        |   1 +
 arch/sparc/kernel/prom_64.c         |  27 ++++
 arch/sparc/kernel/prom_irqtrans.c   |   7 +
 arch/sparc/kernel/ptrace_64.c       |   7 +
 arch/sparc/kernel/setup_64.c        |  55 +++++++
 arch/sparc/kernel/smp_64.c          |  89 ++++++++++-
 arch/sparc/kernel/trampoline_64.S   |  53 ++++++-
 arch/sparc/kernel/traps_64.c        |  27 ++++
 arch/sparc/lib/GENpage.S            |   3 +
 arch/sparc/mm/init_64.c             | 110 ++++++++++++-
 arch/sparc/mm/tsb.c                 |  19 ++-
 arch/sparc/mm/ultra.S               | 236 ++++++++++++++++++++++++++++
 drivers/tty/hvc/Kconfig             |  10 ++
 drivers/tty/hvc/Makefile            |   1 +
 drivers/tty/hvc/hvc_m3000.c         | 205 ++++++++++++++++++++++++
 31 files changed, 1064 insertions(+), 34 deletions(-)
 create mode 100644 drivers/tty/hvc/hvc_m3000.c


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.43.0


