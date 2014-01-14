Return-Path: <slpratt@austin.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8484B2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2014 04:05:15 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <slpratt@austin.ibm.com>;
 Tue, 14 Jan 2014 10:05:13 -0700
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 75E51C90050
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 12:05:01 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0EH525E45744180
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 17:05:02 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0EH51LG006575
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 12:05:01 -0500
Message-ID: <52D56E3B.7060500@austin.ibm.com>
Date: Tue, 14 Jan 2014 11:04:59 -0600
From: Steven Pratt <slpratt@austin.ibm.com>
MIME-Version: 1.0
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: Disable sleep states on P7+
References: <52D54B60.4090807@austin.ibm.com>
 <52D56186.70807@linux.vnet.ibm.com>
In-Reply-To: <52D56186.70807@linux.vnet.ibm.com>
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

On 01/14/2014 10:10 AM, Preeti U Murthy wrote:
> Hi Steven,
>
> On 01/14/2014 08:06 PM, Steven Pratt wrote:
>> I am looking for info on when and how we are able to disable power saving features of current (P7, P7+) chips in order to reduce latency. This is often done in latency sensitive applications when power consumption is not an issue. On Intel boxes we can disable P-state frequency changes as well as disabling C-State or sleep state changes. In fact we can control how deep a sleep the processor can go into.  I know we have control Dynamic Processor Scaling and Idle Power Savings, but what states do these really affect?  Can I really disable Nap mode of a processor? If so how?  Can I disable even the lightest winkle mode?  Looking for current information (read RHEL 6 and SLES11), future changes are interesting.
>>
>> Steve
> I can answer this question with respect to cpuidle on PowerNV platforms.
>
> 1. In order to disable cpuidle states management altogether, one can
> pass the powersave=off kernel cmd line parameter during boot up of the
> kernel. This will ensure that each time a CPU has nothing to do, it can
> enter low thread priority which could lower power consumption to some
> extent but is not expected to hit latency of applications noticeably.
>
> 2. In order to exactly control the cpuidle states into which idle CPUs
> can enter into during runtime, one can make use of the sysfs files under:
> /sys/devices/system/cpu/cpux/cpuidle/statex/disable option to
> selectively disable any state.
>
> However if one is using the menu cpuidle governor, disabling an idle
> state does not disable the idle states which are deeper than it. They
> continue to remain active unless they are specifically disabled. What
> this means is that one cannot control the depth of the idle states
> available for a CPU, although we can control the exact idle states
> available for a processor.
>
> But if the ladder governor is used, one can control the depth of the
> idle states that a CPU can enter into. The governor can be chosen by
> echoing either menu/ladder to
> /sys/devices/system/cpu/cpuidle/current_governor_ro. The cpuidle
> governor takes decisions about the idle state for a cpu to enter into
> depending on its idle history. The popular governor used by most archs
> is the menu governor.
>
> Hence nap/sleep/winkle any of these states can be disabled. The code
> which enables the above mentioned functionalities on powernv is yet to
> go upstream although the same is already upstream and can be used for
> the pseries platform to disable/enable the idle states on it.
>
> Today on powernv the default idle state nap is entered into all the
> time. One can disable it by echoing 0 to powersave_nap under
> /proc/sys/kernel/powersave_nap, in which case the cpu enters low thread

Thanks, that is great information going forward, now I just need info on what works today in PowerVM.

Steve

> priority.
>
> Thanks
>
> Regards
> Preeti U Murthy
>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
