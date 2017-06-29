Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyvn94by3zDr1k
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 19:41:33 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id u36so11291831pgn.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 02:41:33 -0700 (PDT)
Date: Thu, 29 Jun 2017 19:36:14 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-next
 <linux-next@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-kernel <linux-kernel@vger.kernel.org>, sachinp
 <sachinp@linux.vnet.ibm.com>, mpe <mpe@ellerman.id>, paulus@samba.org
Subject: Re: [linux-next] cpus stalls detected few hours after booting next
 kernel
Message-ID: <20170629193614.376e27e6@roar.ozlabs.ibm.com>
In-Reply-To: <1498728106.19484.21.camel@abdul>
References: <1498728106.19484.21.camel@abdul>
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

I've seen this as well (or something like it) in mambo at boot, but
it's pretty rare to hit. I'm trying to debug it.

I'm guessing possibly an idle vs interrupt race.

> [ 4255.151192] Sending NMI from CPU 5 to CPUs 0:
> [ 4255.151246] NMI backtrace for cpu 0
> [ 4255.151287] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.12.0-rc7-next-20170628 #2
> [ 4255.151363] task: c0000007f8495600 task.stack: c0000007f842c000
> [ 4255.151428] NIP: c00000000000adb4 LR: c000000000015584 CTR: c00000000082f4b0
> [ 4255.151504] REGS: c0000007f842fb60 TRAP: 0e81   Not tainted  (4.12.0-rc7-next-20170628)
> [ 4255.151578] MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>
> [ 4255.151586]   CR: 22004884  XER: 00000000
> [ 4255.151675] CFAR: c00000000062c108 SOFTE: 1 
> [ 4255.151675] GPR00: c00000000082d6c8 c0000007f842fde0 c000000001062b00 0000000028000000 
> [ 4255.151675] GPR04: 0000000000000003 c000000000089830 00003aa8056bc35f 0000000000000001 
> [ 4255.151675] GPR08: 0000000000000002 c000000000d52d80 00000007fe7d0000 9000000000001003 
> [ 4255.151675] GPR12: c00000000082a0c0 c00000000fd40000 
> [ 4255.152217] NIP [c00000000000adb4] .L__replay_interrupt_return+0x0/0x4
> [ 4255.152334] LR [c000000000015584] arch_local_irq_restore+0x74/0x90
> [ 4255.152447] Call Trace:
> [ 4255.152499] [c0000007f842fde0] [c00000000017cec0] tick_broadcast_oneshot_control+0x40/0x60 (unreliable)
> [ 4255.152662] [c0000007f842fe00] [c00000000082d6c8] cpuidle_enter_state+0x108/0x3d0
> [ 4255.152803] [c0000007f842fe60] [c000000000133e94] call_cpuidle+0x44/0x80
> [ 4255.152921] [c0000007f842fe80] [c000000000134240] do_idle+0x290/0x2f0
> [ 4255.153037] [c0000007f842fef0] [c000000000134474] cpu_startup_entry+0x34/0x40
> [ 4255.153176] [c0000007f842ff20] [c000000000041944] start_secondary+0x304/0x360
> [ 4255.153316] [c0000007f842ff90] [c00000000000b16c] start_secondary_prolog+0x10/0x14
> [ 4255.153455] Instruction dump:
> [ 4255.153527] 7d200026 618c8000 2c030900 4182e320 2c030500 4182dd68 2c030e80 4182ffa4 
> [ 4255.153668] 2c030ea0 4182f078 2c030e60 4182edb0 <4e800020> 7c781b78 480003c9 480003e1 

What I think you're seeing here is just the lockup IPI causes the CPU to
wake from idle, and so the backtrace gets recorded from where the interrupt
gets replayed when the cpuidle code returns from the low level idle call
then re-enables interrupts.

I don't *think* the replay-wakeup-interrupt patch is directly involved, but
it's likely to be one of the idle patches.

Thanks,
Nick
