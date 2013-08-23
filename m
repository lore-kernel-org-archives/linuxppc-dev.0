Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ABCBB2C009D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 20:13:48 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Sat, 24 Aug 2013 07:08:03 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C0CF43578050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 20:12:48 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7N9uKEj1704220
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 19:56:29 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7NAC93Y004334
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 20:12:10 +1000
Message-ID: <5217354D.2060109@linux.vnet.ibm.com>
Date: Fri, 23 Aug 2013 15:41:25 +0530
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
 <5215A69F.4090904@linux.vnet.ibm.com>
 <1377206679.20722.10.camel@snotra.buserror.net>
In-Reply-To: <1377206679.20722.10.camel@snotra.buserror.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 Wang Dongsheng-B40534 <B40534@freescale.com>,
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

On 08/23/2013 02:54 AM, Scott Wood wrote:
> On Thu, 2013-08-22 at 11:20 +0530, Deepthi Dharwar wrote:
>> On 08/22/2013 01:38 AM, Scott Wood wrote:
>>> On Wed, 2013-08-21 at 10:23 +0530, Deepthi Dharwar wrote:
>>>> On 08/19/2013 11:47 PM, Scott Wood wrote:
>>>>> What actual functionality is common to all powerpc but not common to
>>>>> other arches?
>>>
>>
>> The functionality here is idle states on powerpc  like the snooze loop
>> that is common.
>> Also, the basic registration of the driver, hotplug notifier etc for
>> powerpc.
> 
> The snooze loop uses things like SPRN_PURR, get_lppaca(), and CTRL which
> aren't common to all PPC (they might be common to all book3s64).  I also
> don't see any hook for the low power mode entry -- is "snooze" just a
> busy loop plus the de-emphasis stuff like HMT and CTRL[RUN]?  I'm not
> familiar with the term "snooze" in this context.  I don't think we'd use
> anything like that on our chips; we'd always at least "wait" or "doze"
> depending on the chip.
>

Duly noted. Lot of stuff are common across book3s64. So my later
versions of this patchset does just that. (V5 posted out yesterday).
The driver is common only to IBM-POWER platform. Other PPC variants
can have their own driver.


> It's not clear what is powerpc-specific about the notifier -- perhaps it
> should go in drivers/cpuidle/.

Currently all the arcs have their own hotplug notifier. Unifying this
across all archs is a challenge that needs to be taken going forward.

Thanks for the review.
Regards,
Deepthi


>>> The way forward is to give this file a more appropriate name based on
>>> the hardware that it actually targets -- and to refactor it so that the
>>> answer to that question is not complicated.
>>
>> Sure, thanks.
>> Our idea was to have POWER archs idle states merged at the first go.
>> Only that is what is enabled in the current version (V4 posted out)
>> ( Code is enabled for PSERIES and POWERNV only)
>> If needed, other POWERPC archs might benefit by extending the same
>> driver, that is why it is named cpuidle-powerpc.c
>>
>> But if having cpuidle backend-driver separately for other powerpc arcs
>> makes sense such that each one have their own state information etc
>> then it makes sense to name the files as cpuidle-power.c,
>> cpuilde-ppc32.c and so on.
> 
> Thanks.
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
