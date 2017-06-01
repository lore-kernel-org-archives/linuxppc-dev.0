Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdcMY15K4zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jun 2017 16:07:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 PowerPC  <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: Tree for May 31
In-Reply-To: <20170531153227.7098f0a1@canb.auug.org.au>
References: <20170531153227.7098f0a1@canb.auug.org.au>
Date: Thu, 01 Jun 2017 16:07:51 +1000
Message-ID: <8737bk44w8.fsf@concordia.ellerman.id.au>
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

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> Changes since 20170530:
>
> The mfd tree gained a build failure so I used the version from
> next-20170530.
>
> The drivers-x86 tree gained the same build failure as the mfd tree so
> I used the version from next-20170530.
>
> The rtc tree gained a build failure so I used the version from
> next-20170530.
>
> The akpm tree lost a patch that turned up elsewhere.
>
> Non-merge commits (relative to Linus' tree): 3325
>  3598 files changed, 135000 insertions(+), 72065 deletions(-)

More or less all my powerpc boxes failed to boot this.

All the stack traces point to new_slab():

  PID hash table entries: 4096 (order: -1, 32768 bytes)
  Memory: 127012480K/134217728K available (12032K kernel code, 1920K rwdata, 2916K rodata, 1088K init, 14065K bss, 487808K reserved, 6717440K cma-reserved)
  Unable to handle kernel paging request for data at address 0x000004f0
  Faulting instruction address: 0xc00000000033fd48
  Oops: Kernel access of bad area, sig: 11 [#1]
  SMP NR_CPUS=2048 
  NUMA 
  PowerNV
  Modules linked in:
  CPU: 0 PID: 0 Comm: swapper Not tainted 4.12.0-rc3-gccN-next-20170531-gf2882f4 #1
  task: c000000000fb1200 task.stack: c000000001104000
  NIP: c00000000033fd48 LR: c00000000033fb1c CTR: c0000000002d6ae0
  REGS: c000000001107970 TRAP: 0380   Not tainted  (4.12.0-rc3-gccN-next-20170531-gf2882f4)
  MSR: 9000000002001033 <SF,HV,VEC,ME,IR,DR,RI,LE>
    CR: 22042244  XER: 00000000
  CFAR: c00000000033fbfc SOFTE: 0 
  GPR00: c00000000033fb1c c000000001107bf0 c000000001108b00 c0000007ffff6180 
  GPR04: c000000001139600 0000000000000000 00000007f9880000 0000000000000080 
  GPR08: c0000000011cf5d8 00000000000004f0 0000000000000000 c0000007ffff6280 
  GPR12: 0000000028042822 c00000000fd40000 0000000000000000 0000000000000000 
  GPR16: 0000000000000000 c000000000dc9198 c000000000dc91c8 000000000000006f 
  GPR20: 0000000000000001 0000000000002000 00000000014000c0 0000000000000000 
  GPR24: 0000000000000201 c0000007f9010000 0000000000000000 0000000080010400 
  GPR28: 0000000000000001 0000000000000006 f000000001fe4000 c000000000f15958 
  NIP [c00000000033fd48] new_slab+0x318/0x710
  LR [c00000000033fb1c] new_slab+0xec/0x710
  Call Trace:
  [c000000001107bf0] [c00000000033fb1c] new_slab+0xec/0x710 (unreliable)
  [c000000001107cc0] [c000000000348cc0] __kmem_cache_create+0x270/0x800
  [c000000001107df0] [c000000000ece8b4] create_boot_cache+0xa0/0xe4
  [c000000001107e70] [c000000000ed30d0] kmem_cache_init+0x68/0x16c
  [c000000001107f00] [c000000000ea0b08] start_kernel+0x2a0/0x554
  [c000000001107f90] [c00000000000ad70] start_here_common+0x1c/0x4ac
  Instruction dump:
  57bd039c 79291f24 7fbd0074 7c68482a 7bbdd182 3bbd0005 60000000 3d230001 
  e95e0038 e9299a7a 3929009e 79291f24 <7f6a482a> e93b0080 7fa34800 409e036c 
  ---[ end trace 0000000000000000 ]---
  
  Kernel panic - not syncing: Attempted to kill the idle task!
  Rebooting in 10 seconds..


cheers
