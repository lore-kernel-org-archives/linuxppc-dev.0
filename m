Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DFDDDDDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 03:38:49 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4OHck52020212
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 13:38:46 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4OHckqR510450
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 13:38:46 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4OHcjgi020147
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 13:38:46 -0400
Subject: Re: 440 ebony patch seems to have broken 85xx build on powerpc.git
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Dave Jiang <djiang@mvista.com>
In-Reply-To: <4655C7A6.2050606@mvista.com>
References: <4655C7A6.2050606@mvista.com>
Content-Type: text/plain
Date: Thu, 24 May 2007 12:37:49 -0500
Message-Id: <1180028269.3360.21.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-24 at 10:13 -0700, Dave Jiang wrote:
> Has anyone been able to build mpc85xx_* from the latest powerpc.git? I have
> tried mpc85xx_cds and mpc8560_ads. I pulled a new git tree and attempted to
> build and hit the error message below.
> 
> Also, if I comment out the two lines in arch/powerpc/boot/Makefile that was
> introduced by the 440 Ebony support patch everything is fine.
> 
> $(obj)/44x.o: BOOTCFLAGS += -Wa,-mbooke
> $(obj)/ebony.o: BOOTCFLAGS += -Wa,-mbooke

Without those, other toolchains will break on those files because they
don't understand mtdcr/mfdcr by default.

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

What versions of binutils, and gcc are you using?

It seems we're going to have to start doing conditional per-file CFLAGS
or something else if we continue to compile all the platform files in
the bootwrapper.  I'm not too thrilled with that.

josh
