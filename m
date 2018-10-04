Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B44C64EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 12:10:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61C4120684
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 12:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="PnRrLvo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C4120684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QsCC4fF0zDqC3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 22:09:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="PnRrLvo4";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QrvS3SD9zDrDy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 21:56:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="PnRrLvo4"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42QrvS2RKfz9s8T; Thu,  4 Oct 2018 21:56:20 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42QrvS0KG8z9s55;
 Thu,  4 Oct 2018 21:56:20 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538654180; bh=gLDftZNWzHt9oOTtLfe0z3FFmXvBb/p3uUvr/iNUeos=;
 h=From:To:Cc:Subject:Date:From;
 b=PnRrLvo49py/tkeu4+dYESoW5MUfFY99jk1EvwWfPdnA5Sn/7Kd29tiPM9OhJUNt+
 mOeYPDHXThHwMEBOL+Xr+eDmfOy7SJIxG6Bwujfsy+cyQKUvVsrkKNvg4Oe3aHJkdh
 6dU0AP7iNjYWWgw2/hZCpIv1l/PMjnvOtLOt5DN43w2fEhLQVTapl7/+LrNckYuAvR
 bOOgwdQe/dfU4qdk+erYCCMFouT6Za/y7xhOnafITRSSBkyalPgNeXleHqduJA9N5W
 8Fj5mZSNrDZqUs50XE4aXrHjhMOW6gQbJPpmed0QXPb5XFFvZ2uhJtx3Th6MKlAuk3
 F68SBPwTF0ihw==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v4 00/32] KVM: PPC: Book3S HV: Nested HV virtualization
Date: Thu,  4 Oct 2018 21:55:37 +1000
Message-Id: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch series implements nested virtualization in the KVM-HV
module for radix guests on POWER9 systems.  Unlike PR KVM, nested
guests are able to run in supervisor mode, meaning that performance is
much better than with PR KVM, and is very close to the performance of
a non-nested guests for most things.

The way this works is that each nested guest is also a guest of the
real hypervisor, also known as the level 0 or L0 hypervisor, which
runs in the CPU's hypervisor mode.  Its guests are at level 1, and
when a L1 system wants to run a nested guest, it performs hypercalls
to L0 to set up a virtual partition table in its (L1's) memory and to
enter the L2 guest.  The L0 hypervisor maintains a shadow
partition-scoped page table for the L2 guest and demand-faults entries
into it by translating the L1 real addresses in the partition-scoped
page table in L1 memory into L0 real addresses and puts them in the
shadow partition-scoped page table for L2.

Essentially what this is doing is providing L1 with the ability to do
(some) hypervisor functions using paravirtualization; optionally,
TLB invalidations can be done through emulation of the tlbie
instruction rather than a hypercall.

Along the way, this implements a new guest entry/exit path for radix
guests on POWER9 systems which is written almost entirely in C and
does not do any of the inter-thread coordination that the existing
entry/exit path does.  It is only used for radix guests and when
indep_threads_mode=Y (the default).

The limitations of this scheme are:

- Host and all nested hypervisors and their guests must be in radix
  mode.

- Nested hypervisors cannot use indep_threads_mode=N.

- If the host (i.e. the L0 hypervisor) has indep_threads_mode=N then
  only one nested vcpu can be run on any core at any given time; the
  secondary threads will do nothing.

- A nested hypervisor can't use a smaller page size than the base page
  size of the hypervisor(s) above it.

- A nested hypervisor is limited to having at most 1023 guests below
  it, each of which can have at most NR_CPUS virtual CPUs (and the
  virtual CPU ids have to be < NR_CPUS as well).

This patch series is against my kvm-ppc-fixes branch.

Changes in this version since version 3:

- Removed instruction emulation code.

- Validate parameter to H_SET_PARTITION_TABLE hcall.

- Minor changes in response to review comments.

Paul.

 Documentation/virtual/kvm/api.txt                  |   15 +
 arch/powerpc/include/asm/asm-prototypes.h          |   21 +
 arch/powerpc/include/asm/book3s/64/mmu-hash.h      |   12 +
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |    1 +
 arch/powerpc/include/asm/hvcall.h                  |   41 +
 arch/powerpc/include/asm/kvm_asm.h                 |    4 +-
 arch/powerpc/include/asm/kvm_book3s.h              |   45 +-
 arch/powerpc/include/asm/kvm_book3s_64.h           |  119 +-
 arch/powerpc/include/asm/kvm_book3s_asm.h          |    3 +
 arch/powerpc/include/asm/kvm_booke.h               |    4 +-
 arch/powerpc/include/asm/kvm_host.h                |   16 +-
 arch/powerpc/include/asm/kvm_ppc.h                 |    4 +
 arch/powerpc/include/asm/ppc-opcode.h              |    1 +
 arch/powerpc/include/asm/reg.h                     |    2 +
 arch/powerpc/include/uapi/asm/kvm.h                |    1 +
 arch/powerpc/kernel/asm-offsets.c                  |    5 +-
 arch/powerpc/kernel/cpu_setup_power.S              |    4 +-
 arch/powerpc/kvm/Makefile                          |    3 +-
 arch/powerpc/kvm/book3s.c                          |   43 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c                |    7 +-
 arch/powerpc/kvm/book3s_64_mmu_radix.c             |  718 ++++++++---
 arch/powerpc/kvm/book3s_emulate.c                  |   13 +-
 arch/powerpc/kvm/book3s_hv.c                       |  842 ++++++++++++-
 arch/powerpc/kvm/book3s_hv_builtin.c               |   92 +-
 arch/powerpc/kvm/book3s_hv_interrupts.S            |   95 +-
 arch/powerpc/kvm/book3s_hv_nested.c                | 1280 ++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_ras.c                   |   10 +
 arch/powerpc/kvm/book3s_hv_rm_xics.c               |   13 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |  809 +++++++------
 arch/powerpc/kvm/book3s_hv_tm.c                    |    6 +-
 arch/powerpc/kvm/book3s_hv_tm_builtin.c            |    5 +-
 arch/powerpc/kvm/book3s_pr.c                       |    5 +-
 arch/powerpc/kvm/book3s_xics.c                     |   14 +-
 arch/powerpc/kvm/book3s_xive.c                     |   63 +
 arch/powerpc/kvm/book3s_xive_template.c            |    8 -
 arch/powerpc/kvm/bookehv_interrupts.S              |    8 +-
 arch/powerpc/kvm/emulate_loadstore.c               |    1 -
 arch/powerpc/kvm/powerpc.c                         |   12 +
 arch/powerpc/kvm/tm.S                              |  250 ++--
 arch/powerpc/kvm/trace_book3s.h                    |    1 -
 arch/powerpc/mm/tlb-radix.c                        |    9 +
 include/uapi/linux/kvm.h                           |    1 +
 tools/perf/arch/powerpc/util/book3s_hv_exits.h     |    1 -
 43 files changed, 3772 insertions(+), 835 deletions(-)
