Return-Path: <linuxppc-dev+bounces-29647-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC8FCCF2C4
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2026 13:49:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j70R50WSfz2ygg;
	Mon, 19 Oct 2026 00:49:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792331377;
	cv=none; b=DybyA7AJidOTul/CSDIqXl2C0QXhlFwXRiNYxygpEXbQkhjUg0CiQbBz3eTlNGhymgnhdPqTa1ZtENM1u1KAv5gC+dEyIch7S+a7BJaGCZmWAL9yNgglc2Qpn0Sj1dzjKDEf8IOBe7QZmgnbTBaOgw8wJCjZdrTbLC80tsMQlu7s5ojxmcS9cTsKMB5gVFx0HZKEBObrQXT3A+B/URWeei1PzMJMxAxk4uzG4yz73FpJ2FnorUaRCB01adxMc9zftuQq3E4k5bVXJu1bYXFhyMDC25U6l1NfYf9r8IM2X7ExCGklvYFEX00TufzZJhH6nPbnhIYDDijWR12+wfhVng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792331377; c=relaxed/relaxed;
	bh=BZTGhLaI3EXputloxAEypMkmx+sontqDJHpA+jMjNlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EELdBs4VzLScnA5tpikHQpJFl4K7Xv3HUUOqfmHBouw2zAmK4TWqGlIdkYKNq7FRl0a1f4QxtoqZCV2meSImRWPHzTylgZfNE6WbnTesZ9cS6DXbnc4nWSPfE+DafI1X5PJHA7xFPjHQjkmCS4VgaC/jnvAnDSCNbb287fzjI2+pFo5adeH+oQ+dyaH6NNd+TNWaNw5d/8TPC6QM8X5j8mlx5Zlaepd1VRzsq+kycMWLOtYdPcdyGXEh4vbp6diLCQavYwUEiNn3oV2+MfTSMXWccYKwffYIW8DPIk/itSGqDwH3PHXVU7wjYNiD3FwFC/6+09ooDjwtudggvKjxOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cGtvnwyP; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cGtvnwyP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j70R32dGbz2yHD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 00:49:35 +1100 (AEDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-c3fd91337baso169313566b.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 06:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331367; x=1792936167; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BZTGhLaI3EXputloxAEypMkmx+sontqDJHpA+jMjNlM=;
        b=cGtvnwyPLvSiahD2H54mRXawGH5KsUigClWY77AT1oleJqJugB8EkpxfMmpLDWQqdK
         sHaNVLrOkwu29BBPFxSjFwnRrCyJVZeh/cREx5496nuLWgCxUgo5V6Gh3JtVBfg3i6cX
         B9rBs3DsuNSNRwZdICq62q1CX+z23GamkZvMHH0Nvg03cs1itD/bPVzGa7sQJ3dcYrh2
         IB0xuNIDS/KCgXDlk9di0mdCan1/tMOWQxY9OWDS896EJQiSrjKLmrc5NjRmcpXH7n58
         H0DtFvpp9MZkLWhJuwVTe/gWkuGaUsFN5BPbhzMSCdEulFAx3EphSBw8PnJZ0NePdlh6
         ezuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331367; x=1792936167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BZTGhLaI3EXputloxAEypMkmx+sontqDJHpA+jMjNlM=;
        b=lGScdmrDzpEzhEX7fUp55c18H4dQOP6fF9JKNvS9RveSJxHiXZPPITQZP8wtZTsTCP
         /p5apsyVIFJBw+LOuH3s7mL+NcgbFFilWkGsnSFr45iazLXXGxwxp+bgJxDqR4ZLcdcN
         b9//smeNW7uGgstH61c7i/f1WkeHQdFd5rxnhLvGJ1tI46bLSY8xDyeI02oQnUX4YoO7
         S7JnpYNTuNuFuqdG/zmDsAcqVtiIYRaBYP6KzCVB6tu15gtmlIG35MwcQoyDxnY2/4Ge
         67Vnv2dLJXPsflRzmk7FRjhM5FSsuh0cEsG3Y3+glfIaCsLCsklQ2m4eIDdVB+ULvqC2
         Q0uw==
X-Forwarded-Encrypted: i=1; AKwUvBwS2mFTqocoE0rDN0QIMl70ByDjMFthyfnI5Ar4pRFfyVxoI9xxgt0rs3/M+/9BOHaCjr38FtwLuYhSyw4=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJO7hi+YmzBjF0cMWWcwycOwQLYz/UhP1/52zZIYOxJj9Y3L6ti
	No12oczobNaQMfCW66+ChPHZFZabhqhYiDLpYTsyjNRlTu9qhVV8wwnr
X-Gm-Gg: AYBFou1ATWDPpJfk50jwX5j3Auyqy4GYuIkbnUtkepWNBKVLtUe4TkErepysF+ZcHG7
	sxZxoiZ1buzcC1PCjHqyp+UqYAM6Ets7Npw0Vr4G16VbAznWFBmLvKWVvz66Vtr+TogDaYkq1yf
	s4juVRgqeQUgGQr4QSspvAPzwwcqQSJGY2Oe0uFmcf9+Y946WSiVFzSR62Wied2fa8wrzE4w48k
	tMXgRqYgDTD5uyAkWK1XeAdFkT/pC9ZFC3JGEurkjp3oWRRFAF68AjLkIiiuvYxsl2aDdlZQnlN
	lSQKWjqM2sia74RJUcyTbdNZRCM7DJYFBVUgirviDnWvQVhHx45nWQwFrbF65VGzmVtYOiPhtfU
	NLlHZGW0xiDhF0E9cd3LVtxi4Z+5RRRT3fmefwbmf0CVijx5+T0HTbplBSnISYMcXlljejUd1Ea
	dWVlSsb9CAmqjQ/VWzKJsjM2BxQh3XCLTABtQnIJ1eLzAT6BfjBGOkVIvrsAr/9HiUsIfviXPpX
	cTC5KG4sCLCI7JZskjNUE87T9xG2tEMGYTwg/xI
X-Received: by 2002:a17:906:630b:b0:c3e:e677:563a with SMTP id a640c23a62f3a-c41a02fb699mr350769366b.47.1792331366361;
        Sun, 18 Oct 2026 06:49:26 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm267678266b.61.2026.10.18.06.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:49:24 -0700 (PDT)
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
Subject: [PATCH v4 00/10] sparc64: add Fujitsu M3000 support
Date: Sun, 18 Oct 2026 15:45:02 +0200
Message-ID: <20261018134738.1016106-1-linmag7@gmail.com>
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
Codex assisted with debugging, instrumentation, code drafting, review
and commit-message preparation. Along the way, I stumbled upon some
generic sparc and driver bugs that this series addresses as well.

This series adds CPU, MMU, SMP, Oberon PCIe and firmware console support
for the Fujitsu SPARC Enterprise M3000, based on v7.3-rc1. It also applies
cleanly to the SPARC for-next snapshot a9e88d617a25.

Patches 1-7 fix generic sparc64 code used by the port: page clearing,
secondary startup locking, kernel PUD mappings, IRQ allocation,
firmware-property validation, DMA segment boundaries and IOMMU table
initialization. Patches 8-10 add VII, Oberon and HVC support.
VII CPUs and Oberon bridges are detected at runtime; no platform-specific
CPU or bridge Kconfig selection is required. HVC remains selectable.

Four independent fixes are in a separate follow-up series: IOMMU context
cleanup, PROM short writes, cookie IRQ allocation and interrupt-vector
bounds. They are useful independently and are not prerequisites for
applying or building this series. The PROM short-write fix also affects
the M3000 early console if firmware returns short writes.

The on-board BCM5718 also needs the separately submitted netdev patch:
  [PATCH net-next v3] tg3: normalize inherited BCM5718 register byte order
It is independent of this SPARC series and was included in hardware
validation kernels.

Changes since v3
----------------
- Add generic fixes for DMA segment-boundary checks on sun4u/sun4v and
  initialization of IOMMU page-table entries. Keep the four unrelated
  fixes listed above in their own series.
- Base the huge-PUD guard on the selected hardware page encoding,
  including the sun4v small-page fallback.
- Check for sun4v before reading %ver during secondary startup; restrict
  VII CPU/FPU names to sparc64 builds.
- Reserve only required locked TLB slots. Accept arbitrary 4MB offset
  bits on VII readback while checking all size and address bits.
- Preserve VII PA[46:43] in pte_pfn() and pte_modify(), leaving other
  processors' masks unchanged.
- Require disabled shared-context and TSB-prefetch valid bits at CPU
  entry and firmware handoffs. Record unsupported state and halt.
- Capture secondary MCNTL before the MMU-state check and identify an
  uncaptured value accurately. Explain the silent-halt limitation and
  print an error before halting on an out-of-range trap branch.
- Correct the fatal-trap marker, clarify manual references, queued-lock
  ordering and IPI wording, and complete the generic fixes' Fixes tags.
- Carry Greg Kroah-Hartman's Reviewed-by on the unchanged HVC C code,
  clarify its Kconfig help and add sparclinux maintainer routing.
- Remove the VII and Oberon Kconfig options, retaining runtime CPU and
  firmware-compatible checks and sun4v startup bypasses. Reject unsupported
  VII HugeTLB/THP mappings at runtime before page-size setup side effects;
  preserve huge-page support on other processors.
- Fold VII corrections into CPU enablement. This is ten patches versus
  eight in v3; tg3 remains separate.

Testing
-------
The final code plus the separately submitted tg3 fix booted on
M3000 with eight CPUs and 16 GiB. The four generic follow-up fixes and
the experimental Oberon error/MSI series were absent. It passed 32
fork/COW rounds over 64 pages, migration across all CPUs, 1,000 concurrent
remap/protection rounds, 32 MiB direct-disk verification, network image
checksum verification and per-CPU HVC open/write/close checks. Taint stayed
zero, with no kernel warning, Oops or panic in the collected log.

With HugeTLB and THP compiled in, VII rejected huge-page boot reservations,
MAP_HUGETLB, hugetlbfs and forced huge tmpfs mounts, and MADV_COLLAPSE.
Huge-page pool controls were absent; base-page data and protection checks
passed. Since that boot, only commit text and a stray Kconfig blank line
were changed; executable source is unchanged. The tg3 fix is accounted
for separately.

The same runtime-detection changes were also tested in the preceding
hardware follow-up tree: M3000 SMP and true UP; Ultra45 / UltraSPARC IIIi
UP; and a T5120 sun4v LDOM with eight threads on one physical T2 core.
The identical SMP image booted on M3000 and the T5120 guest. Ultra45 used
its own UP configuration. COW and disk checks passed on each. Ultra45 and
T5120 faulted and verified real HugeTLB mappings; THP collapse produced
16 MiB of anonymous huge pages. These other-platform boots include the
experimental follow-up code and are not exact final-v4 runtime tests.
Ultra45 retains its existing ATAPI DMA advisory messages.

GCC 13.3/binutils 2.42 W=1 vmlinux builds passed in UP and SMP at each of
the revised commits 8-10. Unchanged commits 1-7 retain their earlier
per-commit build results. Existing FusionMPT warnings remain. The runtime
detection tree also passed builds with PCI disabled, HVC disabled, huge
pages disabled, and sparc64 defconfig.

Earlier targeted harnesses reproduce the generic bugs and VII PTE/readback
issues. A read-only M3000 diagnostic found shared-context and prefetch
state disabled on all CPUs at startup and across thousands of PROM calls;
it is absent from this series. No unsupported MMU state was injected on
hardware. These are bounded regression tests, not a long-term stability
or performance claim.

Current limitations
-------------------
VII HugeTLB and THP need further MMU work and testing and are refused at
runtime. Compiling them in remains supported for other processors in the
same kernel. VII CPU offlining is not supported.

Runtime CPU/bridge matching can also select these paths on other VII/VII+
systems, including M4000-M9000. Only the M3000 has been tested; mixed
VI/VII domains are unsupported, and hvc0 binds only on the M3000.

Shared contexts and hardware TSB prefetch must remain disabled. If the
state check fails while PROM is locked, the firmware console cannot
report it and other CPUs can stall behind that lock. The four-word
sparc64_vii_mmu_fault record is identified in System.map; recovering it
after a reset has not been validated. Supporting enabled firmware modes
requires a preservation/restoration protocol.

Oberon uses legacy interrupts; MSI and native bridge error recovery are
not implemented. A boot with PCI_MSI=y and a larger NR_CPUS remains useful
validation. CPU error handling supports restrainable ECC; other patched
error traps remain fatal, including PCI config-access errors. IPI retry
policy and broader error recovery remain separate work.

HVC calls firmware; a call that never returns remains unbounded. Fast
pasted input can exceed the firmware FIFO, and console testing does not
establish panic-path reliability.

Magnus Lindholm (10):
  sparc64: return from the generic clear_page implementation
  sparc64: honor queued spinlock layout in secondary startup
  sparc64: avoid huge kernel PUD mappings with small hardware pages
  sparc64: stop IRQ setup when descriptor allocation fails
  sparc64: validate Fire register properties before initialization
  sparc64: retain the DMA segment start across SG entries
  sparc64: zero newly allocated IOMMU page tables
  sparc64: add SPARC64 VII CPU, MMU and SMP support
  sparc64: add M3000 Oberon PCIe support
  hvc: add an M3000 firmware console backend

 MAINTAINERS                         |   7 +
 arch/sparc/include/asm/head_64.h    |  11 ++
 arch/sparc/include/asm/hugetlb.h    |   3 +
 arch/sparc/include/asm/iommu_64.h   |   1 +
 arch/sparc/include/asm/irq_64.h     |   1 +
 arch/sparc/include/asm/pgtable_64.h |  13 +-
 arch/sparc/include/asm/setup.h      |   7 +
 arch/sparc/include/asm/smp_64.h     |   2 +
 arch/sparc/include/asm/spitfire.h   |   1 +
 arch/sparc/include/asm/trap_block.h |   6 +
 arch/sparc/kernel/cpu.c             |   7 +
 arch/sparc/kernel/entry.h           |   2 +
 arch/sparc/kernel/head_64.S         |  20 +++
 arch/sparc/kernel/helpers.S         | 126 +++++++++++++++
 arch/sparc/kernel/iommu.c           |  50 +++++-
 arch/sparc/kernel/irq_64.c          |  54 +++++--
 arch/sparc/kernel/pci_fire.c        |  35 ++++-
 arch/sparc/kernel/pci_impl.h        |   1 +
 arch/sparc/kernel/pci_sun4v.c       |   4 +-
 arch/sparc/kernel/prom_64.c         |  28 +++-
 arch/sparc/kernel/prom_irqtrans.c   |  13 +-
 arch/sparc/kernel/ptrace_64.c       |   7 +
 arch/sparc/kernel/setup_64.c        |  57 +++++++
 arch/sparc/kernel/smp_64.c          |  83 +++++++++-
 arch/sparc/kernel/trampoline_64.S   |  74 ++++++++-
 arch/sparc/kernel/traps_64.c        |  27 ++++
 arch/sparc/lib/GENpage.S            |   3 +
 arch/sparc/mm/init_64.c             | 121 +++++++++++++-
 arch/sparc/mm/tsb.c                 |  19 ++-
 arch/sparc/mm/ultra.S               | 236 ++++++++++++++++++++++++++++
 drivers/tty/hvc/Kconfig             |  11 ++
 drivers/tty/hvc/Makefile            |   1 +
 drivers/tty/hvc/hvc_m3000.c         | 202 ++++++++++++++++++++++++
 33 files changed, 1189 insertions(+), 44 deletions(-)
 create mode 100644 drivers/tty/hvc/hvc_m3000.c

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935

-- 
2.43.0


