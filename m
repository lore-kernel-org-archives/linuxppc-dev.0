Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtcp81sSVzDr80
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 20:12:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-next <linux-next@vger.kernel.org>,
 stephen Rothwell <sfr@canb.auug.org.au>, sachinp <sachinp@linux.vnet.ibm.com>
Subject: Re: [next-20170619][a28e46f] WARNING: CPU: 5 PID: 1 at
 arch/powerpc/lib/feature-fixups.c:214 .check_features+0xa0/0xbc
In-Reply-To: <1497972897.21025.9.camel@abdul>
References: <1497972897.21025.9.camel@abdul>
Date: Thu, 22 Jun 2017 20:12:30 +1000
Message-ID: <87fuess54h.fsf@concordia.ellerman.id.au>
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

Thanks for testing this configuration Abdul.

Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:
> Hi Michael,
>
> linux-next booted with warnings on a Power LPAR with CMO feature
> enabled.
>
> Test : boot with CMO enabled 
> Kernel: 4.12.0-rc5-next-20170619
> gcc : 4.8.5
> Machine : Power 8 Power VM LPAR (Big Endian)
>
> Steps to recreate:
>
> 1. Enable Shared Memory/CPU Mode for LPAR in HMC (lpar profile)
> 2. Build the kernel for the attached config
> 3. Boot the kernel, boot messages shows below warning
>
> Firmware features changed after feature patching!
> ------------[ cut here ]------------
> WARNING: CPU: 5 PID: 1 at
> arch/powerpc/lib/feature-fixups.c:214 .check_features+0xa0/0xbc
> Modules linked in:
> CPU: 5 PID: 1 Comm: swapper/5 Not tainted 4.12.0-rc5-next-20170619-autotest #1
> task: c0000003bbc20000 task.stack: c0000003bbc80000
> NIP: c000000000ce599c LR: c000000000ce5998 CTR: 00000000006338e4
> REGS: c0000003bbc83910 TRAP: 0700   Not tainted  (4.12.0-rc5-next-20170619-autotest)
> MSR: 800000000282b032 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI>
>   CR: 22000022  XER: 00000002  
> CFAR: c00000000024368c SOFTE: 1 
> GPR00: c000000000ce5998 c0000003bbc83b90 c00000000132e800 0000000000000031 
> GPR04: 0000000000000000 800000380fe53ec0 ffffffffffffffff 0000000000000000 
> GPR08: 0000000000000000 c0000000011999f8 c0000000011999f8 0000000000003ff0 
> GPR12: 0000000028000024 c00000000e743480 c00000000000d380 0000000000000000 
> GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> GPR24: 0000000000000000 c0000000012aad08 c000000000cc0b88 00000000000000e8 
> GPR28: c000000000d3ea38 0000000000000007 0000000000000000 c000000001375d20 
> NIP [c000000000ce599c] .check_features+0xa0/0xbc
> LR [c000000000ce5998] .check_features+0x9c/0xbc
> Call Trace:
> [c0000003bbc83b90] [c000000000ce5998] .check_features+0x9c/0xbc
> (unreliable)
> [c0000003bbc83c10] [c00000000000cb1c] .do_one_initcall+0x5c/0x1c0
> [c0000003bbc83ce0] [c000000000cd47d0] .kernel_init_freeable+0x270/0x350
> [c0000003bbc83db0] [c00000000000d39c] .kernel_init+0x1c/0x140
> [c0000003bbc83e30] [c00000000000b3e4] .ret_from_kernel_thread+0x58/0x74
> Instruction dump:
> 0fe00000 60000000 3d02ffa1 e92296e0 e94851d0 e9290000 7faa4800 41fe0018 
> 3c62ff89 3863e6f0 4b55dcb9 60000000 <0fe00000> 38210080 38600000
> e8010010 
> random: 0x600000003d22001e get_random_bytes called with crng_init=0
> ---[ end trace c0f890377edaeb14 ]---
> Running MSI bitmap self-tests ... 
>
> Possible bad commit looks to be:

That's not the bad commit ...

> commit a28e46f109c9637b2539b9995078d5df4f7f6c09
> Author: Michael Ellerman <mpe@ellerman.id.au>
> Date:   Tue Jul 26 22:29:18 2016 +1000
>
>     powerpc/kernel: Check features don't change after patching
>     
>     Early in boot we binary patch some sections of code based on the CPU and
>     MMU feature bits. But it is a one-time patching, there is no facility
>     for repatching the code later if the set of features change.
>     
>     It is a major bug if the set of features changes after we've done the
>     code patching - so add a check for it.

... it's the commit that adds the warning that something is dodgy.

In this case it's a false positive, FW_FEATURE_CMO is not used in
assembly, so it's OK (but a bit dicey) that we change it after
do_feature_fixups().

But we should still fix it so that we enable/disable FW_FEATURE_CMO
before patching.

cheers
