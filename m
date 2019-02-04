Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298ECC282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 11:22:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 710D9207E0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 11:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710D9207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tQKJ2Y3VzDqDs
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 22:22:12 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tQHB4ZX0zDqCt
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 22:20:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43tQHB1VcMz9s3l;
 Mon,  4 Feb 2019 22:20:22 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v15 00/13] powerpc: Switch to CONFIG_THREAD_INFO_IN_TASK
In-Reply-To: <cover.1548852242.git.christophe.leroy@c-s.fr>
References: <cover.1548852242.git.christophe.leroy@c-s.fr>
Date: Mon, 04 Feb 2019 22:20:20 +1100
Message-ID: <8736p3ol57.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> The purpose of this serie is to activate CONFIG_THREAD_INFO_IN_TASK which
> moves the thread_info into task_struct.

Hi Christophe,

I've taken this series and split some of the patches up a bit more.

I'll just run it through some tests and then post my version.

cheers


> Moving thread_info into task_struct has the following advantages:
> - It protects thread_info from corruption in the case of stack
> overflows.
> - Its address is harder to determine if stack addresses are
> leaked, making a number of attacks more difficult.
>
> Changes in v15:
>  - switched patch 1 and 2.
>  - resync patch 1 with linux/next. As memblock modifications are now fully merged in
>  linux-mm tree, this patch voids as soon as linux-mm gets merged into powerpc/merge branch
>  - Fixed build failure on 64le due to call to __save_stack_trace_tsk_reliable() (patch 5)
>  - Taken the renaming of THREAD_INFO to TASK_STACK out of the preparation patch to ease review (hence new patch 6)
>  - Fixed one place where r11 (physical address of stack) was used instead of r1 to locate
>  thread_info, inducing a bug when switching to r2 which is virtual address of current (patch 7)
>  - Keeping physical address of current in r2 until MMU translation is reactivated (patch 11)
>
> Changes in v14 (ie since v13):
>  - Added in front a fixup patch which conflicts with this serie
>  - Added a patch for using try_get_task_stack()/put_task_stack() in stack walkers.
>  - Fixed compilation failure in the preparation patch (by moving the modification
>  of klp_init_thread_info() to the following patch)
>
> Changes since v12:
>  - Patch 1: Taken comment from Mike (re-introduced the 'panic' in case memblock allocation fails in setup_64.c
>  - Patch 1: Added alloc_stack() function in setup_32.c to also panic in case of allocation failure.
>
> Changes since v11:
>  - Rebased on 81775f5563fa ("Automatic merge of branches 'master', 'next' and 'fixes' into merge")
>  - Added a first patch to change memblock allocs to functions returning virtual addrs. This removes
>    the memset() which were the only remaining stuff in irq_ctx_init() and exc_lvl_ctx_init() at the end.
>  - dropping irq_ctx_init() and exc_lvl_ctx_init() in patch 5 (powerpc: Activate CONFIG_THREAD_INFO_IN_TASK)
>  - A few cosmetic changes in commit log and code.
>
> Changes since v10:
>  - Rebased on 21622a0d2023 ("Automatic merge of branches 'master', 'next' and 'fixes' into merge")
>   ==> Fixed conflict in setup_32.S
>
> Changes since v9:
>  - Rebased on 183cbf93be88 ("Automatic merge of branches 'master', 'next' and 'fixes' into merge")
>   ==> Fixed conflict on xmon
>
> Changes since v8:
>  - Rebased on e589b79e40d9 ("Automatic merge of branches 'master', 'next' and 'fixes' into merge")
>   ==> Main impact was conflicts due to commit 9a8dd708d547 ("memblock: rename memblock_alloc{_nid,_try_nid} to memblock_phys_alloc*")
>
> Changes since v7:
>  - Rebased on fb6c6ce7907d ("Automatic merge of branches 'master', 'next' and 'fixes' into merge")
>
> Changes since v6:
>  - Fixed validate_sp() to exclude NULL sp in 'regain entire stack space' patch (early crash with CONFIG_KMEMLEAK)
>
> Changes since v5:
>  - Fixed livepatch_sp setup by using end_of_stack() instead of hardcoding
>  - Fixed PPC_BPF_LOAD_CPU() macro
>
> Changes since v4:
>  - Fixed a build failure on 32bits SMP when include/generated/asm-offsets.h is not
>  already existing, was due to spaces instead of a tab in the Makefile
>
> Changes since RFC v3: (based on Nick's review)
>  - Renamed task_size.h to task_size_user64.h to better relate to what it contains.
>  - Handling of the isolation of thread_info cpu field inside CONFIG_SMP #ifdefs moved to a separate patch.
>  - Removed CURRENT_THREAD_INFO macro completely.
>  - Added a guard in asm/smp.h to avoid build failure before _TASK_CPU is defined.
>  - Added a patch at the end to rename 'tp' pointers to 'sp' pointers
>  - Renamed 'tp' into 'sp' pointers in preparation patch when relevant
>  - Fixed a few commit logs
>  - Fixed checkpatch report.
>
> Changes since RFC v2:
>  - Removed the modification of names in asm-offsets
>  - Created a rule in arch/powerpc/Makefile to append the offset of current->cpu in CFLAGS
>  - Modified asm/smp.h to use the offset set in CFLAGS
>  - Squashed the renaming of THREAD_INFO to TASK_STACK in the preparation patch
>  - Moved the modification of current_pt_regs in the patch activating CONFIG_THREAD_INFO_IN_TASK
>
> Changes since RFC v1:
>  - Removed the first patch which was modifying header inclusion order in timer
>  - Modified some names in asm-offsets to avoid conflicts when including asm-offsets in C files
>  - Modified asm/smp.h to avoid having to include linux/sched.h (using asm-offsets instead)
>  - Moved some changes from the activation patch to the preparation patch.
>
> Christophe Leroy (13):
>   powerpc/irq: use memblock functions returning virtual address
>   powerpc/32: Fix CONFIG_VIRT_CPU_ACCOUNTING_NATIVE for 40x/booke
>   book3s/64: avoid circular header inclusion in mmu-hash.h
>   powerpc: Only use task_struct 'cpu' field on SMP
>   powerpc: prep stack walkers for THREAD_INFO_IN_TASK
>   powerpc: Rename THREAD_INFO to TASK_STACK
>   powerpc: Prepare for moving thread_info into task_struct
>   powerpc: Activate CONFIG_THREAD_INFO_IN_TASK
>   powerpc: regain entire stack space
>   powerpc: 'current_set' is now a table of task_struct pointers
>   powerpc/32: Remove CURRENT_THREAD_INFO and rename TI_CPU
>   powerpc/64: Remove CURRENT_THREAD_INFO
>   powerpc: clean stack pointers naming
>
>  arch/powerpc/Kconfig                           |   1 +
>  arch/powerpc/Makefile                          |   7 ++
>  arch/powerpc/include/asm/asm-prototypes.h      |   4 +-
>  arch/powerpc/include/asm/book3s/64/mmu-hash.h  |   2 +-
>  arch/powerpc/include/asm/exception-64s.h       |   4 +-
>  arch/powerpc/include/asm/irq.h                 |  18 ++--
>  arch/powerpc/include/asm/livepatch.h           |   6 +-
>  arch/powerpc/include/asm/processor.h           |  39 +--------
>  arch/powerpc/include/asm/ptrace.h              |   2 +-
>  arch/powerpc/include/asm/reg.h                 |   2 +-
>  arch/powerpc/include/asm/smp.h                 |  17 +++-
>  arch/powerpc/include/asm/task_size_user64.h    |  42 +++++++++
>  arch/powerpc/include/asm/thread_info.h         |  19 -----
>  arch/powerpc/kernel/asm-offsets.c              |  10 ++-
>  arch/powerpc/kernel/entry_32.S                 |  80 ++++++-----------
>  arch/powerpc/kernel/entry_64.S                 |  12 +--
>  arch/powerpc/kernel/epapr_hcalls.S             |   5 +-
>  arch/powerpc/kernel/exceptions-64e.S           |  13 +--
>  arch/powerpc/kernel/exceptions-64s.S           |   2 +-
>  arch/powerpc/kernel/head_32.S                  |  14 +--
>  arch/powerpc/kernel/head_40x.S                 |   4 +-
>  arch/powerpc/kernel/head_44x.S                 |   8 +-
>  arch/powerpc/kernel/head_64.S                  |   1 +
>  arch/powerpc/kernel/head_8xx.S                 |   2 +-
>  arch/powerpc/kernel/head_booke.h               |  12 +--
>  arch/powerpc/kernel/head_fsl_booke.S           |  16 ++--
>  arch/powerpc/kernel/idle_6xx.S                 |   8 +-
>  arch/powerpc/kernel/idle_book3e.S              |   2 +-
>  arch/powerpc/kernel/idle_e500.S                |   8 +-
>  arch/powerpc/kernel/idle_power4.S              |   2 +-
>  arch/powerpc/kernel/irq.c                      | 114 +++----------------------
>  arch/powerpc/kernel/kgdb.c                     |  28 ------
>  arch/powerpc/kernel/machine_kexec_64.c         |   6 +-
>  arch/powerpc/kernel/misc_32.S                  |  17 ++--
>  arch/powerpc/kernel/process.c                  |  63 ++++++++------
>  arch/powerpc/kernel/setup-common.c             |   2 +-
>  arch/powerpc/kernel/setup_32.c                 |  26 +++---
>  arch/powerpc/kernel/setup_64.c                 |  51 +++--------
>  arch/powerpc/kernel/smp.c                      |  16 ++--
>  arch/powerpc/kernel/stacktrace.c               |  29 ++++++-
>  arch/powerpc/kernel/trace/ftrace_64_mprofile.S |   6 +-
>  arch/powerpc/kvm/book3s_hv_hmi.c               |   1 +
>  arch/powerpc/mm/hash_low_32.S                  |  14 ++-
>  arch/powerpc/net/bpf_jit32.h                   |   5 +-
>  arch/powerpc/sysdev/6xx-suspend.S              |   5 +-
>  arch/powerpc/xmon/xmon.c                       |   2 +-
>  46 files changed, 302 insertions(+), 445 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/task_size_user64.h
>
> -- 
> 2.13.3
