Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D8F41A03C5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 18:51:34 +1100 (AEDT)
In-Reply-To: <1453337749-15506-7-git-send-email-cyrilbur@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, anton@samba.org
Subject: Re: [v3, 6/9] powerpc: Prepare for splitting giveup_{fpu, altivec,
 vsx} in two
Message-Id: <20160210075134.07A0B140324@ozlabs.org>
Date: Wed, 10 Feb 2016 18:51:33 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-21-01 at 00:55:46 UTC, Cyril Bur wrote:
> This prepares for the decoupling of saving {fpu,altivec,vsx} registers and
> marking {fpu,altivec,vsx} as being unused by a thread.
> 
> Currently giveup_{fpu,altivec,vsx}() does both however optimisations to
> task switching can be made if these two operations are decoupled.
> save_all() will permit the saving of registers to thread structs and leave
> threads MSR with bits enabled.
> 
> This patch introduces no functional change.

> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 0955b7c..45e37c0 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -349,6 +349,14 @@ void flush_spe_to_thread(struct task_struct *tsk)
>  		preempt_enable();
>  	}
>  }
> +#else
> +/*
> + * save_all() is going to test MSR_SPE, rather than pull in all the
> + * booke definitions all the time on a books kernel just ensure it exists
> + * but acts as a nop.
> + */
> +
> +#define MSR_SPE 0
>  #endif /* CONFIG_SPE */


Building corenet32/64_defconfig this gives me:

  arch/powerpc/kernel/process.c:392:0: error: "MSR_SPE" redefined [-Werror]
   #define MSR_SPE 0
   ^
  In file included from ./arch/powerpc/include/asm/reg.h:18:0,
                   from ./arch/powerpc/include/asm/processor.h:13,
                   from ./arch/powerpc/include/asm/thread_info.h:33,
                   from include/linux/thread_info.h:54,
                   from include/asm-generic/preempt.h:4,
                   from arch/powerpc/include/generated/asm/preempt.h:1,
                   from include/linux/preempt.h:59,
                   from include/linux/spinlock.h:50,
                   from include/linux/seqlock.h:35,
                   from include/linux/time.h:5,
                   from include/uapi/linux/timex.h:56,
                   from include/linux/timex.h:56,
                   from include/linux/sched.h:19,
                   from arch/powerpc/kernel/process.c:18:
  ./arch/powerpc/include/asm/reg_booke.h:33:0: note: this is the location of the previous definition
   #define MSR_SPE  __MASK(MSR_SPE_LG)
   ^
  cc1: all warnings being treated as errors
  scripts/Makefile.build:258: recipe for target 'arch/powerpc/kernel/process.o' failed
  make[1]: *** [arch/powerpc/kernel/process.o] Error 1
  make[1]: *** Waiting for unfinished jobs....
  Makefile:950: recipe for target 'arch/powerpc/kernel' failed

cheers
