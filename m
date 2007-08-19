Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: balbir@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] Add scaled time to taskstats based process accounting
In-reply-to: <46C805B0.1000300@linux.vnet.ibm.com> 
References: <20070816070922.37B5370074@localhost.localdomain>
	<46C3FC41.4000609@linux.vnet.ibm.com>
	<19998.1187312981@neuling.org>
	<20070817115951.e1368a7d.akpm@linux-foundation.org>
	<46C805B0.1000300@linux.vnet.ibm.com>
Date: Sun, 19 Aug 2007 23:12:07 +1000
Message-ID: <18727.1187529127@neuling.org>
Cc: Benjamin@ozlabs.org, Jay Lan <jlan@engr.sgi.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



In message <46C805B0.1000300@linux.vnet.ibm.com> you wrote:
> Andrew Morton wrote:
> >>  
> >>  	unsigned int rt_priority;
> >> -	cputime_t utime, stime;
> >> +	cputime_t utime, stime, utimescaled, stimescaled;
> > 
> > Adding 8 or 16 bytes to the task_struct for all architectures for something
> > which only powerpc uses?
> > 
> > Is there any prospect that other CPUs can use this?
> > 
> 
> Hi, Andrew,
> 
> There is definitely the prospect for other architectures to use this
> feature
> 
> x86 provides the APERF and MPERF model specific registers.
> The ratio of APERF to MPERF gives the current scaled load on the
> system (acpi-cpufreq, get_measured_perf()) I have been looking at
> exploiting this functionality for x-series, but ran into a problem;
> as per the specification, APERF and MPERF are to be reset to 0
> upon reading them. As a result, I am still figuring out a good
> way to share the data amongst the ondemand governor and utimescaled
> statistics.
> 
> I think for now, we can
> 
> 1. Put utimescaled and stimescaled under an #ifdef for ARCH_POWERPC

... or even #ifdef TASKSTATS

> 2. Add utimescaled and stimescaled and add a big fat comment stating
>    that work for other architectures is on it's way.
> 
> In either case, I think the functionality is useful and can be
> exploited by other architectures. The powerpc port is complete and
> I think the implementation would provide a good reference for
> other implementations to follow.
> 
> -- 
> 	Warm Regards,
> 	Balbir Singh
> 	Linux Technology Center
> 	IBM, ISTL
> 
