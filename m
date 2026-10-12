Return-Path: <linuxppc-dev+bounces-29303-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9C9CA9EDE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 18:48:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3RM41skGz3bs2;
	Tue, 13 Oct 2026 05:48:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791830928;
	cv=none; b=HZfTHnrMqlIEb4NSyM9+GQONCYxdJxkMVvaR1FG5t/BrCPkbfpT+PvqkFA60PzpwkaTocO5UdEtRCE4ANsYVibNsb5ovAoF7z3a9ABM9+6pwluz4etwrsPj6zGEegeCYDD4GmB3+hc+3OzOlMiSxaP15l7fDwPFymi65S0xfhFNpSEMKD+5G8fdi4NjTH63M9CRrk8XUx5o9uYbXfH2rF24YmpDYoIraNCpLHD6IDeOu/56WJ0t2nf3Q9040xIMO7uTT8mtASiFa3uV/WyoKZ7J+2HQ0EVbp1ONfak93TBiv8zvuow9DwAbkHYscvsZ8Tp03rptG9+sZ0I1r6QSY7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791830928; c=relaxed/relaxed;
	bh=SuQqbuz4y3M9yuu6TKfF/F/BBLi6OQx/9CpoEI3dfHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VW/wWwmiVWVXhb/GhyZgixZREmKmnvWwvf1C515TGBQLF2F2YgswZHJ4UobwbkkEfejsjLV4D8WOO9q3DoOGeQ10VILgAonIhdrAm7pU+61xQvWvp0bJFzIJr2dsAcXi3At9JpVShdq7BkzmupCVUQHBLybI3WMpd+RU0AaMTadtlcqL18+fHdJeU2rTaELjrmFACUvZROANVrDK+K60NMQ+bSsiUU73tErafRYidcftVoNoJzhGkgU+1TTA9SkPZXYrWQcArbi4KtJ6ErYWhFK0JRwoLiqvxdlueF+DNwGtMjHge5a56LC+m3AduFHCLhciwy14SopfB5d3N7sfkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D+DsfO7v; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D+DsfO7v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3RM31GWrz30Vs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 05:48:47 +1100 (AEDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-c2e5e090746so195307066b.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 11:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791830923; x=1792435723; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SuQqbuz4y3M9yuu6TKfF/F/BBLi6OQx/9CpoEI3dfHI=;
        b=D+DsfO7vFI9+APiF8X+leiromQgV/UwvXYxx4RIt95Oh4sxOTEiWwtzmdB7VT/2bKy
         CRT4hN91Pv8sPi5kyOabogTJqbEg+DiYIxGsCBv2ygD2U1wpjGl6uVHE26diGF3IAIw4
         lbWW+ELDsxP5Z3mHK48C1dTpVPs/L9UxAbZFKpcnvgv6Gjuq7DiOu3IUqIzOn4U7/SCt
         hIX+wt6IQ6RdHxlUlo7DarL1yjds/bzvlqllmyxFevtFZ/xmABqJ8lCjU0nuSlgyXxJF
         yI5796L8L8db3SKoSICsGt0E2OFsl5HMefuSs8uGyUsavwjfT7PqEovMMFt9ki/2r96E
         V7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791830923; x=1792435723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SuQqbuz4y3M9yuu6TKfF/F/BBLi6OQx/9CpoEI3dfHI=;
        b=EEM5xiz4gzhCv5tCXMY+2MRk/XmfJ8udl70Bvq/Rt1cQjLqqqBhQC4FcPgw3WUecCF
         UHgVJigd/ySEAfXfSFifCWLoBKDwq8snBS31rLplbde4QfQ7CH70Kqoc4du9ChDZsa3Q
         YsKvY4VLLjhBq7UlWvVQzU2u4SLiSjdymp9Q+njiFmRV30uwiF49Sun96JdWfwv69n1c
         o+XmaU9vpMd5yTgVxA8lERmr7DxL/28bcOcnmuAgjvfmopuHnUlcSWJNkQt7JZOjkwW4
         VxKMDVbcIlbJsKsgdRE8aTSAT3ECB5Q3pyBFIY4oG5AfVBwoYLhm3ThwD0PEmYso6pjx
         NsXQ==
X-Forwarded-Encrypted: i=1; AKwUvBwOh0Ly1M1hjWw33HlYKe+WRW+yejnwR5fFuHk0DPb3egY7aS76RB//bFTq7ZgS/znuVJYdmlDJ7UCN6i0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLRyO/qVNM3ElWQN4ED20+c/XgNQ0qzRSRdDK2FqytNK2E5x3ej
	WKrWPrTOkSNEifKFOLV5bPxNvE8x4Tz+GaY7DPtdpcI5mzYvDVZqo4BK
X-Gm-Gg: AYBFou2ZTpLpFAtJx86hs0E8mVbydpIdOCQykw0gilBV1+qHjnmXyiMw0xhmVptdo5L
	E0OuY9Z8GSYGyOxn9yHGQjowsUpuEhcEsPU4/QCzAdfGF44zt8tpCV68o9iAbGNcwBfoEFowM3r
	exMkANGQsFTIJXpEjPy7M63XynwoPnG0U2cg0hx3hLZVBsupQkmM/XzwwhSy+iY872/I2eTkZWd
	Gd78HEDJ09PjEMZDKe+FbZY8OqP7tSQoXlnr2eMihFTlYxlb3j20Tk1i4lT4JPJZ2gcV1mSU6xP
	LCQ1DCEZ2URHeAggad0wNfhmjvLiBWpZvBLcQpLksrRnxUaUHkML6srX1QZ0w0O7MU54dJjcUMV
	XrBYYjpanFAdn8FKwlU0Pb4TaAl9fvIV4DCj0FUaV2aU3MCdPo/OsmUY3hpTEPzqBiMXuAY5hYD
	i4MHNMCHGqzthOq5ICviobW4+yqtKdbd146zOTaTQNIHIUZyHkswBqvKtAc1sMv9Bun8dAsrj9N
	W9Y03hg7TnTvUI4TIxNMaLjjCkR918bCGmB8zm0
X-Received: by 2002:a17:907:c003:b0:c34:cf13:a92b with SMTP id a640c23a62f3a-c34cf13b42bmr339345466b.3.1791830923181;
        Mon, 12 Oct 2026 11:48:43 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9aa5aa7sm488517666b.55.2026.10.12.11.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:48:42 -0700 (PDT)
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
Subject: [PATCH v3 0/8] sparc64: add Fujitsu M3000 support
Date: Mon, 12 Oct 2026 20:48:01 +0200
Message-ID: <20261012184826.986050-1-linmag7@gmail.com>
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

This series adds CPU, MMU, SMP, Oberon PCIe and firmware console support
for the Fujitsu SPARC Enterprise M3000. It is based on v7.3-rc1.

Patches 1-5 are generic sparc64 fixes: the clear_page return, secondary
startup spinlock layout, sun4u kernel PUD mappings, IRQ allocation
failure handling and Fire firmware register-property validation.
Patches 6-8 add the M3000 support. The generic fixes are kept in this
series so that the architecture changes can be applied and tested
together.

The on-board BCM5718 also needs the separate netdev patch:

[PATCH net-next v3] tg3: normalize inherited BCM5718 register byte order
Link: https://lore.kernel.org/sparclinux/20261011194228.981141-1-linmag7@gmail.com/

That patch applies independently and is not included in this series.
It was included in the M3000 test kernel described below.

Changes since v2
---------------
- Add separate generic fixes for unchecked IRQ allocation failure and
  missing or short Fire reg properties, following the Sashiko review.
  IRQ setup now stops before publishing an invalid descriptor; register
  properties are validated before their entries are accessed.
- Mark fill_in_one_cpu() as __init to match its initialization-only
  caller and vii_cpu_topology(), fixing the section mismatch reported
  by the kernel test robot.
- Address Jiri Slaby's HVC review: reorder the console state to reduce
  padding, use guard()/scoped_guard() for locking, test the input
  pointer directly, and name the firmware argument counts and error
  return values. Keep the polling spinlock released during synchronous
  timer deletion, with the mutex held to serialize close and reopen.
- Retain the raw buffer lock for atomic console calls and the existing
  firmware polling policy. Zero still means zero bytes transferred;
  firmware argument-array positions remain the fixed interface layout.
- Remove the leftover experimental Oberon boot message.
- Fold the CPU and HVC corrections into their respective support
  patches. The two new generic fixes bring the SPARC series to eight
  patches; the tg3 fix remains separate.

Testing
-------
The candidate source tree, including the separate tg3 patch, was built
with W=1 using GCC 13.3 and Clang 23.1.3. Neither build reports the
CPU topology section mismatch or warnings in the changed HVC code.
Other warnings remain in existing code. This does not reproduce the
robot's exact Clang 24 development compiler and defconfig combination.

The GCC kernel booted from disk into OpenRC and SSH on an M3000 with
all eight CPUs and 16 GiB of RAM. Bounded fork/COW, CPU migration,
file write/read verification and network transfer checks passed.
HVC checks covered output, paced input after idle, concurrent open and
close, and hangup/reopen. The kernel remained untainted, with no new
WARNING, BUG or Oops reports during these checks.

The final export plus tg3 differs from that boot-tested source tree only
by removal of the experimental Oberon boot message. It applies cleanly
to v7.3-rc1 and has been rebuilt with GCC and W=1; the final export has
not been rebooted. The Clang image was not booted. This revision has not
been retested on the Ultra45 or in UP mode, and these bounded tests do
not establish long-term stability or exercise hardware failure paths.

Current limitations
-------------------
SPARC64 VII support remains a Kconfig option because this path currently
excludes HugeTLB and THP. Removing that restriction requires further
large-page MMU work and testing. CPU offlining is not supported.

Oberon uses legacy interrupts; MSI and native bridge error recovery are
not implemented. CPU error handling is limited to the supported
restrainable ECC path; other unhandled error traps remain fatal.

The HVC backend relies on firmware calls. A firmware call that does not
return remains unbounded, and fast pasted input can exceed the firmware
FIFO. The console tests above do not establish panic-path reliability.

Magnus Lindholm (8):
  sparc64: return from the generic clear_page implementation
  sparc64: honor queued spinlock layout in secondary startup
  sparc64: avoid huge kernel PUD mappings on sun4u
  sparc64: stop IRQ setup when descriptor allocation fails
  sparc64: validate Fire register properties before initialization
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
 arch/sparc/kernel/irq_64.c          |  54 +++++--
 arch/sparc/kernel/pci_fire.c        |  37 ++++-
 arch/sparc/kernel/pci_impl.h        |   1 +
 arch/sparc/kernel/prom_64.c         |  29 +++-
 arch/sparc/kernel/prom_irqtrans.c   |  15 +-
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
 drivers/tty/hvc/hvc_m3000.c         | 202 ++++++++++++++++++++++++
 31 files changed, 1077 insertions(+), 38 deletions(-)
 create mode 100644 drivers/tty/hvc/hvc_m3000.c


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935

