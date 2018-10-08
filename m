Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DEFC00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 11:02:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 140C920878
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 11:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140C920878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42THWM6kNhzF3DY
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 22:02:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42THT34Qd1zF3Bf
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 22:00:23 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w989xuJ1007570;
 Mon, 8 Oct 2018 04:59:58 -0500
Message-ID: <df8575fba80d19e6e58c16266350e9980c432ae1.camel@kernel.crashing.org>
Subject: Re: [PATCH v6 0/9] powerpc: Switch to CONFIG_THREAD_INFO_IN_TASK
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 08 Oct 2018 20:59:56 +1100
In-Reply-To: <cover.1538954166.git.christophe.leroy@c-s.fr>
References: <cover.1538954166.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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

On Mon, 2018-10-08 at 09:16 +0000, Christophe Leroy wrote:
> The purpose of this serie is to activate CONFIG_THREAD_INFO_IN_TASK which
> moves the thread_info into task_struct.

We need to make sure we don't have code that assumes that we don't take
faults on TI access.

On ppc64, the stack SLB entries are bolted, which means the TI is too.

We might have code that assumes that we don't get SLB faults when
accessing TI. If not, we're fine but that needs a close look.

Ben.

> Moving thread_info into task_struct has the following advantages:
> - It protects thread_info from corruption in the case of stack
> overflows.
> - Its address is harder to determine if stack addresses are
> leaked, making a number of attacks more difficult.
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
> Christophe Leroy (9):
>   book3s/64: avoid circular header inclusion in mmu-hash.h
>   powerpc: Only use task_struct 'cpu' field on SMP
>   powerpc: Prepare for moving thread_info into task_struct
>   powerpc: Activate CONFIG_THREAD_INFO_IN_TASK
>   powerpc: regain entire stack space
>   powerpc: 'current_set' is now a table of task_struct pointers
>   powerpc/32: Remove CURRENT_THREAD_INFO and rename TI_CPU
>   powerpc/64: Remove CURRENT_THREAD_INFO
>   powerpc: clean stack pointers naming
> 
>  arch/powerpc/Kconfig                           |  1 +
>  arch/powerpc/Makefile                          |  8 ++-
>  arch/powerpc/include/asm/asm-prototypes.h      |  4 +-
>  arch/powerpc/include/asm/book3s/64/mmu-hash.h  |  2 +-
>  arch/powerpc/include/asm/exception-64s.h       |  4 +-
>  arch/powerpc/include/asm/irq.h                 | 14 ++---
>  arch/powerpc/include/asm/livepatch.h           |  7 ++-
>  arch/powerpc/include/asm/processor.h           | 39 +------------
>  arch/powerpc/include/asm/ptrace.h              |  2 +-
>  arch/powerpc/include/asm/reg.h                 |  2 +-
>  arch/powerpc/include/asm/smp.h                 | 17 +++++-
>  arch/powerpc/include/asm/task_size_user64.h    | 42 ++++++++++++++
>  arch/powerpc/include/asm/thread_info.h         | 19 -------
>  arch/powerpc/kernel/asm-offsets.c              | 10 ++--
>  arch/powerpc/kernel/entry_32.S                 | 66 ++++++++--------------
>  arch/powerpc/kernel/entry_64.S                 | 12 ++--
>  arch/powerpc/kernel/epapr_hcalls.S             |  5 +-
>  arch/powerpc/kernel/exceptions-64e.S           | 13 +----
>  arch/powerpc/kernel/exceptions-64s.S           |  2 +-
>  arch/powerpc/kernel/head_32.S                  | 14 ++---
>  arch/powerpc/kernel/head_40x.S                 |  4 +-
>  arch/powerpc/kernel/head_44x.S                 |  8 +--
>  arch/powerpc/kernel/head_64.S                  |  1 +
>  arch/powerpc/kernel/head_8xx.S                 |  2 +-
>  arch/powerpc/kernel/head_booke.h               | 12 +---
>  arch/powerpc/kernel/head_fsl_booke.S           | 16 +++---
>  arch/powerpc/kernel/idle_6xx.S                 |  8 +--
>  arch/powerpc/kernel/idle_book3e.S              |  2 +-
>  arch/powerpc/kernel/idle_e500.S                |  8 +--
>  arch/powerpc/kernel/idle_power4.S              |  2 +-
>  arch/powerpc/kernel/irq.c                      | 77 +++++---------------------
>  arch/powerpc/kernel/kgdb.c                     | 28 ----------
>  arch/powerpc/kernel/machine_kexec_64.c         |  6 +-
>  arch/powerpc/kernel/misc_32.S                  | 17 +++---
>  arch/powerpc/kernel/process.c                  | 17 +++---
>  arch/powerpc/kernel/setup-common.c             |  2 +-
>  arch/powerpc/kernel/setup_32.c                 | 15 ++---
>  arch/powerpc/kernel/setup_64.c                 | 41 ++++----------
>  arch/powerpc/kernel/smp.c                      | 16 +++---
>  arch/powerpc/kernel/trace/ftrace_64_mprofile.S |  6 +-
>  arch/powerpc/kvm/book3s_hv_hmi.c               |  1 +
>  arch/powerpc/mm/hash_low_32.S                  | 14 ++---
>  arch/powerpc/net/bpf_jit32.h                   |  5 +-
>  arch/powerpc/sysdev/6xx-suspend.S              |  5 +-
>  arch/powerpc/xmon/xmon.c                       |  2 +-
>  45 files changed, 230 insertions(+), 368 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/task_size_user64.h
> 

