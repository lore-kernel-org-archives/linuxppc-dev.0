Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 7DD14DE075
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 03:53:00 +1100 (EST)
Message-ID: <47260FE5.5080107@ru.mvista.com>
Date: Mon, 29 Oct 2007 19:52:53 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [POWERPC] Fix off-by-one error in setting decrementer on Book
 E
References: <18213.19469.827909.663373@cargo.ozlabs.ibm.com>
In-Reply-To: <18213.19469.827909.663373@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Paul Mackerras wrote:

> The decrementer in Book E and 4xx processors interrupts on the
> transition from 1 to 0, rather than on the 0 to -1 transition as on
> 64-bit server and 32-bit "classic" (6xx/7xx/7xxx) processors.

> This fixes the problem by making set_dec subtract 1 from the count for
> server and classic processors.  Since set_dec already had a bunch of
> ifdefs to handle different processor types, there is no net increase
> in ugliness. :)

> This also removes a redundant call to set the decrementer to
> 0x7fffffff - it was already set to that earlier in timer_interrupt.

> Signed-off-by: Paul Mackerras <paulus@samba.org>

    Heh, I have alike patch but refrained from posting being busy with other
stuff and nt having any PPC target at hand... so, I'm late as usual

> ---
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 9eb3284..5e253d6 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -586,7 +586,7 @@ void timer_interrupt(struct pt_regs * regs)
>  		/* not time for this event yet */
>  		now = per_cpu(decrementer_next_tb, cpu) - now;
>  		if (now <= DECREMENTER_MAX)
> -			set_dec((unsigned int)now - 1);
> +			set_dec((int)now);
>  		return;
>  	}
>  	old_regs = set_irq_regs(regs);
> @@ -601,10 +601,8 @@ void timer_interrupt(struct pt_regs * regs)
>  
>  	if (evt->event_handler)
>  		evt->event_handler(evt);
> -	else
> -		evt->set_next_event(DECREMENTER_MAX, evt);
>  
>  #ifdef CONFIG_PPC_ISERIES
>  	if (firmware_has_feature(FW_FEATURE_ISERIES) && hvlpevent_is_pending())
> @@ -826,9 +824,6 @@ static int decrementer_set_next_event(unsigned long evt,
>  				      struct clock_event_device *dev)
>  {
>  	__get_cpu_var(decrementer_next_tb) = get_tb_or_rtc() + evt;
> -	/* The decrementer interrupts on the 0 -> -1 transition */
> -	if (evt)
> -		--evt;
>  	set_dec(evt);
>  	return 0;
>  }
> diff --git a/include/asm-powerpc/time.h b/include/asm-powerpc/time.h
> index f058955..eed64bd 100644
> --- a/include/asm-powerpc/time.h
> +++ b/include/asm-powerpc/time.h
> @@ -183,6 +183,7 @@ static inline void set_dec(int val)
>  #elif defined(CONFIG_8xx_CPU6)
>  	set_dec_cpu6(val);
>  #else
> +	--val;	/* classic decrementer interrupts when dec goes negative */

    I got an impression that set_dec_cpu6() needs the decremented val as well.
Plus for iSeries compiler will complain for iSeries about cur_dec being
declared after val-- statement, C++ style.  How about such variant (and the 
same for <asm-ppc/time.h>)?

Index: powerpc/include/asm-powerpc/time.h
===================================================================
--- powerpc.orig/include/asm-powerpc/time.h
+++ powerpc/include/asm-powerpc/time.h
@@ -178,16 +178,24 @@ static inline unsigned int get_dec(void)

  static inline void set_dec(int val)
  {
+       /*
+        * The "classic"  decrementer  interrupts at 0 to -1 transition, while
+        * 40x and book E decrementers interrupt  at 1 to  0 transition.
+        */
  #if defined(CONFIG_40x)
         mtspr(SPRN_PIT, val);
-#elif defined(CONFIG_8xx_CPU6)
+#else
+#if !defined(CONFIG_BOOKE)
+       val = val ? val - 1 : 0;
+#endif
+#if defined(CONFIG_8xx_CPU6)
         set_dec_cpu6(val);
-#ifdef CONFIG_PPC_ISERIES
-       int cur_dec;
-
+#if defined(CONFIG_PPC_ISERIES)
         if (firmware_has_feature(FW_FEATURE_ISERIES) &&
-                       get_lppaca()->shared_proc) {
+           get_lppaca()->shared_proc) {
+               int cur_dec;
+
                 get_lppaca()->virtual_decr = val;
                 cur_dec = get_dec();
                 if (cur_dec > val)
@@ -195,7 +203,8 @@ static inline void set_dec(int val)
         } else
  #endif
                 mtspr(SPRN_DEC, val);
-#endif /* not 40x or 8xx_CPU6 */
+#endif /* not 8xx_CPU6 */
+#endif /* not 40x */
  }

  static inline unsigned long tb_ticks_since(unsigned long tstamp)

WBR, Sergei
