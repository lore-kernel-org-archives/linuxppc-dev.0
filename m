Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A7E042C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 15:51:05 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Thu, 22 Aug 2013 11:15:07 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id C2D303940053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 11:20:48 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7M5qSvi46596240
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 11:22:28 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7M5ovHU010562
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 11:20:58 +0530
Message-ID: <5215A69F.4090904@linux.vnet.ibm.com>
Date: Thu, 22 Aug 2013 11:20:23 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC PATCH V3 3/5] powerpc/cpuidle: Generic powerpc backend
 cpuidle driver.
References: <20130819042736.8609.17890.stgit@deepthi.in.ibm.com>
 <20130819042818.8609.77060.stgit@deepthi.in.ibm.com>
 <ABB05CD9C9F68C46A5CEDC7F15439259010226D5@039-SN2MPN1-021.039d.mgd.msft.net>
 <5211F0E0.7080507@linux.vnet.ibm.com>
 <1376936241.31636.352.camel@snotra.buserror.net>
 <521447E7.5000302@linux.vnet.ibm.com>
 <1377115703.5029.14.camel@snotra.buserror.net>
In-Reply-To: <1377115703.5029.14.camel@snotra.buserror.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Wang Dongsheng-B40534 <B40534@freescale.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>,
 "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/22/2013 01:38 AM, Scott Wood wrote:
> On Wed, 2013-08-21 at 10:23 +0530, Deepthi Dharwar wrote:
>> On 08/19/2013 11:47 PM, Scott Wood wrote:
>>> On Mon, 2013-08-19 at 15:48 +0530, Deepthi Dharwar wrote:
>>>> Hi Dongsheng,
>>>>
>>>> On 08/19/2013 11:22 AM, Wang Dongsheng-B40534 wrote:
>>>>> I think we should move the states and handle function to arch/power/platform*
>>>>> The states and handle function is belong to backend driver, not for this, different platform have different state.
>>>>> Different platforms to make their own deal with these states.
>>>>>
>>>>> I think we cannot put all the status of different platforms and handler in this driver.
>>>>
>>>> The idea here is a single powerpc back-end driver, which does a runtime
>>>> detection of the platform it is running and choose the right
>>>> idle states table. This was one of outcome of V2 discussion.
>>>
>>> I see a lot more in there than just detecting a platform and choosing a
>>> driver.
>>>
>>>> I feel there is no harm in keeping the state information in the same
>>>> file. We do have x86, which has all its variants information in one
>>>> file. One place will have all the idle consolidated information of
>>>> all the platform variants. If community does feel, we need to
>>>> have just the states information in arch specific file, we can do so.
>>>
>>> What actual functionality is common to all powerpc but not common to
>>> other arches?
> 

The functionality here is idle states on powerpc  like the snooze loop
that is common.
Also, the basic registration of the driver, hotplug notifier etc for
powerpc.

> 
>>>>>> +config CPU_IDLE_POWERPC
>>>>>> +	bool "CPU Idle driver for POWERPC platforms"
>>>>>> +	depends on PPC64
>>>>>
>>>>> Why not PPC?
>>>>
>>>> PPC64 seems to a good place to began the consolidation work. This
>>>> patch-set has not been tested for PPC32 currently.
>>>
>>> PPC64 is a bad place to start if you want it to be generic, because it
>>> means you'll end up growing dependencies on other things that are PPC64
>>> only.  There are too many arbitrary 32/64 differences as is.
>>
>> Hi Scott,
>>
>> From my understanding, PPC64 includes BOOK3E and BOOK3S archs.
>> PPC includes PPC32 and PPC64.
>>
>> It seemed logical to start consolidating at PPC64 as
>> one does not want to get into 32/64 bit differences.
> 
> I don't want to "get into" a file that claims to be generic PPC but is
> loaded with 64-bit dependencies.
> 
>> From your comments above,  I just wanted to clarify if PPC or PPC64 is
>> bad place to start. If PPC64 is bad place to start, then whats the way
>> forward ?  Can you please throw some more light on it.
> 
> The way forward is to give this file a more appropriate name based on
> the hardware that it actually targets -- and to refactor it so that the
> answer to that question is not complicated.

Sure, thanks.
Our idea was to have POWER archs idle states merged at the first go.
Only that is what is enabled in the current version (V4 posted out)
( Code is enabled for PSERIES and POWERNV only)
If needed, other POWERPC archs might benefit by extending the same
driver, that is why it is named cpuidle-powerpc.c

But if having cpuidle backend-driver separately for other powerpc arcs
makes sense such that each one have their own state information etc
then it makes sense to name the files as cpuidle-power.c,
cpuilde-ppc32.c and so on.

Regards,
Deepthi


> 
> -Scott
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> 
