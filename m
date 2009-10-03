Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D94FBB7BCF
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Oct 2009 08:53:48 +1100 (EST)
Subject: Re: [patch 1/3] powerpc: Move 64bit VDSO to improve context switch
	performance
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
In-Reply-To: <m2ocoo1qfi.fsf@igel.home>
References: <20090714065350.659537380@samba.org>
	<20090714065425.301516312@samba.org>
	<m2ocophale.fsf__34527.2158309401$1254511503$gmane$org@igel.home>
	<m28wfsef79.fsf@igel.home>  <m2ocoo1qfi.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 04 Oct 2009 08:53:27 +1100
Message-Id: <1254606807.7122.23.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2009-10-03 at 16:51 +0200, Andreas Schwab wrote:
> Andreas Schwab <schwab@linux-m68k.org> writes:
> 
> > Andreas Schwab <schwab@linux-m68k.org> writes:
> >
> >> Anton Blanchard <anton@samba.org> writes:
> >>
> >>> On 64bit applications the VDSO is the only thing in segment 0. Since the VDSO
> >>> is position independent we can remove the hint and let get_unmapped_area pick
> >>> an area.
> >>
> >> This breaks gdb.  The section table in the VDSO image when mapped into
> >> the process no longer contains meaningful values, and gdb rejects it.
> >
> > The problem is that the load segment requires 64k alignment, but the
> > page allocater of course only provides PAGE_SIZE alignment, causing the
> > image to be unaligned in memory.
> 
> Here is a patch.  The disadvantage is that now gdb complains that the
> vdso does not contain section headers, because they are no longer
> covered by the load segment.

Maybe a better fix is to force alignment in the kernel by requesting
size + 64k - 4k and aligning it.

Ben.

> Andreas.
> ---
> >From 003c323c753d8717e58220c9560329882bcfa2c2 Mon Sep 17 00:00:00 2001
> From: Andreas Schwab <schwab@linux-m68k.org>
> Date: Sat, 3 Oct 2009 16:46:45 +0200
> Subject: [PATCH] powerpc: fix unaligned load segment in vdso64
> 
> Since the page allocator can only guarantee PAGE_SIZE alignment the load
> segment in the vdso object cannot claim more than that alignment.  Use 4k
> alignment which is the minimum possible page size.
> 
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> ---
>  arch/powerpc/kernel/vdso64/Makefile |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/vdso64/Makefile
> index 79da65d..d4be303 100644
> --- a/arch/powerpc/kernel/vdso64/Makefile
> +++ b/arch/powerpc/kernel/vdso64/Makefile
> @@ -10,7 +10,9 @@ obj-vdso64 := $(addprefix $(obj)/, $(obj-vdso64))
>  GCOV_PROFILE := n
>  
>  EXTRA_CFLAGS := -shared -fno-common -fno-builtin
> +# Force maximum page size of 4k so that it works with any page size
>  EXTRA_CFLAGS += -nostdlib -Wl,-soname=linux-vdso64.so.1 \
> +		-Wl,-z,max-page-size=4096 \
>  		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
>  EXTRA_AFLAGS := -D__VDSO64__ -s
>  
> -- 
> 1.6.4.4
> 
> 
