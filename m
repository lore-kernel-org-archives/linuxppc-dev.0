Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40SBGF0pzNzF24s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 20:01:40 +1000 (AEST)
Subject: Re: [PATCH 4/4] powerpc: Allow LD_DEAD_CODE_DATA_ELIMINATION to be
 selected
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
 Nicolas Pitre <nico@fluxnic.net>
References: <20180420073414.23169-1-npiggin@gmail.com>
 <20180420073414.23169-5-npiggin@gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <5b495777-311b-ae81-6e07-6ae68f6da2b9@c-s.fr>
Date: Fri, 20 Apr 2018 12:01:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180420073414.23169-5-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 20/04/2018 à 09:34, Nicholas Piggin a écrit :
> This requires further changes to linker script to KEEP some tables
> and wildcard compiler generated sections into the right place. This
> includes pp32 modifications from Christophe Leroy.
> 
> When compiling powernv_defconfig with this option:
> 
> text       data      bss       dec        filename
> 11827621   4810490   1341080   17979191   vmlinux
> 11752437   4598858   1338776   17690071   vmlinux.dcde
> 
> Resulting kernel is almost 400kB smaller (and still boots).
> 
> [ppc32 numbers here]
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   arch/powerpc/Kconfig              |  1 +
>   arch/powerpc/kernel/vmlinux.lds.S | 22 +++++++++++-----------
>   2 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index c32a181a7cbb..ee6dbe2efc8b 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -205,6 +205,7 @@ config PPC
>   	select HAVE_KPROBES
>   	select HAVE_KPROBES_ON_FTRACE
>   	select HAVE_KRETPROBES
> +	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
>   	select HAVE_LIVEPATCH			if HAVE_DYNAMIC_FTRACE_WITH_REGS
>   	select HAVE_MEMBLOCK
>   	select HAVE_MEMBLOCK_NODE_MAP
> diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
> index c8af90ff49f0..89381dc959ce 100644
> --- a/arch/powerpc/kernel/vmlinux.lds.S
> +++ b/arch/powerpc/kernel/vmlinux.lds.S
> @@ -89,7 +89,7 @@ SECTIONS
>   	 */
>   	.text BLOCK(0) : AT(ADDR(.text) - LOAD_OFFSET) {
>   #ifdef CONFIG_LD_HEAD_STUB_CATCH
> -		*(.linker_stub_catch);
> +		KEEP(*(.linker_stub_catch));
>   		. = . ;
>   #endif
>   
> @@ -98,7 +98,7 @@ SECTIONS
>   		ALIGN_FUNCTION();
>   #endif
>   		/* careful! __ftr_alt_* sections need to be close to .text */
> -		*(.text.hot .text .text.fixup .text.unlikely .fixup __ftr_alt_* .ref.text);
> +		*(.text.hot .text .text.[0-9a-zA-Z_]* .text.fixup .text.unlikely .fixup __ftr_alt_* .ref.text);

Why not use TEXT_MAIN here instead of .text .text.[0-9a-zA-Z_]* ?

Christophe

>   		SCHED_TEXT
>   		CPUIDLE_TEXT
>   		LOCK_TEXT
> @@ -170,10 +170,10 @@ SECTIONS
>   	.init.data : AT(ADDR(.init.data) - LOAD_OFFSET) {
>   		INIT_DATA
>   		__vtop_table_begin = .;
> -		*(.vtop_fixup);
> +		KEEP(*(.vtop_fixup));
>   		__vtop_table_end = .;
>   		__ptov_table_begin = .;
> -		*(.ptov_fixup);
> +		KEEP(*(.ptov_fixup));
>   		__ptov_table_end = .;
>   	}
>   
> @@ -194,26 +194,26 @@ SECTIONS
>   	. = ALIGN(8);
>   	__ftr_fixup : AT(ADDR(__ftr_fixup) - LOAD_OFFSET) {
>   		__start___ftr_fixup = .;
> -		*(__ftr_fixup)
> +		KEEP(*(__ftr_fixup))
>   		__stop___ftr_fixup = .;
>   	}
>   	. = ALIGN(8);
>   	__mmu_ftr_fixup : AT(ADDR(__mmu_ftr_fixup) - LOAD_OFFSET) {
>   		__start___mmu_ftr_fixup = .;
> -		*(__mmu_ftr_fixup)
> +		KEEP(*(__mmu_ftr_fixup))
>   		__stop___mmu_ftr_fixup = .;
>   	}
>   	. = ALIGN(8);
>   	__lwsync_fixup : AT(ADDR(__lwsync_fixup) - LOAD_OFFSET) {
>   		__start___lwsync_fixup = .;
> -		*(__lwsync_fixup)
> +		KEEP(*(__lwsync_fixup))
>   		__stop___lwsync_fixup = .;
>   	}
>   #ifdef CONFIG_PPC64
>   	. = ALIGN(8);
>   	__fw_ftr_fixup : AT(ADDR(__fw_ftr_fixup) - LOAD_OFFSET) {
>   		__start___fw_ftr_fixup = .;
> -		*(__fw_ftr_fixup)
> +		KEEP(*(__fw_ftr_fixup))
>   		__stop___fw_ftr_fixup = .;
>   	}
>   #endif
> @@ -226,7 +226,7 @@ SECTIONS
>   	. = ALIGN(8);
>   	.machine.desc : AT(ADDR(.machine.desc) - LOAD_OFFSET) {
>   		__machine_desc_start = . ;
> -		*(.machine.desc)
> +		KEEP(*(.machine.desc))
>   		__machine_desc_end = . ;
>   	}
>   #ifdef CONFIG_RELOCATABLE
> @@ -274,7 +274,7 @@ SECTIONS
>   	.data : AT(ADDR(.data) - LOAD_OFFSET) {
>   		DATA_DATA
>   		*(.data.rel*)
> -		*(.sdata)
> +		*(SDATA_MAIN)
>   		*(.sdata2)
>   		*(.got.plt) *(.got)
>   		*(.plt)
> @@ -289,7 +289,7 @@ SECTIONS
>   
>   	.opd : AT(ADDR(.opd) - LOAD_OFFSET) {
>   		__start_opd = .;
> -		*(.opd)
> +		KEEP(*(.opd))
>   		__end_opd = .;
>   	}
>   
> 
