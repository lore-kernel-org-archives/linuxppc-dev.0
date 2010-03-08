Return-Path: <heiko.carstens@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.17.164])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 24A49B7CEF
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Mar 2010 21:11:47 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.1/8.13.1) with ESMTP id o28ABfVJ005780
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Mar 2010 10:11:41 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id o28ABfod1720330
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Mar 2010 11:11:41 +0100
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id o28ABeRR006827
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Mar 2010 11:11:41 +0100
Date: Mon, 8 Mar 2010 11:11:52 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Sachin Sant <sachinp@in.ibm.com>
Subject: Re: [PowerPC] 2.6.33-git11 : Badness at kernel/kprobes.c:264
Message-ID: <20100308101152.GA2557@osiris.boeblingen.de.ibm.com>
References: <4B920E06.4060508@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4B920E06.4060508@in.ibm.com>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, mhiramat@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 06, 2010 at 01:40:46PM +0530, Sachin Sant wrote:
> With latest 33 git(2.6.33-git11 : 64096c1741...) on a POWER6 box
> 
> type=2000 audit(1267853400.180:1): initialized
> Kprobe smoke test started
> ------------[ cut here ]------------
> Badness at kernel/kprobes.c:264
> NIP: c0000000006251e0 LR: c000000000625190 CTR: c00000000007914c
> REGS: c0000000fecc3680 TRAP: 0700   Not tainted  (2.6.33-git11-autotest)
> MSR: 8000000000029032 <EE,ME,CE,IR,DR>  CR: 24000048  XER: 2000000b
> TASK = c0000000feca0000[1] 'swapper' THREAD: c0000000fecc0000 CPU: 2
> GPR00: 0000000000000001 c0000000fecc3900 c000000000b297b0 c0000000fc680000
> GPR04: 0000000000000004 0000000000000000 0000000024022024 c000000000a2b9d0
> GPR08: 0000000000004000 c0000000fc680004 0000000000010000 0000000000000004
> GPR12: 0000000022000024 c000000000bc2b00 0000000000051bc3 0000000000051aa1
> GPR16: 0000000000051bbb 0000000000d00000 c0000000008011f8 c0000000007f1ba1
> GPR20: 00000000015e87a8 c0000000008e87a8 c0000000fecc3cc8 c0000000fecc3cd0
> GPR24: c0000000fecc3cd8 c0000000fecc3cc0 c0000000fecc3be0 0000000000000000
> GPR28: 0000000000000000 c000000000a2b8b8 c000000000a94888 d000000000bd0004
> NIP [c0000000006251e0] .free_insn_slot+0x84/0x12c
> LR [c000000000625190] .free_insn_slot+0x34/0x12c
> Call Trace:
> [c0000000fecc3900] [c000000000625190] .free_insn_slot+0x34/0x12c (unreliable)
> [c0000000fecc3990] [c000000000622050] .arch_remove_kprobe+0x28/0x48
> [c0000000fecc3a10] [c000000000623f58] .__unregister_kprobe_bottom+0x28/0x8c
> [c0000000fecc3aa0] [c00000000062419c] .unregister_kprobes+0xc0/0xf0
> [c0000000fecc3b40] [c0000000006241ec] .unregister_kprobe+0x20/0x30
> [c0000000fecc3bb0] [c0000000000e081c] .init_test_probes+0xc4/0x66c
> [c0000000fecc3c50] [c0000000008c288c] .init_kprobes+0x1f0/0x230
> [c0000000fecc3e30] [c0000000000097a4] .do_one_initcall+0x88/0x1bc
> [c0000000fecc3ee0] [c0000000008a0490] .kernel_init+0x220/0x2dc
> [c0000000fecc3f90] [c00000000002c4d0] .kernel_thread+0x54/0x70
> Instruction dump:
> 7c00f850 7c804b92 2fa40000 419c007c 7d0a5b92 7fa44000 409c0070 7d232214
> 88090020 68000002 7c0000d0 78000fe0 <0b000000> 2fbc0000 419e0044 8123001c
> 
> 2.6.33-git10(64ba99267...) was OK.
> 
> This WARN_ON was introduced by commit 4610ee1d36...
> 
> kprobes: Introduce generic insn_slot framework

FWIW, same on s390...
