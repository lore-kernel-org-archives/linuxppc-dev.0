Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F052A2C014D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 17:04:51 +1000 (EST)
Message-ID: <51ECD947.7010901@asianux.com>
Date: Mon, 22 Jul 2013 15:03:35 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc: kernel: remove useless code which related
 with 'max_cpus'
References: <51ECCA10.7010709@asianux.com>
 <51ECCEA8.5040406@linux.vnet.ibm.com> <51ECD0BF.8080605@asianux.com>
 <51ECD3D4.9020405@asianux.com> <51ECD664.7040708@linux.vnet.ibm.com>
In-Reply-To: <51ECD664.7040708@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: chenhui.zhao@freescale.com, "paulus@samba.org" <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/22/2013 02:51 PM, Srivatsa S. Bhat wrote:
> On 07/22/2013 12:10 PM, Chen Gang wrote:
>> Since not need 'max_cpus' after the related commit, the related code
>> are useless too, need be removed.
>>
>> The related commit:
>>
>>   c1aa687 powerpc: Clean up obsolete code relating to decrementer and timebase
>>
>> The related warning:
>>
>>   arch/powerpc/kernel/smp.c:323:43: warning: parameter ‘max_cpus’ set but not used [-Wunused-but-set-parameter]
>>
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> 
> This version looks good.
> 
> Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> 

Thank you very much.

> Regards,
> Srivatsa S. Bhat
> 
>> ---
>>  arch/powerpc/kernel/smp.c |    9 ++-------
>>  1 files changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
>> index 38b0ba6..7edbd5b 100644
>> --- a/arch/powerpc/kernel/smp.c
>> +++ b/arch/powerpc/kernel/smp.c
>> @@ -346,13 +346,8 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>>  	cpumask_set_cpu(boot_cpuid, cpu_sibling_mask(boot_cpuid));
>>  	cpumask_set_cpu(boot_cpuid, cpu_core_mask(boot_cpuid));
>>
>> -	if (smp_ops)
>> -		if (smp_ops->probe)
>> -			max_cpus = smp_ops->probe();
>> -		else
>> -			max_cpus = NR_CPUS;
>> -	else
>> -		max_cpus = 1;
>> +	if (smp_ops && smp_ops->probe)
>> +		smp_ops->probe();
>>  }
>>
>>  void smp_prepare_boot_cpu(void)
>>
> 
> 
> 
> 


-- 
Chen Gang
