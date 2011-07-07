Return-Path: <a.p.zijlstra@chello.nl>
Received: from casper.infradead.org (casper.infradead.org
	[IPv6:2001:770:15f::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7DE2FB6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Jul 2011 20:59:56 +1000 (EST)
Subject: Re: [regression] 3.0-rc boot failure -- bisected to cd4ea6ae3982
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: mahesh@linux.vnet.ibm.com
In-Reply-To: <20110707102107.GA16666@in.ibm.com>
References: <20110707102107.GA16666@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 07 Jul 2011 12:59:35 +0200
Message-ID: <1310036375.3282.509.camel@twins>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	anton@samba.org, mingo@elte.hu, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-07-07 at 15:52 +0530, Mahesh J Salgaonkar wrote:
>=20
> 2.6.39 booted fine on the system and a git bisect shows commit cd4ea6ae -
> "sched: Change NODE sched_domain group creation" as the cause.

Weird, there's no locking anywhere around there. The typical problems
with this patch-set were massive explosions due to bad pointers etc..
But not silent hangs.

The code its stuck at:

> [1]:
> POWER7 performance monitor hardware support registered
> Brought up 896 CPUs
> Enabling Asymmetric SMT scheduling
> BUG: soft lockup - CPU#0 stuck for 22s! [swapper:1]
> Modules linked in:
> NIP: c000000000074b90 LR: c00000000008a1c4 CTR: 0000000000000000
> REGS: c000000fae25f9c0 TRAP: 0901   Not tainted  (3.0.0-rc6)
> MSR: 8000000000009032 <EE,ME,IR,DR>  CR: 24000088  XER: 00000004
> TASK =3D c000000fae248490[1] 'swapper' THREAD: c000000fae25c000 CPU: 0
> GPR00: 0000e2a55cbeec50 c000000fae25fc40 c000000000e21f90 c000007b2b34cb0=
0
> GPR04: 0000000000000100 0000000000000100 c000011adcf23418 000000000000000=
0
> GPR08: 0000000000000000 c000008b2b7d4480 c000007b2b35ef80 00000000000024a=
c
> GPR12: 0000000044000042 c00000000ebb0000
> NIP [c000000000074b90] .update_group_power+0x50/0x190
> LR [c00000000008a1c4] .build_sched_domains+0x434/0x490
> Call Trace:
> [c000000fae25fc40] [c000000fae25fce0] 0xc000000fae25fce0 (unreliable)
> [c000000fae25fce0] [c00000000008a1c4] .build_sched_domains+0x434/0x490
> [c000000fae25fdd0] [c000000000867370] .sched_init_smp+0xa8/0x224
> [c000000fae25fee0] [c000000000850274] .kernel_init+0x10c/0x1fc
> [c000000fae25ff90] [c000000000023884] .kernel_thread+0x54/0x70
> Instruction dump:
> f821ff61 ebc2b1a0 7c7f1b78 7c9c2378 e9230008 eba30010 2fa90000 419e0054
> e9490010 38000000 7d495378 60000000 <8169000c> e9290000 7faa4800 7c005a14

doesn't contains any locks, its simply looping over all the cpus, and
with that many I can imagine it takes a while, but getting 'stuck' there
is unexpected to say the least.

Surely this isn't the first multi-node P7 to boot a kernel with this
patch? If my git foo is any good it hit -next on 23rd of May.

I guess I'm asking is, do smaller P7 machines boot? And if so, is there
any difference except size?

How many nodes does the thing have anyway, 28? Hmm, that could mean its
the first machine with >16 nodes to boot this, which would make it
trigger the magic ALL_NODES crap.

Let me dig around there.
