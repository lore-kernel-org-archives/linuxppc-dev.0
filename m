Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21B0C43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 12:34:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A552089C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 12:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A552089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42P1tX2BSDzF31s
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 22:34:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42P1p52Mh9zF33f
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2018 22:30:21 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42P1nt5TJlz9ttCY;
 Mon,  1 Oct 2018 14:30:10 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id lK3ueqBCeblZ; Mon,  1 Oct 2018 14:30:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42P1nt4tpXz9ttBl;
 Mon,  1 Oct 2018 14:30:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 118648B968;
 Mon,  1 Oct 2018 14:30:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id xNnS0bw2gqD6; Mon,  1 Oct 2018 14:30:17 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8EFA28B95C;
 Mon,  1 Oct 2018 14:30:17 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 97E9D6F36F; Mon,  1 Oct 2018 12:30:17 +0000 (UTC)
Message-Id: <cover.1538396658.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v3 0/7] powerpc: Switch to CONFIG_THREAD_INFO_IN_TASK
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Date: Mon,  1 Oct 2018 12:30:17 +0000 (UTC)
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

The purpose of this serie is to activate CONFIG_THREAD_INFO_IN_TASK which
moves the thread_info into task_struct.

Moving thread_info into task_struct has the following advantages:
- It protects thread_info from corruption in the case of stack
overflows.
- Its address is harder to determine if stack addresses are
leaked, making a number of attacks more difficult.

Changes since RFC v2:
 - Removed the modification of names in asm-offsets
 - Created a rule in arch/powerpc/Makefile to append the offset of current->cpu in CFLAGS
 - Modified asm/smp.h to use the offset set in CFLAGS
 - Squashed the renaming of THREAD_INFO to TASK_STACK in the preparation patch
 - Moved the modification of current_pt_regs in the patch activating CONFIG_THREAD_INFO_IN_TASK

Changes since RFC v1:
 - Removed the first patch which was modifying header inclusion order in timer
 - Modified some names in asm-offsets to avoid conflicts when including asm-offsets in C files
 - Modified asm/smp.h to avoid having to include linux/sched.h (using asm-offsets instead)
 - Moved some changes from the activation patch to the preparation patch.

Christophe Leroy (7):
  book3s/64: avoid circular header inclusion in mmu-hash.h
  powerpc: Prepare for moving thread_info into task_struct
  powerpc: Activate CONFIG_THREAD_INFO_IN_TASK
  powerpc: regain entire stack space
  powerpc: 'current_set' is now a table of task_struct pointers
  powerpc/32: Remove CURRENT_THREAD_INFO and rename TI_CPU
  powerpc/64: Modify CURRENT_THREAD_INFO()

 arch/powerpc/Kconfig                           |  1 +
 arch/powerpc/Makefile                          |  6 +++
 arch/powerpc/include/asm/asm-prototypes.h      |  4 +-
 arch/powerpc/include/asm/book3s/64/mmu-hash.h  |  2 +-
 arch/powerpc/include/asm/exception-64s.h       |  4 +-
 arch/powerpc/include/asm/irq.h                 | 14 +++---
 arch/powerpc/include/asm/livepatch.h           |  2 +-
 arch/powerpc/include/asm/processor.h           | 39 ++-------------
 arch/powerpc/include/asm/ptrace.h              |  2 +-
 arch/powerpc/include/asm/reg.h                 |  2 +-
 arch/powerpc/include/asm/smp.h                 |  8 +++-
 arch/powerpc/include/asm/task_size.h           | 42 ++++++++++++++++
 arch/powerpc/include/asm/thread_info.h         | 17 +------
 arch/powerpc/kernel/asm-offsets.c              |  8 ++--
 arch/powerpc/kernel/entry_32.S                 | 66 +++++++++-----------------
 arch/powerpc/kernel/entry_64.S                 | 12 ++---
 arch/powerpc/kernel/epapr_hcalls.S             |  5 +-
 arch/powerpc/kernel/exceptions-64e.S           | 13 +----
 arch/powerpc/kernel/exceptions-64s.S           |  2 +-
 arch/powerpc/kernel/head_32.S                  | 14 +++---
 arch/powerpc/kernel/head_40x.S                 |  4 +-
 arch/powerpc/kernel/head_44x.S                 |  8 ++--
 arch/powerpc/kernel/head_64.S                  |  1 +
 arch/powerpc/kernel/head_8xx.S                 |  2 +-
 arch/powerpc/kernel/head_booke.h               | 12 ++---
 arch/powerpc/kernel/head_fsl_booke.S           | 16 +++----
 arch/powerpc/kernel/idle_6xx.S                 |  8 ++--
 arch/powerpc/kernel/idle_book3e.S              |  2 +-
 arch/powerpc/kernel/idle_e500.S                |  8 ++--
 arch/powerpc/kernel/idle_power4.S              |  2 +-
 arch/powerpc/kernel/irq.c                      | 66 ++++----------------------
 arch/powerpc/kernel/kgdb.c                     | 28 -----------
 arch/powerpc/kernel/machine_kexec_64.c         |  6 +--
 arch/powerpc/kernel/misc_32.S                  | 17 +++----
 arch/powerpc/kernel/process.c                  | 15 +++---
 arch/powerpc/kernel/setup-common.c             |  2 +-
 arch/powerpc/kernel/setup_32.c                 | 15 ++----
 arch/powerpc/kernel/setup_64.c                 | 29 ++---------
 arch/powerpc/kernel/smp.c                      | 16 +++----
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |  6 +--
 arch/powerpc/kvm/book3s_hv_hmi.c               |  1 +
 arch/powerpc/mm/hash_low_32.S                  | 14 ++----
 arch/powerpc/sysdev/6xx-suspend.S              |  5 +-
 arch/powerpc/xmon/xmon.c                       |  2 +-
 44 files changed, 203 insertions(+), 345 deletions(-)
 create mode 100644 arch/powerpc/include/asm/task_size.h

-- 
2.13.3

