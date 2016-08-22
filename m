Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHcRc5cJdzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 12:08:12 +1000 (AEST)
Message-ID: <1471831692.14506.35.camel@neuling.org>
Subject: Re: TM Bad Thing exception easily raised from userspace
From: Michael Neuling <mikey@neuling.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Cyril Bur <cyril.bur@au1.ibm.com>, benh <benh@kernel.crashing.org>
Cc: Simon Guo <wei.guo.simon@gmail.com>
Date: Mon, 22 Aug 2016 12:08:12 +1000
In-Reply-To: <fb29f778-75c5-088c-fe40-e03d95b901e0@linux.vnet.ibm.com>
References: <fb29f778-75c5-088c-fe40-e03d95b901e0@linux.vnet.ibm.com>
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

On Fri, 2016-08-19 at 19:21 +0200, Laurent Dufour wrote:
> Hi,
>=20
> While working on the TM support for CRIU, I faced a TM Bad Thing exceptio=
n.
>=20
> Digging further, I found that it is *easy* to raised it from the user
> space. I attached below a simple program which raise it all the time,
> like this :
>=20
> [12045.221359] Kernel BUG at c000000000050a40 [verbose debug info
> unavailable]
> [12045.221470] Unexpected TM Bad Thing exception at c000000000050a40
> (msr 0x201033)
> [12045.221540] Oops: Unrecoverable exception, sig: 6 [#1]
> [12045.221586] SMP NR_CPUS=3D2048 NUMA PowerNV
> [12045.221634] Modules linked in: xt_CHECKSUM iptable_mangle
> ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat
> nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT
> nf_reject_ipv4 xt_tcpudp bridge stp llc ebtable_filter ebtables
> ip6table_filter ip6_tables iptable_filter ip_tables x_tables kvm_hv kvm
> uio_pdrv_genirq ipmi_powernv uio powernv_rng ipmi_msghandler autofs4 ses
> enclosure scsi_transport_sas bnx2x ipr mdio libcrc32c
> [12045.222167] CPU: 68 PID: 6178 Comm: sigreturnpanic Not tainted 4.7.0 #=
34
> [12045.222224] task: c0000000fce38600 ti: c0000000fceb4000 task.ti:
> c0000000fceb4000
> [12045.222293] NIP: c000000000050a40 LR: c0000000000163bc CTR:
> 0000000000000000
> [12045.222361] REGS: c0000000fceb7ac0 TRAP: 0700=C2=A0=C2=A0=C2=A0Not tai=
nted=C2=A0=C2=A0(4.7.0)
> [12045.222418] MSR: 9000000300201033 =C2=A0=C2=A0CR:
> 28444280=C2=A0=C2=A0XER: 20000000
> [12045.222625] CFAR: c0000000000163b8 SOFTE: 0
> PACATMSCRATCH: 900000014280f033
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
> [12045.223655] [c0000000fceb7d80] [c000000000026e74]
> sys_rt_sigreturn+0x494/0x6c0
> [12045.223738] [c0000000fceb7e30] [c0000000000092e0] system_call+0x38/0x1=
08
> [12045.223806] Instruction dump:
> [12045.223841] 7c800164 4e800020 7c0022a6 f80304a8 7c0222a6 f80304b0
> 7c0122a6 f80304b8
> [12045.223955] 4e800020 e80304a8 7c0023a6 e80304b0 <7c0223a6> e80304b8
> 7c0123a6 4e800020
> [12045.224074] ---[ end trace cb8002ee240bae76 ]-
> --

Nice find and bug report!

It looks like we are doing a signal return in suspend mode to a
transaction. This is causing the kernel signal code to write the TEXASR
register while transactional, which will cause the TM bad thing.

We need to fix the signal code (64 and 32 bit) so that it checks the the
transactional state when the sig return was called and clear out that state
so we are non transactional again. =C2=A0We don't need to save the state wh=
en
the sig return was called.

Talking to benh and cyril offline, we are going to continue with this
signal return, provided the signal frame is valid. So a sig return will
work irrespective of the suspend state (active state will not work as the
syscall won't be executed). We won't cause a bad frame just because the sig
return was called while suspended.

Mikey

>=20
> The exception is raised when the kernel is restoring the TM SPRS from
> the signal stack. But this operation is not allowed while in a transactio=
n.
>=20
> The sampler test is ending the signal handler with a pending transaction
> while the signal got caught during a transaction itself.
>=20
> I can't see any straight way to get rid of that, except by clearing the
> transactional state in the path of sigreturn....
>=20
> Please advise.
>=20
> Cheers,
> Laurent.
