Return-Path: <cody@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E6E102C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 08:31:35 +1100 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 14:31:33 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id ADD6B19D8042
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 14:31:29 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1PLV5ZH10420546
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 22:31:05 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s1PLYvOh002024
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 14:34:58 -0700
Message-ID: <530D0BA1.90609@linux.vnet.ibm.com>
Date: Tue, 25 Feb 2014 13:31:13 -0800
From: Cody P Schafer <cody@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Kumar Gala <galak@kernel.crashing.org>,
 Lijun Pan <Lijun.Pan@freescale.com>, Li Yang <leoli@freescale.com>,
 Paul Bolle <pebolle@tiscali.nl>,
 Priyanka Jain <Priyanka.Jain@freescale.com>,
 Scott Wood <scottwood@freescale.com>,
 Tang Yuantian <yuantian.tang@freescale.com>
Subject: Re: [PATCH v2 10/11] powerpc/perf: add kconfig option for hypervisor
 provided counters
References: <20140225033330.54F332C02FB@ozlabs.org>
In-Reply-To: <20140225033330.54F332C02FB@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/24/2014 07:33 PM, Michael Ellerman wrote:
> On Fri, 2014-14-02 at 22:02:14 UTC, Cody P Schafer wrote:
>> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/perf/Makefile             | 2 ++
>>   arch/powerpc/platforms/Kconfig.cputype | 6 ++++++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
>> index 60d71ee..f9c083a 100644
>> --- a/arch/powerpc/perf/Makefile
>> +++ b/arch/powerpc/perf/Makefile
>> @@ -11,5 +11,7 @@ obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
>>   obj-$(CONFIG_FSL_EMB_PERF_EVENT) += core-fsl-emb.o
>>   obj-$(CONFIG_FSL_EMB_PERF_EVENT_E500) += e500-pmu.o e6500-pmu.o
>>
>> +obj-$(CONFIG_HV_PERF_CTRS) += hv-24x7.o hv-gpci.o hv-common.o
>> +
>>   obj-$(CONFIG_PPC64)		+= $(obj64-y)
>>   obj-$(CONFIG_PPC32)		+= $(obj32-y)
>> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
>> index 434fda3..dcc67cd 100644
>> --- a/arch/powerpc/platforms/Kconfig.cputype
>> +++ b/arch/powerpc/platforms/Kconfig.cputype
>> @@ -364,6 +364,12 @@ config PPC_PERF_CTRS
>>          help
>>            This enables the powerpc-specific perf_event back-end.
>>
>> +config HV_PERF_CTRS
>> +       def_bool y
>
> This was bool, why did you change it?

No, it wasn't. v1 also had def_bool. https://lkml.org/lkml/2014/1/16/518
Maybe you're confusing v2.1 and v2 of this patch?

>
>> +       depends on PERF_EVENTS && PPC_HAVE_PMU_SUPPORT
>
> Should be:
>
> 	depends on PERF_EVENTS && PPC_PSERIES
>
>> +       help
>> +         Enable access to perf counters provided by the hypervisor
>> +

Yep, the v2.1 patch (which I bungled and labeled as 9/11) already 
changes both of these.
It'll end up rolled into v3.
