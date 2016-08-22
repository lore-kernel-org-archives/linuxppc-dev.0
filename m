Return-Path: <cyrilbur@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHlQv1jcfzDrd5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 17:23:03 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id g202so5822894pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 00:23:03 -0700 (PDT)
Message-ID: <1471850575.31624.0.camel@gmail.com>
Subject: Re: [PATCH] powerpc: signals: Discard transaction state from signal
 frames
From: Cyril Bur <cyrilbur@gmail.com>
To: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org
Cc: mpe@ellerman.id.au, Laurent Dufour <ldufour@linux.vnet.ibm.com>, Simon
 Guo <wei.guo.simon@gmail.com>
Date: Mon, 22 Aug 2016 17:22:55 +1000
In-Reply-To: <1471849675.14506.70.camel@neuling.org>
References: <20160822051501.24534-1-cyrilbur@gmail.com>
 <1471849675.14506.70.camel@neuling.org>
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

On Mon, 2016-08-22 at 17:07 +1000, Michael Neuling wrote:
> On Mon, 2016-08-22 at 15:15 +1000, Cyril Bur wrote:
> > 
> > Userspace can begin and suspend a transaction within the signal
> > handler which means they might enter sys_rt_sigreturn() with the
> > processor in suspended state.
> > 
> > sys_rt_sigreturn() wants to restore process context (which may have
> > been in a transaction before signal delivery). To do this it must
> > restore TM SPRS. To achieve this, any transaction initiated within
> > the
> > signal frame must be discarded in order to be able to restore TM
> > SPRs
> > as TM SPRs can only be manipulated non-transactionally..
> > > 
> > > 
> > > From the PowerPC ISA:
> >   TM Bad Thing Exception [Category: Transactional Memory]
> >    An attempt is made to execute a mtspr targeting a TM register in
> >    other than Non-transactional state.
> > 
> > Not doing so results in a TM Bad Thing:
> > [12045.221359] Kernel BUG at c000000000050a40 [verbose debug info
> > unavailable]
> > [12045.221470] Unexpected TM Bad Thing exception at
> > c000000000050a40 (msr 0x201033)
> > [12045.221540] Oops: Unrecoverable exception, sig: 6 [#1]
> > [12045.221586] SMP NR_CPUS=2048 NUMA PowerNV
> > [12045.221634] Modules linked in: xt_CHECKSUM iptable_mangle
> > ipt_MASQUERADE
> >  nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat
> > nf_conntrack_ipv4 nf_defrag_ipv4
> >  xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp
> > bridge stp llc ebtable_filter
> >  ebtables ip6table_filter ip6_tables iptable_filter ip_tables
> > x_tables kvm_hv kvm
> >  uio_pdrv_genirq ipmi_powernv uio powernv_rng ipmi_msghandler
> > autofs4 ses enclosure
> >  scsi_transport_sas bnx2x ipr mdio libcrc32c
> > [12045.222167] CPU: 68 PID: 6178 Comm: sigreturnpanic Not tainted
> > 4.7.0 #34
> > [12045.222224] task: c0000000fce38600 ti: c0000000fceb4000 task.ti:
> > c0000000fceb4000
> > [12045.222293] NIP: c000000000050a40 LR: c0000000000163bc CTR:
> > 0000000000000000
> > [12045.222361] REGS: c0000000fceb7ac0 TRAP: 0700   Not tainted
> > (4.7.0)
> > [12045.222418] MSR: 9000000300201033  CR: 28444280  XER: 20000000
> > [12045.222625] CFAR: c0000000000163b8 SOFTE: 0 PACATMSCRATCH:
> > 900000014280f033
> > GPR00: 01100000b8000001 c0000000fceb7d40 c00000000139c100
> > c0000000fce390d0
> > GPR04: 900000034280f033 0000000000000000 0000000000000000
> > 0000000000000000
> > GPR08: 0000000000000000 b000000000001033 0000000000000001
> > 0000000000000000
> > GPR12: 0000000000000000 c000000002926400 0000000000000000
> > 0000000000000000
> > GPR16: 0000000000000000 0000000000000000 0000000000000000
> > 0000000000000000
> > GPR20: 0000000000000000 0000000000000000 0000000000000000
> > 0000000000000000
> > GPR24: 0000000000000000 00003ffff98cadd0 00003ffff98cb470
> > 0000000000000000
> > GPR28: 900000034280f033 c0000000fceb7ea0 0000000000000001
> > c0000000fce390d0
> > [12045.223535] NIP [c000000000050a40] tm_restore_sprs+0xc/0x1c
> > [12045.223584] LR [c0000000000163bc] tm_recheckpoint+0x5c/0xa0
> > [12045.223630] Call Trace:
> > [12045.223655] [c0000000fceb7d80] [c000000000026e74]
> > sys_rt_sigreturn+0x494/0x6c0
> > [12045.223738] [c0000000fceb7e30] [c0000000000092e0]
> > system_call+0x38/0x108
> > [12045.223806] Instruction dump:
> > [12045.223841] 7c800164 4e800020 7c0022a6 f80304a8 7c0222a6
> > f80304b0 7c0122a6 f80304b8
> > [12045.223955] 4e800020 e80304a8 7c0023a6 e80304b0 <7c0223a6>
> > e80304b8 7c0123a6 4e800020
> > [12045.224074] ---[ end trace cb8002ee240bae76 ]---
> > 
> > It isn't clear exactly if there is really a use case for userspace
> > returning with a suspended transaction, however, doing so doesn't
> > (on its own) constitute a bad frame. As such, this patch simply
> > discards the transaction state and continues.
> 
> To clarify which tm context you're talking about can we change this
> to.
> 
>     ... discards the transactional state of the context calling the
> sig
>     return and continues.
> 
> Also, anyone wanna write a selftest and update
> Documentation/powerpc/transactional_memory.txt?
> 

I'll add something simple but I feel like we do need to be quite clear
about this behaviour.

> Couple of comments below.
> 
> 
> > 
> > 
> > Reported-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> > Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> > ---
> >  arch/powerpc/kernel/signal_32.c | 13 +++++++++++++
> >  arch/powerpc/kernel/signal_64.c | 12 ++++++++++++
> >  2 files changed, 25 insertions(+)
> > 
> > diff --git a/arch/powerpc/kernel/signal_32.c
> > b/arch/powerpc/kernel/signal_32.c
> > index b6aa378..f892b93 100644
> > --- a/arch/powerpc/kernel/signal_32.c
> > +++ b/arch/powerpc/kernel/signal_32.c
> > @@ -1219,6 +1219,19 @@ long sys_rt_sigreturn(int r3, int r4, int
> > r5, int r6, int r7, int r8,
> >  	unsigned long tmp;
> >  	int tm_restore = 0;
> >  #endif
> > +
> > +	/*
> > +	 * We always send the user to their signal handler non
> > +	 * transactionally. 
> 
> This first sentence is not relevant IMHO. Same for 64bit.
> 

Yeah, I'll remove

> > 
> > If there is a transactional/suspended state
> > +	 * then throw it away. The purpose of a sigreturn is to
> > destroy
> > +	 * all traces of the signal frame, this includes any
> > transactional
> > +	 * state created within in.
> > +	 * The cause is not important as there will never be a
> > +	 * recheckpoint so it's not user visible.
> > +	 */
> > +	if (MSR_TM_ACTIVE(mfmsr()))
> > +		tm_reclaim_current(0);
> 
> I think this needs to be inside #ifdef CONFIG_PPC_TRANSACTIONAL_MEM. 

Probably, gets me every time *sigh*

>  Just
> move it down a bit.  Same for 64bit.
> 

I was probably being paranoid about doing it early enough before we get
into the meat of sigreturning but defs fine at the start of the #ifdef,
you're right.

> > 
> > +
> >  	/* Always make any pending restarted system calls return
> > -EINTR */
> >  	current->restart_block.fn = do_no_restart_syscall;
> >  
> > diff --git a/arch/powerpc/kernel/signal_64.c
> > b/arch/powerpc/kernel/signal_64.c
> > index 7e49984..5cbfe03d 100644
> > --- a/arch/powerpc/kernel/signal_64.c
> > +++ b/arch/powerpc/kernel/signal_64.c
> > @@ -667,6 +667,18 @@ int sys_rt_sigreturn(unsigned long r3,
> > unsigned long r4, unsigned long r5,
> >  	unsigned long msr;
> >  #endif
> >  
> > +	/*
> > +	 * We always send the user to their signal handler non
> > +	 * transactionally. If there is a transactional/suspended
> > state
> > +	 * then throw it away. The purpose of a sigreturn is to
> > destroy
> > +	 * all traces of the signal frame, this includes any
> > transactional
> > +	 * state created within in.
> > +	 * The cause is not important as there will never be a
> > +	 * recheckpoint so it's not user visible.
> > +	 */
> > +	if (MSR_TM_ACTIVE(mfmsr()))
> > +		tm_reclaim_current(0);
> > +
> >  	/* Always make any pending restarted system calls return
> > -EINTR */
> >  	current->restart_block.fn = do_no_restart_syscall;
> >  
