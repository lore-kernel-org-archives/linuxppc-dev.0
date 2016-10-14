Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3swBYD1kWmzDt2L
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 13:36:00 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id s8so6181101pfj.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 19:36:00 -0700 (PDT)
Subject: Re: [PATCH] powerpc: link error on orphan sections
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20161012070020.30170-1-npiggin@gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <14286beb-d100-5877-7725-37402d7ac38d@gmail.com>
Date: Fri, 14 Oct 2016 13:35:54 +1100
MIME-Version: 1.0
In-Reply-To: <20161012070020.30170-1-npiggin@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 12/10/16 18:00, Nicholas Piggin wrote:
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
>  
>  ifeq ($(CONFIG_PPC64),y)
>  ifeq ($(call cc-option-yn,-mcmodel=medium),y)
> diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
> index 8295f51..9f4d85e 100644
> --- a/arch/powerpc/kernel/vmlinux.lds.S
> +++ b/arch/powerpc/kernel/vmlinux.lds.S
> @@ -97,7 +97,7 @@ SECTIONS
>  	.text : AT(ADDR(.text) - LOAD_OFFSET) {
>  		ALIGN_FUNCTION();
>  		/* careful! __ftr_alt_* sections need to be close to .text */
> -		*(.text .fixup __ftr_alt_* .ref.text)
> +		*(.text.hot .text .text.fixup .text.unlikely .fixup __ftr_alt_* .ref.text .sfpr) \
>  		SCHED_TEXT

Is the "\" to pack the sched_text with the rest of .text?

>  		CPUIDLE_TEXT
>  		LOCK_TEXT
> @@ -256,7 +256,9 @@ SECTIONS
>  	.data : AT(ADDR(.data) - LOAD_OFFSET) {
>  		DATA_DATA
>  		*(.sdata)
> +		*(.sdata2)
>  		*(.got.plt) *(.got)
> +		*(.plt)
>  	}
>  #else
>  	.data : AT(ADDR(.data) - LOAD_OFFSET) {
> @@ -317,6 +319,16 @@ SECTIONS
>  	_end = . ;
>  	PROVIDE32 (end = .);
>  
> -	/* Sections to be discarded. */
> +	STABS_DEBUG
> +
> +	DWARF_DEBUG
> +

Are the debug sections discarded or is the above
comment misplaced? I guess they are discarded because of them
being outside of _end at relocation.

>  	DISCARDS
> +	/DISCARD/ : {
> +		*(*.EMB.apuinfo)
> +		*(.glink .iplt .plt .rela* .comment)
> +		*(.gnu.version*)
> +		*(.gnu.attributes)
> +		*(.eh_frame)
> +	}
>  }


> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 3e42bcd..264ebb3 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -581,6 +581,7 @@
>  #define SBSS(sbss_align)						\
>  	. = ALIGN(sbss_align);						\
>  	.sbss : AT(ADDR(.sbss) - LOAD_OFFSET) {				\
> +		*(.dynsbss)						\
>  		*(.sbss)						\
>  		*(.scommon)						\
>  	}
> @@ -627,6 +628,8 @@
>  		.debug_str      0 : { *(.debug_str) }			\
>  		.debug_loc      0 : { *(.debug_loc) }			\
>  		.debug_macinfo  0 : { *(.debug_macinfo) }		\
> +		/* DWARF 3 */						\
> +		.debug_ranges	0 : { *(.debug_ranges) }		\
>  		/* SGI/MIPS DWARF 2 extensions */			\
>  		.debug_weaknames 0 : { *(.debug_weaknames) }		\
>  		.debug_funcnames 0 : { *(.debug_funcnames) }		\
> 

Balbir Singh.
