Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA3AC1A07F1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 10:43:00 +1100 (AEDT)
Message-ID: <1444779780.12197.3.camel@ellerman.id.au>
Subject: Re: [RFC, 1/2] scripts/kconfig/Makefile: Allow KBUILD_DEFCONFIG to
 be a target
From: Michael Ellerman <mpe@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, mmarek@suse.com, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, yann.morin.1998@free.fr,
 "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
Date: Wed, 14 Oct 2015 10:43:00 +1100
In-Reply-To: <CAOesGMjDC99RFEenyUqc2uhpT9EhqhevrqxiO5Gd7AN_GWmrkg@mail.gmail.com>
References: <1442986835-13985-1-git-send-email-mpe@ellerman.id.au>
 <20151002074708.CF4DC14076A@ozlabs.org>
 <CAOesGMjDC99RFEenyUqc2uhpT9EhqhevrqxiO5Gd7AN_GWmrkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-10-13 at 14:02 -0700, Olof Johansson wrote:
> On Fri, Oct 2, 2015 at 12:47 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > On Wed, 2015-23-09 at 05:40:34 UTC, Michael Ellerman wrote:
> >> Arch Makefiles can set KBUILD_DEFCONFIG to tell kbuild the name of the
> >> defconfig that should be built by default.
> >>
> >> However currently there is an assumption that KBUILD_DEFCONFIG points to
> >> a file at arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG).
> >>
> >> We would like to use a target, using merge_config, as our defconfig, so
> >> adapt the logic in scripts/kconfig/Makefile to allow that.
> >>
> >> To minimise the chance of breaking anything, we first check if
> >> KBUILD_DEFCONFIG is a file, and if so we do the old logic. If it's not a
> >> file, then we call the top-level Makefile with KBUILD_DEFCONFIG as the
> >> target.
> >>
> >> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> >> Acked-by: Michal Marek <mmarek@suse.com>
> >
> > Applied to powerpc next.
> >
> > https://git.kernel.org/powerpc/c/d2036f30cfe1daa19e63ce75
> 
> This breaks arm64 defconfig for me:
> 
> mkdir obj-tmp
> make -f Makefile O=obj-tmp ARCH=arm64 defconfig
> ... watch loop of:
> *** Default configuration is based on target 'defconfig'
>   GEN     ./Makefile

Crap, sorry. I knew I shouldn't have touched that code!

Does this fix it for you?

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index b2b9c87..3043d6b 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -96,7 +96,7 @@ savedefconfig: $(obj)/conf
 defconfig: $(obj)/conf
 ifeq ($(KBUILD_DEFCONFIG),)
        $< $(silent) --defconfig $(Kconfig)
-else ifneq ($(wildcard arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG)),)
+else ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG)),)
        @$(kecho) "*** Default configuration is based on '$(KBUILD_DEFCONFIG)'"
        $(Q)$< $(silent) --defconfig=arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG) $(Kconfig)
 else



$ make O=obj CROSS_COMPILE=/opt/cross/gcc-4.9.0-nolibc/aarch64-linux/bin/aarch64-linux- ARCH=arm64 defconfig
make[1]: Entering directory '/home/michael/kernels/linux-next/obj'
  HOSTCC  scripts/basic/fixdep
  GEN     ./Makefile
  HOSTCC  scripts/kconfig/conf.o
  SHIPPED scripts/kconfig/zconf.tab.c
  SHIPPED scripts/kconfig/zconf.lex.c
  SHIPPED scripts/kconfig/zconf.hash.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
*** Default configuration is based on 'defconfig'
#
# configuration written to .config
#
make[1]: Leaving directory '/home/michael/kernels/linux-next/obj'
$ head obj/.config
#
# Automatically generated file; DO NOT EDIT.
# Linux/arm64 4.3.0-rc5 Kernel Configuration
#
CONFIG_ARM64=y
CONFIG_64BIT=y
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_MMU=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000


cheers
