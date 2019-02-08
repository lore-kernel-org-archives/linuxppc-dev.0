Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B08C169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 12:59:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CDF320844
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 12:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="aYMfm72z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CDF320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wwHf1Cy1zDqXT
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 23:59:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="aYMfm72z"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ww7X0bx1zDqWv
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 23:52:22 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43ww7N226tz9v0dH;
 Fri,  8 Feb 2019 13:52:16 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=aYMfm72z; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id RPH8uguzozuR; Fri,  8 Feb 2019 13:52:16 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43ww7N0yfsz9v9DY;
 Fri,  8 Feb 2019 13:52:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1549630336; bh=S1kn21Xe7/docipPWcnKOsqhSa/YEFzLSyBpdTR2gLE=;
 h=From:Subject:To:Cc:Date:From;
 b=aYMfm72zUAsT4J2PvmbcJeFnvPe9AYVbn5/Mo2Ng6gJYvCN3f/E5hkCgseZk33qgl
 d4FjRrm5iN0IbFkNoS9xcRy8uD1BMcyQZkBb4tVOge2qgfZBLeRGQj6NvHT0UVG37d
 7bOsdzWvEQC+v0Q39WsrCT6QyUCvAoeCs+5Vttfc=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 678D88B756;
 Fri,  8 Feb 2019 13:52:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id CUIsjZfggXVe; Fri,  8 Feb 2019 13:52:17 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 394F58B8D9;
 Fri,  8 Feb 2019 13:52:17 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 11415653E8; Fri,  8 Feb 2019 12:52:16 +0000 (UTC)
Message-Id: <cover.1549630193.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 00/16] powerpc/32: Implement fast syscall entry
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Fri,  8 Feb 2019 12:52:16 +0000 (UTC)
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

The purpose of this series is to implement a fast syscall entry
on ppc32.

Unlike all other exceptions which can happen at any time and
require to preserve all registers, the syscalls do not
require the preservation of volatile registers (except LR).

Syscall entries can then be optimised with lighter entry code
than the general exception handling.

In the meantime this series refactorises the exception entry on
40x/6xx/8xx as they are pretty similar, and it takes benh series
on rationalise the settings of MSR_EE at exceptions/syscall entries
as this change pretty simplies exception entries.

On a 8xx, this series improves null_syscall selftest by 17%
On a 83xx, this series improves null_syscall selftest by 12,5%

Christophe Leroy (16):
  powerpc: CONFIG_THREAD_INFO_IN_TASK series
  powerpc/32: Refactor EXCEPTION entry macros for head_8xx.S and
    head_32.S
  powerpc/32: move LOAD_MSR_KERNEL() into head_32.h and use it
  powerpc/32: make the 6xx/8xx EXC_XFER_TEMPLATE() similar to the
    40x/booke one
  powerpc/40x: Don't use SPRN_SPRG_SCRATCH2 in EXCEPTION_PROLOG
  powerpc/40x: add exception frame marker
  powerpc/40x: Split and rename NORMAL_EXCEPTION_PROLOG
  powerpc/40x: Refactor exception entry macros by using head_32.h
  powerpc/fsl_booke: ensure SPEFloatingPointException() reenables
    interrupts
  powerpc/32: enter syscall with MSR_EE inconditionaly set
  powerpc/32: Enter exceptions with MSR_EE unset
  powerpc/32: get rid of COPY_EE in exception entry
  powerpc: Fix 32-bit handling of MSR_EE on exceptions
  powerpc/32: implement fast entry for syscalls on non BOOKE
  powerpc/32: Remove MSR_PR test when returning from syscall
  powerpc/32: don't do syscall stuff in transfer_to_handler on non BOOKE

 arch/powerpc/Kconfig                           |   1 +
 arch/powerpc/Makefile                          |   7 +
 arch/powerpc/include/asm/asm-prototypes.h      |   4 +-
 arch/powerpc/include/asm/book3s/64/mmu-hash.h  |   2 +-
 arch/powerpc/include/asm/exception-64s.h       |   4 +-
 arch/powerpc/include/asm/irq.h                 |  18 +-
 arch/powerpc/include/asm/livepatch.h           |   7 +-
 arch/powerpc/include/asm/processor.h           | 105 +---------
 arch/powerpc/include/asm/ptrace.h              |   2 +-
 arch/powerpc/include/asm/reg.h                 |   2 +-
 arch/powerpc/include/asm/smp.h                 |  17 +-
 arch/powerpc/include/asm/task_size_32.h        |  21 ++
 arch/powerpc/include/asm/task_size_64.h        |  79 ++++++++
 arch/powerpc/include/asm/thread_info.h         |  19 --
 arch/powerpc/kernel/asm-offsets.c              |  12 +-
 arch/powerpc/kernel/entry_32.S                 | 261 ++++++++++++++-----------
 arch/powerpc/kernel/entry_64.S                 |  12 +-
 arch/powerpc/kernel/epapr_hcalls.S             |   5 +-
 arch/powerpc/kernel/exceptions-64e.S           |  13 +-
 arch/powerpc/kernel/exceptions-64s.S           |   2 +-
 arch/powerpc/kernel/head_32.S                  | 182 ++++-------------
 arch/powerpc/kernel/head_32.h                  | 203 +++++++++++++++++++
 arch/powerpc/kernel/head_40x.S                 | 154 ++++-----------
 arch/powerpc/kernel/head_44x.S                 |  16 +-
 arch/powerpc/kernel/head_64.S                  |   1 +
 arch/powerpc/kernel/head_8xx.S                 | 133 ++-----------
 arch/powerpc/kernel/head_booke.h               |  44 ++---
 arch/powerpc/kernel/head_fsl_booke.S           |  44 ++---
 arch/powerpc/kernel/idle_6xx.S                 |   8 +-
 arch/powerpc/kernel/idle_book3e.S              |   2 +-
 arch/powerpc/kernel/idle_e500.S                |   8 +-
 arch/powerpc/kernel/idle_power4.S              |   2 +-
 arch/powerpc/kernel/irq.c                      | 114 ++---------
 arch/powerpc/kernel/kgdb.c                     |  28 ---
 arch/powerpc/kernel/machine_kexec_64.c         |   6 +-
 arch/powerpc/kernel/misc_32.S                  |  17 +-
 arch/powerpc/kernel/process.c                  |  63 +++---
 arch/powerpc/kernel/setup-common.c             |   2 +-
 arch/powerpc/kernel/setup_32.c                 |  26 ++-
 arch/powerpc/kernel/setup_64.c                 |  51 +----
 arch/powerpc/kernel/smp.c                      |  16 +-
 arch/powerpc/kernel/stacktrace.c               |  29 ++-
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |   6 +-
 arch/powerpc/kernel/traps.c                    |   8 +
 arch/powerpc/kvm/book3s_hv_hmi.c               |   1 +
 arch/powerpc/mm/hash_low_32.S                  |  14 +-
 arch/powerpc/net/bpf_jit32.h                   |   5 +-
 arch/powerpc/sysdev/6xx-suspend.S              |   5 +-
 arch/powerpc/xmon/xmon.c                       |   2 +-
 49 files changed, 816 insertions(+), 967 deletions(-)
 create mode 100644 arch/powerpc/include/asm/task_size_32.h
 create mode 100644 arch/powerpc/include/asm/task_size_64.h
 create mode 100644 arch/powerpc/kernel/head_32.h

-- 
2.13.3

