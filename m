Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHl5R6LVxzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 17:07:55 +1000 (AEST)
Message-ID: <1471849675.14506.70.camel@neuling.org>
Subject: Re: [PATCH] powerpc: signals: Discard transaction state from signal
 frames
From: Michael Neuling <mikey@neuling.org>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org
Cc: mpe@ellerman.id.au, Laurent Dufour <ldufour@linux.vnet.ibm.com>, Simon
 Guo <wei.guo.simon@gmail.com>
Date: Mon, 22 Aug 2016 17:07:55 +1000
In-Reply-To: <20160822051501.24534-1-cyrilbur@gmail.com>
References: <20160822051501.24534-1-cyrilbur@gmail.com>
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

On Mon, 2016-08-22 at 15:15 +1000, Cyril Bur wrote:
> Userspace can begin and suspend a transaction within the signal
> handler which means they might enter sys_rt_sigreturn() with the
> processor in suspended state.
>=20
> sys_rt_sigreturn() wants to restore process context (which may have
> been in a transaction before signal delivery). To do this it must
> restore TM SPRS. To achieve this, any transaction initiated within the
> signal frame must be discarded in order to be able to restore TM SPRs
> as TM SPRs can only be manipulated non-transactionally..
> >=20
> > From the PowerPC ISA:
> =C2=A0 TM Bad Thing Exception [Category: Transactional Memory]
> =C2=A0=C2=A0=C2=A0An attempt is made to execute a mtspr targeting a TM re=
gister in
> =C2=A0=C2=A0=C2=A0other than Non-transactional state.
>=20
> Not doing so results in a TM Bad Thing:
> [12045.221359] Kernel BUG at c000000000050a40 [verbose debug info unavail=
able]
> [12045.221470] Unexpected TM Bad Thing exception at c000000000050a40 (msr=
 0x201033)
> [12045.221540] Oops: Unrecoverable exception, sig: 6 [#1]
> [12045.221586] SMP NR_CPUS=3D2048 NUMA PowerNV
> [12045.221634] Modules linked in: xt_CHECKSUM iptable_mangle ipt_MASQUERA=
DE
> =C2=A0nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_=
ipv4 nf_defrag_ipv4
> =C2=A0xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp bridg=
e stp llc ebtable_filter
> =C2=A0ebtables ip6table_filter ip6_tables iptable_filter ip_tables x_tabl=
es kvm_hv kvm
> =C2=A0uio_pdrv_genirq ipmi_powernv uio powernv_rng ipmi_msghandler autofs=
4 ses enclosure
> =C2=A0scsi_transport_sas bnx2x ipr mdio libcrc32c
> [12045.222167] CPU: 68 PID: 6178 Comm: sigreturnpanic Not tainted 4.7.0 #=
34
> [12045.222224] task: c0000000fce38600 ti: c0000000fceb4000 task.ti: c0000=
000fceb4000
> [12045.222293] NIP: c000000000050a40 LR: c0000000000163bc CTR: 0000000000=
000000
> [12045.222361] REGS: c0000000fceb7ac0 TRAP: 0700=C2=A0=C2=A0=C2=A0Not tai=
nted (4.7.0)
> [12045.222418] MSR: 9000000300201033  CR: 28444280=C2=A0=C2=A0XER: 200000=
00
> [12045.222625] CFAR: c0000000000163b8 SOFTE: 0 PACATMSCRATCH: 90000001428=
0f033
> GPR00: 01100000b8000001 c0000000fceb7d40 c00000000139c100 c0000000fce390d=
0
> GPR04: 900000034280f033 0000000000000000 0000000000000000 000000000000000=
0
> GPR08: 0000000000000000 b000000000001033 0000000000000001 000000000000000=
0
> GPR12: 0000000000000000 c000000002926400 0000000000000000 000000000000000=
0
> GPR16: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0
> GPR20: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0
> GPR24: 0000000000000000 00003ffff98cadd0 00003ffff98cb470 000000000000000=
0
> GPR28: 900000034280f033 c0000000fceb7ea0 0000000000000001 c0000000fce390d=
0
> [12045.223535] NIP [c000000000050a40] tm_restore_sprs+0xc/0x1c
> [12045.223584] LR [c0000000000163bc] tm_recheckpoint+0x5c/0xa0
> [12045.223630] Call Trace:
> [12045.223655] [c0000000fceb7d80] [c000000000026e74] sys_rt_sigreturn+0x4=
94/0x6c0
> [12045.223738] [c0000000fceb7e30] [c0000000000092e0] system_call+0x38/0x1=
08
> [12045.223806] Instruction dump:
> [12045.223841] 7c800164 4e800020 7c0022a6 f80304a8 7c0222a6 f80304b0 7c01=
22a6 f80304b8
> [12045.223955] 4e800020 e80304a8 7c0023a6 e80304b0 <7c0223a6> e80304b8 7c=
0123a6 4e800020
> [12045.224074] ---[ end trace cb8002ee240bae76 ]---
>=20
> It isn't clear exactly if there is really a use case for userspace
> returning with a suspended transaction, however, doing so doesn't
> (on its own) constitute a bad frame. As such, this patch simply
> discards the transaction state and continues.

To clarify which tm context you're talking about can we change this to.

    ... discards the transactional state of the context calling the sig
    return and continues.

Also, anyone wanna write a selftest and update
Documentation/powerpc/transactional_memory.txt?

Couple of comments below.


>=20
> Reported-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
> =C2=A0arch/powerpc/kernel/signal_32.c | 13 +++++++++++++
> =C2=A0arch/powerpc/kernel/signal_64.c | 12 ++++++++++++
> =C2=A02 files changed, 25 insertions(+)
>=20
> diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal=
_32.c
> index b6aa378..f892b93 100644
> --- a/arch/powerpc/kernel/signal_32.c
> +++ b/arch/powerpc/kernel/signal_32.c
> @@ -1219,6 +1219,19 @@ long sys_rt_sigreturn(int r3, int r4, int r5, int =
r6, int r7, int r8,
> =C2=A0	unsigned long tmp;
> =C2=A0	int tm_restore =3D 0;
> =C2=A0#endif
> +
> +	/*
> +	=C2=A0* We always send the user to their signal handler non
> +	=C2=A0* transactionally.=20

This first sentence is not relevant IMHO. Same for 64bit.

> If there is a transactional/suspended state
> +	=C2=A0* then throw it away. The purpose of a sigreturn is to destroy
> +	=C2=A0* all traces of the signal frame, this includes any transactional
> +	=C2=A0* state created within in.
> +	=C2=A0* The cause is not important as there will never be a
> +	=C2=A0* recheckpoint so it's not user visible.
> +	=C2=A0*/
> +	if (MSR_TM_ACTIVE(mfmsr()))
> +		tm_reclaim_current(0);

I think this needs to be inside #ifdef CONFIG_PPC_TRANSACTIONAL_MEM. =C2=A0=
Just
move it down a bit. =C2=A0Same for 64bit.

> +
> =C2=A0	/* Always make any pending restarted system calls return -EINTR */
> =C2=A0	current->restart_block.fn =3D do_no_restart_syscall;
> =C2=A0
> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal=
_64.c
> index 7e49984..5cbfe03d 100644
> --- a/arch/powerpc/kernel/signal_64.c
> +++ b/arch/powerpc/kernel/signal_64.c
> @@ -667,6 +667,18 @@ int sys_rt_sigreturn(unsigned long r3, unsigned long=
 r4, unsigned long r5,
> =C2=A0	unsigned long msr;
> =C2=A0#endif
> =C2=A0
> +	/*
> +	=C2=A0* We always send the user to their signal handler non
> +	=C2=A0* transactionally. If there is a transactional/suspended state
> +	=C2=A0* then throw it away. The purpose of a sigreturn is to destroy
> +	=C2=A0* all traces of the signal frame, this includes any transactional
> +	=C2=A0* state created within in.
> +	=C2=A0* The cause is not important as there will never be a
> +	=C2=A0* recheckpoint so it's not user visible.
> +	=C2=A0*/
> +	if (MSR_TM_ACTIVE(mfmsr()))
> +		tm_reclaim_current(0);
> +
> =C2=A0	/* Always make any pending restarted system calls return -EINTR */
> =C2=A0	current->restart_block.fn =3D do_no_restart_syscall;
> =C2=A0
