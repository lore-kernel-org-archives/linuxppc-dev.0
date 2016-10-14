Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3swHY73LmMzDt2K
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 17:21:15 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64: option to force run-at-load to test relocation
In-Reply-To: <ad8e59d1-57fb-56c9-c2cf-d284835d9288@gmail.com>
References: <20161012065719.29833-1-npiggin@gmail.com>
 <ad8e59d1-57fb-56c9-c2cf-d284835d9288@gmail.com>
Date: Fri, 14 Oct 2016 17:21:12 +1100
Message-ID: <87pon3cuxz.fsf@concordia.ellerman.id.au>
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
> On 12/10/16 17:57, Nicholas Piggin wrote:
>> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
>> index 79da0641..bc9ceac 100644
>> --- a/arch/powerpc/kernel/head_64.S
>> +++ b/arch/powerpc/kernel/head_64.S
>> @@ -111,8 +111,12 @@ __secondary_hold_acknowledge:
>>  	.globl	__run_at_load
>>  __run_at_load:
>>  DEFINE_FIXED_SYMBOL(__run_at_load)
>> +#ifdef CONFIG_RELOCATABLE_TEST
>> +	.long	0x1		/* Test relocation, do not relocate to 0 */
>> +#else
>>  	.long	0x72756e30	/* "run0" -- relocate to 0 by default */
>>  #endif
>> +#endif
>
> Could we do something like
>
> config RELOCATION_VALUE
> 	default 0x72756e30
> 	default	1  if CONFIG_RELOCTABLE_TEST

I'm not a fan of using kconfig logic when plain #defines would achieve
the same result, eg:

#ifdef CONFIG_RELOCATABLE_TEST
#define RUN_AT_LOAD_DEFAULT 1		/* Test relocation, do not relocate to 0 */
#else
#define RUN_AT_LOAD_DEFAULT 0x72756e30  /* "run0" -- relocate to 0 by default */
#endif

	.globl	__run_at_load
__run_at_load:
DEFINE_FIXED_SYMBOL(__run_at_load)
	.long	RUN_AT_LOAD_DEFAULT


Which is probably nicer to look at than Nick's version, but not by a
huge margin. I'd merge either.

cheers
