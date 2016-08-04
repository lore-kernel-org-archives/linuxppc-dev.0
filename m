Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4pgW06sJzDqS9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 22:11:02 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Fengguang Wu <fengguang.wu@intel.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Nicolas Pitre <nico@linaro.org>
Subject: Re: powerpc allyesconfig / allmodconfig linux-next next-20160729 -
 next-20160729 build failures
Date: Thu, 04 Aug 2016 14:09:02 +0200
Message-ID: <4007331.2ypSqpxHsb@wuerfel>
In-Reply-To: <20160804214713.4baa832e@roar.ozlabs.ibm.com>
References: <CAB=NE6U18jv89pxqAeZY8eTj44mq90kyXGaQO-108+ZMTyxQiQ@mail.gmail.com>
 <1880505.MpH3ISbtMJ@wuerfel> <20160804214713.4baa832e@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday, August 4, 2016 9:47:13 PM CEST Nicholas Piggin wrote:
> On Thu, 04 Aug 2016 12:37:41 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday, August 4, 2016 11:00:49 AM CEST Arnd Bergmann wrote:
> > > I tried this
> > > 
> > > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > > index b5e40ed86e60..89bca1a25916 100755
> > > --- a/scripts/link-vmlinux.sh
> > > +++ b/scripts/link-vmlinux.sh
> > > @@ -44,7 +44,7 @@ modpost_link()
> > >         local objects
> > >  
> > >         if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
> > > -               objects="--whole-archive ${KBUILD_VMLINUX_INIT} ${KBUILD_VMLINUX_MAIN} --no-whole-archive"
> > > +               objects="${KBUILD_VMLINUX_INIT} ${KBUILD_VMLINUX_MAIN}"
> > >         else
> > >                 objects="${KBUILD_VMLINUX_INIT} --start-group ${KBUILD_VMLINUX_MAIN} --end-group"
> > >         fi
> > > 
> > > but that did not seem to change anything, the extra symbols are
> > > still there. I have not tried to understand what that actually
> > > does, so maybe I misunderstood your suggestion.
> > >   
> > 
> > On a second attempt, I did the same change for vmlinux instead of the
> > module (d'oh), and got a link failure instead:
> > 
> > 
> > arch/arm/mm/proc-xscale.o: In function `cpu_xscale_do_resume':
> > (.text+0x3d4): undefined reference to `cpu_resume_mmu'
> > arch/arm/kernel/setup.o: In function `setup_arch':
> > ...
> > 
> > However, I also see a link failure in some rare configurations
> > with just your patch:
> > 
> > arch/arm/lib/lib.a(io-acorn.o): In function `outsl':
> > (.text+0x38): undefined reference to `printk'
> > 
> > The problem being a file in a library object that is not referenced,
> > but that references another symbol that is not defined
> > (CONFIG_PRINTK=n).
> 
> The first problem is the existing link system is buggy. I think an
> unconditional switch to --whole-archive (at least for modular kernels)
> should probably be done anyway. For example, on powerpc when building
> with --whole-archive, I have:
> 
> +dma_noop_alloc
> +dma_noop_free
> +dma_noop_map_page
> +dma_noop_mapping_error
> +dma_noop_map_sg
> +dma_noop_ops
> +dma_noop_supported
> +fdt_add_reservemap_entry
> +fdt_begin_node
> +fdt_create
> +fdt_create_empty_tree
> +fdt_end_node
> +fdt_errtable
> +find_cpio_data
> +ioremap_page_range
> 
> find_cpio_data is unnecessary and it's a codesize regression to link it.
> But dma_noop_ops and ioremap_page_range are exported symbols. If I
> reference dma_noop_ops from some random module with otherwise unpatched
> kernel:
> 
> ERROR: "dma_noop_ops" [drivers/char/bsr.ko] undefined!

Right, but only on s390, which is the one architecture using this.
I think we should just have a Kconfig symbol for this file that
gets selected by any architecture that needs it.

This is also what we have ended up doing for almost all other
files in lib/

> The real problem is that our linkage requirements are like a shared
> library when we build modular.
> 
> We could build a list of exports and make it link objects with those
> symbols, to solve this, but IMO that's just wasting lipstick on a pig.
> But I will to propose a patch to always use --whole-archive, thin
> archives or not, and transition all archs over to it in a few release
> cycles. It just works by luck right now.
>
> Why is it a pig? Because having the linker to notice no external
> references and just skipping the .o completely is trying to use a hammer
> as a scalpel. It's just not a very effective way to eliminate dead code
> --  I pulled in only a handful of unneeded functions by switching it.

If we do that, we may just as well get rid of $(lib-y) in the process and
always use $(obj-y).

> I mean it is a quick simple feature that probably works well enough with
> simple build systems. But not an advanced one that builds almost
> everything on demand and also has loadable modules and must act like a
> shared library.
> 
> Real linker DCE is a valid optimisation that can't be replaced by the
> build system of course, but we need to do it properly. Here's what I'm
> working on.
> 
> It applies on top of the previous patch I sent, plus some powerpc stuff
> I'm working on that you should be able to just ignore for another arch.
> it's a WIP, but if you can see if it works for arm that would be cool.
> 
> It doesn't actually build allyesconfig after this,
> ld: .tmp_vmlinux1: Too many sections: 220655 (>= 65280)
> 
> But on a more reasonable configuration (ppc64le)
>     text      data   bss            dec   filename
> 11191672   1183536   1923820   14299028   vmlinux
> 10625528    861895   1919707   13407130	  vmlinux.thin+gc
> 
> 10M-552K   1M-314K         ~   13M-870K

Nice!

> And it actually boots too, which is fairly astounding considering that
> it lost half a meg of code and 1/3 of its data. I'm not completely sure
> I've not done something wrong...

Nicolas Pitre has done some related work, adding him to Cc. IIRC we have
actually had multiple implementations of -ffunction-sections/--gc-sections
in the past that people have used in production, but none of them
ever made it upstream.

One question is whether we should bother with --gc-sections at all,
or use full LTO instead.

	Arnd
---
(full patch quoted below for Nico, no further comments)

> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index e75e17c..1594072 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -104,6 +104,10 @@ LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-y)
>  LDFLAGS_vmlinux	+= --emit-relocs
>  KBUILD_LDFLAGS_MODULE += --emit-relocs
>  
> +KBUILD_CFLAGS	+= -ffunction-sections -fdata-sections
> +LDFLAGS_vmlinux	+= --gc-sections
> +
> +
>  ifeq ($(CONFIG_PPC64),y)
>  ifeq ($(call cc-option-yn,-mcmodel=medium),y)
>  	# -mcmodel=medium breaks modules because it uses 32bit offsets from
> @@ -234,6 +238,8 @@ KBUILD_CFLAGS += $(cpu-as-y)
>  archscripts: scripts_basic
>  	$(Q)$(MAKE) $(build)=arch/powerpc/tools
>  
> +CFLAGS_head_$(CONFIG_WORD_SIZE).o = -fno-function-sections
> +
>  head-y				:= arch/powerpc/kernel/head_$(CONFIG_WORD_SIZE).o
>  head-$(CONFIG_8xx)		:= arch/powerpc/kernel/head_8xx.o
>  head-$(CONFIG_40x)		:= arch/powerpc/kernel/head_40x.o
> @@ -245,6 +251,7 @@ head-$(CONFIG_PPC_FPU)		+= arch/powerpc/kernel/fpu.o
>  head-$(CONFIG_ALTIVEC)		+= arch/powerpc/kernel/vector.o
>  head-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE)  += arch/powerpc/kernel/prom_init.o
>  
> +
>  core-y				+= arch/powerpc/kernel/ \
>  				   arch/powerpc/mm/ \
>  				   arch/powerpc/lib/ \
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 2da380f..b356e59 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -4,7 +4,10 @@
>  
>  CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
>  
> +ccflags-y		+= -fno-function-sections -fno-data-sections
> +
>  subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
> +subdir-ccflags-y	+= -fno-function-sections -fno-data-sections
>  
>  ifeq ($(CONFIG_PPC64),y)
>  CFLAGS_prom_init.o	+= $(NO_MINIMAL_TOC)
> diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
> index 959c131..0856d62 100644
> --- a/arch/powerpc/kernel/vmlinux.lds.S
> +++ b/arch/powerpc/kernel/vmlinux.lds.S
> @@ -56,16 +56,16 @@ SECTIONS
>  	 * in order to optimize stub generation.
>  	 */
>  	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {
> -		*(.head.text.first_256B);
> +		KEEP(*(.head.text.first_256B));
>  #ifndef CONFIG_PPC_BOOK3S
>  		. = 0x100;
>  #else
> -		*(.head.text.real_vectors);
> -		*(.head.text.real_trampolines);
> -		*(.head.text.virt_vectors);
> -		*(.head.text.virt_trampolines);
> +		KEEP(*(.head.text.real_vectors));
> +		KEEP(*(.head.text.real_trampolines));
> +		KEEP(*(.head.text.virt_vectors));
> +		KEEP(*(.head.text.virt_trampolines));
>  #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
> -		*(.head.data.fwnmi_page);
> +		KEEP(*(.head.data.fwnmi_page));
>  		. = 0x8000;
>  #else
>  		. = 0x7000;
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 6a67ab9..3a35719 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -312,76 +312,76 @@
>  	/* Kernel symbol table: Normal symbols */			\
>  	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
>  		VMLINUX_SYMBOL(__start___ksymtab) = .;			\
> -		*(SORT(___ksymtab+*))					\
> +		KEEP(*(SORT(___ksymtab+*)))				\
>  		VMLINUX_SYMBOL(__stop___ksymtab) = .;			\
>  	}								\
>  									\
>  	/* Kernel symbol table: GPL-only symbols */			\
>  	__ksymtab_gpl     : AT(ADDR(__ksymtab_gpl) - LOAD_OFFSET) {	\
>  		VMLINUX_SYMBOL(__start___ksymtab_gpl) = .;		\
> -		*(SORT(___ksymtab_gpl+*))				\
> +		KEEP(*(SORT(___ksymtab_gpl+*)))				\
>  		VMLINUX_SYMBOL(__stop___ksymtab_gpl) = .;		\
>  	}								\
>  									\
>  	/* Kernel symbol table: Normal unused symbols */		\
>  	__ksymtab_unused  : AT(ADDR(__ksymtab_unused) - LOAD_OFFSET) {	\
>  		VMLINUX_SYMBOL(__start___ksymtab_unused) = .;		\
> -		*(SORT(___ksymtab_unused+*))				\
> +		KEEP(*(SORT(___ksymtab_unused+*)))			\
>  		VMLINUX_SYMBOL(__stop___ksymtab_unused) = .;		\
>  	}								\
>  									\
>  	/* Kernel symbol table: GPL-only unused symbols */		\
>  	__ksymtab_unused_gpl : AT(ADDR(__ksymtab_unused_gpl) - LOAD_OFFSET) { \
>  		VMLINUX_SYMBOL(__start___ksymtab_unused_gpl) = .;	\
> -		*(SORT(___ksymtab_unused_gpl+*))			\
> +		KEEP(*(SORT(___ksymtab_unused_gpl+*)))			\
>  		VMLINUX_SYMBOL(__stop___ksymtab_unused_gpl) = .;	\
>  	}								\
>  									\
>  	/* Kernel symbol table: GPL-future-only symbols */		\
>  	__ksymtab_gpl_future : AT(ADDR(__ksymtab_gpl_future) - LOAD_OFFSET) { \
>  		VMLINUX_SYMBOL(__start___ksymtab_gpl_future) = .;	\
> -		*(SORT(___ksymtab_gpl_future+*))			\
> +		KEEP(*(SORT(___ksymtab_gpl_future+*)))			\
>  		VMLINUX_SYMBOL(__stop___ksymtab_gpl_future) = .;	\
>  	}								\
>  									\
>  	/* Kernel symbol table: Normal symbols */			\
>  	__kcrctab         : AT(ADDR(__kcrctab) - LOAD_OFFSET) {		\
>  		VMLINUX_SYMBOL(__start___kcrctab) = .;			\
> -		*(SORT(___kcrctab+*))					\
> +		KEEP(*(SORT(___kcrctab+*)))				\
>  		VMLINUX_SYMBOL(__stop___kcrctab) = .;			\
>  	}								\
>  									\
>  	/* Kernel symbol table: GPL-only symbols */			\
>  	__kcrctab_gpl     : AT(ADDR(__kcrctab_gpl) - LOAD_OFFSET) {	\
>  		VMLINUX_SYMBOL(__start___kcrctab_gpl) = .;		\
> -		*(SORT(___kcrctab_gpl+*))				\
> +		KEEP(*(SORT(___kcrctab_gpl+*)))				\
>  		VMLINUX_SYMBOL(__stop___kcrctab_gpl) = .;		\
>  	}								\
>  									\
>  	/* Kernel symbol table: Normal unused symbols */		\
>  	__kcrctab_unused  : AT(ADDR(__kcrctab_unused) - LOAD_OFFSET) {	\
>  		VMLINUX_SYMBOL(__start___kcrctab_unused) = .;		\
> -		*(SORT(___kcrctab_unused+*))				\
> +		KEEP(*(SORT(___kcrctab_unused+*)))			\
>  		VMLINUX_SYMBOL(__stop___kcrctab_unused) = .;		\
>  	}								\
>  									\
>  	/* Kernel symbol table: GPL-only unused symbols */		\
>  	__kcrctab_unused_gpl : AT(ADDR(__kcrctab_unused_gpl) - LOAD_OFFSET) { \
>  		VMLINUX_SYMBOL(__start___kcrctab_unused_gpl) = .;	\
> -		*(SORT(___kcrctab_unused_gpl+*))			\
> +		KEEP(*(SORT(___kcrctab_unused_gpl+*)))			\
>  		VMLINUX_SYMBOL(__stop___kcrctab_unused_gpl) = .;	\
>  	}								\
>  									\
>  	/* Kernel symbol table: GPL-future-only symbols */		\
>  	__kcrctab_gpl_future : AT(ADDR(__kcrctab_gpl_future) - LOAD_OFFSET) { \
>  		VMLINUX_SYMBOL(__start___kcrctab_gpl_future) = .;	\
> -		*(SORT(___kcrctab_gpl_future+*))			\
> +		KEEP(*(SORT(___kcrctab_gpl_future+*)))			\
>  		VMLINUX_SYMBOL(__stop___kcrctab_gpl_future) = .;	\
>  	}								\
>  									\
>  	/* Kernel symbol table: strings */				\
>          __ksymtab_strings : AT(ADDR(__ksymtab_strings) - LOAD_OFFSET) {	\
> -		*(__ksymtab_strings)					\
> +		KEEP(*(__ksymtab_strings))				\
>  	}								\
>  									\
>  	/* __*init sections */						\
> @@ -519,6 +519,7 @@
>  
>  /* init and exit section handling */
>  #define INIT_DATA							\
> +	KEEP(*(SORT(___kentry+*)))					\
>  	*(.init.data)							\
>  	MEM_DISCARD(init.data)						\
>  	KERNEL_CTORS()							\
> @@ -695,9 +696,9 @@
>  #define INIT_RAM_FS							\
>  	. = ALIGN(4);							\
>  	VMLINUX_SYMBOL(__initramfs_start) = .;				\
> -	*(.init.ramfs)							\
> +	KEEP(*(.init.ramfs))						\
>  	. = ALIGN(8);							\
> -	*(.init.ramfs.info)
> +	KEEP(*(.init.ramfs.info))
>  #else
>  #define INIT_RAM_FS
>  #endif
> diff --git a/include/linux/export.h b/include/linux/export.h
> index 2f9ccbe..a921862 100644
> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -46,7 +46,7 @@ extern struct module __this_module;
>  	extern __visible void *__crc_##sym __attribute__((weak));		\
>  	static const unsigned long __kcrctab_##sym		\
>  	__used							\
> -	__attribute__((section("___kcrctab" sec "+" #sym), unused))	\
> +	__attribute__((section("___kcrctab" sec "+" #sym ",\"a\",@note #"), used))	\
>  	= (unsigned long) &__crc_##sym;
>  #else
>  #define __CRC_SYMBOL(sym, sec)
> @@ -57,12 +57,12 @@ extern struct module __this_module;
>  	extern typeof(sym) sym;					\
>  	__CRC_SYMBOL(sym, sec)					\
>  	static const char __kstrtab_##sym[]			\
> -	__attribute__((section("__ksymtab_strings"), aligned(1))) \
> +	__attribute__((section("__ksymtab_strings" ",\"a\",@note #"), aligned(1))) \
>  	= VMLINUX_SYMBOL_STR(sym);				\
>  	extern const struct kernel_symbol __ksymtab_##sym;	\
>  	__visible const struct kernel_symbol __ksymtab_##sym	\
>  	__used							\
> -	__attribute__((section("___ksymtab" sec "+" #sym), unused))	\
> +	__attribute__((section("___ksymtab" sec "+" #sym ",\"a\",@note #"), used))	\
>  	= { (unsigned long)&sym, __kstrtab_##sym }
>  
>  #if defined(__KSYM_DEPS__)
> diff --git a/include/linux/init.h b/include/linux/init.h
> index aedb254..51393f4 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -156,19 +156,20 @@ extern bool initcall_debug;
>  
>  #ifndef __ASSEMBLY__
>  
> -#ifdef CONFIG_LTO
> +#if 1
>  /* Work around a LTO gcc problem: when there is no reference to a variable
>   * in a module it will be moved to the end of the program. This causes
>   * reordering of initcalls which the kernel does not like.
>   * Add a dummy reference function to avoid this. The function is
>   * deleted by the linker.
>   */
> -#define LTO_REFERENCE_INITCALL(x) \
> -	; /* yes this is needed */			\
> -	static __used __exit void *reference_##x(void)	\
> -	{						\
> -		return &x;				\
> -	}
> +#define LTO_REFERENCE_INITCALL(sym) \
> +	extern typeof(sym) sym;					\
> +	/* extern const unsigned long __kentry_##sym; */		\
> +	static /* __visible */ const unsigned long __kentry_##sym		\
> +	__used							\
> +	__attribute__((section("___kentry" "+" #sym ",\"a\",@note #"), used)) \
> +	= (unsigned long)&sym;
>  #else
>  #define LTO_REFERENCE_INITCALL(x)
>  #endif
> @@ -222,16 +223,18 @@ extern bool initcall_debug;
>  
>  #define __initcall(fn) device_initcall(fn)
>  
> -#define __exitcall(fn) \
> -	static exitcall_t __exitcall_##fn __exit_call = fn
> +#define __exitcall(fn)						\
> +	static exitcall_t __exitcall_##fn __exit_call = fn;	\
>  
> -#define console_initcall(fn) \
> -	static initcall_t __initcall_##fn \
> -	__used __section(.con_initcall.init) = fn
> +#define console_initcall(fn)					\
> +	static initcall_t __initcall_##fn			\
> +	__used __section(.con_initcall.init) = fn;		\
> +	LTO_REFERENCE_INITCALL(__initcall_##fn)
>  
> -#define security_initcall(fn) \
> -	static initcall_t __initcall_##fn \
> -	__used __section(.security_initcall.init) = fn
> +#define security_initcall(fn)					\
> +	static initcall_t __initcall_##fn			\
> +	__used __section(.security_initcall.init) = fn;		\
> +	LTO_REFERENCE_INITCALL(__initcall_##fn)
>  
>  struct obs_kernel_param {
>  	const char *str;
> diff --git a/init/Makefile b/init/Makefile
> index 7bc47ee..c4fb455 100644
> --- a/init/Makefile
> +++ b/init/Makefile
> @@ -2,6 +2,8 @@
>  # Makefile for the linux kernel.
>  #
>  
> +ccflags-y := -fno-function-sections -fno-data-sections
> +
>  obj-y                          := main.o version.o mounts.o
>  ifneq ($(CONFIG_BLK_DEV_INITRD),y)
>  obj-y                          += noinitramfs.o
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index ef4658f..fb848af 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -37,17 +37,22 @@ info()
>  	fi
>  }
>  
> +# Grab all the EXPORT_SYMBOL symbols in the vmlinux build
> +# ${1} - output file
> +exports_extract()
> +{
> +	${NM} -g ${KBUILD_VMLINUX_INIT} ${KBUILD_VMLINUX_MAIN} |
> +		grep "R __ksymtab_" |
> +		sed 's/.*__ksymtab_\(.*\)$/\1/' > ${1}
> +}
> +
>  # Link of vmlinux.o used for section mismatch analysis
>  # ${1} output file
>  modpost_link()
>  {
>  	local objects
>  
> -	if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
> -		objects="--whole-archive ${KBUILD_VMLINUX_INIT} ${KBUILD_VMLINUX_MAIN} --no-whole-archive"
> -	else
> -		objects="${KBUILD_VMLINUX_INIT} --start-group ${KBUILD_VMLINUX_MAIN} --end-group"
> -	fi
> +	objects="--whole-archive ${KBUILD_VMLINUX_INIT} ${KBUILD_VMLINUX_MAIN}"
>  	${LD} ${LDFLAGS} -r -o ${1} ${objects}
>  }
>  
> @@ -60,11 +65,7 @@ vmlinux_link()
>  	local objects
>  
>  	if [ "${SRCARCH}" != "um" ]; then
> -		if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
> -			objects="--whole-archive ${KBUILD_VMLINUX_INIT} ${KBUILD_VMLINUX_MAIN} --no-whole-archive"
> -		else
> -			objects="${KBUILD_VMLINUX_INIT} --start-group ${KBUILD_VMLINUX_MAIN} --end-group"
> -		fi
> +		objects="--whole-archive ${KBUILD_VMLINUX_INIT} ${KBUILD_VMLINUX_MAIN}"
>  		${LD} ${LDFLAGS} ${LDFLAGS_vmlinux} -o ${2}                  \
>  			-T ${lds} ${objects} ${1}
>  	else
> 
