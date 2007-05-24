Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 387B2DDDFB
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 05:05:44 +1000 (EST)
In-Reply-To: <4655C7A6.2050606@mvista.com>
References: <4655C7A6.2050606@mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2ded9f19fbaf49a89ed6e32de87f5828@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 440 ebony patch seems to have broken 85xx build on powerpc.git
Date: Thu, 24 May 2007 21:05:28 +0200
To: Dave Jiang <djiang@mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> $(obj)/44x.o: BOOTCFLAGS += -Wa,-mbooke
> $(obj)/ebony.o: BOOTCFLAGS += -Wa,-mbooke

Probably -Wa,-m440 works better.  However...

>   /opt/montavista/cge/devkit/ppc/85xx/bin/ppc_85xx-gcc -m32
> -Wp,-MD,arch/powerpc/boot/.ebony.o.d -Wall -Wstrict-prototypes -O2
> -fomit-frame-pointer -fno-builtin -nostdinc -isystem
> /opt/montavista/cge/devkit/ppc/85xx/bin/../lib/gcc/powerpc-montavista- 
> linux-gnuspe/4.2.0/include
> -fPIC -fno-stack-protector -Iarch/powerpc/boot
> -I/home/djiang/community/git-repos/tmp/ppc-master/arch/powerpc/boot  
> -Wa,-mbooke
> -c -o arch/powerpc/boot/ebony.o arch/powerpc/boot/ebony.c

Nothing is telling GCC what CPU to compile for, so it
will just use the compiler's default, which very likely
is not what you want.  For files that will only ever
be used on 440, the correct flags are -mcpu=440 -Wa,-m440 .


Segher
