Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: balbir@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] Add scaled time to taskstats based process accounting
In-reply-to: <46C52872.9060408@linux.vnet.ibm.com> 
References: <20070816070922.37B5370074@localhost.localdomain>
	<46C3FC41.4000609@linux.vnet.ibm.com>
	<13529.1187310208@neuling.org>
	<46C52872.9060408@linux.vnet.ibm.com>
Date: Fri, 17 Aug 2007 14:56:44 +1000
Message-ID: <13853.1187326604@neuling.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <46C52872.9060408@linux.vnet.ibm.com> you wrote:
> Michael Neuling wrote:
> >> I'd also request for you to add a cpu_scaled_run_real_total for use
> >> by delay accounting. cpu_scaled_run_real_total should be similar in
> >> functionality to cpu_run_real_total.
> > 
> > Will do.  Should I add cpu_scaled_run_real_total to the end of the
> > struct taskstat, or next to cpu_run_real_total?
> > 
> 
> Please add it to the end, that helps maintain binary compatibility
> across all versions of taskstats.

OK

> 
> >>>  	/* Note: this timer irq context must be accounted for as well. */
> >>> -	if (user_tick)
> >>> +	if (user_tick) {
> >>>  		account_user_time(p, jiffies_to_cputime(1));
> >>> -	else
> >>> +		account_user_time_scaled(p, jiffies_to_cputime(1));
> >>> +	} else {
> >>>  		account_system_time(p, HARDIRQ_OFFSET, jiffies_to_cputime(1));
> >>> +		account_system_time_scaled(p, jiffies_to_cputime(1));
> >>> +	}
> >> I am a little confused here, scaled accounting and regular accounting
> >> go hand in hand?
> > 
> > We need to account for scaled and normal time in this generic code.
> > All other calls to account_(user|system)_time are in arch code.  
> > 
> 
> So the assumption here is that we ran at full frequency during
> this time, is my understanding correct?

Yes.  

I guess we could keep a per CPU last scaling factor for this case
(similar to what we are storing in the POWERPC paca)

Mikey
