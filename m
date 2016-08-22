Return-Path: <cyrilbur@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHlj128lxzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 17:35:17 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id cf3so7560918pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 00:35:17 -0700 (PDT)
Message-ID: <1471851310.31624.1.camel@gmail.com>
Subject: Re: [PATCH] powerpc: signals: Discard transaction state from signal
 frames
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org
Cc: mikey@neuling.org, Laurent Dufour <ldufour@linux.vnet.ibm.com>, Simon
 Guo <wei.guo.simon@gmail.com>
Date: Mon, 22 Aug 2016 17:35:10 +1000
In-Reply-To: <20160822073206.1342-1-cyrilbur@gmail.com>
References: <20160822073206.1342-1-cyrilbur@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-08-22 at 17:32 +1000, Cyril Bur wrote:

The subject prefix should have contained V2. Sorry.

> Userspace can begin and suspend a transaction within the signal
> handler which means they might enter sys_rt_sigreturn() with the
> processor in suspended state.
> 
> sys_rt_sigreturn() wants to restore process context (which may have
> been in a transaction before signal delivery). To do this it must
> restore TM SPRS. To achieve this, any transaction initiated within
> the
> signal frame must be discarded in order to be able to restore TM SPRs
> as TM SPRs can only be manipulated non-transactionally..
> From the PowerPC ISA:
>   TM Bad Thing Exception [Category: Transactional Memory]
>    An attempt is made to execute a mtspr targeting a TM register in
>    other than Non-transactional state.
> 
> Not doing so results in a TM Bad Thing:
> [12045.221359] Kernel BUG at c000000000050a40 [verbose debug info
> unavailable]
> [12045.221470] Unexpected TM Bad Thing exception at c000000000050a40
> (msr 0x201033)
> [12045.221540] Oops: Unrecoverable exception, sig: 6 [#1]
> [12045.221586] SMP NR_CPUS=2048 NUMA PowerNV
> [12045.221634] Modules linked in: xt_CHECKSUM iptable_mangle
> ipt_MASQUERADE
>  nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat
> nf_conntrack_ipv4 nf_defrag_ipv4
>  xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp bridge
> stp llc ebtable_filter
>  ebtables ip6table_filter ip6_tables iptable_filter ip_tables
> x_tables kvm_hv kvm
>  uio_pdrv_genirq ipmi_powernv uio powernv_rng ipmi_msghandler autofs4
> ses enclosure
>  scsi_transport_sas bnx2x ipr mdio libcrc32c
> [12045.222167] CPU: 68 PID: 6178 Comm: sigreturnpanic Not tainted
> 4.7.0 #34
> [12045.222224] task: c0000000fce38600 ti: c0000000fceb4000 task.ti:
> c0000000fceb4000
> [12045.222293] NIP: c000000000050a40 LR: c0000000000163bc CTR:
> 0000000000000000
> [12045.222361] REGS: c0000000fceb7ac0 TRAP: 0700   Not tainted
> (4.7.0)
> [12045.222418] MSR: 9000000300201033 <SF,HV,ME,IR,DR,RI,LE,TM[SE]>
> CR: 28444280  XER: 20000000
> [12045.222625] CFAR: c0000000000163b8 SOFTE: 0 PACATMSCRATCH:
> 900000014280f033
> GPR00: 01100000b8000001 c0000000fceb7d40 c00000000139c100
> c0000000fce390d0
> GPR04: 900000034280f033 0000000000000000 0000000000000000
> 0000000000000000
> GPR08: 0000000000000000 b000000000001033 0000000000000001
> 0000000000000000
> GPR12: 0000000000000000 c000000002926400 0000000000000000
> 0000000000000000
> GPR16: 0000000000000000 0000000000000000 0000000000000000
> 0000000000000000
> GPR20: 0000000000000000 0000000000000000 0000000000000000
> 0000000000000000
> GPR24: 0000000000000000 00003ffff98cadd0 00003ffff98cb470
> 0000000000000000
> GPR28: 900000034280f033 c0000000fceb7ea0 0000000000000001
> c0000000fce390d0
> [12045.223535] NIP [c000000000050a40] tm_restore_sprs+0xc/0x1c
> [12045.223584] LR [c0000000000163bc] tm_recheckpoint+0x5c/0xa0
> [12045.223630] Call Trace:
> [12045.223655] [c0000000fceb7d80] [c000000000026e74]
> sys_rt_sigreturn+0x494/0x6c0
> [12045.223738] [c0000000fceb7e30] [c0000000000092e0]
> system_call+0x38/0x108
> [12045.223806] Instruction dump:
> [12045.223841] 7c800164 4e800020 7c0022a6 f80304a8 7c0222a6 f80304b0
> 7c0122a6 f80304b8
> [12045.223955] 4e800020 e80304a8 7c0023a6 e80304b0 <7c0223a6>
> e80304b8 7c0123a6 4e800020
> [12045.224074] ---[ end trace cb8002ee240bae76 ]---
> 
> It isn't clear exactly if there is really a use case for userspace
> returning with a suspended transaction, however, doing so doesn't (on
> its own) constitute a bad frame. As such, this patch simply discards
> the transactional state of the context calling the sigreturn and
> continues.
> 
> Reported-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
> V2: Move the code down into the #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> (32 and 64 bit)
> 	Add a small amount of text to Documentation
> 	Adjust the commit message for clarity 
> 
>  Documentation/powerpc/transactional_memory.txt |  2 ++
>  arch/powerpc/kernel/signal_32.c                | 12 ++++++++++++
>  arch/powerpc/kernel/signal_64.c                | 12 ++++++++++++
>  3 files changed, 26 insertions(+)
> 
> diff --git a/Documentation/powerpc/transactional_memory.txt
> b/Documentation/powerpc/transactional_memory.txt
> index ba0a2a4..e32fdbb 100644
> --- a/Documentation/powerpc/transactional_memory.txt
> +++ b/Documentation/powerpc/transactional_memory.txt
> @@ -167,6 +167,8 @@ signal will be rolled back anyway.
>  For signals taken in non-TM or suspended mode, we use the
>  normal/non-checkpointed stack pointer.
>  
> +Any transaction initiated inside a sighandler and suspended on
> return
> +from the sighandler to the kernel will get reclaimed and discarded.
>  
>  Failure cause codes used by kernel
>  ==================================
> diff --git a/arch/powerpc/kernel/signal_32.c
> b/arch/powerpc/kernel/signal_32.c
> index b6aa378..31e4e15 100644
> --- a/arch/powerpc/kernel/signal_32.c
> +++ b/arch/powerpc/kernel/signal_32.c
> @@ -1226,7 +1226,19 @@ long sys_rt_sigreturn(int r3, int r4, int r5,
> int r6, int r7, int r8,
>  		(regs->gpr[1] + __SIGNAL_FRAMESIZE + 16);
>  	if (!access_ok(VERIFY_READ, rt_sf, sizeof(*rt_sf)))
>  		goto bad;
> +
>  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +	/*
> +	 * If there is a transactional/suspended state then throw it
> away.
> +	 * The purpose of a sigreturn is to destroy all traces of
> the
> +	 * signal frame, this includes any transactional state
> created
> +	 * within in.
> +	 * The cause is not important as there will never be a
> +	 * recheckpoint so it's not user visible.
> +	 */
> +	if (MSR_TM_ACTIVE(mfmsr()))
> +		tm_reclaim_current(0);
> +
>  	if (__get_user(tmp, &rt_sf->uc.uc_link))
>  		goto bad;
>  	uc_transact = (struct ucontext __user *)(uintptr_t)tmp;
> diff --git a/arch/powerpc/kernel/signal_64.c
> b/arch/powerpc/kernel/signal_64.c
> index 7e49984..8425eee 100644
> --- a/arch/powerpc/kernel/signal_64.c
> +++ b/arch/powerpc/kernel/signal_64.c
> @@ -676,7 +676,19 @@ int sys_rt_sigreturn(unsigned long r3, unsigned
> long r4, unsigned long r5,
>  	if (__copy_from_user(&set, &uc->uc_sigmask, sizeof(set)))
>  		goto badframe;
>  	set_current_blocked(&set);
> +
>  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +	/*
> +	 * If there is a transactional/suspended state then throw it
> away.
> +	 * The purpose of a sigreturn is to destroy all traces of
> the
> +	 * signal frame, this includes any transactional state
> created
> +	 * within in.
> +	 * The cause is not important as there will never be a
> +	 * recheckpoint so it's not user visible.
> +	 */
> +	if (MSR_TM_ACTIVE(mfmsr()))
> +		tm_reclaim_current(0);
> +
>  	if (__get_user(msr, &uc->uc_mcontext.gp_regs[PT_MSR]))
>  		goto badframe;
>  	if (MSR_TM_ACTIVE(msr)) {
