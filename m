Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttkNp3ptVzDqHf
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 19:23:54 +1100 (AEDT)
Subject: Re: bootx_init.c:88: undefined reference to `__stack_chk_fail_local'
To: benh@au1.ibm.com, Christian Kujau <lists@nerdbynature.de>
References: <alpine.DEB.2.20.99.1701030715390.31470@trent.utfs.org>
 <1483483841.15843.4.camel@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <ca802791-9a7d-90b4-2025-852517225f14@c-s.fr>
Date: Wed, 4 Jan 2017 09:23:47 +0100
MIME-Version: 1.0
In-Reply-To: <1483483841.15843.4.camel@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 03/01/2017 à 23:50, Benjamin Herrenschmidt a écrit :
> On Tue, 2017-01-03 at 07:25 -0800, Christian Kujau wrote:
>> Hi,
>>
>> when compiling v4.10-rc2 with CONFIG_CC_STACKPROTECTOR_STRONG=y, the
>> linker fails with:
>
> The way gcc implements the stack protector has some serious
> incompatibilities with the way the Linux kernel uses r13, I wouldn't
> even try until we sort that out...

Yes indeed, it looks like recent versions of GCC don't use anymore the 
global __stack_chk_guard variable but a hard coded offset relative to r2 
or r13:

On 32 bits, it uses -7008(r2)
On 64 bits, it uses -7010(r13)

On 32 bits, r2 points to current struct, which contains the stack_canary 
value for the task. I have tried to alter get_current() in order to 
define it as an offset to r2 so that current->stack_canary is at 
-7008(r2), but I end up with circular cross references in header files 
and still have task_struct undefined when get_current() needs it to 
calculate offset of stack_canary within the structure.

When CONFIG_CC_STACKPROTECTOR is active, would it be feasible to get the 
pointer to current from the stack using the thread_info instead of using 
r2 reg ? That way we could keep r2 to point to current->stack_canary + 
0x7008

Christophe

>
> Cheers,
> Ben.
>>
>> ================================
>> + ld -EB -m elf32ppc -Bstatic --build-id -X -o .tmp_vmlinux1 -T
>> ./arch/powerpc/kernel/vmlinux.lds arch/powerpc/kernel/head_32.o
>> arch/powerpc/kernel/fpu.o arch/powerpc/kernel/vector.o
>> arch/powerpc/kernel/prom_init.o init/built-in.o --start-group
>> usr/built-in.o arch/powerpc/kernel/built-in.o arch/powerpc/mm/built-
>> in.o
>> arch/powerpc/lib/built-in.o arch/powerpc/sysdev/built-in.o
>> arch/powerpc/platforms/built-in.o arch/powerpc/math-emu/built-in.o
>> arch/powerpc/crypto/built-in.o arch/powerpc/net/built-in.o
>> kernel/built-in.o certs/built-in.o mm/built-in.o fs/built-in.o
>> ipc/built-in.o security/built-in.o crypto/built-in.o block/built-
>> in.o
>> lib/lib.a lib/built-in.o drivers/built-in.o sound/built-in.o
>> firmware/built-in.o net/built-in.o virt/built-in.o --end-group
>> arch/powerpc/platforms/built-in.o: In function `bootx_printf':
>> /usr/local/src/linux-
>> git/arch/powerpc/platforms/powermac/bootx_init.c:88: undefined
>> reference to `__stack_chk_fail_local'
>> arch/powerpc/platforms/built-in.o: In function
>> `bootx_add_display_props':
>> /usr/local/src/linux-
>> git/arch/powerpc/platforms/powermac/bootx_init.c:211: undefined
>> reference to `__stack_chk_fail_local'
>> arch/powerpc/platforms/built-in.o: In function
>> `bootx_scan_dt_build_struct':
>> /usr/local/src/linux-
>> git/arch/powerpc/platforms/powermac/bootx_init.c:350: undefined
>> reference to `__stack_chk_fail_local'
>> arch/powerpc/platforms/built-in.o: In function `bootx_init':
>> /usr/local/src/linux-
>> git/arch/powerpc/platforms/powermac/bootx_init.c:596: undefined
>> reference to `__stack_chk_fail_local'
>> /usr/bin/ld.bfd.real: .tmp_vmlinux1: hidden symbol
>> `__stack_chk_fail_local' isn't defined
>> /usr/bin/ld.bfd.real: final link failed: Bad value
>> ================================
>>
>>
>> $ ld --version | head -1
>> GNU ld (GNU Binutils for Debian) 2.25
>>
>> $ gcc --version | head -1
>> gcc-4.9.real (Debian 4.9.2-10) 4.9.2
>>
>>
>> I'm regularly compiling userspace programs with -fstack-protector
>> w/o
>> problems. I suspect it's either
>> 6533b7c16ee5712041b4e324100550e02a9a5dda
>> ("powerpc: Initial stack protector (-fstack-protector) support") or
>> 902e06eb86cd62753974c249bd1dedae2825b430 ("powerpc/32: Change the
>> stack
>> protector canary value per task") or both but I haven't started the
>> bisection yet.
>>
>> Any other ideas?
>>
>> Thanks,
>> Christian.
