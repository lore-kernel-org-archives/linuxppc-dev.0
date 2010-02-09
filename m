Return-Path: <jwboyer@gmail.com>
Received: from mail-iw0-f188.google.com (mail-iw0-f188.google.com
	[209.85.223.188]) by ozlabs.org (Postfix) with ESMTP id D3BF0B7D04
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Feb 2010 13:06:39 +1100 (EST)
Received: by iwn26 with SMTP id 26so6393932iwn.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 08 Feb 2010 18:06:38 -0800 (PST)
Date: Mon, 8 Feb 2010 21:06:29 -0500
From: Josh Boyer <jwboyer@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, dwmw2@infradead.org
Subject: Re: [PATCH 2/4] Fix G5 thermal shutdown
Message-ID: <20100209020629.GB5393@hansolo.jdub.homelinux.org>
References: <20100205133552.GF12001@hansolo.jdub.homelinux.org>
	<20100205135216.GH12001@hansolo.jdub.homelinux.org>
	<1265676905.8287.254.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1265676905.8287.254.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 09, 2010 at 11:55:05AM +1100, Benjamin Herrenschmidt wrote:
>On Fri, 2010-02-05 at 08:52 -0500, Josh Boyer wrote:
>> This changes the thresholds for the liquid cooled G5 thermal
>> shutdown mechanism to prevent an errant shutdown.
>> 
>> This has been carried since about Fedora Core 5.  I have no idea
>> if it's really needed or not.
>
>Can we have a SoB ?

David?

josh

>
>Cheers,
>Ben.
>
>> ---
>> 
>> --- linux-2.6.15/drivers/macintosh/therm_pm72.c.orig	2006-04-02 21:34:48.000000000 +0100
>> +++ linux-2.6.15/drivers/macintosh/therm_pm72.c	2006-04-02 22:33:27.000000000 +0100
>> @@ -924,10 +925,16 @@ static void do_monitor_cpu_combined(void
>>  		printk(KERN_WARNING "Warning ! Temperature way above maximum (%d) !\n",
>>  		       temp_combi >> 16);
>>  		state0->overtemp += CPU_MAX_OVERTEMP / 4;
>> -	} else if (temp_combi > (state0->mpu.tmax << 16))
>> +	} else if (temp_combi > (state0->mpu.tmax << 16)) {
>>  		state0->overtemp++;
>> -	else
>> +		printk(KERN_WARNING "Temperature %d above max %d. overtemp %d\n",
>> +		       temp_combi >> 16, state0->mpu.tmax, state0->overtemp);
>> +	} else {
>> +		if (state0->overtemp)
>> +			printk(KERN_WARNING "Temperature back down to %d\n",
>> +			       temp_combi >> 16);
>>  		state0->overtemp = 0;
>> +	}
>>  	if (state0->overtemp >= CPU_MAX_OVERTEMP)
>>  		critical_state = 1;
>>  	if (state0->overtemp > 0) {
>> @@ -999,10 +1015,16 @@ static void do_monitor_cpu_split(struct 
>>  		       " (%d) !\n",
>>  		       state->index, temp >> 16);
>>  		state->overtemp += CPU_MAX_OVERTEMP / 4;
>> -	} else if (temp > (state->mpu.tmax << 16))
>> +	} else if (temp > (state->mpu.tmax << 16)) {
>>  		state->overtemp++;
>> -	else
>> +		printk(KERN_WARNING "CPU %d temperature %d above max %d. overtemp %d\n",
>> +		       state->index, temp >> 16, state->mpu.tmax, state->overtemp);
>> +	} else {
>> +		if (state->overtemp)
>> +			printk(KERN_WARNING "CPU %d temperature back down to %d\n",
>> +			       state->index, temp >> 16);
>>  		state->overtemp = 0;
>> +	}
>>  	if (state->overtemp >= CPU_MAX_OVERTEMP)
>>  		critical_state = 1;
>>  	if (state->overtemp > 0) {
>> @@ -1061,10 +1097,16 @@ static void do_monitor_cpu_rack(struct c
>>  		       " (%d) !\n",
>>  		       state->index, temp >> 16);
>>  		state->overtemp = CPU_MAX_OVERTEMP / 4;
>> -	} else if (temp > (state->mpu.tmax << 16))
>> +	} else if (temp > (state->mpu.tmax << 16)) {
>>  		state->overtemp++;
>> -	else
>> +		printk(KERN_WARNING "CPU %d temperature %d above max %d. overtemp %d\n",
>> +		       state->index, temp >> 16, state->mpu.tmax, state->overtemp);
>> +	} else {
>> +		if (state->overtemp)
>> +			printk(KERN_WARNING "CPU %d temperature back down to %d\n",
>> +			       state->index, temp >> 16);
>>  		state->overtemp = 0;
>> +	}
>>  	if (state->overtemp >= CPU_MAX_OVERTEMP)
>>  		critical_state = 1;
>>  	if (state->overtemp > 0) {
>> --- linux-2.6.15/drivers/macintosh/therm_pm72.h~	2006-01-03 03:21:10.000000000 +0000
>> +++ linux-2.6.15/drivers/macintosh/therm_pm72.h	2006-04-02 22:25:58.000000000 +0100
>> @@ -243,7 +243,7 @@ struct dimm_pid_state
>>  #define CPU_TEMP_HISTORY_SIZE		2
>>  #define CPU_POWER_HISTORY_SIZE		10
>>  #define CPU_PID_INTERVAL		1
>> -#define CPU_MAX_OVERTEMP		30
>> +#define CPU_MAX_OVERTEMP		90
>>  
>>  #define CPUA_PUMP_RPM_INDEX		7
>>  #define CPUB_PUMP_RPM_INDEX		8
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>
