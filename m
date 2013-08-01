Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 747262C00C9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2013 14:59:26 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Thu, 1 Aug 2013 10:19:10 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id E93AF394004E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2013 10:29:08 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r714xCip36241412
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Aug 2013 10:29:12 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r714xE1P015234
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Aug 2013 14:59:14 +1000
Message-ID: <51F9EA96.7030407@linux.vnet.ibm.com>
Date: Thu, 01 Aug 2013 10:26:54 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Subject: Re: [PATCH V2 4/6] cpuidle/pseries: Move the pseries_idle backend
 driver to sysdev.
References: <20130731025840.19448.24468.stgit@deepthi>
 <20130731025924.19448.46538.stgit@deepthi>
 <ABB05CD9C9F68C46A5CEDC7F15439259FF2953@039-SN2MPN1-021.039d.mgd.msft.net>
 <51F88BA7.7090404@linux.vnet.ibm.com>
 <ABB05CD9C9F68C46A5CEDC7F15439259FF2A3A@039-SN2MPN1-021.039d.mgd.msft.net>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259FF2A3A@039-SN2MPN1-021.039d.mgd.msft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rjw@sisk.pl" <rjw@sisk.pl>, Zhao Chenhui-B35336 <B35336@freescale.com>,
 "srivatsa.bhat@linux.vnet.ibm.com" <srivatsa.bhat@linux.vnet.ibm.com>,
 Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Dongsheng,

On 07/31/2013 11:16 AM, Wang Dongsheng-B40534 wrote:
> Hi Preeti,
> 
>> -----Original Message-----
>> From: Preeti U Murthy [mailto:preeti@linux.vnet.ibm.com]
>> Sent: Wednesday, July 31, 2013 12:00 PM
>> To: Wang Dongsheng-B40534
>> Cc: Deepthi Dharwar; benh@kernel.crashing.org; daniel.lezcano@linaro.org;
>> linux-kernel@vger.kernel.org; michael@ellerman.id.au;
>> srivatsa.bhat@linux.vnet.ibm.com; svaidy@linux.vnet.ibm.com; linuxppc-
>> dev@lists.ozlabs.org; rjw@sisk.pl; linux-pm@vger.kernel.org
>> Subject: Re: [PATCH V2 4/6] cpuidle/pseries: Move the pseries_idle
>> backend driver to sysdev.
>>
>> Hi Dongsheng,
>>
>> On 07/31/2013 08:52 AM, Wang Dongsheng-B40534 wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Deepthi Dharwar [mailto:deepthi@linux.vnet.ibm.com]
>>>> Sent: Wednesday, July 31, 2013 10:59 AM
>>>> To: benh@kernel.crashing.org; daniel.lezcano@linaro.org; linux-
>>>> kernel@vger.kernel.org; michael@ellerman.id.au;
>>>> srivatsa.bhat@linux.vnet.ibm.com; preeti@linux.vnet.ibm.com;
>>>> svaidy@linux.vnet.ibm.com; linuxppc-dev@lists.ozlabs.org
>>>> Cc: rjw@sisk.pl; Wang Dongsheng-B40534; linux-pm@vger.kernel.org
>>>> Subject: [PATCH V2 4/6] cpuidle/pseries: Move the pseries_idle
>>>> backend driver to sysdev.
>>>>
>>>> Move pseries_idle backend driver code to arch/powerpc/sysdev so that
>>>> the code can be used for a common driver for powernv and pseries.
>>>> This removes a lot of code duplicacy.
>>>>
>>> Why not drivers/cpuidle/?
>>>
>>> I think it should be move to drivers/cpuidle.
>>
>> Please take a look at what the cpuidle under drivers has to provide.
>> cpuidle has two parts to it. The front end and the back end. The front
>> end constitutes the cpuidle governors, registering of arch specific
>> cpuidle drivers, disabling and enabling of cpuidle feature. It is this
>> front end code which is present under drivers/cpuidle.
>>
>> The arch specific cpuidle drivers which decide what needs to be done to
>> enter a specific idle state chosen by the cpuidle governor is what
>> constitutes the back end of cpuidle. This will not be in drivers/cpuidle
>> but in an arch/ specific code.
>>
>> The cpuidle under drivers/cpuidle drives the idle power management, but
>> the low level handling of the entry into idle states should be taken care
>> of by the architecture.
>>
>> Your recent patch :
>> cpuidle: add freescale e500 family porcessors idle support IMO should
>> hook onto the backend cpuidle driver that this patchset provides.
>>
> Sorry, I don't think so, cpuidle framework has been already very common.
> Here we just need to do state definition and handling. I wonder whether
> we need this layer.
> 
> If your handle is platform dependent, it should be in arch/platform.
> 
> If it is only for some platforms and the operation of these platforms can be
> multiplexed, Why cannot as a driver to put into driver/cpuidle?
> 
> If it a general driver, I think we can put some common operating to driver/cpuidle
> and make the platform specific code to arch/powerpc/platform.
> 
> This patch include front end and back end, not just back end.
> 
> This patch include too many state of different platforms and handle function. This state
> and handle that should belong to itself platforms. Not a general way. If Deepthi will do
> a general powerpc cpuidle, I think, it's cannot just using the macro to distinguish
> platform. the front end code maybe move to driver/cpuidle(drvier register) should be better,
> make the Low Power State and what should be handle to arch/powerpc/platform/**, because different
> platforms have different state of low power consumption, and the processing method.
> The front end can provide some general methods to register into general powerpc cpuidle driver.


As Daniel pointed out, with a call to cpuidle_register(), we can get the
cpuidle_driver and cpuidle_device registered through the generic cpuidle
framework. Hence we can get rid of the powerpc_idle_devices_init() routine.

We can have the hotplug notifier in the generic cpuidle framework as
well. The rest of the patchset however should be arch specific IMO.

Regards
Preeti U Murthy

> 
> -dongsheng
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
