Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7EB6EB6EF1
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2012 00:06:18 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Thu, 12 Jan 2012 13:58:35 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q0CD63kk4915326
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2012 00:06:06 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q0CD6236018580
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2012 00:06:03 +1100
Message-ID: <4F0EDAB3.4070802@linux.vnet.ibm.com>
Date: Thu, 12 Jan 2012 18:35:55 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: cpuidle: Default y for pseries
References: <1326243935.23910.85.camel@pasglop>
 <20120111223744.GA30947@oc1711230544.ibm.com>
 <1326323168.23910.168.camel@pasglop>
In-Reply-To: <1326323168.23910.168.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, linux-pm@vger.kernel.org,
 Shaohua Li <shaohua.li@intel.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 01/12/2012 04:36 AM, Benjamin Herrenschmidt wrote:

> On Wed, 2012-01-11 at 20:37 -0200, Thadeu Lima de Souza Cascardo wrote:
>> On Tue, Jan 10, 2012 at 03:05:35PM -0000, Benjamin Herrenschmidt wrote:
>>> We just replaced the pseries platform idle loops with a cpuidle backend,
>>> however that means that you won't get any power saving and won't return
>>> any unused idle time to the hypervisor unless cpuidle is enabled.
>>>
>>> Thus is should default to y when pseries is enabled. I prefer that to
>>> a select so we can still make it modular if we want to.
>>>
>>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>
>>> ---
>>> Linus, do you want to just pick that up or should I put it into powerpc.git
>>> and ask you to pull ? I will have 2 or 3 other fixes there later today,
>>> but I wanted to make sure you were ok with the approach with this
>>> specific one.
>>
>> Hi, Ben.
>>
>> Note that building with CONFIG_PSERIES_IDLE=m fails.
> 
> Ah ok. Well, making it built-in only makes sense anyway as I said
> separately, so I think I'll just select it.
> 
> Cheers,
> Ben.
> 
>>   CC [M]  arch/powerpc/platforms/pseries/processor_idle.o
>> arch/powerpc/platforms/pseries/processor_idle.c:35: error: redefinition
>> of ‘update_smt_snooze_delay’
>> /root/linux/arch/powerpc/include/asm/system.h:230: note: previous
>> definition of ‘update_smt_snooze_delay’ was here
>> arch/powerpc/platforms/pseries/processor_idle.c:175: error: redefinition
>> of ‘pseries_notify_cpuidle_add_cpu’
>> /root/linux/arch/powerpc/include/asm/system.h:231: note: previous
>> definition of ‘pseries_notify_cpuidle_add_cpu’ was here
>> make[2]: *** [arch/powerpc/platforms/pseries/processor_idle.o] Error 1
>> make[1]: *** [arch/powerpc/platforms/pseries] Error 2
>> make: *** [arch/powerpc/platforms] Error 2
>>
>> asm/system.h has empty inline implementations for
>> update_smt_snooze_delay and pseries_notify_cpuidle_add_cpu, which are
>> used when CONFIG_PSERIES_IDLE is undefined. Since those two functions
>> are used in core power architecture functions (store_smt_snooze_delay
>> at kernel/sysfs.c and smp_xics_setup_cpu at platforms/pseries/smp.c),
>> this requires some rework in these interactions or we should simply
>> disable PSERIES_IDLE to be built as a module for now.
>>
>> Regards.
>> Cascardo.
>>
>>>
>>> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
>>> index 7dbc4a8..62ca70d 100644
>>> --- a/drivers/cpuidle/Kconfig
>>> +++ b/drivers/cpuidle/Kconfig
>>> @@ -1,7 +1,8 @@
>>>  
>>>  config CPU_IDLE
>>>  	bool "CPU idle PM support"
>>> -	default ACPI
>>> +	default y if ACPI
>>> +	default y if PPC_PSERIES
>>>  	help
>>>  	  CPU idle is a generic framework for supporting software-controlled
>>>  	  idle processor power management.  It includes modular cross-platform



The following patch disables pseries cpuidle driver to be loaded as a
module as there are build problems reported when one is trying to do so.
This is a work around for now until the problem is fixed.

arch/powerpc/platforms/pseries/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/Kconfig
b/arch/powerpc/platforms/pseries/Kconfig
index ae7b6d4..31f22c1 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -122,7 +122,7 @@ config DTL
          Say N if you are unsure.

 config PSERIES_IDLE
-       tristate "Cpuidle driver for pSeries platforms"
+       bool "Cpuidle driver for pSeries platforms"
        depends on CPU_IDLE
        depends on PPC_PSERIES
        default y

As pointed out, asm/system.h has empty inline implementations for
update_smt_snooze_delay and pseries_notify_cpuidle_add_cpu, which are
used when CONFIG_PSERIES_IDLE is undefined. Since those two functions
are used in core power architecture functions (store_smt_snooze_delay
at kernel/sysfs.c and smp_xics_setup_cpu at platforms/pseries/smp.c),

Going forward, the aim is to remove the dependency of using these
functions from core power architecture functions. So I am proposing the
following changes:

a) Removing update_smt_snooze_delay () and allow the pseries
idle backend driver to query snooze entry on need basis
while initializing the driver fields by exporting an api to return
snooze value for a given cpu.

b) Replacing the pseries_notify_cpuidle_add_cpu() call
by registering a cpu_notifier to take actions accordingly.

Regards,
Deepthi
