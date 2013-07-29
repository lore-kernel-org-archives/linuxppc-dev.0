Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 750DC2C0107
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 00:28:40 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Tue, 30 Jul 2013 00:20:43 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 048A72BB004F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 00:28:37 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6TESQNJ66715740
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 00:28:26 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6TESZBv003339
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 00:28:35 +1000
Message-ID: <51F67BE5.10701@linux.vnet.ibm.com>
Date: Mon, 29 Jul 2013 19:57:49 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/3] cpuidle/powernv: Enable idle powernv cpu to call
 into the cpuidle framework.
References: <20130723090111.7291.99479.stgit@deepthi.in.ibm.com>
 <20130723090150.7291.89879.stgit@deepthi.in.ibm.com>
 <51F35AC7.8060909@linaro.org>
In-Reply-To: <51F35AC7.8060909@linaro.org>
Content-Type: text/plain; charset=UTF-8
Cc: linux-pm@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/27/2013 10:59 AM, Daniel Lezcano wrote:
> On 07/23/2013 11:01 AM, Deepthi Dharwar wrote:
>> This patch enables idle powernv cpu to hook on to the cpuidle
>> framework, if available, else call on to default idle platform
>> code.
> 
> Why do you need to do that ?
> 

Hi Daniel,

Well, this is needed in case when one does not compile with CPU_IDLE
config option.

When CPUIDLE is not configured, idle cpus are needed to be running some
sort of default idle code or loop ( in the worst case) if cpuidle driver
is not registered or if one decides not to have that config enabled.

Regards,
Deepthi

> 
>> Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/powernv/setup.c |   12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
>> index 84438af..97d0951 100644
>> --- a/arch/powerpc/platforms/powernv/setup.c
>> +++ b/arch/powerpc/platforms/powernv/setup.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/of.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/bug.h>
>> +#include <linux/cpuidle.h>
>>  
>>  #include <asm/machdep.h>
>>  #include <asm/firmware.h>
>> @@ -196,6 +197,15 @@ static int __init pnv_probe(void)
>>  	return 1;
>>  }
>>  
>> +void powernv_idle(void)
>> +{
>> +	/* Hook to cpuidle framework if available, else
>> +	 * call on default platform idle code
>> +	 */
>> +	if (cpuidle_idle_call())
>> +		power7_idle();
>> +}
>> +
>>  define_machine(powernv) {
>>  	.name			= "PowerNV",
>>  	.probe			= pnv_probe,
>> @@ -205,7 +215,7 @@ define_machine(powernv) {
>>  	.show_cpuinfo		= pnv_show_cpuinfo,
>>  	.progress		= pnv_progress,
>>  	.machine_shutdown	= pnv_shutdown,
>> -	.power_save             = power7_idle,
>> +	.power_save             = powernv_idle,
>>  	.calibrate_decr		= generic_calibrate_decr,
>>  #ifdef CONFIG_KEXEC
>>  	.kexec_cpu_down		= pnv_kexec_cpu_down,
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
> 
> 
