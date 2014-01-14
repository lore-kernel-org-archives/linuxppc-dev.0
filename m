Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9D65E2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2014 03:14:15 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 14 Jan 2014 11:14:11 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id AF703C9004A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 11:14:06 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0EGE8QZ38535212
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 16:14:09 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0EGE8Zw022703
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 11:14:08 -0500
Message-ID: <52D56186.70807@linux.vnet.ibm.com>
Date: Tue, 14 Jan 2014 21:40:46 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
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
> I am looking for info on when and how we are able to disable power saving features of current (P7, P7+) chips in order to reduce latency. This is often done in latency sensitive applications when power consumption is not an issue. On Intel boxes we can disable P-state frequency changes as well as disabling C-State or sleep state changes. In fact we can control how deep a sleep the processor can go into.  I know we have control Dynamic Processor Scaling and Idle Power Savings, but what states do these really affect?  Can I really disable Nap mode of a processor? If so how?  Can I disable even the lightest winkle mode?  Looking for current information (read RHEL 6 and SLES11), future changes are interesting.
> 
> Steve

I can answer this question with respect to cpuidle on PowerNV platforms.

1. In order to disable cpuidle states management altogether, one can
pass the powersave=off kernel cmd line parameter during boot up of the
kernel. This will ensure that each time a CPU has nothing to do, it can
enter low thread priority which could lower power consumption to some
extent but is not expected to hit latency of applications noticeably.

2. In order to exactly control the cpuidle states into which idle CPUs
can enter into during runtime, one can make use of the sysfs files under:
/sys/devices/system/cpu/cpux/cpuidle/statex/disable option to
selectively disable any state.

However if one is using the menu cpuidle governor, disabling an idle
state does not disable the idle states which are deeper than it. They
continue to remain active unless they are specifically disabled. What
this means is that one cannot control the depth of the idle states
available for a CPU, although we can control the exact idle states
available for a processor.

But if the ladder governor is used, one can control the depth of the
idle states that a CPU can enter into. The governor can be chosen by
echoing either menu/ladder to
/sys/devices/system/cpu/cpuidle/current_governor_ro. The cpuidle
governor takes decisions about the idle state for a cpu to enter into
depending on its idle history. The popular governor used by most archs
is the menu governor.

Hence nap/sleep/winkle any of these states can be disabled. The code
which enables the above mentioned functionalities on powernv is yet to
go upstream although the same is already upstream and can be used for
the pseries platform to disable/enable the idle states on it.

Today on powernv the default idle state nap is entered into all the
time. One can disable it by echoing 0 to powersave_nap under
/proc/sys/kernel/powersave_nap, in which case the cpu enters low thread
priority.

Thanks

Regards
Preeti U Murthy

> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
