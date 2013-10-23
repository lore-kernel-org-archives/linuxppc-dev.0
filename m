Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 340C42C070D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 20:28:45 +1100 (EST)
Message-ID: <526796C2.7030902@windriver.com>
Date: Wed, 23 Oct 2013 17:28:34 +0800
From: =?UTF-8?B?IuKAnHRpZWp1bi5jaGVu4oCdIg==?= <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [v5][PATCH 1/6] powerpc/book3e: load critical/machine/debug
 exception stack
References: <1371724110-8250-1-git-send-email-tiejun.chen@windriver.com>	
 <1371724110-8250-2-git-send-email-tiejun.chen@windriver.com>
 <1382140519.7979.936.camel@snotra.buserror.net>
In-Reply-To: <1382140519.7979.936.camel@snotra.buserror.net>
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

On 10/19/2013 07:55 AM, Scott Wood wrote:
> On Thu, 2013-06-20 at 18:28 +0800, Tiejun Chen wrote:
>> We always alloc critical/machine/debug check exceptions. This is
>> different from the normal exception. So we should load these exception
>> stack properly like we did for booke.
>>
>> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
>> ---
>>   arch/powerpc/kernel/exceptions-64e.S |   49 +++++++++++++++++++++++++++++++---
>>   1 file changed, 46 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
>> index 4b23119..4d8e57f 100644
>> --- a/arch/powerpc/kernel/exceptions-64e.S
>> +++ b/arch/powerpc/kernel/exceptions-64e.S
>> @@ -36,6 +36,37 @@
>>    */
>>   #define	SPECIAL_EXC_FRAME_SIZE	INT_FRAME_SIZE
>>
>> +/* only on book3e */
>> +#define DBG_STACK_BASE		dbgirq_ctx
>> +#define MC_STACK_BASE		mcheckirq_ctx
>> +#define CRIT_STACK_BASE		critirq_ctx
>> +
>> +#ifdef CONFIG_RELOCATABLE
>> +#define LOAD_STACK_BASE(reg, level)			\
>> +	tovirt(r2,r2);					\
>> +	LOAD_REG_ADDR(reg, level##_STACK_BASE);
>
> Where does r2 come from here, where does it get used, and why do we need
> tovirt() on book3e?
>

As I remember this should be covered when we boot that capture kernel in 
kexec/kdump case.

Now this is also gone away after move forward the c code.

Thanks,

Tiejun
