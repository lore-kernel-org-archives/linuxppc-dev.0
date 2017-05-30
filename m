Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcMcG59rgzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 15:29:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64s: dt_cpu_ftrs boot time setup option
In-Reply-To: <1496096943.21894.13.camel@gmail.com>
References: <20170511112441.30287-1-npiggin@gmail.com>
 <1496096943.21894.13.camel@gmail.com>
Date: Tue, 30 May 2017 15:29:34 +1000
Message-ID: <87vaoi6hfl.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:
> On Thu, 2017-05-11 at 21:24 +1000, Nicholas Piggin wrote:
>> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
>> index fcc7588a96d6..050925b5b451 100644
>> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
>> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
>> @@ -671,12 +671,24 @@ static struct dt_cpu_feature_match __initdata
>>  	{"wait-v3", feat_enable, 0},
>>  };
>>  
>> -/* XXX: how to configure this? Default + boot time? */
>> -#ifdef CONFIG_PPC_CPUFEATURES_ENABLE_UNKNOWN
>> -#define CPU_FEATURE_ENABLE_UNKNOWN 1
>> -#else
>> -#define CPU_FEATURE_ENABLE_UNKNOWN 0
>> -#endif
>> +static bool __initdata using_dt_cpu_ftrs = true;
>> +static bool __initdata dt_cpu_ftrs_enable_unknown = true;
>> +
>> +static int __init dt_cpu_ftrs_parse(char *str)
>> +{
>> +	if (!str)
>> +		return 0;
>> +
>> +	if (!strcmp(str, "off"))
>> +		using_dt_cpu_ftrs = false;
>> +	else if (!strcmp(str, "known"))
>> +		dt_cpu_ftrs_enable_unknown = false;
>> +	else
>> +		return 1;
>> +
>> +	return 0;
>> +}
>> +early_param("dt_cpu_ftrs", dt_cpu_ftrs_parse);
>
> I wouldn't use strcmp with user passed parameters.

Why not? Especially considering the generic code has already parsed the
string to find the = delimiter, and is just passing us the tail.

cheers
