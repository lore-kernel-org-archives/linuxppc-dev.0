Return-Path: <ntl@pobox.com>
Received: from gretel.pobox.com (gretel.pobox.com [208.58.1.197])
	by ozlabs.org (Postfix) with ESMTP id 10FB967A40
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jun 2006 08:02:54 +1000 (EST)
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by gretel.pobox.com (Postfix) with ESMTP id 7089C2C42CFC
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Jun 2006 17:55:27 -0400 (EDT)
Date: Mon, 5 Jun 2006 16:54:40 -0500
From: Nathan Lynch <ntl@pobox.com>
To: John Rose <johnrose@austin.ibm.com>
Subject: Re: [PATCH] reorg RTAS delay code
Message-ID: <20060605215440.GV8934@localdomain>
References: <1149103929.2524.8.camel@sinatra.austin.ibm.com>
	<1149139866.28307.32.camel@localhost.localdomain>
	<1149177349.9812.16.camel@sinatra.austin.ibm.com>
	<1149200718.15158.0.camel@sinatra.austin.ibm.com>
	<1149280229.18052.3.camel@sinatra.austin.ibm.com>
	<20060602213308.GP8934@localdomain>
	<1149543108.17307.6.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1149543108.17307.6.camel@sinatra.austin.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, External List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

John Rose wrote:
> This patch attempts to handle RTAS "busy" return codes in a more simple
> and consistent manner.  Typical callers of RTAS shouldn't have to
> manage wait times and delay calls.
> 
> This patch also changes the kernel to use msleep() rather than udelay()
> when a runtime delay is necessary.  This will avoid CPU soft lockups
> for extended delay conditions.
> 
> Signed-off-by: John Rose <johnrose@austin.ibm.com>
> 
> ---
> 
> Resend - added the suggested might_sleep() and braces.

FWIW:

Acked-by: Nathan Lynch <ntl@pobox.com>

>  2_6_linus-johnrose/arch/powerpc/kernel/rtas-rtc.c   |   30 +++----
>  2_6_linus-johnrose/arch/powerpc/kernel/rtas.c       |   85 ++++++++------------
>  2_6_linus-johnrose/arch/powerpc/kernel/rtas_flash.c |   25 -----
>  2_6_linus-johnrose/include/asm-powerpc/rtas.h       |    8 -
>  4 files changed, 57 insertions(+), 91 deletions(-)
> 
> diff -puN arch/powerpc/kernel/rtas.c~rtas_delay_reorg arch/powerpc/kernel/rtas.c
> --- 2_6_linus/arch/powerpc/kernel/rtas.c~rtas_delay_reorg	2006-06-02 15:09:43.000000000 -0500
> +++ 2_6_linus-johnrose/arch/powerpc/kernel/rtas.c	2006-06-05 15:00:03.000000000 -0500
> @@ -370,24 +370,36 @@ int rtas_call(int token, int nargs, int 
>  	return ret;
>  }
>  
> -/* Given an RTAS status code of 990n compute the hinted delay of 10^n
> - * (last digit) milliseconds.  For now we bound at n=5 (100 sec).
> +/* For RTAS_BUSY (-2), delay for 1 millisecond.  For an extended busy status
> + * code of 990n, perform the hinted delay of 10^n (last digit) milliseconds.
>   */
> -unsigned int rtas_extended_busy_delay_time(int status)
> +unsigned int rtas_busy_delay_time(int status)
>  {
> -	int order = status - 9900;
> -	unsigned long ms;
> +	int order;
> +	unsigned int ms = 0;
>  
> -	if (order < 0)
> -		order = 0;	/* RTC depends on this for -2 clock busy */
> -	else if (order > 5)
> -		order = 5;	/* bound */
> +	if (status == RTAS_BUSY) {
> +		ms = 1;
> +	} else if (status >= 9900 && status <= 9905) {
> +		order = status - 9900;
> +		for (ms = 1; order > 0; order--)
> +			ms *= 10;
> +	}
> +
> +	return ms;
> +}
> +
> +/* For an RTAS busy status code, perform the hinted delay. */
> +unsigned int rtas_busy_delay(int status)
> +{
> +	unsigned int ms;
>  
> -	/* Use microseconds for reasonable accuracy */
> -	for (ms = 1; order > 0; order--)
> -		ms *= 10;
> +	might_sleep();
> +	ms = rtas_busy_delay_time(status);
> +	if (ms)
> +		msleep(ms);
>  
> -	return ms; 
> +	return ms;
>  }
>  
>  int rtas_error_rc(int rtas_rc)
> @@ -438,22 +450,14 @@ int rtas_get_power_level(int powerdomain
>  int rtas_set_power_level(int powerdomain, int level, int *setlevel)
>  {
>  	int token = rtas_token("set-power-level");
> -	unsigned int wait_time;
>  	int rc;
>  
>  	if (token == RTAS_UNKNOWN_SERVICE)
>  		return -ENOENT;
>  
> -	while (1) {
> +	do {
>  		rc = rtas_call(token, 2, 2, setlevel, powerdomain, level);
> -		if (rc == RTAS_BUSY)
> -			udelay(1);
> -		else if (rtas_is_extended_busy(rc)) {
> -			wait_time = rtas_extended_busy_delay_time(rc);
> -			udelay(wait_time * 1000);
> -		} else
> -			break;
> -	}
> +	} while (rtas_busy_delay(rc));
>  
>  	if (rc < 0)
>  		return rtas_error_rc(rc);
> @@ -463,22 +467,14 @@ int rtas_set_power_level(int powerdomain
>  int rtas_get_sensor(int sensor, int index, int *state)
>  {
>  	int token = rtas_token("get-sensor-state");
> -	unsigned int wait_time;
>  	int rc;
>  
>  	if (token == RTAS_UNKNOWN_SERVICE)
>  		return -ENOENT;
>  
> -	while (1) {
> +	do {
>  		rc = rtas_call(token, 2, 2, state, sensor, index);
> -		if (rc == RTAS_BUSY)
> -			udelay(1);
> -		else if (rtas_is_extended_busy(rc)) {
> -			wait_time = rtas_extended_busy_delay_time(rc);
> -			udelay(wait_time * 1000);
> -		} else
> -			break;
> -	}
> +	} while (rtas_busy_delay(rc));
>  
>  	if (rc < 0)
>  		return rtas_error_rc(rc);
> @@ -488,23 +484,14 @@ int rtas_get_sensor(int sensor, int inde
>  int rtas_set_indicator(int indicator, int index, int new_value)
>  {
>  	int token = rtas_token("set-indicator");
> -	unsigned int wait_time;
>  	int rc;
>  
>  	if (token == RTAS_UNKNOWN_SERVICE)
>  		return -ENOENT;
>  
> -	while (1) {
> +	do {
>  		rc = rtas_call(token, 3, 1, NULL, indicator, index, new_value);
> -		if (rc == RTAS_BUSY)
> -			udelay(1);
> -		else if (rtas_is_extended_busy(rc)) {
> -			wait_time = rtas_extended_busy_delay_time(rc);
> -			udelay(wait_time * 1000);
> -		}
> -		else
> -			break;
> -	}
> +	} while (rtas_busy_delay(rc));
>  
>  	if (rc < 0)
>  		return rtas_error_rc(rc);
> @@ -555,13 +542,11 @@ void rtas_os_term(char *str)
>  	do {
>  		status = rtas_call(rtas_token("ibm,os-term"), 1, 1, NULL,
>  				   __pa(rtas_os_term_buf));
> +	} while (rtas_busy_delay(status));
>  
> -		if (status == RTAS_BUSY)
> -			udelay(1);
> -		else if (status != 0)
> -			printk(KERN_EMERG "ibm,os-term call failed %d\n",
> +	if (status != 0)
> +		printk(KERN_EMERG "ibm,os-term call failed %d\n",
>  			       status);
> -	} while (status == RTAS_BUSY);
>  }
>  
>  static int ibm_suspend_me_token = RTAS_UNKNOWN_SERVICE;
> @@ -789,7 +774,7 @@ EXPORT_SYMBOL(rtas_token);
>  EXPORT_SYMBOL(rtas_call);
>  EXPORT_SYMBOL(rtas_data_buf);
>  EXPORT_SYMBOL(rtas_data_buf_lock);
> -EXPORT_SYMBOL(rtas_extended_busy_delay_time);
> +EXPORT_SYMBOL(rtas_busy_delay_time);
>  EXPORT_SYMBOL(rtas_get_sensor);
>  EXPORT_SYMBOL(rtas_get_power_level);
>  EXPORT_SYMBOL(rtas_set_power_level);
> diff -puN arch/powerpc/kernel/rtas-rtc.c~rtas_delay_reorg arch/powerpc/kernel/rtas-rtc.c
> --- 2_6_linus/arch/powerpc/kernel/rtas-rtc.c~rtas_delay_reorg	2006-06-02 15:09:43.000000000 -0500
> +++ 2_6_linus-johnrose/arch/powerpc/kernel/rtas-rtc.c	2006-06-02 15:09:43.000000000 -0500
> @@ -14,19 +14,20 @@
>  unsigned long __init rtas_get_boot_time(void)
>  {
>  	int ret[8];
> -	int error, wait_time;
> +	int error;
> +	unsigned int wait_time;
>  	u64 max_wait_tb;
>  
>  	max_wait_tb = get_tb() + tb_ticks_per_usec * 1000 * MAX_RTC_WAIT;
>  	do {
>  		error = rtas_call(rtas_token("get-time-of-day"), 0, 8, ret);
> -		if (error == RTAS_CLOCK_BUSY || rtas_is_extended_busy(error)) {
> -			wait_time = rtas_extended_busy_delay_time(error);
> +
> +		wait_time = rtas_busy_delay_time(error);
> +		if (wait_time) {
>  			/* This is boot time so we spin. */
>  			udelay(wait_time*1000);
> -			error = RTAS_CLOCK_BUSY;
>  		}
> -	} while (error == RTAS_CLOCK_BUSY && (get_tb() < max_wait_tb));
> +	} while (wait_time && (get_tb() < max_wait_tb));
>  
>  	if (error != 0 && printk_ratelimit()) {
>  		printk(KERN_WARNING "error: reading the clock failed (%d)\n",
> @@ -44,24 +45,25 @@ unsigned long __init rtas_get_boot_time(
>  void rtas_get_rtc_time(struct rtc_time *rtc_tm)
>  {
>          int ret[8];
> -	int error, wait_time;
> +	int error;
> +	unsigned int wait_time;
>  	u64 max_wait_tb;
>  
>  	max_wait_tb = get_tb() + tb_ticks_per_usec * 1000 * MAX_RTC_WAIT;
>  	do {
>  		error = rtas_call(rtas_token("get-time-of-day"), 0, 8, ret);
> -		if (error == RTAS_CLOCK_BUSY || rtas_is_extended_busy(error)) {
> +
> +		wait_time = rtas_busy_delay_time(error);
> +		if (wait_time) {
>  			if (in_interrupt() && printk_ratelimit()) {











>  				memset(rtc_tm, 0, sizeof(struct rtc_time));
>  				printk(KERN_WARNING "error: reading clock"
>  				       " would delay interrupt\n");
>  				return;	/* delay not allowed */
>  			}
> -			wait_time = rtas_extended_busy_delay_time(error);
>  			msleep(wait_time);
> -			error = RTAS_CLOCK_BUSY;
>  		}
> -	} while (error == RTAS_CLOCK_BUSY && (get_tb() < max_wait_tb));
> +	} while (wait_time && (get_tb() < max_wait_tb));
>  
>          if (error != 0 && printk_ratelimit()) {
>                  printk(KERN_WARNING "error: reading the clock failed (%d)\n",
> @@ -88,14 +90,14 @@ int rtas_set_rtc_time(struct rtc_time *t
>  				  tm->tm_year + 1900, tm->tm_mon + 1,
>  				  tm->tm_mday, tm->tm_hour, tm->tm_min,
>  				  tm->tm_sec, 0);
> -		if (error == RTAS_CLOCK_BUSY || rtas_is_extended_busy(error)) {
> +
> +		wait_time = rtas_busy_delay_time(error);
> +		if (wait_time) {
>  			if (in_interrupt())
>  				return 1;	/* probably decrementer */
> -			wait_time = rtas_extended_busy_delay_time(error);
>  			msleep(wait_time);
> -			error = RTAS_CLOCK_BUSY;
>  		}
> -	} while (error == RTAS_CLOCK_BUSY && (get_tb() < max_wait_tb));
> +	} while (wait_time && (get_tb() < max_wait_tb));
>  
>          if (error != 0 && printk_ratelimit())
>                  printk(KERN_WARNING "error: setting the clock failed (%d)\n",
> diff -puN include/asm-powerpc/rtas.h~rtas_delay_reorg include/asm-powerpc/rtas.h
> --- 2_6_linus/include/asm-powerpc/rtas.h~rtas_delay_reorg	2006-06-02 15:09:43.000000000 -0500
> +++ 2_6_linus-johnrose/include/asm-powerpc/rtas.h	2006-06-02 15:09:43.000000000 -0500
> @@ -177,12 +177,8 @@ extern unsigned long rtas_get_boot_time(
>  extern void rtas_get_rtc_time(struct rtc_time *rtc_time);
>  extern int rtas_set_rtc_time(struct rtc_time *rtc_time);
>  
> -/* Given an RTAS status code of 9900..9905 compute the hinted delay */
> -unsigned int rtas_extended_busy_delay_time(int status);
> -static inline int rtas_is_extended_busy(int status)
> -{
> -	return status >= 9900 && status <= 9909;
> -}
> +extern unsigned int rtas_busy_delay_time(int status);
> +extern unsigned int rtas_busy_delay(int status);
>  
>  extern void pSeries_log_error(char *buf, unsigned int err_type, int fatal);
>  
> diff -puN arch/powerpc/kernel/rtas_flash.c~rtas_delay_reorg arch/powerpc/kernel/rtas_flash.c
> --- 2_6_linus/arch/powerpc/kernel/rtas_flash.c~rtas_delay_reorg	2006-06-02 15:09:43.000000000 -0500
> +++ 2_6_linus-johnrose/arch/powerpc/kernel/rtas_flash.c	2006-06-05 15:00:44.000000000 -0500
> @@ -365,20 +365,12 @@ static int rtas_excl_release(struct inod
>  
>  static void manage_flash(struct rtas_manage_flash_t *args_buf)
>  {
> -	unsigned int wait_time;
>  	s32 rc;
>  
> -	while (1) {
> +	do {
>  		rc = rtas_call(rtas_token("ibm,manage-flash-image"), 1, 
>  			       1, NULL, args_buf->op);
> -		if (rc == RTAS_RC_BUSY)
> -			udelay(1);
> -		else if (rtas_is_extended_busy(rc)) {
> -			wait_time = rtas_extended_busy_delay_time(rc);
> -			udelay(wait_time * 1000);
> -		} else
> -			break;
> -	}
> +	} while (rtas_busy_delay(rc));
>  
>  	args_buf->status = rc;
>  }
> @@ -451,27 +443,18 @@ static ssize_t manage_flash_write(struct
>  static void validate_flash(struct rtas_validate_flash_t *args_buf)
>  {
>  	int token = rtas_token("ibm,validate-flash-image");
> -	unsigned int wait_time;
>  	int update_results;
>  	s32 rc;	
>  
>  	rc = 0;
> -	while(1) {
> +	do {
>  		spin_lock(&rtas_data_buf_lock);
>  		memcpy(rtas_data_buf, args_buf->buf, VALIDATE_BUF_SIZE);
>  		rc = rtas_call(token, 2, 2, &update_results, 
>  			       (u32) __pa(rtas_data_buf), args_buf->buf_size);
>  		memcpy(args_buf->buf, rtas_data_buf, VALIDATE_BUF_SIZE);
>  		spin_unlock(&rtas_data_buf_lock);
> -			
> -		if (rc == RTAS_RC_BUSY)
> -			udelay(1);
> -		else if (rtas_is_extended_busy(rc)) {
> -			wait_time = rtas_extended_busy_delay_time(rc);
> -			udelay(wait_time * 1000);
> -		} else
> -			break;
> -	}
> +	} while (rtas_busy_delay(rc));
>  
>  	args_buf->status = rc;
>  	args_buf->update_results = update_results;
> 
> _
> 
> 
