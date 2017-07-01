Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wzxzR56X3zDr8b
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jul 2017 12:24:03 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 3/7] powerpc/64s: Blacklist system_call() and
 system_call_common() from kprobes
In-Reply-To: <35022d2cef7795e924d032b2766f21cb98ab0e55.1498755960.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498755960.git.naveen.n.rao@linux.vnet.ibm.com>
 <35022d2cef7795e924d032b2766f21cb98ab0e55.1498755960.git.naveen.n.rao@linux.vnet.ibm.com>
Date: Sat, 01 Jul 2017 12:24:02 +1000
Message-ID: <87fuegx5bx.fsf@concordia.ellerman.id.au>
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

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> Convert some of the symbols into private symbols and blacklist
> system_call_common() and system_call() from kprobes. We can't take a
> trap at parts of these functions as either MSR_RI is unset or the kernel
> stack pointer is not yet setup.
>
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/entry_64.S | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index da9486e2fd89..ef8e6615b8ba 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -52,12 +52,11 @@ exception_marker:
>  	.section	".text"
>  	.align 7
>  
> -	.globl system_call_common
> -system_call_common:
> +_GLOBAL(system_call_common)

Looks good.

Yet ...

Power6:

  [    0.313058] Bad kernel stack pointer 7fffdd061cf0 at c00000000000cd80
  [    0.313068] Oops: Bad kernel stack pointer, sig: 6 [#1]
  [    0.313072] SMP NR_CPUS=2048 
  [    0.313072] NUMA 
  [    0.313076] pSeries
  [    0.313081] Modules linked in:
  [    0.313087] CPU: 1 PID: 1 Comm: init Not tainted 4.12.0-rc3-gcc_ubuntu_be-g464970a #1
  [    0.313093] task: c000000049480000 task.stack: c0000000494c0000
  [    0.313097] NIP: c00000000000cd80 LR: 00007fff8e8a13b0 CTR: 00007fff8e8a1370
  [    0.313103] REGS: c000000007fa3d40 TRAP: 0300   Not tainted  (4.12.0-rc3-gcc_ubuntu_be-g464970a)
  [    0.313108] MSR: 8000000000001032 <SF,ME,IR,DR,RI>
  [    0.313114]   CR: 84000022  XER: 00000000
  [    0.313120] CFAR: 00000000000087c0 DAR: 0000000000001e64 DSISR: 42000000 SOFTE: 0 
  [    0.313120] GPR00: 000000000000002d 00007fffdd061cf0 00007fff8e8c8af8 0000000000000000 
  [    0.313120] GPR04: 00000000000019c0 00007fff8e860000 0000000000000001 00007fff8e8c2a30 
  [    0.313120] GPR08: 00000000493e1528 0000000000000000 b000000000001032 00007fff8e8a1ea8 
  [    0.313120] GPR12: 800000000000d032 c000000006b30500 0000000000000000 0000000000000000 
  [    0.313120] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
  [    0.313120] GPR20: 0000000000000000 0000000000000000 0000000000000080 0000000000010000 
  [    0.313120] GPR24: 0000000000000000 00007fffdd0626c9 00000000493a0040 0000000000000009 
  [    0.313120] GPR28: 00007fff8e8bfe58 00007fff8e8bfb88 00007fff8e8bfe40 00007fff8e8c0148 
  [    0.313190] NIP [c00000000000cd80] .load_up_vsx+0x1c/0x2c
  [    0.313195] LR [00007fff8e8a13b0] 0x7fff8e8a13b0
  [    0.313199] Call Trace:
  [    0.313201] Instruction dump:
  [    0.313206] 7fe721ce 10000604 38800200 7c0439ce 4e800020 71852000 41a2f7c5 75850200 
  [    0.313217] 41a2fd71 e88d0250 388419c0 38c00001 <90c404a4> 658c0080 f9810178 4bffefc4 
  [    0.313229] ---[ end trace 3ca7930ed36d9399 ]---

Power7:

  [    1.770801] Bad kernel stack pointer ff9be8b0 at 1f7f79590
  [    1.770811] Oops: Bad kernel stack pointer, sig: 6 [#1]
  [    1.770814] SMP NR_CPUS=2048 
  [    1.770815] NUMA 
  [    1.770819] pSeries
  [    1.770825] Modules linked in:
  [    1.770832] CPU: 26 PID: 1 Comm: init Not tainted 4.12.0-rc3-gcc6-g464970a #1
  [    1.770838] task: c000000e18300000 task.stack: c000000e18380000
  [    1.770843] NIP: 00000001f7f79590 LR: 00000000f7f79358 CTR: 00000001f7f79590
  [    1.770848] REGS: c00000000ed47d40 TRAP: 0400   Not tainted  (4.12.0-rc3-gcc6-g464970a)
  [    1.770853] MSR: 8000000040001032 <SF,ME,IR,DR,RI>
  [    1.770860]   CR: 24000888  XER: 20000000
  [    1.770866] CFAR: 00000000000087c0 SOFTE: 0 
  [    1.770866] GPR00: 00000000f7f7998c 00000000ff9be8b0 0000000000000000 0000000000000000 
  [    1.770866] GPR04: 00000000f7f9f5b8 0000000000000005 0000000000000072 0000000000000072 
  [    1.770866] GPR08: fffffffffeff0000 0000000000000000 00000001f7f79590 00000000f7f7ac30 
  [    1.770866] GPR12: 0000000000000001 c00000000ec08200 0000000000010000 0000000000000000 
  [    1.770866] GPR16: 00000000ff9bed49 0000000000000000 00000000dc0065c2 0000000000000000 
  [    1.770866] GPR20: 0000000020000000 0000000000000064 0000000000000001 0000000000000001 
  [    1.770866] GPR24: 0000000000000001 0000000000000001 00000000f7f62b40 0000000020620034 
  [    1.770866] GPR28: 000000000000000a 00000000ff9bed49 00000000f7f9fff4 00000000f7f9f308 
  [    1.770929] NIP [00000001f7f79590] 0x1f7f79590
  [    1.770933] LR [00000000f7f79358] 0xf7f79358
  [    1.770937] Call Trace:
  [    1.770940] Instruction dump:
  [    1.770945] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
  [    1.770953] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
  [    1.770964] ---[ end trace 4eb52706b24fb9c6 ]---

Cell:

  [   21.359058] init[1]: unhandled signal 11 at 00000000 nip 00000000 lr c00000000000b01c code 30001
  [   21.412082] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
  [   21.412082] 
  [   21.466866] CPU: 1 PID: 1 Comm: init Not tainted 4.12.0-rc3-gcc6x-g464970a #1
  [   21.509619] Call Trace:
  [   21.524265] [c0000007fb9838d0] [c000000000440a28] .dump_stack+0xa8/0xe8 (unreliable)
  [   21.570715] [c0000007fb983960] [c0000000001d0258] .panic+0x13c/0x2ec
  [   21.608787] [c0000007fb983a10] [c0000000000a59c0] .do_exit+0xb88/0xb90
  [   21.647945] [c0000007fb983ae0] [c0000000000a6cd4] .do_group_exit+0x64/0x100
  [   21.689666] [c0000007fb983b70] [c0000000000b5dfc] .get_signal+0x3bc/0x748
  [   21.730338] [c0000007fb983c70] [c00000000001742c] .do_signal+0x64/0x2b0
  [   21.769969] [c0000007fb983db0] [c000000000017870] .do_notify_resume+0xc0/0xe8
  [   21.812733] [c0000007fb983e30] [c00000000000abb0] .ret_from_except_lite+0x5c/0x60
  [   21.857649] Rebooting in 180 seconds..

And G5 too, but I don't have the trace.

Strangely it doesn't break on all my BE systems. I suspect AIL=1 avoids it.

One to investigate on Monday :)

cheers
