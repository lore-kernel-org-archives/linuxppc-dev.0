Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sw86g2HmjzDsyY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 11:46:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc: link error on orphan sections
In-Reply-To: <20161012070020.30170-1-npiggin@gmail.com>
References: <20161012070020.30170-1-npiggin@gmail.com>
Date: Fri, 14 Oct 2016 11:46:19 +1100
Message-ID: <87zim7dag4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> Add --orphan-handling=error to final link flags. This ensures we have to
> handle all sections. This would have caught subtle breakage such as
> 7de3b27bac47da9de08409df1d69664acbb72197 at build-time.
>
> Also bring some wayward sections into the fold:
> - .text.hot and .text.unlikely are compiler generated sections.
> - .sfpr is a linker generated section for register save functions.
> - .sdata2, .dynsbss, .plt are used by PPC32
> - We previously did not specify DWARF_DEBUG or STABS_DEBUG
> - DWARF_DEBUG did not include DWARF3 .debug_ranges
> - A number of sections are unused.
>
> I don't know if I've exactly got everything right here, particularly
> with ppc32, so would appreciate people casting their eye over it.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/Makefile             |  2 +-
>  arch/powerpc/kernel/vmlinux.lds.S | 16 ++++++++++++++--
>  include/asm-generic/vmlinux.lds.h |  3 +++
>  3 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 50d020a..a3f2784 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -90,7 +90,7 @@ endif
>  
>  LDFLAGS_vmlinux-y := -Bstatic
>  LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
> -LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-y)
> +LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-y) --orphan-handling=error

At least some old(er) toolchains don't support that:

  /opt/cross/kisskb/gcc-4.6.3-nolibc/powerpc-linux/bin/powerpc-linux-ld: unrecognized option '--orphan-handling=error'

So we'll need an ld-option wrapper around it.

cheers
