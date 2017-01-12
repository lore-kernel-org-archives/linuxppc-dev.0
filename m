Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzpQ70d79zDqVn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2017 01:42:38 +1100 (AEDT)
Subject: Re: bootx_init.c:88: undefined reference to `__stack_chk_fail_local'
To: Segher Boessenkool <segher@kernel.crashing.org>
References: <alpine.DEB.2.20.99.1701030715390.31470@trent.utfs.org>
 <81ef821b-8af2-0ee5-ab35-58639548dab7@c-s.fr>
 <alpine.DEB.2.20.99.1701040957380.31470@trent.utfs.org>
 <alpine.DEB.2.20.999.1701091739320.5450@trent.utfs.org>
 <d0e56084-49d7-2486-c2a6-de146331d1c7@c-s.fr>
 <20170111225440.GQ28613@gate.crashing.org>
 <1c81ce1a-33ca-7ba4-56f5-976935deb609@c-s.fr>
Cc: Christian Kujau <lists@nerdbynature.de>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <7604032b-c9ae-e3ce-fcd5-d9e555559f52@c-s.fr>
Date: Thu, 12 Jan 2017 15:42:34 +0100
MIME-Version: 1.0
In-Reply-To: <1c81ce1a-33ca-7ba4-56f5-976935deb609@c-s.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 12/01/2017 à 08:52, Christophe LEROY a écrit :
>
>
> Le 11/01/2017 à 23:54, Segher Boessenkool a écrit :
>> On Tue, Jan 10, 2017 at 07:26:15AM +0100, Christophe LEROY wrote:
>>>> Maybe ppc32 is not supposed to be built with CC_STACKPROTECTOR ?
>>>
>>> Indeed, the latest versions of GCC don't use anymore the global variable
>>> __stack_chk_guard as canary value, but a value stored at -0x7008(r2).
>>> This is not compatible with the current implementation of  the kernel
>>> with uses r2 as a pointeur to current task struct.
>>> So until we fix it, I don't think CC_STACKPROTECTOR is usable on PPC
>>> with modern versions of GCC.
>>
>> I still wonder what changed.  Nothing relevant has changed for ten years
>> or whatever as far as I see; unless it is just the
>> -fstack-protector-strong
>> that makes it fail now.  Curious.
>>
>
> Yes, looks like it was changed from global to TLS in 2005 on powerpc.
> Indeed when I implemented STACKPROTECTOR in Kernel on ppc I
> copied/pasted it from ARM which is (still?) using the global
> __stack_chk_guard, and at first it worked quite well on my powerpc.
>
> x86 has the following option on GCC. Couldn't we have it on powerpc too ?
>
> -mstack-protector-guard=guard
> Generate  stack  protection  code  using  canary  at
> guard.   Supported  locations are ‘ global ’ for global canary or ‘ tls
> ’ for per-thread canary in the TLS block (the  default). This  option
> has  effect  only  when  ‘-fstack-protector’  or ‘-fstack-protector-all’
> is specified.
>

Finally, it looks like it is not so easy.

I have three instances of GCC:
* 4.4.4, home built
* 4.6.3, from https://www.kernel.org/pub/tools/crosstool/
* 4.8.3, home built

The 4.6.3 uses __stack_chk_guard, while the 4.4.4 and 4.8.3 use -28680(r2)

Is it dependent on the way GCC is built ? Then do we have a way to know, 
when we compile, which method GCC will use ?

See details below for each of the 3 GCC versions.

Christophe

Using built-in specs.
Target: ppc-linux
Configured with: /root/cldk/gcc-4.4.4/configure --target=ppc-linux 
--with-headers=yes --with-cpu=860 --prefix=/opt/cldk 
--bindir=/opt/cldk/bin --sbindir=/opt/cldk/sbin 
--libexecdir=/opt/cldk/libexec --datadir=/opt/cldk/share 
--sysconfdir=/opt/cldk/etc --libdir=/opt/cldk/lib 
--includedir=/opt/cldk/usr/include --oldincludedir=/opt/cldk/usr/include 
--infodir=/opt/cldk/share/info --mandir=/opt/cldk/share/man 
--enable-languages=c,c++
Thread model: posix
gcc version 4.4.4 (GCC)

0000007c <name_to_dev_t>:
   7c:	7c 08 02 a6 	mflr    r0
   80:	94 21 ff a0 	stwu    r1,-96(r1)
   84:	3c 80 00 00 	lis     r4,0
			86: R_PPC_ADDR16_HA	.rodata.str1.4+0x1bc
   88:	93 c1 00 58 	stw     r30,88(r1)
   8c:	93 e1 00 5c 	stw     r31,92(r1)
   90:	90 01 00 64 	stw     r0,100(r1)
   94:	93 81 00 50 	stw     r28,80(r1)
   98:	93 a1 00 54 	stw     r29,84(r1)
   9c:	38 84 01 bc 	addi    r4,r4,444
			9e: R_PPC_ADDR16_LO	.rodata.str1.4+0x1bc
   a0:	38 a0 00 09 	li      r5,9
   a4:	80 02 8f f8 	lwz     r0,-28680(r2)
   a8:	90 01 00 4c 	stw     r0,76(r1)

[...]

   fc:	80 01 00 4c 	lwz     r0,76(r1)
  100:	81 22 8f f8 	lwz     r9,-28680(r2)
  104:	7c 00 4a 79 	xor.    r0,r0,r9
  108:	39 20 00 00 	li      r9,0
  10c:	7f a3 eb 78 	mr      r3,r29
  110:	40 82 03 88 	bne-    498 <name_to_dev_t+0x41c>

[...]

  498:	48 00 00 01 	bl      498 <name_to_dev_t+0x41c>
			498: R_PPC_REL24	__stack_chk_fail


Using built-in specs.
COLLECT_GCC=powerpc64-linux-gcc
COLLECT_LTO_WRAPPER=/opt/gcc-4.6.3-nolibc/powerpc64-linux/bin/../libexec/gcc/powerpc64-linux/4.6.3/lto-wrapper
Target: powerpc64-linux
Configured with: /home/tony/buildall/src/gcc/configure 
--target=powerpc64-linux --host=i686-linux-gnu --build=i686-linux-gnu 
--enable-targets=all 
--prefix=/opt/cross/gcc-4.6.3-nolibc/powerpc64-linux/ 
--enable-languages=c --with-newlib --without-headers 
--enable-sjlj-exceptions --with-system-libunwind --disable-nls 
--disable-threads --disable-shared --disable-libmudflap --disable-libssp 
--disable-libgomp --disable-decimal-float --enable-checking=release 
--with-mpfr=/home/tony/buildall/src/sys-i686 
--with-gmp=/home/tony/buildall/src/sys-i686 --disable-bootstrap 
--disable-libquadmath
Thread model: single
gcc version 4.6.3 (GCC)

000000c0 <name_to_dev_t>:
   c0:	94 21 ff a0 	stwu    r1,-96(r1)
   c4:	7c 08 02 a6 	mflr    r0
   c8:	3c 80 00 00 	lis     r4,0
			ca: R_PPC_ADDR16_HA	.rodata.str1.4+0x50
   cc:	38 a0 00 09 	li      r5,9
   d0:	38 84 00 50 	addi    r4,r4,80
			d2: R_PPC_ADDR16_LO	.rodata.str1.4+0x50
   d4:	bf 81 00 50 	stmw    r28,80(r1)
   d8:	3f e0 00 00 	lis     r31,0
			da: R_PPC_ADDR16_HA	__stack_chk_guard
   dc:	7c 7e 1b 78 	mr      r30,r3
   e0:	90 01 00 64 	stw     r0,100(r1)
   e4:	3b ff 00 00 	addi    r31,r31,0
			e6: R_PPC_ADDR16_LO	__stack_chk_guard
   e8:	80 1f 00 00 	lwz     r0,0(r31)
   ec:	90 01 00 4c 	stw     r0,76(r1)

[...]

  13c:	81 21 00 4c 	lwz     r9,76(r1)
  140:	80 1f 00 00 	lwz     r0,0(r31)
  144:	7d 29 02 79 	xor.    r9,r9,r0
  148:	38 00 00 00 	li      r0,0
  14c:	7f 83 e3 78 	mr      r3,r28
  150:	40 82 03 68 	bne-    4b8 <name_to_dev_t+0x3f8>

[...]

  4b8:	48 00 00 01 	bl      4b8 <name_to_dev_t+0x3f8>
			4b8: R_PPC_REL24	__stack_chk_fail


Using built-in specs.
COLLECT_GCC=ppc-linux-gcc
COLLECT_LTO_WRAPPER=/opt/cldk/libexec/gcc/ppc-linux/4.8.3/lto-wrapper
Target: ppc-linux
Configured with: /root/cldk/gcc-4.8.3/configure --target=ppc-linux 
--with-headers=yes --with-cpu=860 --prefix=/opt/cldk 
--bindir=/opt/cldk/bin --sbindir=/opt/cldk/sbin 
--libexecdir=/opt/cldk/libexec --datadir=/opt/cldk/share 
--sysconfdir=/opt/cldk/etc --libdir=/opt/cldk/lib 
--includedir=/opt/cldk/usr/include --oldincludedir=/opt/cldk/usr/include 
--infodir=/opt/cldk/share/info --mandir=/opt/cldk/share/man 
--enable-languages=c,c++
Thread model: posix
gcc version 4.8.3 (GCC)

000000b0 <name_to_dev_t>:
   b0:	7c 08 02 a6 	mflr    r0
   b4:	94 21 ff a0 	stwu    r1,-96(r1)
   b8:	3c 80 00 00 	lis     r4,0
			ba: R_PPC_ADDR16_HA	.rodata.str1.4+0x50
   bc:	bf a1 00 54 	stmw    r29,84(r1)
   c0:	90 01 00 64 	stw     r0,100(r1)
   c4:	38 84 00 00 	addi    r4,r4,0
			c6: R_PPC_ADDR16_LO	.rodata.str1.4+0x50
   c8:	38 a0 00 09 	li      r5,9
   cc:	7c 7f 1b 78 	mr      r31,r3
   d0:	81 22 8f f8 	lwz     r9,-28680(r2)
   d4:	91 21 00 4c 	stw     r9,76(r1)

[...]

  124:	81 41 00 4c 	lwz     r10,76(r1)
  128:	81 22 8f f8 	lwz     r9,-28680(r2)
  12c:	7d 4a 4a 79 	xor.    r10,r10,r9
  130:	39 20 00 00 	li      r9,0
  134:	40 82 03 70 	bne     4a4 <name_to_dev_t+0x3f4>

[...]

  4a4:	48 00 00 01 	bl      4a4 <name_to_dev_t+0x3f4>
			4a4: R_PPC_REL24	__stack_chk_fail
