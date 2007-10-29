Return-Path: <jdi@l4x.org>
Received: from mail.trixing.net (mail.trixing.net [87.230.125.58])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7773CDE16A
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 08:50:11 +1100 (EST)
Message-ID: <47265586.1050701@l4x.org>
Date: Mon, 29 Oct 2007 22:49:58 +0100
From: Jan Dittmer <jdi@l4x.org>
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
Subject: Re: boot/wrap assumes a biarch toolchain?
References: <20071029140719.GA17120@kryten>
	<jesl3udm0e.fsf@sykes.suse.de>	<4725F34C.6090904@ppp0.net>
	<jelk9mdj6e.fsf@sykes.suse.de>	<47263830.2010009@l4x.org>
	<jebqahei70.fsf@sykes.suse.de>
In-Reply-To: <jebqahei70.fsf@sykes.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Jan Dittmer <jdittmer@ppp0.net>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andreas Schwab wrote:
> Jan Dittmer <jdi@l4x.org> writes:
> 
>> Andreas Schwab wrote:
>>> Jan Dittmer <jdittmer@ppp0.net> writes:
>>>
>>>> $ powerpc64-linux-gcc-4.0.4 -v
>>>> Using built-in specs.
>>>> Target: powerpc64-linux
>>>> Configured with: ../configure --prefix=/usr/cc217
>>>> --exec-prefix=/usr/cc217/powerpc64 --target=powerpc64-linux
>>>> --disable-shared --disable-werror --disable-nls --disable-threads
>>>> --disable-werror --disable-libmudflap --with-newlib --with-gnu-as
>>>> --with-gnu-ld --enable-languages=c
>>>> Thread model: single
>>>> gcc version 4.0.4
>>>>
>>>> g5_defconfig:
>>>>
>>>> $ make ARCH=powerpc HOSTCC=gcc-4.0 CROSS_COMPILE=powerpc64-linux- 
>>>> CROSS32_COMPILE=powerpc64-linux-
>>> Your compiler still needs -m32 to generate 32-bit code (or use
>>> --with-cpu=default32 to make that the default).
>> 4.1.2 exhibits the same behavior.
> 
> What do you mean with "the same behavior"?

Same error, you write above that a newer compiler version should
not need -m32 or --with-cpu=default32 any more? But I still get:

   CC      arch/powerpc/kernel/signal.o
   LDS     arch/powerpc/kernel/vdso32/vdso32.lds
   VDSO32A arch/powerpc/kernel/vdso32/sigtramp.o
   VDSO32A arch/powerpc/kernel/vdso32/gettimeofday.o
/usr/src/xtest/linux-2.6/arch/powerpc/kernel/vdso32/gettimeofday.S: 
Assembler messages:
/usr/src/xtest/linux-2.6/arch/powerpc/kernel/vdso32/gettimeofday.S:33: 
Error: syntax error; found `@' but expected `,'
/usr/src/xtest/linux-2.6/arch/powerpc/kernel/vdso32/gettimeofday.S:33: 
Error: junk at end of line: `@local'
/usr/src/xtest/linux-2.6/arch/powerpc/kernel/vdso32/gettimeofday.S:37: 
Error: syntax error; found `@' but expected `,'
/usr/src/xtest/linux-2.6/arch/powerpc/kernel/vdso32/gettimeofday.S:37: 
Error: junk at end of line: `@local'
/usr/src/xtest/linux-2.6/arch/powerpc/kernel/vdso32/gettimeofday.S:95: 
Error: syntax error; found `@' but expected `,'
/usr/src/xtest/linux-2.6/arch/powerpc/kernel/vdso32/gettimeofday.S:95: 
Error: junk at end of line: `@local'
/usr/src/xtest/linux-2.6/arch/powerpc/kernel/vdso32/gettimeofday.S:103: 
Error: syntax error; found `@' but expected `,'
/usr/src/xtest/linux-2.6/arch/powerpc/kernel/vdso32/gettimeofday.S:103: 
Error: junk at end of line: `@local'
/usr/src/xtest/linux-2.6/arch/powerpc/kernel/vdso32/gettimeofday.S:130: 
Error: syntax error; found `@' but expected `,'
/usr/src/xtest/linux-2.6/arch/powerpc/kernel/vdso32/gettimeofday.S:130: 
Error: junk at end of line: `@local'
make[3]: *** [arch/powerpc/kernel/vdso32/gettimeofday.o] Error 1
make[2]: *** [arch/powerpc/kernel/vdso32] Error 2
make[1]: *** [arch/powerpc/kernel] Error 2
make: *** [sub-make] Error 2

Jan

> 
> Andreas.
> 
