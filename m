Return-Path: <balbir@linux.vnet.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BB9D5DDE2C
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 14:47:59 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l7H4pOSL336396
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 14:51:26 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7H4pN8E107516
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 14:51:24 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7H4lnvK029817
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 14:47:50 +1000
Message-ID: <46C52872.9060408@linux.vnet.ibm.com>
Date: Fri, 17 Aug 2007 10:17:46 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 1/2] Add scaled time to taskstats based process accounting
References: <20070816070922.37B5370074@localhost.localdomain>
	<46C3FC41.4000609@linux.vnet.ibm.com>
	<13529.1187310208@neuling.org>
In-Reply-To: <13529.1187310208@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Neuling wrote:
>> I'd also request for you to add a cpu_scaled_run_real_total for use
>> by delay accounting. cpu_scaled_run_real_total should be similar in
>> functionality to cpu_run_real_total.
> 
> Will do.  Should I add cpu_scaled_run_real_total to the end of the
> struct taskstat, or next to cpu_run_real_total?
> 

Please add it to the end, that helps maintain binary compatibility
across all versions of taskstats.

>>>  	/* Note: this timer irq context must be accounted for as well. */
>>> -	if (user_tick)
>>> +	if (user_tick) {
>>>  		account_user_time(p, jiffies_to_cputime(1));
>>> -	else
>>> +		account_user_time_scaled(p, jiffies_to_cputime(1));
>>> +	} else {
>>>  		account_system_time(p, HARDIRQ_OFFSET, jiffies_to_cputime(1));
>>> +		account_system_time_scaled(p, jiffies_to_cputime(1));
>>> +	}
>> I am a little confused here, scaled accounting and regular accounting
>> go hand in hand?
> 
> We need to account for scaled and normal time in this generic code.
> All other calls to account_(user|system)_time are in arch code.  
> 

So the assumption here is that we ran at full frequency during
this time, is my understanding correct?

-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
