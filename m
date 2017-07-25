Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGv7x4XwVzDqm2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 20:08:13 +1000 (AEST)
Message-ID: <1500977248.2792.1.camel@kernel.crashing.org>
Subject: Re: [PATCH v3] powerpc/vdso64: Add support for
 CLOCK_{REALTIME/MONOTONIC}_COARSE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Santosh Sivaraj <santosh@fossix.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, John Stultz
 <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Frederic
 Weisbecker <fweisbec@gmail.com>
Date: Tue, 25 Jul 2017 20:07:28 +1000
In-Reply-To: <20170725065613.7039-1-santosh@fossix.org>
References: <20170721090944.16889-1-santosh@fossix.org>
 <20170725065613.7039-1-santosh@fossix.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-07-25 at 12:26 +0530, Santosh Sivaraj wrote:

> +static notrace void kernel_get_tspec(struct timespec *tp,
> +				     struct vdso_data *vdata, u32 *wtom_sec,
> +				     u32 *wtom_nsec)
> +{
> +	u64 tb;
> +	u32 update_count;

This is broken:

> +	do {
> +		/* check for update count & load values */
> +		update_count = vdata->tb_update_count;
> +
> +		/* Get TB, offset it and scale result */
> +		tb = mulhdu((get_tb() - vdata->tb_orig_stamp) << 12,
> +			    vdata->tb_to_xs) + vdata->stamp_sec_fraction;
> +		tp->tv_sec = vdata->stamp_xtime.tv_sec;
> +		if (wtom_sec)
> +			*wtom_sec = vdata->wtom_clock_sec;
> +		if (wtom_nsec)
> +			*wtom_nsec = vdata->wtom_clock_nsec;
> +	} while (update_count != vdata->tb_update_count);

The assembly code is carefuly crafted to create a chain of data
dependencies in order to enforce the ordering in this function,
you completely broke it.

IE. the pointer used to access tb_orig_stamp etc... depends on the
initial update count, and the final read of the update count depends
on all the previously read values (or should), thus ordering those
loads. Withtout that you'll need more expensive lwsync's.

Additionally, you broke another semantic of the seqlock which is
to spin on the first update count if it has an odd value.

The same problem exist in all your other implementations.

I am really NOT a fan of that attempt at converting to C. The code is
hand crafted assembly for a number of reasons, including the above ones
and maximum performance.

As it is, it's deeply broken.

> +
> +	tp->tv_nsec = ((u64)mulhwu(tb, NSEC_PER_SEC) << 32) >> 32;
> +	tp->tv_sec += (tb >> 32);
> +}
> +
> +static notrace int clock_get_realtime(struct timespec *tp,
> +				      struct vdso_data *vdata)
> +{
> +	kernel_get_tspec(tp, vdata, NULL, NULL);
> +
> +	return 0;
> +}
> +
> +static notrace int clock_get_monotonic(struct timespec *tp,
> +				       struct vdso_data *vdata)
> +{
> +	__s32 wtom_sec, wtom_nsec;
> +	u64 nsec;
> +
> +	kernel_get_tspec(tp, vdata, &wtom_sec, &wtom_nsec);
> +
> +	tp->tv_sec += wtom_sec;
> +
> +	nsec = tp->tv_nsec;
> +	tp->tv_nsec = 0;
> +	timespec_add_ns(tp, nsec + wtom_nsec);
> +
> +	return 0;
> +}
> +
> +static notrace int clock_realtime_coarse(struct timespec *tp,
> +					 struct vdso_data *vdata)
> +{
> +	u32 update_count;
> +
> +	do {
> +		/* check for update count & load values */
> +		update_count = vdata->tb_update_count;
> +
> +		tp->tv_sec = vdata->stamp_xtime.tv_sec;
> +		tp->tv_nsec = vdata->stamp_xtime.tv_nsec;
> +	} while (update_count != vdata->tb_update_count);
> +
> +	return 0;
> +}
> +
> +static notrace int clock_monotonic_coarse(struct timespec *tp,
> +					  struct vdso_data *vdata)
> +{
> +	__s32 wtom_sec, wtom_nsec;
> +	u64 nsec;
> +	u32 update_count;
> +
> +	do {
> +		/* check for update count & load values */
> +		update_count = vdata->tb_update_count;
> +
> +		tp->tv_sec = vdata->stamp_xtime.tv_sec;
> +		tp->tv_nsec = vdata->stamp_xtime.tv_nsec;
> +		wtom_sec = vdata->wtom_clock_sec;
> +		wtom_nsec = vdata->wtom_clock_nsec;
> +	} while (update_count != vdata->tb_update_count);
> +
> +	tp->tv_sec += wtom_sec;
> +	nsec = tp->tv_nsec;
> +	tp->tv_nsec = 0;
> +	timespec_add_ns(tp, nsec + wtom_nsec);
> +
> +	return 0;
> +}
> +
> +notrace int kernel_clock_gettime(clockid_t clk_id, struct timespec *tp)
> +{
> +	int ret;
> +	struct vdso_data *vdata = __get_datapage();
> +
> +	if (!tp || !vdata)
> +		return -EBADR;
> +
> +	switch (clk_id) {
> +	case CLOCK_REALTIME:
> +		ret = clock_get_realtime(tp, vdata);
> +		break;
> +	case CLOCK_MONOTONIC:
> +		ret = clock_get_monotonic(tp, vdata);
> +		break;
> +	case CLOCK_REALTIME_COARSE:
> +		ret = clock_realtime_coarse(tp, vdata);
> +		break;
> +	case CLOCK_MONOTONIC_COARSE:
> +		ret = clock_monotonic_coarse(tp, vdata);
> +		break;
> +	default:
> +		/* fallback to syscall */
> +		ret = -1;
> +		break;
> +	}
> +
> +	return ret;
> +}
> diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
> index 3820213..c3f6b24 100644
> --- a/arch/powerpc/kernel/vdso64/gettimeofday.S
> +++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
> @@ -16,6 +16,8 @@
>  #include <asm/asm-offsets.h>
>  #include <asm/unistd.h>
>  
> +.global	kernel_clock_gettime
> +
>  	.text
>  /*
>   * Exact prototype of gettimeofday
> @@ -60,71 +62,23 @@ V_FUNCTION_END(__kernel_gettimeofday)
>   */
>  V_FUNCTION_BEGIN(__kernel_clock_gettime)
>    .cfi_startproc
> -	/* Check for supported clock IDs */
> -	cmpwi	cr0,r3,CLOCK_REALTIME
> -	cmpwi	cr1,r3,CLOCK_MONOTONIC
> -	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
> -	bne	cr0,99f
> -
> -	mflr	r12			/* r12 saves lr */
> -  .cfi_register lr,r12
> -	mr	r11,r4			/* r11 saves tp */
> -	bl	V_LOCAL_FUNC(__get_datapage)	/* get data page */
> -	lis	r7,NSEC_PER_SEC@h	/* want nanoseconds */
> -	ori	r7,r7,NSEC_PER_SEC@l
> -50:	bl	V_LOCAL_FUNC(__do_get_tspec)	/* get time from tb & kernel */
> -	bne	cr1,80f			/* if not monotonic, all done */
> -
> -	/*
> -	 * CLOCK_MONOTONIC
> -	 */
> -
> -	/* now we must fixup using wall to monotonic. We need to snapshot
> -	 * that value and do the counter trick again. Fortunately, we still
> -	 * have the counter value in r8 that was returned by __do_get_tspec.
> -	 * At this point, r4,r5 contain our sec/nsec values.
> -	 */
> -
> -	lwa	r6,WTOM_CLOCK_SEC(r3)
> -	lwa	r9,WTOM_CLOCK_NSEC(r3)
> -
> -	/* We now have our result in r6,r9. We create a fake dependency
> -	 * on that result and re-check the counter
> -	 */
> -	or	r0,r6,r9
> -	xor	r0,r0,r0
> -	add	r3,r3,r0
> -	ld	r0,CFG_TB_UPDATE_COUNT(r3)
> -        cmpld   cr0,r0,r8		/* check if updated */
> -	bne-	50b
> -
> -	/* Add wall->monotonic offset and check for overflow or underflow.
> -	 */
> -	add	r4,r4,r6
> -	add	r5,r5,r9
> -	cmpd	cr0,r5,r7
> -	cmpdi	cr1,r5,0
> -	blt	1f
> -	subf	r5,r7,r5
> -	addi	r4,r4,1
> -1:	bge	cr1,80f
> -	addi	r4,r4,-1
> -	add	r5,r5,r7
> -
> -80:	std	r4,TSPC64_TV_SEC(r11)
> -	std	r5,TSPC64_TV_NSEC(r11)
> -
> -	mtlr	r12
> +	mflr	r6			/* r12 saves lr */
> +	stwu	r1,-112(r1)
> +  .cfi_register lr,r6
> +	std	r6,24(r1)
> +	std	r3,32(r1)
> +	std	r4,40(r1)
>  	crclr	cr0*4+so
> -	li	r3,0
> -	blr
> -
> -	/*
> -	 * syscall fallback
> -	 */
> -99:
> +	bl	V_LOCAL_FUNC(kernel_clock_gettime)
> +	cmpwi	r3,0
> +	beq	77f
>  	li	r0,__NR_clock_gettime
> +	ld	r3,32(r1)
> +	ld	r4,40(r1)
>  	sc
> +77:	ld	r6,24(r1)
> +	addi	r1,r1,112
> +	mtlr	r6
>  	blr
>    .cfi_endproc
>  V_FUNCTION_END(__kernel_clock_gettime)
