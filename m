Return-Path: <SRS0=6cb3=P7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20642C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 10:06:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFAD220870
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 10:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="qmBawP+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFAD220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43l1C12hZPzDqLh
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 21:06:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="qmBawP+o"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43l1913KQ2zDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 21:04:21 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43l18w0wjCz9tyZS;
 Wed, 23 Jan 2019 11:04:16 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=qmBawP+o; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id LecDX33IwxtM; Wed, 23 Jan 2019 11:04:16 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43l18v6n8vz9tyZK;
 Wed, 23 Jan 2019 11:04:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548237855; bh=rJWkQ5tIW9mztCMgFG4VMzlkgZQIKaxpeoWBGsdOweI=;
 h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
 b=qmBawP+oggKmr9sQrekG/NNTblT0YDrVDWgXj7SmPmDAV7o8e+rBJZNx+bpYK1bWl
 GXRAgYgrCFtOwha0nXrD2jPcf/s7wlqDFErPqZ6lN6qZv4ReOcriGK5ommxMy/Qho+
 0RpCFMsG0OaFUEa6AeFCMvq1kaCJ3ZncHOV5AMkg=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 131F48B7FF;
 Wed, 23 Jan 2019 11:04:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 7x2fvWQ_dIfk; Wed, 23 Jan 2019 11:04:16 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 664638B801;
 Wed, 23 Jan 2019 11:04:16 +0100 (CET)
Subject: Re: [PATCH v13 00/10] powerpc: Switch to CONFIG_THREAD_INFO_IN_TASK
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
References: <cover.1547195976.git.christophe.leroy@c-s.fr>
Message-ID: <2e700e1c-5bd9-652e-b535-68a89dd703a1@c-s.fr>
Date: Wed, 23 Jan 2019 11:04:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <cover.1547195976.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 12/01/2019 à 10:55, Christophe Leroy a écrit :
> The purpose of this serie is to activate CONFIG_THREAD_INFO_IN_TASK which
> moves the thread_info into task_struct.
> 
> Moving thread_info into task_struct has the following advantages:
> - It protects thread_info from corruption in the case of stack
> overflows.
> - Its address is harder to determine if stack addresses are
> leaked, making a number of attacks more difficult.

I ran null_syscall and context_switch benchmark selftests and the result 
is surprising. There is slight degradation in context_switch and a 
significant one on null_syscall:

Without the serie:

~# chrt -f 98 ./context_switch --no-altivec --no-vector --no-fp
55542
55562
55564
55562
55568
...

~# ./null_syscall
    2546.71 ns     336.17 cycles


With the serie:

~# chrt -f 98 ./context_switch --no-altivec --no-vector --no-fp
55138
55142
55152
55144
55142

~# ./null_syscall
    3479.54 ns     459.30 cycles

So 0,8% less context switches per second and 37% more time for one syscall ?


Any idea ?

Christophe


> 
> Changes since v12:
>   - Patch 1: Taken comment from Mike (re-introduced the 'panic' in case memblock allocation fails in setup_64.c
>   - Patch 1: Added alloc_stack() function in setup_32.c to also panic in case of allocation failure.
> 
> Changes since v11:
>   - Rebased on 81775f5563fa ("Automatic merge of branches 'master', 'next' and 'fixes' into merge")
>   - Added a first patch to change memblock allocs to functions returning virtual addrs. This removes
>     the memset() which were the only remaining stuff in irq_ctx_init() and exc_lvl_ctx_init() at the end.
>   - dropping irq_ctx_init() and exc_lvl_ctx_init() in patch 5 (powerpc: Activate CONFIG_THREAD_INFO_IN_TASK)
>   - A few cosmetic changes in commit log and code.
> 
> Changes since v10:
>   - Rebased on 21622a0d2023 ("Automatic merge of branches 'master', 'next' and 'fixes' into merge")
>    ==> Fixed conflict in setup_32.S
> 
> Changes since v9:
>   - Rebased on 183cbf93be88 ("Automatic merge of branches 'master', 'next' and 'fixes' into merge")
>    ==> Fixed conflict on xmon
> 
> Changes since v8:
>   - Rebased on e589b79e40d9 ("Automatic merge of branches 'master', 'next' and 'fixes' into merge")
>    ==> Main impact was conflicts due to commit 9a8dd708d547 ("memblock: rename memblock_alloc{_nid,_try_nid} to memblock_phys_alloc*")
> 
> Changes since v7:
>   - Rebased on fb6c6ce7907d ("Automatic merge of branches 'master', 'next' and 'fixes' into merge")
> 
> Changes since v6:
>   - Fixed validate_sp() to exclude NULL sp in 'regain entire stack space' patch (early crash with CONFIG_KMEMLEAK)
> 
> Changes since v5:
>   - Fixed livepatch_sp setup by using end_of_stack() instead of hardcoding
>   - Fixed PPC_BPF_LOAD_CPU() macro
> 
> Changes since v4:
>   - Fixed a build failure on 32bits SMP when include/generated/asm-offsets.h is not
>   already existing, was due to spaces instead of a tab in the Makefile
> 
> Changes since RFC v3: (based on Nick's review)
>   - Renamed task_size.h to task_size_user64.h to better relate to what it contains.
>   - Handling of the isolation of thread_info cpu field inside CONFIG_SMP #ifdefs moved to a separate patch.
>   - Removed CURRENT_THREAD_INFO macro completely.
>   - Added a guard in asm/smp.h to avoid build failure before _TASK_CPU is defined.
>   - Added a patch at the end to rename 'tp' pointers to 'sp' pointers
>   - Renamed 'tp' into 'sp' pointers in preparation patch when relevant
>   - Fixed a few commit logs
>   - Fixed checkpatch report.
> 
> Changes since RFC v2:
>   - Removed the modification of names in asm-offsets
>   - Created a rule in arch/powerpc/Makefile to append the offset of current->cpu in CFLAGS
>   - Modified asm/smp.h to use the offset set in CFLAGS
>   - Squashed the renaming of THREAD_INFO to TASK_STACK in the preparation patch
>   - Moved the modification of current_pt_regs in the patch activating CONFIG_THREAD_INFO_IN_TASK
> 
> Changes since RFC v1:
>   - Removed the first patch which was modifying header inclusion order in timer
>   - Modified some names in asm-offsets to avoid conflicts when including asm-offsets in C files
>   - Modified asm/smp.h to avoid having to include linux/sched.h (using asm-offsets instead)
>   - Moved some changes from the activation patch to the preparation patch.
> 
> Christophe Leroy (10):
>    powerpc/irq: use memblock functions returning virtual address
>    book3s/64: avoid circular header inclusion in mmu-hash.h
>    powerpc: Only use task_struct 'cpu' field on SMP
>    powerpc: Prepare for moving thread_info into task_struct
>    powerpc: Activate CONFIG_THREAD_INFO_IN_TASK
>    powerpc: regain entire stack space
>    powerpc: 'current_set' is now a table of task_struct pointers
>    powerpc/32: Remove CURRENT_THREAD_INFO and rename TI_CPU
>    powerpc/64: Remove CURRENT_THREAD_INFO
>    powerpc: clean stack pointers naming
> 
>   arch/powerpc/Kconfig                           |   1 +
>   arch/powerpc/Makefile                          |   7 ++
>   arch/powerpc/include/asm/asm-prototypes.h      |   4 +-
>   arch/powerpc/include/asm/book3s/64/mmu-hash.h  |   2 +-
>   arch/powerpc/include/asm/exception-64s.h       |   4 +-
>   arch/powerpc/include/asm/irq.h                 |  18 ++--
>   arch/powerpc/include/asm/livepatch.h           |   6 +-
>   arch/powerpc/include/asm/processor.h           |  39 +--------
>   arch/powerpc/include/asm/ptrace.h              |   2 +-
>   arch/powerpc/include/asm/reg.h                 |   2 +-
>   arch/powerpc/include/asm/smp.h                 |  17 +++-
>   arch/powerpc/include/asm/task_size_user64.h    |  42 +++++++++
>   arch/powerpc/include/asm/thread_info.h         |  19 -----
>   arch/powerpc/kernel/asm-offsets.c              |  10 ++-
>   arch/powerpc/kernel/entry_32.S                 |  66 +++++---------
>   arch/powerpc/kernel/entry_64.S                 |  12 +--
>   arch/powerpc/kernel/epapr_hcalls.S             |   5 +-
>   arch/powerpc/kernel/exceptions-64e.S           |  13 +--
>   arch/powerpc/kernel/exceptions-64s.S           |   2 +-
>   arch/powerpc/kernel/head_32.S                  |  14 +--
>   arch/powerpc/kernel/head_40x.S                 |   4 +-
>   arch/powerpc/kernel/head_44x.S                 |   8 +-
>   arch/powerpc/kernel/head_64.S                  |   1 +
>   arch/powerpc/kernel/head_8xx.S                 |   2 +-
>   arch/powerpc/kernel/head_booke.h               |  12 +--
>   arch/powerpc/kernel/head_fsl_booke.S           |  16 ++--
>   arch/powerpc/kernel/idle_6xx.S                 |   8 +-
>   arch/powerpc/kernel/idle_book3e.S              |   2 +-
>   arch/powerpc/kernel/idle_e500.S                |   8 +-
>   arch/powerpc/kernel/idle_power4.S              |   2 +-
>   arch/powerpc/kernel/irq.c                      | 114 +++----------------------
>   arch/powerpc/kernel/kgdb.c                     |  28 ------
>   arch/powerpc/kernel/machine_kexec_64.c         |   6 +-
>   arch/powerpc/kernel/misc_32.S                  |  17 ++--
>   arch/powerpc/kernel/process.c                  |  40 ++++-----
>   arch/powerpc/kernel/setup-common.c             |   2 +-
>   arch/powerpc/kernel/setup_32.c                 |  25 +++---
>   arch/powerpc/kernel/setup_64.c                 |  51 +++--------
>   arch/powerpc/kernel/smp.c                      |  16 ++--
>   arch/powerpc/kernel/trace/ftrace_64_mprofile.S |   6 +-
>   arch/powerpc/kvm/book3s_hv_hmi.c               |   1 +
>   arch/powerpc/mm/hash_low_32.S                  |  14 ++-
>   arch/powerpc/net/bpf_jit32.h                   |   5 +-
>   arch/powerpc/sysdev/6xx-suspend.S              |   5 +-
>   arch/powerpc/xmon/xmon.c                       |   2 +-
>   45 files changed, 249 insertions(+), 431 deletions(-)
>   create mode 100644 arch/powerpc/include/asm/task_size_user64.h
> 
