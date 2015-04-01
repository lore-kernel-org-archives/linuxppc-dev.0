Return-Path: <sudeep.holla@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id DC8271A0744
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 20:55:04 +1100 (AEDT)
Message-ID: <551BC0B4.8050007@arm.com>
Date: Wed, 01 Apr 2015 10:56:04 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC/RFT,
 RESEND] powerpc: move cacheinfo sysfs to generic cacheinfo
 infrastructure
References: <20150331105637.39B451400DE@ozlabs.org>	
 <551AD5E4.2040103@arm.com> <1427863242.4256.10.camel@ellerman.id.au>
In-Reply-To: <1427863242.4256.10.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: Paul Mackerras <paulus@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 01/04/15 05:40, Michael Ellerman wrote:
> On Tue, 2015-03-31 at 18:14 +0100, Sudeep Holla wrote:
>>
>> On 31/03/15 11:56, Michael Ellerman wrote:
>>> On Mon, 2015-23-02 at 18:18:20 UTC, Sudeep Holla wrote:
>>>> This patch removes the redundant sysfs cacheinfo code by reusing
>>>> the newly introduced generic cacheinfo infrastructure through the
>>>> commit 246246cbde5e ("drivers: base: support cpu cache information
>>>> interface to userspace via sysfs")
>>
>>> Removing the include doesn't fix it, it needs cacheinfo_cpu_on/offline().
>>>
>>
>> I agree, had a quick look at that, and it requires some rework not sure
>> if that should be in generic code or ppc specific.
>
> Yeah OK.
>
> Also if I just remove the references from the suspend code, it still causes
> changes to the result, some of which look wrong:
>
> --- cpu0.before	2015-04-01 15:34:58.985470973 +1100
> +++ cpu0.after-no-power	2015-04-01 15:36:31.313435304 +1100
> @@ -3,22 +3,24 @@
>   ./cpu0/cache/index0/level:1
>   ./cpu0/cache/index0/number_of_sets:8
>   ./cpu0/cache/index0/shared_cpu_map:0000,000000ff
> +./cpu0/cache/index0/shared_cpu_list:0-7		<- additional, OK
>   ./cpu0/cache/index0/coherency_line_size:128
>   ./cpu0/cache/index0/ways_of_associativity:64
> -./cpu0/cache/index1/size:32K				<- we lost the size of the Icache?
>   ./cpu0/cache/index1/type:Instruction
>   ./cpu0/cache/index1/level:1
> -./cpu0/cache/index1/number_of_sets:4			}-.
> -./cpu0/cache/index1/shared_cpu_map:0000,000000ff	  .
> -./cpu0/cache/index1/coherency_line_size:128		  .   These changes are no good
> -./cpu0/cache/index1/ways_of_associativity:64		  .
> +./cpu0/cache/index1/shared_cpu_map:ffff,ffffffff	  .
> +./cpu0/cache/index1/shared_cpu_list:0-47		}-
>   ./cpu0/cache/index2/size:512K
>   ./cpu0/cache/index2/type:Unified
>   ./cpu0/cache/index2/level:2
>   ./cpu0/cache/index2/number_of_sets:8
>   ./cpu0/cache/index2/shared_cpu_map:0000,000000ff
> +./cpu0/cache/index2/shared_cpu_list:0-7		<- additional, OK
> +./cpu0/cache/index2/ways_of_associativity:0		<- this is new but wrong I think
>   ./cpu0/cache/index3/size:8192K
>   ./cpu0/cache/index3/type:Unified
>   ./cpu0/cache/index3/level:3
>   ./cpu0/cache/index3/number_of_sets:8
>   ./cpu0/cache/index3/shared_cpu_map:0000,000000ff
> +./cpu0/cache/index3/shared_cpu_list:0-7
> +./cpu0/cache/index3/ways_of_associativity:0		<- ditto
>

Thanks for the log. It's been long time since I looked at this code.
It would be good to know if Anshuman had looked at this issue. If not
I will start looking at this in couple of days.

Regards,
Sudeep
