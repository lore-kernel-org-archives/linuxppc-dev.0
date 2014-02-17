Return-Path: <cody@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B3DD22C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Feb 2014 06:41:46 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Mon, 17 Feb 2014 14:41:43 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 040EC6E803C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Feb 2014 14:41:35 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1HJfdFx2031984
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Feb 2014 19:41:39 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1HJfc2x010749
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Feb 2014 14:41:39 -0500
Message-ID: <530265E6.5030906@linux.vnet.ibm.com>
Date: Mon, 17 Feb 2014 11:41:26 -0800
From: Cody P Schafer <cody@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 10/11] powerpc/perf: add kconfig option for hypervisor
 provided counters
References: <1392415338-16288-1-git-send-email-cody@linux.vnet.ibm.com>
 <1392415338-16288-11-git-send-email-cody@linux.vnet.ibm.com>
 <1392417133.6733.624.camel@snotra.buserror.net>
 <20140215002505.GA2991@negative> <1392621108.8740.5.camel@concordia>
In-Reply-To: <1392621108.8740.5.camel@concordia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Paul Bolle <pebolle@tiscali.nl>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Priyanka Jain <Priyanka.Jain@freescale.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Tang Yuantian <yuantian.tang@freescale.com>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Scott Wood <scottwood@freescale.com>, Lijun Pan <Lijun.Pan@freescale.com>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>, Anton Blanchard <anton@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/16/2014 11:11 PM, Michael Ellerman wrote:
> On Fri, 2014-02-14 at 16:25 -0800, Cody P Schafer wrote:
>> On Fri, Feb 14, 2014 at 04:32:13PM -0600, Scott Wood wrote:
>>> On Fri, 2014-02-14 at 14:02 -0800, Cody P Schafer wrote:
>>>> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
>>>> index 434fda3..dcc67cd 100644
>>>> --- a/arch/powerpc/platforms/Kconfig.cputype
>>>> +++ b/arch/powerpc/platforms/Kconfig.cputype
>>>> @@ -364,6 +364,12 @@ config PPC_PERF_CTRS
>>>>          help
>>>>            This enables the powerpc-specific perf_event back-end.
>>>>
>>>> +config HV_PERF_CTRS
>>>> +       def_bool y
>>>> +       depends on PERF_EVENTS && PPC_HAVE_PMU_SUPPORT
>>>> +       help
>>>> +         Enable access to perf counters provided by the hypervisor
>>>
>>> Please don't add default-y stuff that is platform-specific, and
>>> definitely point out that platform dependency in the config description
>>> -- I have to look elsewhere in the patchset to determine that this is
>>> for "Power Hypervisor".  PPC_HAVE_PMU_SUPPORT is enabled by all 6xx
>>> builds, even for hardware like e300 that doesn't have PMU at all (it has
>>> the FSL embedded perfmon instead), much less this hv interface.
>>>
>>> And yes, PPC_PERF_CTRS has the same problem and should be fixed. :-)
>>
>> Yep, I just based this one on what PPC_PERF_CTRS was doing.
>>
>> How about the following:
>>
>> +config HV_PERF_CTRS
>> +       bool "Perf Hypervisor supplied counters"
>
> "Support for Hypervisor supplied PMU events (24x7 & GPCI)" ?

Sounds good to me.

>
>> +       default y
>> +       depends on PERF_EVENTS && PPC_HAVE_PMU_SUPPORT && PPC_PSERIES
>
> I think you just want:
>
> 	depends on PERF_EVENTS && PPC_PSERIES
>
>
> Because you're adding two completely new PMUs, they're not a "struct power_pmu"
> backend for the existing powerpc PMU implementation.
>

Ack. I'll fix this up in v3
