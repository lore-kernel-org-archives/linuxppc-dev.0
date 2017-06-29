Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wz2XF5JCNzDr27
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 00:45:49 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id f127so12172332pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 07:45:49 -0700 (PDT)
Date: Fri, 30 Jun 2017 00:45:34 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-next
 <linux-next@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-kernel <linux-kernel@vger.kernel.org>, sachinp
 <sachinp@linux.vnet.ibm.com>, mpe <mpe@ellerman.id.au>, paulus@samba.org,
 Paul McKenney <Paul.McKenney@us.ibm.com>
Subject: Re: [linux-next] cpus stalls detected few hours after booting next
 kernel
Message-ID: <20170630004534.228f7c08@roar.ozlabs.ibm.com>
In-Reply-To: <20170629202305.6187367f@roar.ozlabs.ibm.com>
References: <1498728106.19484.21.camel@abdul>
 <20170629193614.376e27e6@roar.ozlabs.ibm.com>
 <20170629202305.6187367f@roar.ozlabs.ibm.com>
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

On Thu, 29 Jun 2017 20:23:05 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> On Thu, 29 Jun 2017 19:36:14 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:

> > I don't *think* the replay-wakeup-interrupt patch is directly involved, but
> > it's likely to be one of the idle patches.  

Okay this turned out to be misconfigured sleep states I added for the
simulator, sorry for the false alarm.

> Although you have this in the backtrace. I wonder if that's a stuck
> lock in rcu_process_callbacks?

So this spinlock becomes top of the list of suspects. Can you try
enabling lockdep and try to reproduce it?

> [ 5948.345539] CPU: 63 PID: 7360 Comm: rs:main Q:Reg Not tainted \
> 4.12.0-rc7-next-20170628 #2 [ 5948.345612] task: c000000f1c14e600 task.stack: \
> c000000f1c1e8000 [ 5948.345672] NIP: c0000000009c7a10 LR: c0000000009c7a08 CTR: \
> c00000000015eda0 [ 5948.358553] REGS: c000000f1c1eb150 TRAP: 0501   Not tainted  \
> (4.12.0-rc7-next-20170628) [ 5948.358623] MSR: 9000000000009033 \
> <SF,HV,EE,ME,IR,DR,RI,LE> [ 5948.358626]   CR: 28082884  XER: 20000000
> [ 5948.358706] CFAR: c0000000009c7a28 SOFTE: 1 
> GPR00: c00000000015f14c c000000f1c1eb3d0 c000000001062b00 0000000000000001 
> GPR04: c000000fff6e6180 0000000000000000 0000000000000001 00000000000000cc 
> GPR08: 0000000000000001 000000008000004a 0000000000000000 0000000000000000 
> GPR12: c00000000015eda0 c00000000fd55a80 
> [ 5948.358986] NIP [c0000000009c7a10] _raw_spin_lock_irqsave+0x90/0x100
> [ 5948.359043] LR [c0000000009c7a08] _raw_spin_lock_irqsave+0x88/0x100
> [ 5948.359099] Call Trace:
> [ 5948.359123] [c000000f1c1eb3d0] [0000000000000001] 0x1 (unreliable)
> [ 5948.359182] [c000000f1c1eb410] [c00000000015f14c] \
d> rcu_process_callbacks+0x3ac/0x620 [ 5948.359252] [c000000f1c1eb4c0] \
> [c0000000000e1e0c] __do_softirq+0x14c/0x3a0 [ 5948.365958] [c000000f1c1eb5b0] \
> [c0000000000e2448] irq_exit+0x108/0x120 [ 5948.366016] [c000000f1c1eb5d0] \
> [c0000000000232b4] timer_interrupt+0xa4/0xe0 [ 5948.366075] [c000000f1c1eb600] \
> [c000000000009208] decrementer_common+0x158/0x160 [ 5948.366149] --- interrupt: 901 \
> at start_this_handle+0xd0/0x4b0  LR = jbd2__journal_start+0x17c/0x2b0
> [ 5948.366242] [c000000f1c1eb8f0] [c000000f20a5cb00] 0xc000000f20a5cb00 (unreliable)
> [ 5948.366314] [c000000f1c1eba00] [c00000000040717c] jbd2__journal_start+0x17c/0x2b0
> [ 5948.366388] [c000000f1c1eba70] [c00000000038edf4] \
> __ext4_journal_start_sb+0x84/0x180 [ 5948.366459] [c000000f1c1ebad0] \
> [c0000000003b47dc] ext4_da_write_begin+0x17c/0x520 [ 5948.366532] [c000000f1c1ebb90] \
> [c00000000021f9c8] generic_perform_write+0xe8/0x250 [ 5948.366604] [c000000f1c1ebc20] \
> [c000000000220d20] __generic_file_write_iter+0x200/0x240 [ 5948.366677] \
> [c000000f1c1ebc80] [c00000000039d614] ext4_file_write_iter+0x2e4/0x4d0 [ 5948.373255] \
> [c000000f1c1ebd00] [c0000000002e13c0] __vfs_write+0x120/0x200 [ 5948.373313] \
> [c000000f1c1ebd90] [c0000000002e2c48] vfs_write+0xc8/0x240 [ 5948.373371] \
> [c000000f1c1ebde0] [c0000000002e4940] SyS_write+0x60/0x110 [ 5948.373430] \
> [c000000f1c1ebe30] [c00000000000b8e0] system_call+0x38/0xdc [ 5948.373486] \
> Instruction dump: [ 5948.373521] 7fe3fb78 e8010010 eba1ffe8 ebc1fff0 ebe1fff8 \
> 7c0803a6 4e800020 8bad028a  [ 5948.373592] 7fe3fb78 4b64db15 60000000 7c210b78 \
> <e92d0000> 89290009 792affe3 40820048  [ 5948.374515] Sending NMI from CPU 74 to CPUs \
> 
