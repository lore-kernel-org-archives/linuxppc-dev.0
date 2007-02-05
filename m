Return-Path: <jacob.shin@amd.com>
Received: from outbound2-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 22A6FDDE36
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 04:13:58 +1100 (EST)
Message-ID: <45C765C3.3090004@amd.com>
Date: Mon, 05 Feb 2007 11:13:39 -0600
From: "Jacob Shin" <jacob.shin@amd.com>
MIME-Version: 1.0
To: "Johannes Berg" <johannes@sipsolutions.net>
Subject: Re: CPU hotplug vs. cpufreq on ppc64
References: <1170360890.4036.19.camel@johannes.berg>
In-Reply-To: <1170360890.4036.19.camel@johannes.berg>
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Cc: davej@codemonkey.org.uk, Ashok Raj <ashok.raj@intel.com>,
	cpufreq <cpufreq@lists.linux.org.uk>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, mark.langsdorf@amd.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg wrote:
> I'm having an odd problem with ppc64 cpufreq and cpu hotplug. The cpu
> hotplug I'm doing is just fake, but I need to unplug the CPUs for
> suspend.
> 
> When the system boots up, all CPUs are added as such:
> [   18.132830] cpufreq-core: trying to register driver powermac
> [   18.132835] cpufreq-core: adding CPU 0
> [   18.132976] cpufreq-core: CPU 1 already managed, adding link
> [   18.132983] cpufreq-core: CPU 2 already managed, adding link
> [   18.132989] cpufreq-core: CPU 3 already managed, adding link
> [   18.132998] cpufreq-core: setting new policy for CPU 0: 1250000 - 2500000 kHz
> [   18.133025] cpufreq-core: new min and max freqs are 1250000 - 2500000 kHz
> [   18.133029] cpufreq-core: governor switch
> [   18.133033] cpufreq-core: __cpufreq_governor for CPU 0, event 1
> [   18.133043] cpufreq-core: target for CPU 0: 2500000 kHz, relation 1
> [   18.133056] cpufreq-core: governor: change or update limits
> [   18.133060] cpufreq-core: __cpufreq_governor for CPU 0, event 3
> [   18.133069] cpufreq-core: target for CPU 0: 2500000 kHz, relation 1
> [   18.133082] cpufreq-core: initialization complete
> [   18.133086] cpufreq-core: adding CPU 1
> [   18.133089] cpufreq-core: adding CPU 2
> [   18.133092] cpufreq-core: adding CPU 3
> [   18.133097] cpufreq-core: driver powermac up and running
> 
> This says that the 4 CPUs can actually only be switched all together
> with CPU0. This is achieved by doing
> 
>         policy->cpus = cpu_possible_map;
> in
> g5_cpufreq_cpu_init (arch/powerpc/platforms/powermac/cpufreq_64.c)
> 
> 
> When I suspend now, I get
> [  167.563428] cpufreq-core: unregistering CPU 1
> [  167.563440] cpufreq-core: removing link
> [  167.569139] cpufreq-core: target for CPU 0: 1250000 kHz, relation 1
> [  167.573690] cpufreq-core: unregistering CPU 2
> [  167.573704] cpufreq-core: removing link
> [  167.576175] cpufreq-core: target for CPU 0: 1250000 kHz, relation 1
> [  167.582261] cpufreq-core: unregistering CPU 3
> [  167.582270] cpufreq-core: removing link
> [  168.415156] cpufreq-core: suspending cpu 0
> [  168.415164] cpufreq-core: suspending cpu 1
> [  168.415170] cpufreq-core: suspending cpu 2
> [  168.415177] cpufreq-core: suspending cpu 3
> 
> which seems fine. However, when I resume, I get
> [  168.446692] cpufreq-core: resuming cpu 0
> [  168.446708] cpufreq-core: resuming cpu 1
> [  168.446715] cpufreq-core: resuming cpu 2
> [  168.446721] cpufreq-core: resuming cpu 3
> [  168.624880] cpufreq-core: handle_update for cpu 0 called
> [  168.624893] cpufreq-core: updating policy for CPU 0
> [  168.624905] cpufreq-core: setting new policy for CPU 0: 1250000 - 2500000 kHz
> [  168.624965] cpufreq-core: new min and max freqs are 1250000 - 2500000 kHz
> [  168.624974] cpufreq-core: governor: change or update limits
> [  168.624982] cpufreq-core: __cpufreq_governor for CPU 0, event 3
> [  168.625009] cpufreq-core: target for CPU 0: 1250000 kHz, relation 0
> [  169.232726] cpufreq-core: adding CPU 1
> [  169.232741] cpufreq-core: initialization failed
> [  169.239623] cpufreq-core: adding CPU 2
> [  169.239636] cpufreq-core: initialization failed
> [  169.247240] cpufreq-core: adding CPU 3
> [  169.247255] cpufreq-core: initialization failed
> 
> The question now is where this needs to be handled, and how. The driver
> can't really say that it initialised fine because it's still initialised
> on CPU0. However, I suppose that for real CPU hotplug cpufreq can't try
> to remember the pre-unplug groups either...

Hi,

Consider the scenario where,

CPU0 comes online first, and no other CPUs are online yet.  CPU0 cannot 
advertise to cpufreq what his affected CPUs are because CPU1, CPU2, and 
CPU3 do not exist!  At this point in time, the kernel is only aware of 
CPU0, which is the only CPU that cpufreq manages for the moment.

Now, say CPU1 comes online.  CPU1 now knows that itself and CPU0 are 
tied together in freq scaling.  However, CPU0 is still left in the dark, 
and thinks that he only manages himself.  So CPU1 will register itself, 
and tell cpufreq that its affected cpus are itself and CPU0.  The 
cpufreq driver will see that CPU0 is already managed, update CPU0's 
affected cpus data structure, symlink CPU1 to CPU0, and finally call 
exit on CPU1 to clean up.

Same story for CPU2 and CPU3.

You can easily simulate this scenario using the maxcpus=1 kernel 
parameter, and bring other CPUs online one by one.

Hope this helps,

Jacob Shin
AMD, Inc.
