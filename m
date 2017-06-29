Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wywjV4jPhzDr4R
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 20:23:26 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id j186so11411600pge.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 03:23:26 -0700 (PDT)
Date: Thu, 29 Jun 2017 20:23:05 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-next
 <linux-next@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-kernel <linux-kernel@vger.kernel.org>, sachinp
 <sachinp@linux.vnet.ibm.com>, mpe <mpe@ellerman.id.au>, paulus@samba.org,
 Paul McKenney <Paul.McKenney@us.ibm.com>
Subject: Re: [linux-next] cpus stalls detected few hours after booting next
 kernel
Message-ID: <20170629202305.6187367f@roar.ozlabs.ibm.com>
In-Reply-To: <20170629193614.376e27e6@roar.ozlabs.ibm.com>
References: <1498728106.19484.21.camel@abdul>
 <20170629193614.376e27e6@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 29 Jun 2017 19:36:14 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> I've seen this as well (or something like it) in mambo at boot, but
> it's pretty rare to hit. I'm trying to debug it.
> 
> I'm guessing possibly an idle vs interrupt race.
> 
> > [ 4255.151192] Sending NMI from CPU 5 to CPUs 0:
> > [ 4255.151246] NMI backtrace for cpu 0
> > [ 4255.151287] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.12.0-rc7-next-20170628 #2
> > [ 4255.151363] task: c0000007f8495600 task.stack: c0000007f842c000
> > [ 4255.151428] NIP: c00000000000adb4 LR: c000000000015584 CTR: c00000000082f4b0
> > [ 4255.151504] REGS: c0000007f842fb60 TRAP: 0e81   Not tainted  (4.12.0-rc7-next-20170628)
> > [ 4255.151578] MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>
> > [ 4255.151586]   CR: 22004884  XER: 00000000
> > [ 4255.151675] CFAR: c00000000062c108 SOFTE: 1 
> > [ 4255.151675] GPR00: c00000000082d6c8 c0000007f842fde0 c000000001062b00 0000000028000000 
> > [ 4255.151675] GPR04: 0000000000000003 c000000000089830 00003aa8056bc35f 0000000000000001 
> > [ 4255.151675] GPR08: 0000000000000002 c000000000d52d80 00000007fe7d0000 9000000000001003 
> > [ 4255.151675] GPR12: c00000000082a0c0 c00000000fd40000 
> > [ 4255.152217] NIP [c00000000000adb4] .L__replay_interrupt_return+0x0/0x4
> > [ 4255.152334] LR [c000000000015584] arch_local_irq_restore+0x74/0x90
> > [ 4255.152447] Call Trace:
> > [ 4255.152499] [c0000007f842fde0] [c00000000017cec0] tick_broadcast_oneshot_control+0x40/0x60 (unreliable)
> > [ 4255.152662] [c0000007f842fe00] [c00000000082d6c8] cpuidle_enter_state+0x108/0x3d0
> > [ 4255.152803] [c0000007f842fe60] [c000000000133e94] call_cpuidle+0x44/0x80
> > [ 4255.152921] [c0000007f842fe80] [c000000000134240] do_idle+0x290/0x2f0
> > [ 4255.153037] [c0000007f842fef0] [c000000000134474] cpu_startup_entry+0x34/0x40
> > [ 4255.153176] [c0000007f842ff20] [c000000000041944] start_secondary+0x304/0x360
> > [ 4255.153316] [c0000007f842ff90] [c00000000000b16c] start_secondary_prolog+0x10/0x14
> > [ 4255.153455] Instruction dump:
> > [ 4255.153527] 7d200026 618c8000 2c030900 4182e320 2c030500 4182dd68 2c030e80 4182ffa4 
> > [ 4255.153668] 2c030ea0 4182f078 2c030e60 4182edb0 <4e800020> 7c781b78 480003c9 480003e1   
> 
> What I think you're seeing here is just the lockup IPI causes the CPU to
> wake from idle, and so the backtrace gets recorded from where the interrupt
> gets replayed when the cpuidle code returns from the low level idle call
> then re-enables interrupts.
> 
> I don't *think* the replay-wakeup-interrupt patch is directly involved, but
> it's likely to be one of the idle patches.

Although you have this in the backtrace. I wonder if that's a stuck
lock in rcu_process_callbacks?


[ 5948.345539] CPU: 63 PID: 7360 Comm: rs:main Q:Reg Not tainted \
4.12.0-rc7-next-20170628 #2 [ 5948.345612] task: c000000f1c14e600 task.stack: \
c000000f1c1e8000 [ 5948.345672] NIP: c0000000009c7a10 LR: c0000000009c7a08 CTR: \
c00000000015eda0 [ 5948.358553] REGS: c000000f1c1eb150 TRAP: 0501   Not tainted  \
(4.12.0-rc7-next-20170628) [ 5948.358623] MSR: 9000000000009033 \
<SF,HV,EE,ME,IR,DR,RI,LE> [ 5948.358626]   CR: 28082884  XER: 20000000
[ 5948.358706] CFAR: c0000000009c7a28 SOFTE: 1 
GPR00: c00000000015f14c c000000f1c1eb3d0 c000000001062b00 0000000000000001 
GPR04: c000000fff6e6180 0000000000000000 0000000000000001 00000000000000cc 
GPR08: 0000000000000001 000000008000004a 0000000000000000 0000000000000000 
GPR12: c00000000015eda0 c00000000fd55a80 
[ 5948.358986] NIP [c0000000009c7a10] _raw_spin_lock_irqsave+0x90/0x100
[ 5948.359043] LR [c0000000009c7a08] _raw_spin_lock_irqsave+0x88/0x100
[ 5948.359099] Call Trace:
[ 5948.359123] [c000000f1c1eb3d0] [0000000000000001] 0x1 (unreliable)
[ 5948.359182] [c000000f1c1eb410] [c00000000015f14c] \
rcu_process_callbacks+0x3ac/0x620 [ 5948.359252] [c000000f1c1eb4c0] \
[c0000000000e1e0c] __do_softirq+0x14c/0x3a0 [ 5948.365958] [c000000f1c1eb5b0] \
[c0000000000e2448] irq_exit+0x108/0x120 [ 5948.366016] [c000000f1c1eb5d0] \
[c0000000000232b4] timer_interrupt+0xa4/0xe0 [ 5948.366075] [c000000f1c1eb600] \
[c000000000009208] decrementer_common+0x158/0x160 [ 5948.366149] --- interrupt: 901 \
at start_this_handle+0xd0/0x4b0  LR = jbd2__journal_start+0x17c/0x2b0
[ 5948.366242] [c000000f1c1eb8f0] [c000000f20a5cb00] 0xc000000f20a5cb00 (unreliable)
[ 5948.366314] [c000000f1c1eba00] [c00000000040717c] jbd2__journal_start+0x17c/0x2b0
[ 5948.366388] [c000000f1c1eba70] [c00000000038edf4] \
__ext4_journal_start_sb+0x84/0x180 [ 5948.366459] [c000000f1c1ebad0] \
[c0000000003b47dc] ext4_da_write_begin+0x17c/0x520 [ 5948.366532] [c000000f1c1ebb90] \
[c00000000021f9c8] generic_perform_write+0xe8/0x250 [ 5948.366604] [c000000f1c1ebc20] \
[c000000000220d20] __generic_file_write_iter+0x200/0x240 [ 5948.366677] \
[c000000f1c1ebc80] [c00000000039d614] ext4_file_write_iter+0x2e4/0x4d0 [ 5948.373255] \
[c000000f1c1ebd00] [c0000000002e13c0] __vfs_write+0x120/0x200 [ 5948.373313] \
[c000000f1c1ebd90] [c0000000002e2c48] vfs_write+0xc8/0x240 [ 5948.373371] \
[c000000f1c1ebde0] [c0000000002e4940] SyS_write+0x60/0x110 [ 5948.373430] \
[c000000f1c1ebe30] [c00000000000b8e0] system_call+0x38/0xdc [ 5948.373486] \
Instruction dump: [ 5948.373521] 7fe3fb78 e8010010 eba1ffe8 ebc1fff0 ebe1fff8 \
7c0803a6 4e800020 8bad028a  [ 5948.373592] 7fe3fb78 4b64db15 60000000 7c210b78 \
<e92d0000> 89290009 792affe3 40820048  [ 5948.374515] Sending NMI from CPU 74 to CPUs \
