Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 9B8DCDDF87
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Apr 2007 04:13:44 +1000 (EST)
Date: Fri, 27 Apr 2007 13:14:10 -0500
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PATCH] powerpc: Show current speed in /proc/cpuinfo
Message-ID: <20070427181410.GC15582@lixom.net>
References: <20070427084118.GA8842@lixom.net> <4631BBB1.9010705@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4631BBB1.9010705@genesi-usa.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 27, 2007 at 10:00:33AM +0100, Matt Sealey wrote:

> Would it not be relevant to keep listing the maximum CPU speed as well
> as the real, current CPU speed?
> 
> Intel encode this into their CPUID string and when I bring up Windows' System
> Properties dialog I get this;
> 
> Intel(R) Pentium(R) M processor 1.70GHz
> 593MHz, 512MB of RAM
> 
> So you can always, always find out very easily what spec your processor
> is, and not just what cpufreq has done with it?

On a system running cpufreq, you might not even have booted
the system at full speed, so the only way to know for sure
what the max speed is, is to look at the one in cpufreq
(/sys/devices/system/cpu/cpu<x>/cpufreq/scaling_max_freq).

For non-cpufreq platforms, the speed reported will be the same as before,
which on most platforms is whatever firmware tells us the speed of the
cpu is.

> > +	/* cpufreq_speed_get() is in kHz */
> > +	freq = cpufreq_quick_get(cpu_id);
> 
> Is it speed or quick? This and the comment below confused me, KHz or Hz? :D

It's quick, I'll fix that. ppc_proc_freq is in Hz, freq in kHz, so you
need to divide.


-Olof
