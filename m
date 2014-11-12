Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 80FC31A01EE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 17:51:45 +1100 (AEDT)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 11 Nov 2014 23:51:42 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 4943E3E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Nov 2014 23:51:40 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAC6pdvU57933850
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 07:51:40 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 sAC6uUjO022788
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Nov 2014 23:56:30 -0700
Message-ID: <54630362.7050007@linux.vnet.ibm.com>
Date: Wed, 12 Nov 2014 12:21:14 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] powernv: cpuidle: Redesign idle states management
References: <1415030910-5799-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1415030910-5799-4-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1415030910-5799-4-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Shreyas,

On 11/03/2014 09:38 PM, Shreyas B. Prabhu wrote:
> diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
> index 283c603..df11acb 100644
> --- a/arch/powerpc/kernel/idle_power7.S
> +++ b/arch/powerpc/kernel/idle_power7.S
>  _GLOBAL(power7_idle)
>  	/* Now check if user or arch enabled NAP mode */
> @@ -141,49 +192,16 @@ _GLOBAL(power7_idle)
>  
>  _GLOBAL(power7_nap)
>  	mr	r4,r3
> -	li	r3,0
> +	li	r3,1

The comment at the top of this file states 0 for nap and 1 for sleep.
You will need to change that. As an alternative I would suggest using
the macros that you have already defined:PNV_THREAD_NAP and
PNV_THREAD_SLEEP to write to r3 above and remove the lines that say 0
for nap and 1 for sleep in the comments.

>  	b	power7_powersave_common
>  	/* No return */
>  

<snip>

> @@ -210,12 +226,91 @@ _GLOBAL(power7_wakeup_tb_loss)
>  BEGIN_FTR_SECTION
>  	CHECK_HMI_INTERRUPT
>  END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
> +
> +	li	r7,1
> +	mfspr	r8,SPRN_PIR
> +	/*
> +	 * The last 3 bits of PIR represents the thread id of a cpu
> +	 * in power8. This will need adjusting for power7.
> +	 */
> +	andi.	r8,r8,0x07		/* Get thread id into r8 */
> +	rotld	r7,r7,r8
> +	/* r7 now has 'thread_id'th bit set */
> +
> +	ld	r14,PACA_CORE_IDLE_STATE_PTR(r13)
> +lwarx_loop2:
> +	lwarx	r15,0,r14
> +	andi.	r9,r15,PNV_CORE_IDLE_LOCK_BIT
> +	/*
> +	 * Lock bit is set in one of the 2 cases-
> +	 * a. In the sleep/winkle enter path, the last thread is executing
> +	 * fastsleep workaround code.
> +	 * b. In the wake up path, another thread is executing fastsleep
> +	 * workaround undo code or resyncing timebase or restoring context
> +	 * In either case loop until the lock bit is cleared.
> +	 */
> +	bne	lwarx_loop2
> +
> +	cmpwi	cr2,r15,0
> +	or	r15,r15,r7		/* Set thread bit */
> +
> +	beq	cr2,first_thread
> +
> +	/* Not first thread in core to wake up */
> +	stwcx.	r15,0,r14
> +	bne-	lwarx_loop2
> +	b	common_exit
> +
> +first_thread:
> +	/* First thread in core to wakeup */
> +	ori	r15,r15,PNV_CORE_IDLE_LOCK_BIT
> +	stwcx.	r15,0,r14
> +	bne-	lwarx_loop2
> +
> +	LOAD_REG_ADDR(r3, pnv_need_fastsleep_workaround)
> +	lbz	r3,0(r3)
> +	cmpwi	r3,1
> +	/*  skip fastsleep workaround if its not needed */
> +	bne	timebase_resync
> +
> +	/* Undo fast sleep workaround */
> +	mfcr	r16	/* Backup CR into a non-volatile register */

Don't you want to do this ^^ before calling opal_call_realmode for
timebase resync below also?

> +	li	r3,1
> +	li	r4,0
> +	li	r0,OPAL_CONFIG_CPU_IDLE_STATE
> +	bl	opal_call_realmode
> +	mtcr	r16	/* Restore CR */
> +
> +	/* Do timebase resync if we are waking up from sleep. Use cr1 value
> +	 * set in exceptions-64s.S */
> +	ble	cr1,clear_lock
> +
> +timebase_resync:
>  	/* Time base re-sync */
> -	li	r3,OPAL_RESYNC_TIMEBASE
> +	li	r0,OPAL_RESYNC_TIMEBASE
>  	bl	opal_call_realmode;
> -
> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
> index 34c6665..980c964 100644
> --- a/arch/powerpc/platforms/powernv/setup.c
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -36,6 +36,8 @@
>  #include <asm/opal.h>
>  #include <asm/kexec.h>
>  #include <asm/smp.h>
> +#include <asm/cputhreads.h>
> +#include <asm/cpuidle.h>
>  
>  #include "powernv.h"
>  
> @@ -292,11 +294,55 @@ static void __init pnv_setup_machdep_rtas(void)
>  
>  static u32 supported_cpuidle_states;
>  
> +static void pnv_alloc_idle_core_states(void)
> +{
> +	int i, j;
> +	int nr_cores = cpu_nr_cores();
> +	u32 *core_idle_state;
> +
> +	/*
> +	 * Deep idle states like sleep and winkle are per core idle states.
> +	 * A core enters these states only when all the threads enter either
> +	 * the particular idle state or a deeper one. There are tasks like
> +	 * fastsleep hardware bug workaround and hypervisor core state save
> +	 * which have to be done only by the last thread of the core entering
> +	 * deep idle state and similarly tasks like timebase resync, hypervisor
> +	 * core register restore that have to be done only by the first thread
> +	 * waking up from these states. Introducing core_idle_state, a per core
> +	 * structure which will keep track threads entering idle states deeper
> +	 * than sleep.

Since you already have explained ^^ in the changelog, you do not need to
elaborate it here.

> +	 * core_idle_state - First 8 bits track the idle state of each thread
> +	 * of the core. The 8th bit is the lock bit. Initially all thread bits
> +	 * are set. They are cleared when the thread enters deep idle state
> +	 * like sleep and winkle. Initially the lock bit is cleared.

you can simply have the comment about the bits of core_idle_state
without having to mention about when they are cleared etc..

> +	 * The lock bit has 2 purposes
> +	 * a. While the first thread is restoring core state, it prevents
> +	 * from other threads in the core from switching to prcoess context.
> +	 * b. While the last thread in the core is saving the core state, it
> +	 * prevent a different thread from waking up.

The above two points are useful. As far as I see besides explaining the
bits of core_idle_state structure and the purpose of lock bit the rest
of the comments is redundant. A git-blame will let people know why all
this is needed. The comment section should not be used up for this
purpose IMO.

Regards
Preeti U Murthy
