Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNCnd4yvxzDvyk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 15:55:01 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id x23so865287pgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 20:55:01 -0800 (PST)
Date: Tue, 22 Nov 2016 15:54:47 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 4/7] powerpc/64: tool to check head sections location
 sanity
Message-ID: <20161122155447.61198020@roar.ozlabs.ibm.com>
In-Reply-To: <8760npimtd.fsf@concordia.ellerman.id.au>
References: <20161019031600.17933-1-npiggin@gmail.com>
 <20161019031600.17933-5-npiggin@gmail.com>
 <8760npimtd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 15 Nov 2016 11:55:26 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > diff --git a/arch/powerpc/Makefile.postlink b/arch/powerpc/Makefile.postlink
> > index 1725e64..b8fe12b 100644
> > --- a/arch/powerpc/Makefile.postlink
> > +++ b/arch/powerpc/Makefile.postlink
> > @@ -24,6 +27,9 @@ endif
> >  
> >  vmlinux: FORCE
> >  	@true
> > +ifeq ($(CONFIG_PPC64),y)  
> 
> You can just use:
> 
> ifdef CONFIG_PPC64

Okay. The same applies to other parts of this file added earlier.
I'll fix.

> > +	$(call cmd,head_check)
> > +endif
> >  ifeq ($(CONFIG_RELOCATABLE),y)
> >  	$(call if_changed,relocs_check)
> >  endif
> > @@ -32,6 +38,7 @@ endif
> >  	@true
> >  
> >  clean:
> > +	rm -f .tmp_symbols.txt
> >  	@true  
> 
> We shouldn't need the true anymore should we?

True.

> > diff --git a/arch/powerpc/tools/head_check.sh b/arch/powerpc/tools/head_check.sh
> > new file mode 100755
> > index 0000000..9635fe7
> > --- /dev/null
> > +++ b/arch/powerpc/tools/head_check.sh
> > @@ -0,0 +1,69 @@
> > +#!/bin/sh  
> 
> We run this explicitly via $(CONFIG_SHELL), so having a shebang here is
> redundant and also a little confusing. I added "-x" here, to turn on
> tracing, but it doesn't take effect, so I think better to just drop the
> line. If anyone wants to run it manually they can just pass it to sh.

Okay. How about relocs_check.sh? I just started by copying that.

> 
> > +# Copyright © 2016 IBM Corporation
> > +
> > +# This program is free software; you can redistribute it and/or
> > +# modify it under the terms of the GNU General Public License
> > +# as published by the Free Software Foundation; either version
> > +# 2 of the License, or (at your option) any later version.
> > +
> > +# This script checks the head of a vmlinux for linker stubs that
> > +# break our placement of fixed-location code for 64-bit.
> > +
> > +# based on relocs_check.pl
> > +# Copyright © 2009 IBM Corporation
> > +
> > +# READ THIS
> > +#
> > +# If the build dies here, it's likely code in head_64.S or nearby is
> > +# referencing labels it can't reach, which results in the linker inserting
> > +# stubs without the assembler's knowledge. This can move code around in ways
> > +# that break the fixed location placement stuff (head-64.h). To debug,
> > +# disassemble the vmlinux and look for branch stubs (long_branch, plt_branch
> > +# etc) in the fixed section region (0 - 0x8000ish). Check what places are
> > +# calling those stubs.
> > +#
> > +# Linker stubs use the TOC pointer, so even if fixed section code could
> > +# tolerate them being inserted into head code, they can't be allowed in low
> > +# level entry code (boot, interrupt vectors, etc) until r2 is set up. This
> > +# could cause the kernel to die in early boot.  
> 
> Can you add:
> 
> # Turn this on if you want more debug output:
> # set -x

Can do, same question applies for relocs_check.sh

> 
> > +
> > +if [ $# -lt 2 ]; then
> > +	echo "$0 [path to nm] [path to vmlinux]" 1>&2
> > +	exit 1
> > +fi
> > +
> > +# Have Kbuild supply the path to nm so we handle cross compilation.
> > +nm="$1"
> > +vmlinux="$2"
> > +
> > +nm "$vmlinux" | grep -e " T _stext$" -e " t start_first_256B$" -e " a text_start$" -e " t start_text$" -m4 > .tmp_symbols.txt  
> 
> You don't use $nm there.

Thanks, good catch.

> > +
> > +
> > +vma=$(cat .tmp_symbols.txt | grep " T _stext$" | cut -d' ' -f1)
> > +
> > +expected_start_head_addr=$vma
> > +
> > +start_head_addr=$(cat .tmp_symbols.txt | grep " t start_first_256B$" | cut -d' ' -f1)
> > +
> > +if [ "$start_head_addr" != "$expected_start_head_addr" ]; then
> > +	echo "ERROR: head code starts at $start_head_addr, should be 0"
> > +	echo "ERROR: see comments in arch/powerpc/tools/head_check.sh"  
> 
> This is blowing up for me with ppc64e_defconfig.
> 
> It says:
> 
> ERROR: start_text address is c000000000001100, should be c000000000000200

I must have forgotten to test e. I'll fix that.

Thanks,
Nick
