Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Chen Gang <gang.chen@asianux.com>, sfr@canb.auug.org.au
Subject: Re: [Suggestion] PowerPC: kernel: cross compiling issue with
 allmodconfig
In-reply-to: <51428C81.6000204@asianux.com>
References: <51428C81.6000204@asianux.com>
Date: Fri, 15 Mar 2013 15:52:54 +1100
Message-ID: <25841.1363323174@ale.ozlabs.ibm.com>
Cc: matt@ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "paulus@samba.org" <paulus@samba.org>, imunsie@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>   do next-* tree support powerpc POWER7 with allmodconfig ?
> 
>   I met an issue, can we bear it (or I need additional trying) ?
> 
> 
> Compiling:
>   make V=1 EXTRA_CFLAGS=-W ARCH=powerpc allmodconfig
>     set cpu type POWER7 in menuconfig.
>     set cross-compiler in menuconfig.
>       under Fedora 16 x86_64 laptop
>       /usr/bin/powerpc64-linux-gnu-gcc -v
>         gcc version 4.7.1 20120606 (Red Hat 4.7.1-0.1.20120606) (GCC)
> 
> Issue:
>   error:
>     /android/public-kernel/linux-next/arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
>     /android/public-kernel/linux-next/arch/powerpc/kernel/exceptions-64s.S:1304: Error: attempt to move .org backwards
> 
>   command:
>     powerpc64-linux-gnu-gcc -m64 -Wp,-MD,arch/powerpc/kernel/.head_64.o.d  -nostdinc -isystem /usr/lib/gcc/powerpc64-linux-gnu/4.7.1/include -I/android/public-kernel/linux-next/arch/powerpc/include -Iarch/powerpc/include/generated  -I/android/public-kernel/linux-next/include -Iinclude -I/android/public-kernel/linux-next/arch/powerpc/include/uapi -Iarch/powerpc/include/generated/uapi -I/android/public-kernel/linux-next/include/uapi -Iinclude/generated/uapi -include /android/public-kernel/linux-next/include/linux/kconfig.h -D__KERNEL__  -I/android/public-kernel/linux-next/arch/powerpc -Iarch/powerpc -D__ASSEMBLY__  -I/android/public-kernel/linux-next/arch/powerpc -Iarch/powerpc -Wa,-maltivec -gdwarf-2   -c -o arch/powerpc/kernel/head_64.o /android/public-kernel/linux-next/arch/powerpc/kernel/head_64.S
> 
>   (head_64.S includes exceptions-64.S)

Yep it's a known problem but no one has bothered to fix it since it
doesn't happen in a config that anyone cares about like
pseries_defconfig and ppc64_defconfig.  We've been moving code around in
this area a lot recently hence the breakage.

It should be fixed though.  Patches welcome. :-)

Mikey
