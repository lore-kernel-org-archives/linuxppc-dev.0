Return-Path: <sam@ravnborg.org>
Received: from pasmtpB.tele.dk (pasmtpb.tele.dk [80.160.77.98])
	by ozlabs.org (Postfix) with ESMTP id 2028BDDEA3
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 19:49:45 +1000 (EST)
Date: Wed, 25 Jul 2007 11:50:59 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: "do section mismatch check on full vmlinux" breaks powerpc build
Message-ID: <20070725095059.GA25580@uranus.ravnborg.org>
References: <20070724224105.GG951@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070724224105.GG951@localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 24, 2007 at 05:41:05PM -0500, Nathan Lynch wrote:
> Hello-
> 
> 2.6.23-rc1 breaks the build for 64-bit powerpc for me (using
> maple_defconfig):
> 
>   LD      vmlinux.o
> powerpc64-unknown-linux-gnu-ld: dynreloc miscount for
> kernel/built-in.o, section .opd
> powerpc64-unknown-linux-gnu-ld: can not edit opd Bad value
> make: *** [vmlinux.o] Error 1
> 
> This is on a i386 host with:
> powerpc64-unknown-linux-gnu-gcc (GCC) 4.1.2
> GNU ld version 2.16.1
> 
> Reverting the following commit fixes it:
> 
> commit 741f98fe298a73c9d47ed53703c1279a29718581
> Author: Sam Ravnborg <sam@ravnborg.org>
> Date:   Tue Jul 17 10:54:06 2007 +0200
> 
>     kbuild: do section mismatch check on full vmlinux
> 
> 
> However, I see a possibly related binutils patch:
> http://article.gmane.org/gmane.comp.gnu.binutils/33650
> 
> Will there be a kbuild fix for this or should I update my binutils?

Did a bit more testing.
Im am down to the following to reproduce the fault:
 /opt/crosstool/gcc-4.1.0-glibc-2.3.6/powerpc64-unknown-linux-gnu/bin/powerpc64-unknown-linux-gnu-ld -m elf64ppc  -r -o vmlinux.o kernel/signal.o arch/powerpc/kernel/vdso.o

Seems that vdso.o and signal.o does not like each other??

	Sam
