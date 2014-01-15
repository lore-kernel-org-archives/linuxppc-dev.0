Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 187952C007A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2014 22:02:43 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Wed, 15 Jan 2014 21:02:40 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id F34543578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2014 22:02:38 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0FB2QAY64618592
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2014 22:02:26 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0FB2cph022461
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2014 22:02:38 +1100
Message-ID: <52D66ADD.9080906@linux.vnet.ibm.com>
Date: Wed, 15 Jan 2014 16:32:53 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Steven Pratt <slpratt@austin.ibm.com>
Subject: Re: Disable sleep states on P7+
References: <52D54B60.4090807@austin.ibm.com>
In-Reply-To: <52D54B60.4090807@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Steven,

On 01/14/2014 08:06 PM, Steven Pratt wrote:
> I am looking for info on when and how we are able to disable power saving features of current (P7, P7+) chips in order to reduce latency. This is often done in latency sensitive applications when

 power consumption is not an issue. On Intel boxes we can disable
P-state frequency changes as well as disabling C-State or sleep state
changes. In fact we can control how deep a sleep the processor can go
into.

I know we have control Dynamic Processor Scaling and Idle Power Savings,
but what states do these really affect?  Can I really disable Nap mode
of a processor? If so how?  Can I disable even the lightest winkle mode?

Looking for current information (read RHEL 6 and SLES11), future changes
are interesting.
> 

On POWERVM platforms idle states currently supported are:
Snooze - reducing thread priority.
Nap
Sleep.

Snooze and Nap can be controlled through in-band kernel mechanisms and
Sleep state through AEM.

Currently you can turn off Idle Power Savings mode and run in dynamic
processor scaling mode. By doing so you will disable entry into Sleep
state on all CPUS.

If you further want to disable NAP, then you could just boot the kernel
with powersave=off. This will disable the entry into any of the idle
state like nap and just reduce the priority of the thread when there is
no work to be done. This is part of cpuidle framework which is available
on SLES 11 SP3 and RHEL7.

In the newer kernels cpuidle framework is adopted for POWERVM platform
but in case if you are using RHEL 6 or SLES 11 SP1/2, then you could use
the ppc64_cpu util and set a high smt-snooze-delay value say 1000.first

#> ppc64_cpu --smt-snooze-delay=1000.

smt-snooze-delay variable potentially delays entry to NAP state.
So if the idle time predicted on a cpu = 1000us and smt-snooze-delay is
set to 100 (which is default value), then on RHEL 6 and SLES 11 SP1/2
kernels cpus would reduce the thread priority and spin for  first 100us
and if the cpu continues to be idle further then automatically go to NAP
state for remaining (1000-100us) time.

By setting a very high value, one would always be looping  This could
potentially delay ure entry to NAP state and effectively disable entry
into NAP state most of the time.

Please let me know if you have any queries around it.

Regards,
Deepthi






> Steve
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
