Return-Path: <mikem@beardog.cca.cpqcorp.net>
Received: from palrel13.hp.com (palrel13.hp.com [156.153.255.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "palrel13.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 8BCAF67B8D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Sep 2006 07:53:27 +1000 (EST)
Received: from beardog.cca.cpqcorp.net (beardog.cca.cpqcorp.net
	[16.101.176.144])
	by palrel13.hp.com (Postfix) with ESMTP id 61F4136B64
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Sep 2006 14:35:31 -0700 (PDT)
Date: Thu, 21 Sep 2006 16:35:21 -0500
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: linuxppc-embedded@ozlabs.org
Subject: compile errors 
Message-ID: <20060921213521.GA19725@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,
I tried searching for my error without any luck.

I'm new to PPC and embedded linux so please bear with me. I'm trying to cross-compile
on an x86 host for a PPC 440SP target. I downloaded and installed the ELDK from 
Wolfgang Denk's website. I execute:

	make ARCH=ppc CROSS_COMPILE=ppc_45xx- menuconfig

and configure, save, and exit. To try and build the kernel I execute:

	make ARCH=ppc CROSS_COMPILE=ppc_45xx-

it cranks along for a minute before erroring out with:

  ppc_4xx-gcc -m32 -Wp,-MD,arch/powerpc/kernel/.process.o.d  -nostdinc -isystem /home/embedded/denx/usr/bin/../lib/gcc/powerpc-linux/4.0.0/include -D__KERNEL__ -Iinclude  -include include/linux/autoconf.h -Iarch/ppc -Iarch/ppc/include -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding -Os     -fomit-frame-pointer -g -Iarch/ppc -msoft-float -pipe -ffixed-r2 -mmultiple  -mno-altivec -mstring -Wa,-m405 -Wdeclaration-after-statement -Wno-pointer-sign    -DKBUILD_BASENAME=process -DKBUILD_MODNAME=process -c -o arch/powerpc/kernel/.tmp_process.o arch/powerpc/kernel/process.c
arch/powerpc/kernel/process.c: In function 'set_dabr':
arch/powerpc/kernel/process.c:228: error: 'struct machdep_calls' has no member named 'set_dabr'
arch/powerpc/kernel/process.c:229: error: 'struct machdep_calls' has no member named 'set_dabr'
make[1]: *** [arch/powerpc/kernel/process.o] Error 1
make: *** [arch/powerpc/kernel] Error 2

Any suggestions on what's wrong? I've had the same error on the 2.6.15 kernel provided
with the ELDK as well as kernel.org 2.6.10 and 2.6.16.29. My path points to the
denx directories first and ${CROSS_COMPILE}=ppc_4xx-.

Any help is greatly appreciated.

Thanks,
mikem
