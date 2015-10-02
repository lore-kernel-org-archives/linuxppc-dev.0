Return-Path: <labbott@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BFEE81A007F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Oct 2015 01:43:35 +1000 (AEST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Laura Abbott <labbott@redhat.com>
Subject: Missing operand for tlbie instruction on Power7
Message-ID: <560EA623.1040300@redhat.com>
Date: Fri, 2 Oct 2015 08:43:31 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

We received a report (https://bugzilla.redhat.com/show_bug.cgi?id=1267395) of bad assembly
when compiling on powerpc with little endian

[labbott@labbott-redhat-machine linux_upstream]$ make ARCH=powerpc CROSS_COMPILE=powerpc64-linux-gnu-
   CHK     include/config/kernel.release
   CHK     include/generated/uapi/linux/version.h
   CHK     include/generated/utsrelease.h
   CHK     include/generated/bounds.h
   CHK     include/generated/timeconst.h
   CHK     include/generated/asm-offsets.h
   CALL    scripts/checksyscalls.sh
   CHK     include/generated/compile.h
   CALL    arch/powerpc/kernel/systbl_chk.sh
   AS      arch/powerpc/kernel/swsusp_asm64.o
arch/powerpc/kernel/swsusp_asm64.S: Assembler messages:
arch/powerpc/kernel/swsusp_asm64.S:188: Error: missing operand
scripts/Makefile.build:294: recipe for target 'arch/powerpc/kernel/swsusp_asm64.o' failed
make[1]: *** [arch/powerpc/kernel/swsusp_asm64.o] Error 1
Makefile:941: recipe for target 'arch/powerpc/kernel' failed
make: *** [arch/powerpc/kernel] Error 2

This problem started happening after a binutils update:

[labbott@labbott-redhat-machine linux_upstream]$ powerpc64-linux-gnu-as --version
GNU assembler version 2.25.1-1.fc22
Copyright (C) 2014 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or later.
This program has absolutely no warranty.
This assembler was configured for a target of `powerpc64-linux-gnu'.
[labbott@labbott-redhat-machine linux_upstream]$

After some discussion with the binutils folks, it turns out that the tlbie
instruction actually requires another operand and binutils was updated to
check for this https://sourceware.org/ml/binutils/2015-05/msg00133.html .

The code sequence in arch/powerpc/include/asm/ppc_asm.h now needs to be updated:

#if !defined(CONFIG_4xx) && !defined(CONFIG_8xx)
#define tlbia                                   \
         li      r4,1024;                        \
         mtctr   r4;                             \
         lis     r4,KERNELBASE@h;                \
0:      tlbie   r4;                             \
         addi    r4,r4,0x1000;                   \
         bdnz    0b
#endif

I don't know enough ppc assembly to properly fix this but I can test.

Thanks,
Laura
