Return-Path: <jdittmer@ppp0.net>
Received: from rzcomm22.rz.tu-bs.de (rzcomm22.rz.tu-bs.de [134.169.9.68])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0FF87DE007
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 01:57:53 +1100 (EST)
Message-ID: <4725F34C.6090904@ppp0.net>
Date: Mon, 29 Oct 2007 15:50:52 +0100
From: Jan Dittmer <jdittmer@ppp0.net>
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
Subject: Re: boot/wrap assumes a biarch toolchain?
References: <20071029140719.GA17120@kryten> <jesl3udm0e.fsf@sykes.suse.de>
In-Reply-To: <jesl3udm0e.fsf@sykes.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andreas Schwab wrote:
> Anton Blanchard <anton@samba.org> writes:
> 
>> One way to make this go away would be to build binutils as biarch:
>>
>> # configure --target=powerpc-linux --enable-targets=powerpc64-linux ...
> 
> If you configure your toolchain for powerpc64-linux you get a biarch
> toolchain by default.

Hmm:

$ powerpc64-linux-ld -V
GNU ld (Linux/GNU Binutils) 2.17.50.0.17.20070615
   Supported emulations:
    elf64ppc
    elf32ppclinux
    elf32ppc
    elf32ppcsim

$ powerpc64-linux-gcc-4.0.4 -v
Using built-in specs.
Target: powerpc64-linux
Configured with: ../configure --prefix=/usr/cc217 
--exec-prefix=/usr/cc217/powerpc64 --target=powerpc64-linux --disable-shared 
--disable-werror --disable-nls --disable-threads --disable-werror 
--disable-libmudflap --with-newlib --with-gnu-as --with-gnu-ld 
--enable-languages=c
Thread model: single
gcc version 4.0.4

g5_defconfig:

$ make ARCH=powerpc HOSTCC=gcc-4.0 CROSS_COMPILE=powerpc64-linux- 
CROSS32_COMPILE=powerpc64-linux-
...
   CC      arch/powerpc/kernel/signal.o
   LDS     arch/powerpc/kernel/vdso32/vdso32.lds
   VDSO32A arch/powerpc/kernel/vdso32/sigtramp.o
   VDSO32A arch/powerpc/kernel/vdso32/gettimeofday.o
/usr/src/xtest/linux-2.6/arch/powerpc/kernel/vdso32/gettimeofday.S: Assembler 
messages:
/usr/src/xtest/linux-2.6/arch/powerpc/kernel/vdso32/gettimeofday.S:33: Error: 
syntax error; found `@' but expected `,'
/usr/src/xtest/linux-2.6/arch/powerpc/kernel/vdso32/gettimeofday.S:33: Error: 
junk at end of line: `@local'
/usr/src/xtest/linux-2.6/arch/powerpc/kernel/vdso32/gettimeofday.S:37: Error: 
syntax error; found `@' but expected `,'
/usr/src/xtest/linux-2.6/arch/powerpc/kernel/vdso32/gettimeofday.S:37: Error: 
junk at end of line: `@local'
/usr/src/xtest/linux-2.6/arch/powerpc/kernel/vdso32/gettimeofday.S:95: Error: 
syntax error; found `@' but expected `,'
/usr/src/xtest/linux-2.6/arch/powerpc/kernel/vdso32/gettimeofday.S:95: Error: 
junk at end of line: `@local'
/usr/src/xtest/linux-2.6/arch/powerpc/kernel/vdso32/gettimeofday.S:103: Error: 
syntax error; found `@' but expected `,'
/usr/src/xtest/linux-2.6/arch/powerpc/kernel/vdso32/gettimeofday.S:103: Error: 
junk at end of line: `@local'
/usr/src/xtest/linux-2.6/arch/powerpc/kernel/vdso32/gettimeofday.S:130: Error: 
syntax error; found `@' but expected `,'
/usr/src/xtest/linux-2.6/arch/powerpc/kernel/vdso32/gettimeofday.S:130: Error: 
junk at end of line: `@local'
make[3]: *** [arch/powerpc/kernel/vdso32/gettimeofday.o] Error 1
make[2]: *** [arch/powerpc/kernel/vdso32] Error 2
make[1]: *** [arch/powerpc/kernel] Error 2
make: *** [sub-make] Error 2


Jan
