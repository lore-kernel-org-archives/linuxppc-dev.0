Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id B6F96DDEE7
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Dec 2008 09:33:32 +1100 (EST)
In-Reply-To: <200812190939.46733.yur@emcraft.com>
References: <200812190939.46733.yur@emcraft.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <79323ed6bfab87d44b196d610cea5e42@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] powerpc 44x: support for 256KB PAGE_SIZE
Date: Sat, 20 Dec 2008 16:39:10 -0600
To: Yuri Tikhonov <yur@emcraft.com>
Cc: yanok@emcraft.com, dzu@denx.de, linuxppc-dev@ozlabs.org, paulus@samba.org,
	wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 19, 2008, at 12:39 AM, Yuri Tikhonov wrote:

> This patch adds support for 256KB pages on ppc44x-based boards.
>

Hi.  A couple of small comments.

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index cd8ff7c..348702c 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -436,6 +436,14 @@ config PPC_64K_PAGES
>  	bool "64k page size" if 44x || PPC_STD_MMU_64
>  	select PPC_HAS_HASH_64K if PPC_STD_MMU_64
>
> +config PPC_256K_PAGES
> +	bool "256k page size" if 44x
> +	depends on !STDBINUTILS
> +	help
> +	  ELF standard supports only page sizes up to 64K so you need a 
> patched
> +	  binutils in order to use 256K pages. Chose it only if you know what
> +	  you are doing.
> +

Make the page size 256k.   As the ELF standard only requires alignment 
to
support page sizes up to 64k, you will need to compile all of your user
space applications with a patched binutils.

Say N unless you know what you are doing.

(The previous text did not describe what the option actually did, and 
did not emphasize that all of user space had to be compiled).


> diff --git a/arch/powerpc/include/asm/thread_info.h 
> b/arch/powerpc/include/asm/thread_info.h
> index 9665a26..3c8bbab 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -15,8 +15,12 @@
>  #ifdef CONFIG_PPC64
>  #define THREAD_SHIFT		14
>  #else
> +#ifdef CONFIG_PPC_256K_PAGES
> +#define THREAD_SHIFT		15
> +#else
>  #define THREAD_SHIFT		13
>  #endif
> +#endif

Switching to #elif would remove the nested ifdef here.

>
>  #define THREAD_SIZE		(1 << THREAD_SHIFT)
>
> diff --git a/arch/powerpc/kernel/head_booke.h 
> b/arch/powerpc/kernel/head_booke.h
> index fce2df9..bc6a26c 100644
> --- a/arch/powerpc/kernel/head_booke.h
> +++ b/arch/powerpc/kernel/head_booke.h
> @@ -10,6 +10,14 @@
>  		mtspr	SPRN_IVOR##vector_number,r26;	\
>  		sync
>
> +#ifndef CONFIG_PPC_256K_PAGES

This if should be on THREAD_SIZE or THREAD_SHIFT, not the option that 
causes it to be large.

> +#define ALLOC_STACK_FRAME(reg, val)	addi reg,reg,val
> +#else
> +#define ALLOC_STACK_FRAME(reg, val)			\
> +	addis	reg,reg,val@ha;				\
> +	addi	reg,reg,val@l
> +#endif
> +
>  #define NORMAL_EXCEPTION_PROLOG						     \
>  	mtspr	SPRN_SPRG0,r10;		/* save two registers to work with */\
>  	mtspr	SPRN_SPRG1,r11;						     \
> @@ -20,7 +28,7 @@
>  	beq	1f;							     \
>  	mfspr	r1,SPRN_SPRG3;		/* if from user, start at top of   */\
>  	lwz	r1,THREAD_INFO-THREAD(r1); /* this thread's kernel stack   */\
> -	addi	r1,r1,THREAD_SIZE;					     \
> +	ALLOC_STACK_FRAME(r1, THREAD_SIZE);				     \
>  1:	subi	r1,r1,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
>  	mr	r11,r1;							     \
>  	stw	r10,_CCR(r11);          /* save various registers	   */\
> diff --git a/init/Kconfig b/init/Kconfig
> index f763762..96229b9 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -635,6 +635,16 @@ config ELF_CORE
>  	help
>  	  Enable support for generating core dumps. Disabling saves about 4k.
>
> +config STDBINUTILS
> +	bool "Using standard binutils" if EMBEDDED
> +	depends on 44x
> +	default y
> +	help
> +	  Turning this option off allows you to select 256KB PAGE_SIZE on 
> 44x.
> +	  Note, that kernel will be able to run only those applications,
> +	  which had been compiled using the patched binutils (ELF standard
> +	  supports only page sizes up to 64K).
> +

The config variable 44x is pretty nondescript for a global config file. 
  If you leave it here, I would suggest  making it depend on PPC && 44x 
so that other people don't have to wonder what 44x means.  I didn't 
look if there was a better place to put this option, somewhere 
architecture specific might be better (eg after selecting the 44x cpu 
type).

>  config PCSPKR_PLATFORM
>  	bool "Enable PC-Speaker support" if EMBEDDED
>  	depends on ALPHA || X86 || MIPS || PPC_PREP || PPC_CHRP || 
> PPC_PSERIES
>

thanks,
milton
