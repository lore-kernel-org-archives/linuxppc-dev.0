Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 13A362C0339
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 20:27:16 +1100 (EST)
Message-ID: <5267966A.40007@windriver.com>
Date: Wed, 23 Oct 2013 17:27:06 +0800
From: =?UTF-8?B?IuKAnHRpZWp1bi5jaGVu4oCdIg==?= <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [v5][PATCH 2/6] powerpc/book3e: store critical/machine/debug
 exception thread info
References: <1371724110-8250-1-git-send-email-tiejun.chen@windriver.com>	
 <1371724110-8250-3-git-send-email-tiejun.chen@windriver.com>
 <1382136213.7979.908.camel@snotra.buserror.net>
In-Reply-To: <1382136213.7979.908.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/19/2013 06:43 AM, Scott Wood wrote:
> On Thu, 2013-06-20 at 18:28 +0800, Tiejun Chen wrote:
>> We need to store thread info to these exception thread info like something
>> we already did for PPC32.
>>
>> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
>> ---
>>   arch/powerpc/kernel/exceptions-64e.S |   15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
>> index 4d8e57f..07cf657 100644
>> --- a/arch/powerpc/kernel/exceptions-64e.S
>> +++ b/arch/powerpc/kernel/exceptions-64e.S
>> @@ -67,6 +67,18 @@
>>   	std	r10,PACA_##level##_STACK(r13);
>>   #endif
>>
>> +/* Store something to exception thread info */
>> +#define	BOOK3E_STORE_EXC_LEVEL_THEAD_INFO(type)					\
>> +	ld	r14,PACAKSAVE(r13);						\
>> +	CURRENT_THREAD_INFO(r14, r14);						\
>> +	CURRENT_THREAD_INFO(r15, r1);						\
>> +	ld	r10,TI_FLAGS(r14);		     				\
>> +	std	r10,TI_FLAGS(r15);			     			\
>> +	ld	r10,TI_PREEMPT(r14);		     				\
>> +	std	r10,TI_PREEMPT(r15);		     				\
>> +	ld	r10,TI_TASK(r14);			     			\
>> +	std	r10,TI_TASK(r15);
>
> Where is "type" used?
>

Yes, its noting now but its worth leaving this to extend something in the future.

> BTW, no need for a BOOK3E prefix for things local to this file.
>

What about "EXC_LEVEL_EXCEPTION_PROLOG"? Please see next version.

Thanks,

Tiejun
