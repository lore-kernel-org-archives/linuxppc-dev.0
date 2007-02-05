Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3A8F3DDE04
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 12:40:08 +1100 (EST)
Subject: Re: CPU hotplug vs. cpufreq on ppc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1170360890.4036.19.camel@johannes.berg>
References: <1170360890.4036.19.camel@johannes.berg>
Content-Type: text/plain
Date: Mon, 05 Feb 2007 12:39:16 +1100
Message-Id: <1170639556.2620.75.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	cpufreq <cpufreq@lists.linux.org.uk>,
	Ashok Raj <ashok.raj@intel.com>, davej@codemonkey.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


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

So you mean that the policy->cpus mask is lost on unplug/replug ? Hrm...
I'm not sure what's the best way to restore it. Do we have a cpufreq
backend callback on hotplug to restore things ?

Ben.
