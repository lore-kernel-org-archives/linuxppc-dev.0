Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJBNS5g6WzDrJV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 22:38:32 +1000 (AEST)
In-Reply-To: <1501075111-20198-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: npiggin@gmail.com
Subject: Re: powerpc/Makefile: Fix ld version check with 64-bit LE-only
 toolchain
Message-Id: <3xJBNS1KFNz9sN5@ozlabs.org>
Date: Thu, 27 Jul 2017 22:38:31 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-07-26 at 13:18:31 UTC, Michael Ellerman wrote:
> In commit efe0160cfd40 ("powerpc/64: Linker on-demand sfpr functions
> for modules"), we added an ld version check early in the powerpc
> top-level Makefile.
> 
> Because the Makefile runs before the kernel config is setup, the
> checks for CONFIG_CPU_LITTLE_ENDIAN etc. all take the default case. So
> we end up configuring ld for 32-bit big endian.
> 
> That would be OK, except that for historical (or perhaps no) reason,
> we use 'override LD' to add the endian flags to the LD variable
> itself, rather than the normal approach of adding them to LDFLAGS.
> 
> The end result is that when we check the ld version we run it as:
> 
>   $(CROSS_COMPILE)ld -EB -m elf32ppc --version
> 
> This often works, unless you are using a 64-bit only and/or little
> endian only, toolchain. In which case you see something like:
> 
>   $ make defconfig
>   powerpc64le-linux-ld: unrecognised emulation mode: elf32ppc
>   Supported emulations: elf64lppc elf32lppc elf32lppclinux elf32lppcsim
>   /bin/sh: 1: [: -ge: unexpected operator
> 
> The proper fix is to stop using 'override LD', but that will require a
> fair bit of testing. Instead we can fix it for now just by reordering
> the Makefile to do the version check earlier.
> 
> Fixes: efe0160cfd40 ("powerpc/64: Linker on-demand sfpr functions for modules")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/b40b2386bce982ad97f3683b2b34e5

cheers
