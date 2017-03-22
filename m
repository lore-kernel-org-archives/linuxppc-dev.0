Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vp66b3CxmzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 21:55:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: svaidy@linux.vnet.ibm.com
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv/cpuidle: Pass correct drv->cpumask for
 registration
In-Reply-To: <20170320043112.GA4123@drishya.in.ibm.com>
References: <20170317180550.9931-1-svaidy@linux.vnet.ibm.com>
 <1489814882.5616.11.camel@neuling.org>
 <20170318064425.GC4225@drishya.in.ibm.com>
 <87k27kzlz0.fsf@concordia.ellerman.id.au>
 <20170320043112.GA4123@drishya.in.ibm.com>
Date: Wed, 22 Mar 2017 21:55:50 +1100
Message-ID: <87lgrxd1hl.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> writes:
> * Michael Ellerman <mpe@ellerman.id.au> [2017-03-20 14:05:39]:
>> Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> writes:
>  
>> > On powernv platform cpu_present could be less than cpu_possible
>> > in cases where firmware detects the cpu, but it is not available
>> > for OS.
>> 
>> It's entirely normal for present < possible, on my laptop for example,
>> so I don't see how that causes the bug.
>
> Yes, present < possible in itself not a problem.  It is whether
> cpu_device exist for that cpu or not.
...
>
> Currently if CONFIG_HOTPLUG_CPU=n, then we skip calling register_cpu()
> and that causes the problem.
...
>> 
>> I really don't understand how a CPU not being present leads to a crash
>> in printf()? Something in that call chain should have checked that the
>> CPU was registered before crashing in printf() - surely?
>
> Yes, we should have just failed to register the cpuidle driver.  I have
> the fix here:
>
> [PATCH] cpuidle: Validate cpu_dev in cpuidle_add_sysfs
> http://patchwork.ozlabs.org/patch/740634/

OK. Can you send a v2 of this with a better change log that includes all
the clarifications above.

And despite your subject being powerpc/powernv/cpuidle, this is a
cpuidle patch. I can merge it, but I at least need you to Cc the cpuidle
maintainers so they have a chance to see it.

cheers
