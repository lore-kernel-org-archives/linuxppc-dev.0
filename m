Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sw7yp1mrVzDsyY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 11:39:30 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id 128so6037127pfz.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 17:39:30 -0700 (PDT)
Subject: Re: [PATCH] powerpc/64: option to force run-at-load to test relocation
To: Nicholas Piggin <npiggin@gmail.com>
References: <20161012065719.29833-1-npiggin@gmail.com>
 <ad8e59d1-57fb-56c9-c2cf-d284835d9288@gmail.com>
 <20161013132534.695afc12@roar.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <4e9b19c1-c6b1-54af-7540-34ed550e4031@gmail.com>
Date: Fri, 14 Oct 2016 11:39:22 +1100
MIME-Version: 1.0
In-Reply-To: <20161013132534.695afc12@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 13/10/16 13:25, Nicholas Piggin wrote:
> On Wed, 12 Oct 2016 18:35:21 +1100
> Balbir Singh <bsingharora@gmail.com> wrote:
> 
>> On 12/10/16 17:57, Nicholas Piggin wrote:
>>> This adds a config option that can help exercise the case when
>>> the kernel is not running at PAGE_OFFSET.
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>>  arch/powerpc/Kconfig               | 9 +++++++++
>>>  arch/powerpc/kernel/head_64.S      | 4 ++++
>>>  arch/powerpc/kernel/setup-common.c | 3 +++
>>>  3 files changed, 16 insertions(+)
>>>
>>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>>> index 65fba4c..5d43cb8 100644
>>> --- a/arch/powerpc/Kconfig
>>> +++ b/arch/powerpc/Kconfig
>>> @@ -478,6 +478,15 @@ config RELOCATABLE
>>>  	  setting can still be useful to bootwrappers that need to know the
>>>  	  load address of the kernel (eg. u-boot/mkimage).
>>>  
>>> +config RELOCATABLE_TEST
>>> +	bool "Test relocatable kernel"
>>> +	depends on (PPC64 && RELOCATABLE)
>>> +	default n
>>> +	help
>>> +	  This runs the relocatable kernel at the address it was initially
>>> +	  loaded at, which tends to be non-zero and therefore test the
>>> +	  relocation code.
>>> +
>>>  config CRASH_DUMP
>>>  	bool "Build a kdump crash kernel"
>>>  	depends on PPC64 || 6xx || FSL_BOOKE || (44x && !SMP)
>>> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
>>> index 79da0641..bc9ceac 100644
>>> --- a/arch/powerpc/kernel/head_64.S
>>> +++ b/arch/powerpc/kernel/head_64.S
>>> @@ -111,8 +111,12 @@ __secondary_hold_acknowledge:
>>>  	.globl	__run_at_load
>>>  __run_at_load:
>>>  DEFINE_FIXED_SYMBOL(__run_at_load)
>>> +#ifdef CONFIG_RELOCATABLE_TEST
>>> +	.long	0x1		/* Test relocation, do not relocate to 0 */
>>> +#else
>>>  	.long	0x72756e30	/* "run0" -- relocate to 0 by default */
>>>  #endif
>>> +#endif  
>>
>> Could we do something like
>>
>> config RELOCATION_VALUE
>> 	default 0x72756e30
>> 	default	1  if CONFIG_RELOCTABLE_TEST
>>
>> and then get
>>
>> 	.long CONFIG_RELOCATION_VALUE
> 
> Normally I'm up for reducing ifdefs in S and c files, but in this case
> I'm not sure. I like being able to see the two possible values in the
> source. I don't really mind though. If you or Michael feel strongly, I'm
> happy to change it.
> 

I guess it depends, for me parsing two .long's under #ifdef seems a little
more work than a .long with a constant depending on the configuration.

I don't feel too strongly about it either

Balbir Singh.
