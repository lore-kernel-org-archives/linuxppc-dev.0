Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHppR41B1zDvhf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 11:55:27 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 4/7] powerpc/64: tool to check head sections location
 sanity
In-Reply-To: <20161019031600.17933-5-npiggin@gmail.com>
References: <20161019031600.17933-1-npiggin@gmail.com>
 <20161019031600.17933-5-npiggin@gmail.com>
Date: Tue, 15 Nov 2016 11:55:26 +1100
Message-ID: <8760npimtd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> diff --git a/arch/powerpc/Makefile.postlink b/arch/powerpc/Makefile.postl=
ink
> index 1725e64..b8fe12b 100644
> --- a/arch/powerpc/Makefile.postlink
> +++ b/arch/powerpc/Makefile.postlink
> @@ -24,6 +27,9 @@ endif
>=20=20
>  vmlinux: FORCE
>  	@true
> +ifeq ($(CONFIG_PPC64),y)

You can just use:

ifdef CONFIG_PPC64

> +	$(call cmd,head_check)
> +endif
>  ifeq ($(CONFIG_RELOCATABLE),y)
>  	$(call if_changed,relocs_check)
>  endif
> @@ -32,6 +38,7 @@ endif
>  	@true
>=20=20
>  clean:
> +	rm -f .tmp_symbols.txt
>  	@true

We shouldn't need the true anymore should we?

> diff --git a/arch/powerpc/tools/head_check.sh b/arch/powerpc/tools/head_c=
heck.sh
> new file mode 100755
> index 0000000..9635fe7
> --- /dev/null
> +++ b/arch/powerpc/tools/head_check.sh
> @@ -0,0 +1,69 @@
> +#!/bin/sh

We run this explicitly via $(CONFIG_SHELL), so having a shebang here is
redundant and also a little confusing. I added "-x" here, to turn on
tracing, but it doesn't take effect, so I think better to just drop the
line. If anyone wants to run it manually they can just pass it to sh.

> +# Copyright =C2=A9 2016 IBM Corporation
> +
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License
> +# as published by the Free Software Foundation; either version
> +# 2 of the License, or (at your option) any later version.
> +
> +# This script checks the head of a vmlinux for linker stubs that
> +# break our placement of fixed-location code for 64-bit.
> +
> +# based on relocs_check.pl
> +# Copyright =C2=A9 2009 IBM Corporation
> +
> +# READ THIS
> +#
> +# If the build dies here, it's likely code in head_64.S or nearby is
> +# referencing labels it can't reach, which results in the linker inserti=
ng
> +# stubs without the assembler's knowledge. This can move code around in =
ways
> +# that break the fixed location placement stuff (head-64.h). To debug,
> +# disassemble the vmlinux and look for branch stubs (long_branch, plt_br=
anch
> +# etc) in the fixed section region (0 - 0x8000ish). Check what places are
> +# calling those stubs.
> +#
> +# Linker stubs use the TOC pointer, so even if fixed section code could
> +# tolerate them being inserted into head code, they can't be allowed in =
low
> +# level entry code (boot, interrupt vectors, etc) until r2 is set up. Th=
is
> +# could cause the kernel to die in early boot.

Can you add:

# Turn this on if you want more debug output:
# set -x

> +
> +if [ $# -lt 2 ]; then
> +	echo "$0 [path to nm] [path to vmlinux]" 1>&2
> +	exit 1
> +fi
> +
> +# Have Kbuild supply the path to nm so we handle cross compilation.
> +nm=3D"$1"
> +vmlinux=3D"$2"
> +
> +nm "$vmlinux" | grep -e " T _stext$" -e " t start_first_256B$" -e " a te=
xt_start$" -e " t start_text$" -m4 > .tmp_symbols.txt

You don't use $nm there.

> +
> +
> +vma=3D$(cat .tmp_symbols.txt | grep " T _stext$" | cut -d' ' -f1)
> +
> +expected_start_head_addr=3D$vma
> +
> +start_head_addr=3D$(cat .tmp_symbols.txt | grep " t start_first_256B$" |=
 cut -d' ' -f1)
> +
> +if [ "$start_head_addr" !=3D "$expected_start_head_addr" ]; then
> +	echo "ERROR: head code starts at $start_head_addr, should be 0"
> +	echo "ERROR: see comments in arch/powerpc/tools/head_check.sh"

This is blowing up for me with ppc64e_defconfig.

It says:

ERROR: start_text address is c000000000001100, should be c000000000000200


cheers
