Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 05D06DDDF7
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 04:01:29 +1000 (EST)
Message-ID: <4655D353.6000304@ru.mvista.com>
Date: Thu, 24 May 2007 22:02:59 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Dave Jiang <djiang@mvista.com>
Subject: Re: 440 ebony patch seems to have broken 85xx build on powerpc.git
References: <4655C7A6.2050606@mvista.com>
In-Reply-To: <4655C7A6.2050606@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dave Jiang wrote:

> Has anyone been able to build mpc85xx_* from the latest powerpc.git? I have
> tried mpc85xx_cds and mpc8560_ads. I pulled a new git tree and attempted to
> build and hit the error message below.

> Also, if I comment out the two lines in arch/powerpc/boot/Makefile that was
> introduced by the 440 Ebony support patch everything is fine.

> $(obj)/44x.o: BOOTCFLAGS += -Wa,-mbooke
> $(obj)/ebony.o: BOOTCFLAGS += -Wa,-mbooke

> make -f
> /home/djiang/community/git-repos/tmp/ppc-master/scripts/Makefile.modpost vmlinux
>   scripts/mod/modpost   -o
> /home/djiang/community/git-repos/tmp/ppc-master/Module.symvers
> arch/powerpc/kernel/head_fsl_booke.o  init/built-in.o  usr/built-in.o
> arch/powerpc/kernel/built-in.o  arch/powerpc/mm/built-in.o
> arch/powerpc/lib/built-in.o  arch/powerpc/sysdev/built-in.o
> arch/powerpc/platforms/built-in.o  arch/powerpc/math-emu/built-in.o
> kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o
> security/built-in.o  crypto/built-in.o  block/built-in.o  lib/lib.a
> lib/built-in.o  drivers/built-in.o  sound/built-in.o  net/built-in.o
> WARNING: arch/powerpc/mm/built-in.o(.text+0x10bc): Section mismatch: reference
> to .init.text:early_get_page (between 'pte_alloc_one_kernel' and 'steal_context')
> rm -f .old_version
> make ARCH=ppc64 -f scripts/Makefile.build obj=arch/powerpc/boot
> arch/powerpc/boot/uImage
>   /opt/montavista/cge/devkit/ppc/85xx/bin/ppc_85xx-gcc -m32
> -Wp,-MD,arch/powerpc/boot/.ebony.o.d -Wall -Wstrict-prototypes -O2
> -fomit-frame-pointer -fno-builtin -nostdinc -isystem
> /opt/montavista/cge/devkit/ppc/85xx/bin/../lib/gcc/powerpc-montavista-linux-gnuspe/4.2.0/include
> -fPIC -fno-stack-protector -Iarch/powerpc/boot
> -I/home/djiang/community/git-repos/tmp/ppc-master/arch/powerpc/boot -Wa,-mbooke
> -c -o arch/powerpc/boot/ebony.o arch/powerpc/boot/ebony.c
> /home/djiang/tmp/cc2UVyci.s: Assembler messages:
> /home/djiang/tmp/cc2UVyci.s:142: Error: Unrecognized opcode: `isel'
> make[1]: *** [arch/powerpc/boot/ebony.o] Error 1

    I wonder WTF ebony.c gets built for MPC85xx targets? :-O

WBR, Sergei
