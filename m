Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCJVq59vSzDq8b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 18:56:35 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0V7n1iJ138458
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 02:56:32 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28aedaeytk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 02:56:32 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 31 Jan 2017 17:56:30 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3B6BC2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 18:56:28 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0V7uKMk23462132
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 18:56:28 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0V7ttI7003711
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 18:55:55 +1100
Date: Tue, 31 Jan 2017 13:25:37 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, ananth@in.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, benh@kernel.crashing.org,
 mahesh@linux.vnet.ibm.com, mhiramat@kernel.org
Subject: Re: [PATCH V3 3/4] arch/powerpc: Implement Optprobes
References: <1482153507-17350-1-git-send-email-anju@linux.vnet.ibm.com>
 <1482153507-17350-2-git-send-email-anju@linux.vnet.ibm.com>
 <878tpswa6g.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <878tpswa6g.fsf@concordia.ellerman.id.au>
Message-Id: <20170131075536.GA3824@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/01/31 07:43AM, Michael Ellerman wrote:
> Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
> 
> > Detour buffer contains instructions to create an in memory pt_regs.
> > After the execution of the pre-handler, a call is made for instruction emulation.
> > The NIP is determined in advanced through dummy instruction emulation and a branch
> > instruction is created to the NIP at the end of the trampoline.
> >
> > Instruction slot for detour buffer is allocated from the reserved area.
> > For the time being, 64KB is reserved in memory for this purpose.
> >
> > Instructions which can be emulated using analyse_instr() are suppliants
> > for optimization. Before optimization ensure that the address range
> > between the detour buffer allocated and the instruction being probed
> > is within ± 32MB.
> >
> > Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> >  .../features/debug/optprobes/arch-support.txt      |   2 +-
> >  arch/powerpc/Kconfig                               |   1 +
> >  arch/powerpc/include/asm/kprobes.h                 |  24 +-
> >  arch/powerpc/include/asm/sstep.h                   |   1 +
> >  arch/powerpc/kernel/Makefile                       |   1 +
> >  arch/powerpc/kernel/optprobes.c                    | 331 +++++++++++++++++++++
> >  arch/powerpc/kernel/optprobes_head.S               | 135 +++++++++
> >  arch/powerpc/lib/sstep.c                           |  21 ++
> >  8 files changed, 514 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/powerpc/kernel/optprobes.c
> >  create mode 100644 arch/powerpc/kernel/optprobes_head.S
> 
> This breaks the pseries_defconfig (at least) build:
> 
>   In file included from ../include/linux/kprobes.h:45:0,
>                    from ../arch/powerpc/kernel/optprobes.c:12:
>   ../arch/powerpc/kernel/optprobes.c: In function ‘arch_prepare_optimized_kprobe’:
>   ../arch/powerpc/include/asm/kprobes.h:79:16: error: ‘MODULE_NAME_LEN’ undeclared (first use in this function)
>     char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];  \
>                   ^
>   ../arch/powerpc/kernel/optprobes.c:230:2: note: in expansion of macro ‘kprobe_lookup_name’
>     kprobe_lookup_name("optimized_callback", op_callback_addr);
>     ^~~~~~~~~~~~~~~~~~
>   ../arch/powerpc/include/asm/kprobes.h:79:16: note: each undeclared identifier is reported only once for each function it appears in
>     char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];  \
>                   ^
>   ../arch/powerpc/kernel/optprobes.c:230:2: note: in expansion of macro ‘kprobe_lookup_name’
>     kprobe_lookup_name("optimized_callback", op_callback_addr);
>     ^~~~~~~~~~~~~~~~~~
>   ../arch/powerpc/include/asm/kprobes.h:82:14: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>     if ((modsym = strchr(name, ':')) != NULL) {   \
>                 ^
>   ../arch/powerpc/kernel/optprobes.c:230:2: note: in expansion of macro ‘kprobe_lookup_name’
>     kprobe_lookup_name("optimized_callback", op_callback_addr);
>     ^~~~~~~~~~~~~~~~~~
>   ../arch/powerpc/include/asm/kprobes.h:79:7: error: unused variable ‘dot_name’ [-Werror=unused-variable]
>     char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];  \
>          ^
>   ../arch/powerpc/kernel/optprobes.c:230:2: note: in expansion of macro ‘kprobe_lookup_name’
>     kprobe_lookup_name("optimized_callback", op_callback_addr);
>     ^~~~~~~~~~~~~~~~~~
>   ../arch/powerpc/include/asm/kprobes.h:82:14: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>     if ((modsym = strchr(name, ':')) != NULL) {   \
>                 ^
>   ../arch/powerpc/kernel/optprobes.c:231:2: note: in expansion of macro ‘kprobe_lookup_name’
>     kprobe_lookup_name("emulate_step", emulate_step_addr);
>     ^~~~~~~~~~~~~~~~~~
>   ../arch/powerpc/include/asm/kprobes.h:79:7: error: unused variable ‘dot_name’ [-Werror=unused-variable]
>     char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];  \
>          ^
>   ../arch/powerpc/kernel/optprobes.c:231:2: note: in expansion of macro ‘kprobe_lookup_name’
>     kprobe_lookup_name("emulate_step", emulate_step_addr);
>     ^~~~~~~~~~~~~~~~~~
>   cc1: all warnings being treated as errors
>   make[2]: *** [arch/powerpc/kernel/optprobes.o] Error 1
>   make[2]: *** Waiting for unfinished jobs....
>   make[1]: *** [arch/powerpc/kernel] Error 2
>   make[1]: *** Waiting for unfinished jobs....
>   make: *** [sub-make] Error 2
> 
> 
> This may not be your bug, but your patch exposes it unfortunately.

Sorry for the trouble, we should have caught this.

- Naveen
