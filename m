Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 4BAB8DDDF3
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 15:52:46 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f90d4d7306443a720ca31adf513faf25@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] Support for relocatable kdump kernel
Date: Tue, 21 Oct 2008 23:56:01 -0500
To: Michael Ellerman <michael@ellerman.id.au>, Mohan Kumar M <mohan@in.ibm.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed Oct 22 at 14:38:10 EST in 2008, Michael Ellerman wrote:
> This adds relocatable kernel support for kdump. With this one can
> use the same regular kernel to capture the kdump. A signature 
> (0xfeed1234)
> is passed in r6 from panic code to the next kernel through 
> kexec_sequence
> and purgatory code. The signature is used to differentiate between
> kdump kernel and non-kdump kernels.

I object to this signature being passed from the kernel.  The
purgatory code should be modified to set this based on a memory
variable in its space, and that varable should be set by the
userspace code code that prepares purgatory.  (The standard
kexec-tools has library code to do this and we already use it
to tell purgatory the location of the device tree and kernel).

> The purgatory code compares the signature and sets the __kdump_flag in
> head_64.S.  During the boot up, kernel code checks __kdump_flag and if 
> it
> is set, the kernel will behave as relocatable kdump kernel. This kernel
> will boot at the address where it was loaded by kexec-tools ie. at the
> address reserved through crashkernel boot parameter.

I was hoping for a more generic test, but I haven't had the time to
write code for this so I'll accept this part for now.


> CONFIG_CRASH_DUMP depends on CONFIG_RELOCATABLE option to build kdump
> kernel as relocatable. So the same kernel can be used as production and
> kdump kernel.
>
>

>
> diff --git a/arch/powerpc/include/asm/kdump.h 
> b/arch/powerpc/include/asm/kdump.h
> index f6c93c7..a503da9 100644
> --- a/arch/powerpc/include/asm/kdump.h
> +++ b/arch/powerpc/include/asm/kdump.h
> @@ -9,6 +9,12 @@
>   * Reserve to the end of the FWNMI area, see head_64.S */
>  #define KDUMP_RESERVE_LIMIT    0x10000 /* 64K */
>
> +/*
> + * Used to differentiate between relocatable kdump kernel and other
> + * kernels
> + */
> +#define KDUMP_SIGNATURE        0xfeed1234
> +

This can go

>  #ifdef CONFIG_CRASH_DUMP
>
>  #define KDUMP_TRAMPOLINE_START 0x0100
> @@ -19,17 +25,18 @@
>  #endif /* CONFIG_CRASH_DUMP */
>
>  #ifndef __ASSEMBLY__
> -#ifdef CONFIG_CRASH_DUMP
>
> +extern unsigned long __kdump_flag;
> +

This will not be needed.  It will only be referenced by the
assembly code in head.S.

> +#if defined(CONFIG_CRASH_DUMP) && !defined(CONFIG_RELOCATABLE)
>  extern void reserve_kdump_trampoline(void);
>  extern void setup_kdump_trampoline(void);
> -
> -#else /* !CONFIG_CRASH_DUMP */
> -
> +#else
> +/* !CRASH_DUMP || RELOCATABLE */
>  static inline void reserve_kdump_trampoline(void) { ; }
>  static inline void setup_kdump_trampoline(void) { ; }
> +#endif
>
> -#endif /* CONFIG_CRASH_DUMP */
>  #endif /* __ASSEMBLY__ */
>
>  #endif /* __PPC64_KDUMP_H */
> diff --git a/arch/powerpc/kernel/crash_dump.c 
> b/arch/powerpc/kernel/crash_dump.c
> index 97e0563..19671ac 100644
> --- a/arch/powerpc/kernel/crash_dump.c
> +++ b/arch/powerpc/kernel/crash_dump.c
> @@ -30,6 +30,7 @@
>  /* Stores the physical address of elf header of crash image. */
>  unsigned long long elfcorehdr_addr = ELFCORE_ADDR_MAX;
>
> +#ifndef CONFIG_RELOCATABLE

is this done somewhere else for the relocatable case?
a comment pointing to where would be helpful.

>  void __init reserve_kdump_trampoline(void)
>  {
>         lmb_reserve(0, KDUMP_RESERVE_LIMIT);
> @@ -68,6 +69,7 @@ void __init setup_kdump_trampoline(void)
>
>         DBG(" <- setup_kdump_trampoline()\n");
>  }
> +#endif /* CONFIG_RELOCATABLE */
>
>  /*
>   * Note: elfcorehdr_addr is not just limited to vmcore. It is also 
> used by
> diff --git a/arch/powerpc/kernel/head_64.S 
> b/arch/powerpc/kernel/head_64.S
> index 84856be..69489bd 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -97,6 +97,12 @@ __secondary_hold_spinloop:
>  __secondary_hold_acknowledge:
>         .llong  0x0
>
> +       /* This flag is set by purgatory if we should be a kdump 
> kernel. */
> +       /* Do not move this variable as purgatory knows about it. */
> +       .globl  __kdump_flag
> +__kdump_flag:
> +       .llong  0x0
> +
>  #ifdef CONFIG_PPC_ISERIES
>         /*
>          * At offset 0x20, there is a pointer to iSeries LPAR data.
> @@ -1384,7 +1390,13 @@ _STATIC(__after_prom_start)
>         /* process relocations for the final address of the kernel */
>         lis     r25,PAGE_OFFSET at highest      /* compute virtual 
> base of kernel */
>         sldi    r25,r25,32
> -       mr      r3,r25
> +#ifdef CONFIG_CRASH_DUMP
> +       ld      r7,__kdump_flag-_stext(r26)
> +       cmpldi  cr0,r7,1        /* kdump kernel ? - stay where we are 
> */
> +       bne     1f
> +       add     r25,r25,r26
> +#endif
> +1:     mr      r3,r25
>         bl      .relocate
>  #endif
>
> @@ -1398,11 +1410,26 @@ _STATIC(__after_prom_start)
>         li      r3,0                    /* target addr */
>         mr.     r4,r26                  /* In some cases the loader 
> may  */
>         beq     9f                      /* have already put us at zero 
> */
> -       lis     r5,(copy_to_here - _stext)@ha
> -       addi    r5,r5,(copy_to_here - _stext)@l /* # bytes of memory 
> to copy */
>         li      r6,0x100                /* Start offset, the first 
> 0x100 */
>                                         /* bytes were copied earlier.  
>   */
>
> +#ifdef CONFIG_CRASH_DUMP
> +/*
> + * Check if the kernel has to be running as relocatable kernel based 
> on the
> + * variable __kdump_flag, if it is set the kernel is treated as 
> relocatable
> + * kernel, otherwise it will be moved to PHYSICAL_START
> + */
> +       ld      r7,__kdump_flag-_stext(r26)
> +       cmpldi  cr0,r7,1
> +       bne     3f
> +
> +       li      r5,__end_interrupts - _stext    /* just copy 
> interrupts */
> +       b       5f
> +3:
> +#endif
> +       lis     r5,(copy_to_here - _stext)@ha
> +       addi    r5,r5,(copy_to_here - _stext)@l /* # bytes of memory 
> to copy */
> +
>         bl      .copy_and_flush         /* copy the first n bytes      
>   */
>                                         /* this includes the code 
> being  */
>                                         /* executed here.              
>   */
> @@ -1411,15 +1438,15 @@ _STATIC(__after_prom_start)
>         mtctr   r8
>         bctr
>
> +p_end: .llong  _end - _stext
> +
>  4:     /* Now copy the rest of the kernel up to _end */
>         addis   r5,r26,(p_end - _stext)@ha
>         ld      r5,(p_end - _stext)@l(r5)       /* get _end */
> -       bl      .copy_and_flush         /* copy the rest */
> +5:     bl      .copy_and_flush         /* copy the rest */
>
>  9:     b       .start_here_multiplatform
>
> -p_end: .llong  _end - _stext
> -
>  /*
>   * Copy routine used to copy the kernel to start at physical address 0
>   * and flush and invalidate the caches as needed.
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index ea1ba89..3857d7e 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -458,6 +458,42 @@ void iommu_unmap_sg(struct iommu_table *tbl, 
> struct scatterlist *sglist,
>         spin_unlock_irqrestore(&(tbl->it_lock), flags);
>  }
>
> +static void iommu_table_clear(struct iommu_table *tbl)
> +{
> +       if (!__kdump_flag) {

This test should be using the new is_kdump_kernel in
include/linux/crash_dump.h.   (That tests the presence
of the elfcore= command line, but it (1) is common
with other architectures, and (2) allows the kernel
to be running offset for other uses.

> +               /* Clear the table in case firmware left allocations 
> in it */
> +               ppc_md.tce_free(tbl, tbl->it_offset, tbl->it_size);
> +               return;
> +       }
>
> +
> +#ifdef CONFIG_CRASH_DUMP
> +       if (ppc_md.tce_get) {
> +               unsigned long index, tceval, tcecount = 0;
> +
>

> --- a/arch/powerpc/kernel/machine_kexec.c
> +++ b/arch/powerpc/kernel/machine_kexec.c
> @@ -88,11 +88,13 @@ void __init reserve_crashkernel(void)
>
>         crash_size = crashk_res.end - crashk_res.start + 1;
>
> +#ifndef CONFIG_RELOCATABLE
>         if (crashk_res.start != KDUMP_KERNELBASE)
>                 printk("Crash kernel location must be 0x%x\n",
>                                 KDUMP_KERNELBASE);
>
>         crashk_res.start = KDUMP_KERNELBASE;
> +#endif

actually, we should never test on ppc64, as we don't care
if the base kernel is compiled CONFIG_RELOCATABLE but only
that the dump kernel must be.

>         crash_size = PAGE_ALIGN(crash_size);
>         crashk_res.end = crashk_res.start + crash_size - 1;
>
> diff --git a/arch/powerpc/kernel/machine_kexec_64.c 
> b/arch/powerpc/kernel/machine_kexec_64.c
> index 4bd8b4f..e6efec7 100644
> --- a/arch/powerpc/kernel/machine_kexec_64.c
> +++ b/arch/powerpc/kernel/machine_kexec_64.c
> @@ -255,11 +255,14 @@ static union thread_union kexec_stack
>  /* Our assembly helper, in kexec_stub.S */
>  extern NORET_TYPE void kexec_sequence(void *newstack, unsigned long 
> start,
>                                         void *image, void *control,
> -                                       void (*clear_all)(void)) 
> ATTRIB_NORET;
> +                                       void (*clear_all)(void),
> +                                       unsigned long kdump_flag) 
> ATTRIB_NORET;
>
>  /* too late to fail here */
>  void default_machine_kexec(struct kimage *image)
>  {
> +       unsigned long kdump_flag = 0;
> +
>         /* prepare control code if any */
>
>         /*
> @@ -270,8 +273,10 @@ void default_machine_kexec(struct kimage *image)
>          * using debugger IPI.
>          */
>
> -       if (crashing_cpu == -1)
> -               kexec_prepare_cpus();
> +       if (crashing_cpu == -1)
> +               kexec_prepare_cpus();
> +       else
> +               kdump_flag = KDUMP_SIGNATURE;
>
>         /* switch to a staticly allocated stack.  Based on irq stack 
> code.
>          * XXX: the task struct will likely be invalid once we do the 
> copy!
> @@ -284,7 +289,7 @@ void default_machine_kexec(struct kimage *image)
>          */
>         kexec_sequence(&kexec_stack, image->start, image,
>                         page_address(image->control_code_page),
> -                       ppc_md.hpte_clear_all);
> +                       ppc_md.hpte_clear_all, kdump_flag);
>         /* NOTREACHED */
>  }
>
>
> diff --git a/arch/powerpc/kernel/misc_64.S 
> b/arch/powerpc/kernel/misc_64.S
> index 3053fe5..a243fd0 100644
> --- a/arch/powerpc/kernel/misc_64.S
> +++ b/arch/powerpc/kernel/misc_64.S
> @@ -611,10 +611,12 @@ real_mode:        /* assume normal blr return */
>
>
>  /*
> - * kexec_sequence(newstack, start, image, control, clear_all())
> + * kexec_sequence(newstack, start, image, control, clear_all(), 
> kdump_flag)
>   *
>   * does the grungy work with stack switching and real mode switches
>   * also does simple calls to other code
> + *
> + * kdump_flag says whether the next kernel should be a kdump kernel.
>   */
>
>  _GLOBAL(kexec_sequence)
> @@ -647,7 +649,7 @@ _GLOBAL(kexec_sequence)
>         mr      r29,r5                  /* image (virt) */
>         mr      r28,r6                  /* control, unused */
>         mr      r27,r7                  /* clear_all() fn desc */
> -       mr      r26,r8                  /* spare */
> +       mr      r26,r8                  /* kdump flag */
>         lhz     r25,PACAHWCPUID(r13)    /* get our phys cpu from paca 
> */
>
>         /* disable interrupts, we are overwriting kernel data next */
> @@ -709,5 +711,6 @@ _GLOBAL(kexec_sequence)
>         mr      r4,r30  # start, aka phys mem offset
>         mtlr    4
>         li      r5,0
> -       blr     /* image->start(physid, image->start, 0); */
> +       mr      r6,r26                  /* kdump_flag */
> +       blr     /* image->start(physid, image->start, 0, kdump_flag); 
> */
>  #endif /* CONFIG_KEXEC */

please remove these changes and signature.
as explained above, this should be handled by the user space loading
the kexec kernel.   We never use the same kexec target for kdump and
a normal reboot.


> diff --git a/arch/powerpc/platforms/cell/ras.c 
> b/arch/powerpc/platforms/cell/ras.c
> index 2a14b05..665af1c 100644
> --- a/arch/powerpc/platforms/cell/ras.c
> +++ b/arch/powerpc/platforms/cell/ras.c
> @@ -21,6 +21,7 @@
>  #include <asm/machdep.h>
>  #include <asm/rtas.h>
>  #include <asm/cell-regs.h>
> +#include <asm/kdump.h>
>
>  #include "ras.h"
>
> @@ -111,9 +112,8 @@ static int __init cbe_ptcal_enable_on_node(int 
> nid, int order)
>         int ret = -ENOMEM;
>         unsigned long addr;
>
> -#ifdef CONFIG_CRASH_DUMP
> -       rtas_call(ptcal_stop_tok, 1, 1, NULL, nid);
> -#endif
> +       if (__kdump_flag)
> +               rtas_call(ptcal_stop_tok, 1, 1, NULL, nid);
>

This should use is_kdump_kernel() from include/linux/crash_dump.h

>         area = kmalloc(sizeof(*area), GFP_KERNEL);
>         if (!area)
> diff --git a/arch/powerpc/platforms/pseries/iommu.c 
> b/arch/powerpc/platforms/pseries/iommu.c
> index a8c4466..d56491d 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -44,6 +44,7 @@
>  #include <asm/tce.h>
>  #include <asm/ppc-pci.h>
>  #include <asm/udbg.h>
> +#include <asm/kdump.h>
>
>  #include "plpar_wrappers.h"
>
> @@ -291,9 +292,8 @@ static void iommu_table_setparms(struct 
> pci_controller *phb,
>
>         tbl->it_base = (unsigned long)__va(*basep);
>
> -#ifndef CONFIG_CRASH_DUMP
> -       memset((void *)tbl->it_base, 0, *sizep);
> -#endif
> +       if (!__kdump_flag)
> +               memset((void *)tbl->it_base, 0, *sizep);
>

as should this.

>
>         tbl->it_busno = phb->bus->number;
>


thanks,
milton
