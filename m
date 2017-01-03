Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttTq86VJ3zDqGL
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 09:57:24 +1100 (AEDT)
Date: Tue, 3 Jan 2017 14:57:19 -0800 (PST)
From: Christian Kujau <lists@nerdbynature.de>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
cc: Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: bootx_init.c:88: undefined reference to `__stack_chk_fail_local'
In-Reply-To: <1483483841.15843.4.camel@au1.ibm.com>
Message-ID: <alpine.DEB.2.20.99.1701031454320.31470@trent.utfs.org>
References: <alpine.DEB.2.20.99.1701030715390.31470@trent.utfs.org>
 <1483483841.15843.4.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 4 Jan 2017, Benjamin Herrenschmidt wrote:
> On Tue, 2017-01-03 at 07:25 -0800, Christian Kujau wrote:
> > Hi,
> > 
> > when compiling v4.10-rc2 with CONFIG_CC_STACKPROTECTOR_STRONG=y, the 
> > linker fails with:
> 
> The way gcc implements the stack protector has some serious
> incompatibilities with the way the Linux kernel uses r13, I wouldn't
> even try until we sort that out...

Yeah, I noticed. While _compilation_ succeeded with 
CONFIG_CC_STACKPROTECTOR_REGULAR=y, the kernel panicked during boot with:

Kernel panic - not syning: stack-protector: Kernel stack is corrupted in: c0103894
CPU: 0 PID: 586 Comm: systemd Tainted: G  W 4.10.0-rc2 #3
Call Trace:
[ee949ca0] [c067d6cc] panic+0x114/0x268 (unreliable)
[ee949d00] [c002be80] print_tainted+0x0/0xcc
[ee949d10] [c0103894] path_openat+0x1014/0x1050
[ee949df0] [c01048dc] do_filp_open+0xac/0xfc
[ee949ea0] [c00f994c] do_open_execat+0x64/0x1bc
[ee949ee0] [c00fb0f8] do_execveat_common+0x24c/0x774
[ee949f30] [c00fb650] do_execve+0x30/0x40
[ee949f40] [c0010db0] ret_from_syscall+0x0/0x38
--- interrupt: c01 at 0x20403618
    LR = 0x204037ac


(written down manually, hopefully w/o typos).

I'll disable the stack protector on this powerpc (G4) machine for now.

Thanks,
Christian.

> 
> Cheers,
> Ben.
> > 
> > ================================
> > + ld -EB -m elf32ppc -Bstatic --build-id -X -o .tmp_vmlinux1 -T 
> > ./arch/powerpc/kernel/vmlinux.lds arch/powerpc/kernel/head_32.o 
> > arch/powerpc/kernel/fpu.o arch/powerpc/kernel/vector.o 
> > arch/powerpc/kernel/prom_init.o init/built-in.o --start-group 
> > usr/built-in.o arch/powerpc/kernel/built-in.o arch/powerpc/mm/built-
> > in.o 
> > arch/powerpc/lib/built-in.o arch/powerpc/sysdev/built-in.o 
> > arch/powerpc/platforms/built-in.o arch/powerpc/math-emu/built-in.o 
> > arch/powerpc/crypto/built-in.o arch/powerpc/net/built-in.o 
> > kernel/built-in.o certs/built-in.o mm/built-in.o fs/built-in.o 
> > ipc/built-in.o security/built-in.o crypto/built-in.o block/built-
> > in.o 
> > lib/lib.a lib/built-in.o drivers/built-in.o sound/built-in.o 
> > firmware/built-in.o net/built-in.o virt/built-in.o --end-group
> > arch/powerpc/platforms/built-in.o: In function `bootx_printf':
> > /usr/local/src/linux-
> > git/arch/powerpc/platforms/powermac/bootx_init.c:88: undefined
> > reference to `__stack_chk_fail_local'
> > arch/powerpc/platforms/built-in.o: In function
> > `bootx_add_display_props':
> > /usr/local/src/linux-
> > git/arch/powerpc/platforms/powermac/bootx_init.c:211: undefined
> > reference to `__stack_chk_fail_local'
> > arch/powerpc/platforms/built-in.o: In function 
> > `bootx_scan_dt_build_struct':
> > /usr/local/src/linux-
> > git/arch/powerpc/platforms/powermac/bootx_init.c:350: undefined
> > reference to `__stack_chk_fail_local'
> > arch/powerpc/platforms/built-in.o: In function `bootx_init':
> > /usr/local/src/linux-
> > git/arch/powerpc/platforms/powermac/bootx_init.c:596: undefined
> > reference to `__stack_chk_fail_local'
> > /usr/bin/ld.bfd.real: .tmp_vmlinux1: hidden symbol
> > `__stack_chk_fail_local' isn't defined
> > /usr/bin/ld.bfd.real: final link failed: Bad value
> > ================================
> > 
> > 
> > $ ld --version | head -1
> > GNU ld (GNU Binutils for Debian) 2.25
> > 
> > $ gcc --version | head -1
> > gcc-4.9.real (Debian 4.9.2-10) 4.9.2
> > 
> > 
> > I'm regularly compiling userspace programs with -fstack-protector
> > w/o 
> > problems. I suspect it's either
> > 6533b7c16ee5712041b4e324100550e02a9a5dda 
> > ("powerpc: Initial stack protector (-fstack-protector) support") or 
> > 902e06eb86cd62753974c249bd1dedae2825b430 ("powerpc/32: Change the
> > stack 
> > protector canary value per task") or both but I haven't started the 
> > bisection yet.
> > 
> > Any other ideas?
> > 
> > Thanks,
> > Christian.
> 
> 

-- 
BOFH excuse #111:

The salesman drove over the CPU board.
