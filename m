Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttjFb3MP6zDqHB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 18:32:34 +1100 (AEDT)
Subject: Re: bootx_init.c:88: undefined reference to `__stack_chk_fail_local'
To: Christian Kujau <lists@nerdbynature.de>
References: <alpine.DEB.2.20.99.1701030715390.31470@trent.utfs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <81ef821b-8af2-0ee5-ab35-58639548dab7@c-s.fr>
Date: Wed, 4 Jan 2017 08:32:26 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.99.1701030715390.31470@trent.utfs.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 03/01/2017 à 16:25, Christian Kujau a écrit :
> Hi,
>
> when compiling v4.10-rc2 with CONFIG_CC_STACKPROTECTOR_STRONG=y, the
> linker fails with:
>
> ================================
> + ld -EB -m elf32ppc -Bstatic --build-id -X -o .tmp_vmlinux1 -T
> ./arch/powerpc/kernel/vmlinux.lds arch/powerpc/kernel/head_32.o
> arch/powerpc/kernel/fpu.o arch/powerpc/kernel/vector.o
> arch/powerpc/kernel/prom_init.o init/built-in.o --start-group
> usr/built-in.o arch/powerpc/kernel/built-in.o arch/powerpc/mm/built-in.o
> arch/powerpc/lib/built-in.o arch/powerpc/sysdev/built-in.o
> arch/powerpc/platforms/built-in.o arch/powerpc/math-emu/built-in.o
> arch/powerpc/crypto/built-in.o arch/powerpc/net/built-in.o
> kernel/built-in.o certs/built-in.o mm/built-in.o fs/built-in.o
> ipc/built-in.o security/built-in.o crypto/built-in.o block/built-in.o
> lib/lib.a lib/built-in.o drivers/built-in.o sound/built-in.o
> firmware/built-in.o net/built-in.o virt/built-in.o --end-group
> arch/powerpc/platforms/built-in.o: In function `bootx_printf':
> /usr/local/src/linux-git/arch/powerpc/platforms/powermac/bootx_init.c:88: undefined reference to `__stack_chk_fail_local'
> arch/powerpc/platforms/built-in.o: In function `bootx_add_display_props':
> /usr/local/src/linux-git/arch/powerpc/platforms/powermac/bootx_init.c:211: undefined reference to `__stack_chk_fail_local'
> arch/powerpc/platforms/built-in.o: In function
> `bootx_scan_dt_build_struct':
> /usr/local/src/linux-git/arch/powerpc/platforms/powermac/bootx_init.c:350: undefined reference to `__stack_chk_fail_local'
> arch/powerpc/platforms/built-in.o: In function `bootx_init':
> /usr/local/src/linux-git/arch/powerpc/platforms/powermac/bootx_init.c:596: undefined reference to `__stack_chk_fail_local'
> /usr/bin/ld.bfd.real: .tmp_vmlinux1: hidden symbol `__stack_chk_fail_local' isn't defined
> /usr/bin/ld.bfd.real: final link failed: Bad value
> ================================
>
>
> $ ld --version | head -1
> GNU ld (GNU Binutils for Debian) 2.25
>
> $ gcc --version | head -1
> gcc-4.9.real (Debian 4.9.2-10) 4.9.2
>
>
> I'm regularly compiling userspace programs with -fstack-protector w/o
> problems. I suspect it's either 6533b7c16ee5712041b4e324100550e02a9a5dda
> ("powerpc: Initial stack protector (-fstack-protector) support") or
> 902e06eb86cd62753974c249bd1dedae2825b430 ("powerpc/32: Change the stack
> protector canary value per task") or both but I haven't started the
> bisection yet.
>
> Any other ideas?
>
> Thanks,
> Christian.
>

Using GCC 5.4.0, I don't have that issue. bootx_init.o only contains 
reference to __stack_chk_fail

Looking a bit over internet, some people have reported having 
encountered that issue due to old object files not properly cleaned.

Have you tried a 'make clean' or 'distclean' ?

Christophe
