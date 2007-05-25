Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 858CEDDEEA
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 11:32:57 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l4P1rNJx216594
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 11:53:23 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4P1aJRD110008
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 11:36:19 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4P1Wl53016864
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 11:32:47 +1000
Date: Fri, 25 May 2007 11:27:39 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: 440 ebony patch seems to have broken 85xx build on powerpc.git
Message-ID: <20070525012739.GA11789@localhost.localdomain>
References: <4655C7A6.2050606@mvista.com> <4655D353.6000304@ru.mvista.com>
	<1180030140.3360.24.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1180030140.3360.24.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 24, 2007 at 01:09:00PM -0500, Josh Boyer wrote:
> On Thu, 2007-05-24 at 22:02 +0400, Sergei Shtylyov wrote:
> > Dave Jiang wrote:
> > 
> > > Has anyone been able to build mpc85xx_* from the latest powerpc.git? I have
> > > tried mpc85xx_cds and mpc8560_ads. I pulled a new git tree and attempted to
> > > build and hit the error message below.
> > 
> > > Also, if I comment out the two lines in arch/powerpc/boot/Makefile that was
> > > introduced by the 440 Ebony support patch everything is fine.
> > 
> > > $(obj)/44x.o: BOOTCFLAGS += -Wa,-mbooke
> > > $(obj)/ebony.o: BOOTCFLAGS += -Wa,-mbooke
> > 
> > > make -f
> > > /home/djiang/community/git-repos/tmp/ppc-master/scripts/Makefile.modpost vmlinux
> > >   scripts/mod/modpost   -o
> > > /home/djiang/community/git-repos/tmp/ppc-master/Module.symvers
> > > arch/powerpc/kernel/head_fsl_booke.o  init/built-in.o  usr/built-in.o
> > > arch/powerpc/kernel/built-in.o  arch/powerpc/mm/built-in.o
> > > arch/powerpc/lib/built-in.o  arch/powerpc/sysdev/built-in.o
> > > arch/powerpc/platforms/built-in.o  arch/powerpc/math-emu/built-in.o
> > > kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o
> > > security/built-in.o  crypto/built-in.o  block/built-in.o  lib/lib.a
> > > lib/built-in.o  drivers/built-in.o  sound/built-in.o  net/built-in.o
> > > WARNING: arch/powerpc/mm/built-in.o(.text+0x10bc): Section mismatch: reference
> > > to .init.text:early_get_page (between 'pte_alloc_one_kernel' and 'steal_context')
> > > rm -f .old_version
> > > make ARCH=ppc64 -f scripts/Makefile.build obj=arch/powerpc/boot
> > > arch/powerpc/boot/uImage
> > >   /opt/montavista/cge/devkit/ppc/85xx/bin/ppc_85xx-gcc -m32
> > > -Wp,-MD,arch/powerpc/boot/.ebony.o.d -Wall -Wstrict-prototypes -O2
> > > -fomit-frame-pointer -fno-builtin -nostdinc -isystem
> > > /opt/montavista/cge/devkit/ppc/85xx/bin/../lib/gcc/powerpc-montavista-linux-gnuspe/4.2.0/include
> > > -fPIC -fno-stack-protector -Iarch/powerpc/boot
> > > -I/home/djiang/community/git-repos/tmp/ppc-master/arch/powerpc/boot -Wa,-mbooke
> > > -c -o arch/powerpc/boot/ebony.o arch/powerpc/boot/ebony.c
> > > /home/djiang/tmp/cc2UVyci.s: Assembler messages:
> > > /home/djiang/tmp/cc2UVyci.s:142: Error: Unrecognized opcode: `isel'
> > > make[1]: *** [arch/powerpc/boot/ebony.o] Error 1
> > 
> >     I wonder WTF ebony.c gets built for MPC85xx targets? :-O
> 
> Because it's part of the bootwrapper and all platform files get built no
> matter what the actual target is at the moment.
> 
> We might want to take a look at why we're doing that again.

So that we have a better chance of catching platform specific build
bugs: which we just did.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
