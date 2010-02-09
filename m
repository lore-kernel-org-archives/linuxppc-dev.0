Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D9718B7CE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Feb 2010 11:55:26 +1100 (EST)
Subject: Re: [PATCH 2/4] Fix G5 thermal shutdown
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@gmail.com>
In-Reply-To: <20100205135216.GH12001@hansolo.jdub.homelinux.org>
References: <20100205133552.GF12001@hansolo.jdub.homelinux.org>
	<20100205135216.GH12001@hansolo.jdub.homelinux.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 09 Feb 2010 11:55:05 +1100
Message-ID: <1265676905.8287.254.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-02-05 at 08:52 -0500, Josh Boyer wrote:
> This changes the thresholds for the liquid cooled G5 thermal
> shutdown mechanism to prevent an errant shutdown.
> 
> This has been carried since about Fedora Core 5.  I have no idea
> if it's really needed or not.

Can we have a SoB ?

Cheers,
Ben.

> ---
> 
> --- linux-2.6.15/drivers/macintosh/therm_pm72.c.orig	2006-04-02 21:34:48.000000000 +0100
> +++ linux-2.6.15/drivers/macintosh/therm_pm72.c	2006-04-02 22:33:27.000000000 +0100
> @@ -924,10 +925,16 @@ static void do_monitor_cpu_combined(void
>  		printk(KERN_WARNING "Warning ! Temperature way above maximum (%d) !\n",
>  		       temp_combi >> 16);
>  		state0->overtemp += CPU_MAX_OVERTEMP / 4;
> -	} else if (temp_combi > (state0->mpu.tmax << 16))
> +	} else if (temp_combi > (state0->mpu.tmax << 16)) {
>  		state0->overtemp++;
> -	else
> +		printk(KERN_WARNING "Temperature %d above max %d. overtemp %d\n",
> +		       temp_combi >> 16, state0->mpu.tmax, state0->overtemp);
> +	} else {
> +		if (state0->overtemp)
> +			printk(KERN_WARNING "Temperature back down to %d\n",
> +			       temp_combi >> 16);
>  		state0->overtemp = 0;
> +	}
>  	if (state0->overtemp >= CPU_MAX_OVERTEMP)
>  		critical_state = 1;
>  	if (state0->overtemp > 0) {
> @@ -999,10 +1015,16 @@ static void do_monitor_cpu_split(struct 
>  		       " (%d) !\n",
>  		       state->index, temp >> 16);
>  		state->overtemp += CPU_MAX_OVERTEMP / 4;
> -	} else if (temp > (state->mpu.tmax << 16))
> +	} else if (temp > (state->mpu.tmax << 16)) {
>  		state->overtemp++;
> -	else
> +		printk(KERN_WARNING "CPU %d temperature %d above max %d. overtemp %d\n",
> +		       state->index, temp >> 16, state->mpu.tmax, state->overtemp);
> +	} else {
> +		if (state->overtemp)
> +			printk(KERN_WARNING "CPU %d temperature back down to %d\n",
> +			       state->index, temp >> 16);
>  		state->overtemp = 0;
> +	}
>  	if (state->overtemp >= CPU_MAX_OVERTEMP)
>  		critical_state = 1;
>  	if (state->overtemp > 0) {
> @@ -1061,10 +1097,16 @@ static void do_monitor_cpu_rack(struct c
>  		       " (%d) !\n",
>  		       state->index, temp >> 16);
>  		state->overtemp = CPU_MAX_OVERTEMP / 4;
> -	} else if (temp > (state->mpu.tmax << 16))
> +	} else if (temp > (state->mpu.tmax << 16)) {
>  		state->overtemp++;
> -	else
> +		printk(KERN_WARNING "CPU %d temperature %d above max %d. overtemp %d\n",
> +		       state->index, temp >> 16, state->mpu.tmax, state->overtemp);
> +	} else {
> +		if (state->overtemp)
> +			printk(KERN_WARNING "CPU %d temperature back down to %d\n",
> +			       state->index, temp >> 16);
>  		state->overtemp = 0;
> +	}
>  	if (state->overtemp >= CPU_MAX_OVERTEMP)
>  		critical_state = 1;
>  	if (state->overtemp > 0) {
> --- linux-2.6.15/drivers/macintosh/therm_pm72.h~	2006-01-03 03:21:10.000000000 +0000
> +++ linux-2.6.15/drivers/macintosh/therm_pm72.h	2006-04-02 22:25:58.000000000 +0100
> @@ -243,7 +243,7 @@ struct dimm_pid_state
>  #define CPU_TEMP_HISTORY_SIZE		2
>  #define CPU_POWER_HISTORY_SIZE		10
>  #define CPU_PID_INTERVAL		1
> -#define CPU_MAX_OVERTEMP		30
> +#define CPU_MAX_OVERTEMP		90
>  
>  #define CPUA_PUMP_RPM_INDEX		7
>  #define CPUB_PUMP_RPM_INDEX		8
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
