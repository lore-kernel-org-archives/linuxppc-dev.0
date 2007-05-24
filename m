Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 87C2FDDE41
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 05:40:03 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4OJf1cI022411
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 15:41:01 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4OJe0EF119180
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 15:40:00 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4OJdx73032322
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 15:40:00 -0400
Subject: Re: 440 ebony patch seems to have broken 85xx build on powerpc.git
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <2ded9f19fbaf49a89ed6e32de87f5828@kernel.crashing.org>
References: <4655C7A6.2050606@mvista.com>
	<2ded9f19fbaf49a89ed6e32de87f5828@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 24 May 2007 14:39:03 -0500
Message-Id: <1180035543.3360.25.camel@zod.rchland.ibm.com>
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

On Thu, 2007-05-24 at 21:05 +0200, Segher Boessenkool wrote:
> > $(obj)/44x.o: BOOTCFLAGS += -Wa,-mbooke
> > $(obj)/ebony.o: BOOTCFLAGS += -Wa,-mbooke
> 
> Probably -Wa,-m440 works better.  However...
> 
> >   /opt/montavista/cge/devkit/ppc/85xx/bin/ppc_85xx-gcc -m32
> > -Wp,-MD,arch/powerpc/boot/.ebony.o.d -Wall -Wstrict-prototypes -O2
> > -fomit-frame-pointer -fno-builtin -nostdinc -isystem
> > /opt/montavista/cge/devkit/ppc/85xx/bin/../lib/gcc/powerpc-montavista- 
> > linux-gnuspe/4.2.0/include
> > -fPIC -fno-stack-protector -Iarch/powerpc/boot
> > -I/home/djiang/community/git-repos/tmp/ppc-master/arch/powerpc/boot  
> > -Wa,-mbooke
> > -c -o arch/powerpc/boot/ebony.o arch/powerpc/boot/ebony.c
> 
> Nothing is telling GCC what CPU to compile for, so it
> will just use the compiler's default, which very likely
> is not what you want.  For files that will only ever
> be used on 440, the correct flags are -mcpu=440 -Wa,-m440 .

We could add that to the per-file flags already, right?

josh
