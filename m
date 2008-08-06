Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 6FA7FDDF40
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 12:03:14 +1000 (EST)
Received: from [192.168.1.37] (node164.74.251.72.1dial.com [72.251.74.164])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id m7622mAg081331
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 19:03:07 -0700 (PDT)
Message-ID: <4899059A.3020703@hypersurf.com>
Date: Tue, 05 Aug 2008 18:59:54 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: to schedule() or not to schedule() ?
References: <4895F9EB.8050508@hypersurf.com>
	<48989DFE.7080506@nortel.com>	<4898A96B.40502@hypersurf.com>
	<1217977256.7593.2.camel@localhost>
In-Reply-To: <1217977256.7593.2.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Tue, 2008-08-05 at 12:26 -0700, Kevin Diggs wrote:
> 
>>Chris Friesen wrote:
>>
>>>Kevin Diggs wrote:
> 
> 
>>>>    I have the following near the top of my cpufreq driver target 
>>>>routine:
>>>>
>>>>while(test_and_set_bit(cf750gxmCfgChangeBit,&cf750gxvStateBits)) {
>>>>        /*
>>>>         * Someone mucking with our cfg? (I hope it is ok to call
>>>>         * schedule() here! - truth is I have no idea what I am doing
>>>>         * ... my reasoning is I want to yeild the cpu so whoever is
>>>>         * mucking around can finish)
>>>>         */
>>>>        schedule();
>>>>}
>>>>
>>>>This is to prevent bad things from happening if someone is trying to 
>>>>change a parameter for the driver via sysfs while the target routine 
>>>>is running. Fortunately, because I had a bug where this bit was not 
>>>>getting cleared on one of the paths through the target routine ... I 
>>>>now know it is not safe to call schedule (it got stuck in there - 
>>>>knocked out my adb keyboard! - (I think target is called from a timer 
>>>>that the governor sets up ... interrupt context?)).
>>>
>>>
>>>Is the issue that someone may be in the middle of a multi-stage 
>>>procedure, and you've woken up partway through?
>>>
>>>If so, what about simply rescheduling the timer for some short time in 
>>>the future and aborting the current call?
> 
> 
>>Chris,
>>
>>	Thanks for taking the time to reply. The parameter in question modifies 
>>the frequency table. It is used several times in the target routine. 
>>I've addressed the issue by making a local copy of the frequency table 
>>upon entry to the target routine and use that while there. I don't care 
>>who wins the race.
> 
> 
> How are you copying the table? Is it an atomic copy? Otherwise you could
> just end up copying the table while it's being updated, and you get a
> copy of the partially updated table.
> 
> Don't you just need a spinlock?
> 
> cheers
> 
In the initialization routine I create 2 tables. One is a table with all 
the frequencies. The other has just the min and max. The parameter just 
changes a pointer to point to one table or the other. The above 
addressing of the issue should really say "a local copy of the pointer 
to the frequency table".

Thanks for the reply!

For the purpose of learning, there is no direct, correct way to yield 
the cpu when in a timer fired routine, right?

kevin
