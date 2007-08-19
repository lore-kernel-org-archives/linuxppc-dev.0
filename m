Return-Path: <balbir@linux.vnet.ibm.com>
Received: from ausmtp06.au.ibm.com (ausmtp06.au.ibm.com [202.81.18.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 45EEFDDE23
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Aug 2007 18:56:26 +1000 (EST)
Message-ID: <46C805B0.1000300@linux.vnet.ibm.com>
Date: Sun, 19 Aug 2007 14:26:16 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] Add scaled time to taskstats based process accounting
References: <20070816070922.37B5370074@localhost.localdomain>
	<46C3FC41.4000609@linux.vnet.ibm.com>
	<19998.1187312981@neuling.org>
	<20070817115951.e1368a7d.akpm@linux-foundation.org>
In-Reply-To: <20070817115951.e1368a7d.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Neuling <mikey@neuling.org>, Benjamin@ozlabs.org,
	Jay Lan <jlan@engr.sgi.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton wrote:
>>  
>>  	unsigned int rt_priority;
>> -	cputime_t utime, stime;
>> +	cputime_t utime, stime, utimescaled, stimescaled;
> 
> Adding 8 or 16 bytes to the task_struct for all architectures for something
> which only powerpc uses?
> 
> Is there any prospect that other CPUs can use this?
> 

Hi, Andrew,

There is definitely the prospect for other architectures to use this
feature

x86 provides the APERF and MPERF model specific registers.
The ratio of APERF to MPERF gives the current scaled load on the
system (acpi-cpufreq, get_measured_perf()) I have been looking at
exploiting this functionality for x-series, but ran into a problem;
as per the specification, APERF and MPERF are to be reset to 0
upon reading them. As a result, I am still figuring out a good
way to share the data amongst the ondemand governor and utimescaled
statistics.

I think for now, we can

1. Put utimescaled and stimescaled under an #ifdef for ARCH_POWERPC
2. Add utimescaled and stimescaled and add a big fat comment stating
   that work for other architectures is on it's way.

In either case, I think the functionality is useful and can be
exploited by other architectures. The powerpc port is complete and
I think the implementation would provide a good reference for
other implementations to follow.

-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
