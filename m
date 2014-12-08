Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7298E1A010C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 16:29:50 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Sun, 7 Dec 2014 22:29:47 -0700
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 8941938C804F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 00:29:43 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB85Thkp28639462
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Dec 2014 05:29:43 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB85TgMg015122
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Dec 2014 00:29:43 -0500
Message-ID: <5485373B.302@linux.vnet.ibm.com>
Date: Mon, 08 Dec 2014 10:59:31 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] tick-broadcast: Register for hrtimer based broadcast
 as the default broadcast mode
References: <20141205124756.25803.4988.stgit@preeti.in.ibm.com>
 <20141205133908.GA21313@leverpostej>
In-Reply-To: <20141205133908.GA21313@leverpostej>
Content-Type: text/plain; charset=UTF-8
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "fweisbec@gmail.com" <fweisbec@gmail.com>,
 "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
 Will Deacon <Will.Deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jingchang.lu@freescale.com" <jingchang.lu@freescale.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/05/2014 07:09 PM, Mark Rutland wrote:
> Hi Preeti,
> 
> Moving this out of the architecture code looks good to me!
> 
> I have a couple of minor comments below.
<snip>

>>  
>> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
>> index ec1791f..6044a51 100644
>> --- a/kernel/time/timekeeping.c
>> +++ b/kernel/time/timekeeping.c
>> @@ -1016,6 +1016,10 @@ void __init timekeeping_init(void)
>>  		boot.tv_sec = 0;
>>  		boot.tv_nsec = 0;
>>  	}
>> +	/* Register for hrtimer based broadcast as the default timekeeping
>> +	 * mode in deep idle states.
>> +	 */
> 
> Nit: for code style this should have a newline after the '/*' (and we
> should probably have a newline before that anyway.
> 
>> +	tick_setup_hrtimer_broadcast();
> 
> We register the generic dummy timer via an early_initcall, which keeps
> all the logic in the dummy timer driver. Are we able to do the same of
> the broadcast hrtimer? Or is there some ordering constraint we need to
> meet?

Yes this is doable. There are no ordering constraints. Placing it in an
early_initcall() will enable it to run before initializing SMP and
cpuidle, which is perfect (we do not have any per-cpu initializations
and we do not want cpus to begin entering idle states before this
hrtimer is initialized).

It also runs after the hrtimer/clockevents infrastructure has been
initialized, which is good since we need them. The broadcast hrtimer
will thus only get registered as a broadcast device if no other clock
device has managed to register itself as one.

Let me send out a V2.

Thanks

Regards
Preeti U Murthy
