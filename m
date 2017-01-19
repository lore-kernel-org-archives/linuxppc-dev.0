Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [IPv6:2a03:3680:0:3::67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v3qJM1RFjzDqJn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 14:36:35 +1100 (AEDT)
Date: Wed, 18 Jan 2017 19:36:29 -0800 (PST)
From: Christian Kujau <lists@nerdbynature.de>
To: Christophe Leroy <christophe.leroy@c-s.fr>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH RFC] powerpc/32: fix handling of stack protector with
 recent GCC
In-Reply-To: <20170116090031.4843668B50@localhost.localdomain>
Message-ID: <alpine.DEB.2.20.999.1701181913290.3270@trent.utfs.org>
References: <20170116090031.4843668B50@localhost.localdomain>
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

On Mon, 16 Jan 2017, Christophe Leroy wrote:
>  Christian, can you test it ?

OK, so with that applied to v4.10-rc4, compilation still fails with GCC 
4.9.2 and CC_STACKPROTECTOR_STRONG=y, see below. But it compiles just fine 
with CC_STACKPROTECTOR_REGULAR=y and boots to!

Cross-compiling the same with GCC 5.2.0 works, even for 
CC_STACKPROTECTOR_STRONG=y and the system boots just fine.

So, with that limitation, feel free to add:

 Tested-by: Christian Kujau <lists@nerdbynature.de>


Thanks for the fix!
Christian.


----
$ gcc --version | head -1
gcc-4.9.real (Debian 4.9.2-10) 4.9.2

$ grep CC_STACKPROTECTOR_STRONG $DIR/.config
CONFIG_CC_STACKPROTECTOR_STRONG=y

$ make O=$DIR V=1 bindeb-pkg
[...]
+ ld -EB -m elf32ppc -Bstatic --build-id -X -o .tmp_vmlinux1 -T 
./arch/powerpc/kernel/vmlinux.lds arch/powerpc/kernel/head_32.o 
arch/powerpc/kernel/fpu.o arch/powerpc/kernel/vector.o 
arch/powerpc/kernel/prom_init.o init/built-in.o --start-group 
usr/built-in.o arch/powerpc/kernel/built-in.o arch/powerpc/mm/built-in.o 
arch/powerpc/lib/built-in.o arch/powerpc/sysdev/built-in.o 
arch/powerpc/platforms/built-in.o arch/powerpc/math-emu/built-in.o 
arch/powerpc/crypto/built-in.o arch/powerpc/net/built-in.o 
kernel/built-in.o certs/built-in.o mm/built-in.o fs/built-in.o 
ipc/built-in.o security/built-in.o crypto/built-in.o block/built-in.o 
lib/lib.a lib/built-in.o drivers/built-in.o sound/built-in.o 
firmware/built-in.o net/built-in.o virt/built-in.o --end-group
arch/powerpc/platforms/built-in.o: In function `bootx_printf':
/usr/local/src/linux-git/arch/powerpc/platforms/powermac/bootx_init.c:88: undefined reference to `__stack_chk_fail_local'
arch/powerpc/platforms/built-in.o: In function `bootx_add_display_props':
/usr/local/src/linux-git/arch/powerpc/platforms/powermac/bootx_init.c:211: undefined reference to `__stack_chk_fail_local' 
arch/powerpc/platforms/built-in.o: In function `bootx_scan_dt_build_struct':
/usr/local/src/linux-git/arch/powerpc/platforms/powermac/bootx_init.c:350: undefined reference to `__stack_chk_fail_local'
arch/powerpc/platforms/built-in.o: In function `bootx_init':
/usr/local/src/linux-git/arch/powerpc/platforms/powermac/bootx_init.c:596: undefined reference to `__stack_chk_fail_local'
/usr/bin/ld.bfd.real: .tmp_vmlinux1: hidden symbol `__stack_chk_fail_local' isn't defined
/usr/bin/ld.bfd.real: final link failed: Bad value

-- 
BOFH excuse #66:

bit bucket overflow
