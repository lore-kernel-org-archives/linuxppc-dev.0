Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205])
 by lists.ozlabs.org (Postfix) with ESMTP id 24F341A0006
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 13:28:11 +1000 (EST)
Message-ID: <53AB933D.1040108@roeck-us.net>
Date: Wed, 25 Jun 2014 20:27:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2] sched: Fix compiler warnings
References: <1403658329-13196-1-git-send-email-linux@roeck-us.net>
 <20140626105928.5f375f0c@canb.auug.org.au>
In-Reply-To: <20140626105928.5f375f0c@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Russell King <linux@arm.linux.org.uk>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/25/2014 05:59 PM, Stephen Rothwell wrote:
> Hi Guenter,
>
> [I know I'm a bit late to this, but ...]
>
> On Tue, 24 Jun 2014 18:05:29 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
>> index 9d85318..e35d880 100644
>> --- a/arch/arm/kernel/topology.c
>> +++ b/arch/arm/kernel/topology.c
>> @@ -275,7 +275,7 @@ void store_cpu_topology(unsigned int cpuid)
>>   		cpu_topology[cpuid].socket_id, mpidr);
>>   }
>>
>> -static inline const int cpu_corepower_flags(void)
>> +static inline int cpu_corepower_flags(void)
>>   {
>>   	return SD_SHARE_PKG_RESOURCES  | SD_SHARE_POWERDOMAIN;
>>   }
>
> The only reference to this function is to take its address, so "inline"
> is useless, right?
>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 306f4f0..0376b05 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -872,21 +872,21 @@ enum cpu_idle_type {
>>   #define SD_NUMA			0x4000	/* cross-node balancing */
>>
>>   #ifdef CONFIG_SCHED_SMT
>> -static inline const int cpu_smt_flags(void)
>> +static inline int cpu_smt_flags(void)
>>   {
>>   	return SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
>>   }
>>   #endif
>>
>>   #ifdef CONFIG_SCHED_MC
>> -static inline const int cpu_core_flags(void)
>> +static inline int cpu_core_flags(void)
>>   {
>>   	return SD_SHARE_PKG_RESOURCES;
>>   }
>>   #endif
>>
>>   #ifdef CONFIG_NUMA
>> -static inline const int cpu_numa_flags(void)
>> +static inline int cpu_numa_flags(void)
>>   {
>>   	return SD_NUMA;
>>   }
>
> The same is true of those three, but then they would have to be moved
> into a .c file and replaced with prototypes ...
>

Personally I wasn't sure why it had to be functions instead of defines,
but who knows. Anyway, seems others are not happy with my proposed fix
either, and everyone seems to suggest a different solution, so I guess
it won't go anywhere.

I "solved" my immediate problem of getting a polluted build log by
filtering the warnings out, so I don't really care too much anymore ;-).

Guenter
