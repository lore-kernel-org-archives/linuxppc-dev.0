Return-Path: <SRS0=/OnI=RO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2182EC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 08:34:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F23C2064A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 08:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="dr4ZE+Zq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F23C2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44HrxQ5J6JzDqDM
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 19:34:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="dr4ZE+Zq"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Hrs747NwzDqCh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2019 19:30:33 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Hrrv0q9WzB09ZL;
 Mon, 11 Mar 2019 09:30:23 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=dr4ZE+Zq; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Yd00vQ6sluRh; Mon, 11 Mar 2019 09:30:23 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Hrrt6pY6zB09ZD;
 Mon, 11 Mar 2019 09:30:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552293022; bh=mOmlvAdP26fagEkdX0sK+V4/3NmXkg//8eYE7tTc354=;
 h=From:Subject:To:Cc:Date:From;
 b=dr4ZE+Zqybak05ROVAI+s1XxopUdxLpJ9zylpRfznSBB2vV+Lx5ZmXvQZPU68h+zv
 N/Yv4CC3hJA8ymdf799urVPxi6+f8PHEqkIYgMRWpFudwNbUZgtmMLmHRAXb3KLUD4
 +oI7vapqTC0GpnHisabNwV5VxcOn7hO0PX7dvck8=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5F78F8B7FE;
 Mon, 11 Mar 2019 09:30:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id V5K2KPzEWNPt; Mon, 11 Mar 2019 09:30:27 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2B6E38B813;
 Mon, 11 Mar 2019 09:30:27 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id EA11D6FA08; Mon, 11 Mar 2019 08:30:26 +0000 (UTC)
Message-Id: <cover.1552292207.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 00/10] Kernel Userspace protection for PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 11 Mar 2019 08:30:26 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This series intend to implement Kernel Userspace protection for PPC32.
It comes on top of the v5 series for Radix.

The first patch of the series is a fix which is expected to be merged soon.
The second patch is a squash of Russel/Michael series for Radix.

Tested on:
- 8xx
- 83xx (ie book3s32 without hash table)
- QEMU MAC99 (ie book3s32 with hash table)

v2:
- Rebased/adapted the series on top of the v5 series for Radix.
- Reordered the patches so that we first have the ones common to 32 bits, then the 8xx, then book3s32
- Fixed lockup on bad data write (unauthorised write to user) on book3s32 hash.
- Added KUEP for book3s32

Christophe Leroy (9):
  powerpc/6xx: fix setup and use of SPRN_SPRG_PGDIR for hash32
  powerpc/32: Remove MSR_PR test when returning from syscall
  powerpc/32: Prepare for Kernel Userspace Access Protection
  powerpc/8xx: Only define APG0 and APG1
  powerpc/8xx: Add Kernel Userspace Execution Prevention
  powerpc/8xx: Add Kernel Userspace Access Protection
  powerpc/32s: Implement Kernel Userspace Execution Prevention.
  powerpc/32s: Prepare Kernel Userspace Access Protection
  powerpc/32s: Implement Kernel Userspace Access Protection

Russell Currey (1):
  powerpc/mm: Detect bad KUAP faults (Squash of v5 series)

 Documentation/admin-guide/kernel-parameters.txt |   4 +-
 arch/powerpc/include/asm/book3s/32/kup.h        | 149 ++++++++++++++++++++++++
 arch/powerpc/include/asm/book3s/32/mmu-hash.h   |   5 +
 arch/powerpc/include/asm/book3s/64/kup-radix.h  | 119 +++++++++++++++++++
 arch/powerpc/include/asm/exception-64s.h        |   2 +
 arch/powerpc/include/asm/feature-fixups.h       |   3 +
 arch/powerpc/include/asm/futex.h                |   4 +
 arch/powerpc/include/asm/kup.h                  |  65 +++++++++++
 arch/powerpc/include/asm/mmu.h                  |  10 +-
 arch/powerpc/include/asm/nohash/32/kup-8xx.h    |  68 +++++++++++
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h    |  26 ++++-
 arch/powerpc/include/asm/processor.h            |   3 +
 arch/powerpc/include/asm/ptrace.h               |  11 +-
 arch/powerpc/include/asm/uaccess.h              |  38 ++++--
 arch/powerpc/kernel/asm-offsets.c               |   7 ++
 arch/powerpc/kernel/cpu_setup_6xx.S             |   3 -
 arch/powerpc/kernel/entry_32.S                  |  28 +++--
 arch/powerpc/kernel/entry_64.S                  |  27 ++++-
 arch/powerpc/kernel/exceptions-64s.S            |   3 +
 arch/powerpc/kernel/head_32.S                   |  52 +++++++--
 arch/powerpc/kernel/idle_book3s.S               |  39 +++++++
 arch/powerpc/kernel/setup_64.c                  |  10 ++
 arch/powerpc/lib/checksum_wrappers.c            |   4 +
 arch/powerpc/lib/code-patching.c                |   4 +-
 arch/powerpc/mm/8xx_mmu.c                       |  24 ++++
 arch/powerpc/mm/fault.c                         |  49 ++++++--
 arch/powerpc/mm/hash_low_32.S                   |  14 +--
 arch/powerpc/mm/init-common.c                   |  26 +++++
 arch/powerpc/mm/init_32.c                       |   3 +
 arch/powerpc/mm/pgtable-radix.c                 |  30 ++++-
 arch/powerpc/mm/pkeys.c                         |   1 +
 arch/powerpc/mm/ppc_mmu_32.c                    |  23 ++++
 arch/powerpc/platforms/Kconfig.cputype          |  37 ++++++
 33 files changed, 826 insertions(+), 65 deletions(-)
 create mode 100644 arch/powerpc/include/asm/book3s/32/kup.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/kup-radix.h
 create mode 100644 arch/powerpc/include/asm/kup.h
 create mode 100644 arch/powerpc/include/asm/nohash/32/kup-8xx.h

-- 
2.13.3

