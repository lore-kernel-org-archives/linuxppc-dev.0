Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 9DAAFDDE01
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 02:05:06 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <1224123753-20907-3-git-send-email-yanok@emcraft.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d02415a31b89736f070f290be89013d4@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [2/2] powerpc: support for 256K pages on PPC 44x
Date: Mon, 10 Nov 2008 09:09:24 -0600
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>, Vladimir Panfilov <pvr@emcraft.com>,
	Wolfgang Denk <wd@denx.de>, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2008-10-16 at 02:22:32, Ilya Yanok wrote:
>
> This patch adds support for 256K pages on PPC 44x along with
> some hacks needed for this.

This description is insufficient, it describes neither the hacks nor 
why they are required.

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 9627cfd..7df5528 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -425,6 +425,14 @@  config PPC_64K_PAGES
>         bool "64k page size" if 44x || PPC64
>         select PPC_HAS_HASH_64K if PPC64
>
> +config PPC_256K_PAGES
> +       bool "256k page size" if 44x
> +       depends on BROKEN

I know it was not your original choice, but I feel BROKEN is too 
strong.  It should be under embedded, and maybe a second choice "I am 
using standard binutils" that defaults to yes and is set to no (so that 
all yes config does not enable it by accident), but I feel labeling 
this BROKEN for an external dependency is wrong.

> +       help
> +         ELF standard supports only page sizes up to 64K so you need 
> a patched
> +         binutils in order to use 256K pages. Chose it only if you 
> know what
> +         you are doing.
> +
>  endchoice
>
>  config FORCE_MAX_ZONEORDER
> diff --git a/arch/powerpc/include/asm/highmem.h 
> b/arch/powerpc/include/asm/highmem.h
> index dc1132c..0b4ac6a 100644
> --- a/arch/powerpc/include/asm/highmem.h
> +++ b/arch/powerpc/include/asm/highmem.h
> @@ -38,7 +38,8 @@  extern pte_t *pkmap_page_table;
>   * easily, subsequent pte tables have to be allocated in one physical
>   * chunk of RAM.
>   */
> -#if defined(CONFIG_PPC_64K_PAGES) && !defined(CONFIG_PPC64)
> +#if defined(CONFIG_PPC_256K_PAGES) || \
> +       (defined(CONFIG_PPC_64K_PAGES) && !defined(CONFIG_PPC64))

Just because 256K pages is not selectable on PPC64 doesn't mean that 
this is the right grouping.   However, as I said on the previous patch, 
this file is never included on PPC64 so the clause should be removed.


> diff --git a/arch/powerpc/include/asm/page_32.h 
> b/arch/powerpc/include/asm/page_32.h
> index ebfae53..273369a 100644
> --- a/arch/powerpc/include/asm/page_32.h
> +++ b/arch/powerpc/include/asm/page_32.h
> @@ -20,7 +20,11 @@
>   */
>  #ifdef CONFIG_PTE_64BIT
>  typedef unsigned long long pte_basic_t;
> +#ifdef CONFIG_PPC_256K_PAGES
> +#define PTE_SHIFT       (PAGE_SHIFT - 7)

This seems to be missing the comment on how many ptes are actually in 
the page that are in the other if and else cases.

> +#else
>  #define PTE_SHIFT      (PAGE_SHIFT - 3)        /* 512 ptes per page */
> +#endif
>  #else
>  typedef unsigned long pte_basic_t;
>  #define PTE_SHIFT      (PAGE_SHIFT - 2)        /* 1024 ptes per page 
> */
> diff --git a/arch/powerpc/include/asm/thread_info.h 
> b/arch/powerpc/include/asm/thread_info.h
> index 9665a26..3c8bbab 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -15,8 +15,12 @@
>  #ifdef CONFIG_PPC64
>  #define THREAD_SHIFT           14
>  #else
> +#ifdef CONFIG_PPC_256K_PAGES
> +#define THREAD_SHIFT           15
> +#else
>  #define THREAD_SHIFT           13
>  #endif
> +#endif
>
>  #define THREAD_SIZE            (1 << THREAD_SHIFT)


So this appears to be the one hack.  For some unknown reason, you are 
increasing the kernel stack from 8k to 32k when selecting 256k pages.   
What data structure is ballooning in size so much that you need the 
additional kernel stack space on 256k pages but not on 64k pages?  Is 
this really tied to 256k base page size?

>
> diff --git a/arch/powerpc/kernel/head_booke.h 
> b/arch/powerpc/kernel/head_booke.h
> index fce2df9..acd4b47 100644
> --- a/arch/powerpc/kernel/head_booke.h
> +++ b/arch/powerpc/kernel/head_booke.h
> @@ -9,6 +9,13 @@
>                 li      r26,vector_label@l;             \
>                 mtspr   SPRN_IVOR##vector_number,r26;   \
>                 sync
> +#ifndef CONFIG_PPC_256K_PAGES
> +#define ALLOC_STACK_FRAME(reg, val)    addi    reg,reg,val
> +#else
> +#define ALLOC_STACK_FRAME(reg, val)                    \
> +               addis   reg,reg,val@ha;                 \
> +               addi    reg,reg,val@l
> +#endif

And this is directly related to choosing the stack size of 32k, which 
can not be added in a single instruction and larger even than what the 
64 bit kernel uses.  So even further explanation of the analysis is 
required.

>
>  #define NORMAL_EXCEPTION_PROLOG                                       
>               \
>         mtspr   SPRN_SPRG0,r10;         /* save two registers to work 
> with */\
> @@ -20,7 +27,7 @@
>         beq     1f;                                                    
>       \
>         mfspr   r1,SPRN_SPRG3;          /* if from user, start at top 
> of   */\
>         lwz     r1,THREAD_INFO-THREAD(r1); /* this thread's kernel 
> stack   */\
> -       addi    r1,r1,THREAD_SIZE;                                     
>       \
> +       ALLOC_STACK_FRAME(r1, THREAD_SIZE);                            
>               \
>  1:     subi    r1,r1,INT_FRAME_SIZE;   /* Allocate an exception frame 
>     */\
>         mr      r11,r1;                                                
>       \
>         stw     r10,_CCR(r11);          /* save various registers      
>     */\
> @@ -112,7 +119,7 @@
>         andi.   r10,r10,MSR_PR;                                        
>       \
>         mfspr   r11,SPRN_SPRG3;         /* if from user, start at top 
> of   */\
>         lwz     r11,THREAD_INFO-THREAD(r11); /* this thread's kernel 
> stack */\
> -       addi    r11,r11,EXC_LVL_FRAME_OVERHEAD; /* allocate stack 
> frame    */\
> +       ALLOC_STACK_FRAME(r11 ,EXC_LVL_FRAME_OVERHEAD); /* allocate 
> stack frame    */\
>         beq     1f;                                                    
>       \
>         /* COMING FROM USER MODE */                                    
>       \
>         stw     r9,_CCR(r11);           /* save CR                     
>     */\

milton
