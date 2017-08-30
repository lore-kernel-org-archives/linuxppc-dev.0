Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xj3941zclzDqMY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 21:26:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 4/4] powerpc/64s: idle ESL=0 stop can avoid MSR and
 save/restore overhead
In-Reply-To: <20170825043036.18236-5-npiggin@gmail.com>
References: <20170825043036.18236-1-npiggin@gmail.com>
 <20170825043036.18236-5-npiggin@gmail.com>
Date: Wed, 30 Aug 2017 21:25:59 +1000
Message-ID: <87pobd1em0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> When stop is executed with EC=ESL=0, it appears to execute like a
> normal instruction (resuming from NIP when woken by interrupt).
> So all the save/restore handling can be avoided completely. In
> particular NV GPRs do not have to be saved, and MSR does not have
> to be switched back to kernel MSR.
>
> So move the test for "lite" sleep states out to power9_idle_stop.
>
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kernel/idle_book3s.S | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)

This is blowing up for me on mambo:

  usbcore: registered new interface driver usb-storage
  Disabling lock debugging due to kernel taint
  Severe Machine check interrupt [Not recovered]
    NIP [c0000000002a0c04]: kmem_cache_free+0x64/0x2c0
    Initiator: CPU
    Error type: Real address [Load/Store (foreign)]
  opal: Hardware platform error: Unrecoverable Machine Check exception
  CPU: 0 PID: 0 Comm: swapper/0 Tainted: G   M            4.13.0-rc2-gcc-6.3.1-00257-g26268bb39bff #543
  task: c0000000016b1200 task.stack: c00000000175c000
  NIP:  c0000000002a0c04 LR: c0000000001128ec CTR: c000000000112800
  REGS: c00000003fff7d80 TRAP: 0200   Tainted: G   M             (4.13.0-rc2-gcc-6.3.1-00257-g26268bb39bff)
  MSR:  9000000000209003 <SF,HV,EE,ME,RI,LE>  CR: 28002828  XER: 20000000
  CFAR: c0000000001128e8 DAR: c00a0000003c3ce0 DSISR: 00000008 SOFTE: 1 
  GPR00: c0000000001128ec c00000000175f7b0 c000000001760500 c0000000f001a000 
  GPR04: c0000000f0f37f00 0000000000000003 00000000000220c3 0000000000000000 
  GPR08: 0000000000000000 00000000003c3cc0 c0000000017e7758 0000000000000000 
  GPR12: c000000000112800 c00000000fff0000 c000000000112800 c0000000f0f37f90 
  GPR16: c00000000175c000 c00000000175c000 0000000000000001 c0000000016d7900 
  GPR20: c00000000179ba98 7fffffffffffffff c00000000175c000 0000000000000000 
  GPR24: c00000000017a8c0 000000000000000a c0000000016d8a00 c00000000175f8d0 
  GPR28: c0000000001128ec c0000000f0f37f00 c00a0000003c3cc0 c0000000f001a000 
  NIP [c0000000002a0c04] kmem_cache_free+0x64/0x2c0
  LR [c0000000001128ec] put_cred_rcu+0xec/0x140
  Call Trace:
  [c00000000175f7b0] [c00000000175f800] init_thread_union+0x3800/0x4000 (unreliable)
  [c00000000175f840] [c0000000001128ec] put_cred_rcu+0xec/0x140
  [c00000000175f8b0] [c00000000017a908] rcu_process_callbacks+0x438/0x6a0
  [c00000000175f980] [c0000000000e5e28] __do_softirq+0x198/0x310
  [c00000000175fa70] [c0000000000e6248] irq_exit+0xf8/0x140
  [c00000000175fa90] [c000000000023710] timer_interrupt+0xa0/0xe0
  [c00000000175fac0] [c000000000008fcc] decrementer_common+0x11c/0x120
  --- interrupt: 901 at replay_interrupt_return+0x0/0x4
      LR = arch_local_irq_restore.part.1+0x84/0xb0
  [c00000000175fdb0] [c00000000175c000] init_thread_union+0x0/0x4000 (unreliable)
  [c00000000175fdd0] [c00000000001cde0] arch_cpu_idle+0xe0/0x140
  [c00000000175fe00] [c0000000007f4f44] default_idle_call+0x44/0x84
  [c00000000175fe20] [c000000000142e54] do_idle+0x254/0x320
  [c00000000175fe90] [c000000000143280] cpu_startup_entry+0x30/0x40
  [c00000000175fec0] [c00000000000d2d8] rest_init+0x2f8/0x320
  [c00000000175ff00] [c000000001000d74] start_kernel+0x510/0x52c
  [c00000000175ff90] [c00000000000ab70] start_here_common+0x1c/0x4ac
  Instruction dump:
  60000000 e9230008 71280100 40820170 2fbf0000 419e013c 3d420008 394a7258 
  7bbe8502 7bc93664 ebca0000 7fde4a14 <e93e0020> 712a0001 40820234 e93f0008 
  [    1.217346467,0] OPAL: Reboot requested due to Platform error.
  [    1.217351582,3] OPAL: failed to log an error
  [    1.217358188,5] OPAL: Reboot request...


I'll just drop it for now.

cheers
