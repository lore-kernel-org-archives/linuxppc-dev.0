Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3C5672C00FA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 18:00:20 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Wed, 11 Sep 2013 17:48:31 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1139C2BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 18:00:15 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8B7hqJd57213144
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 17:43:52 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8B80DMv010114
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 18:00:14 +1000
Message-ID: <5230231E.8070104@linux.vnet.ibm.com>
Date: Wed, 11 Sep 2013 13:30:30 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Export cpu_to_chip_id() to fix build error
References: <1378777076-4699-1-git-send-email-linux@roeck-us.net>
 <1378850610.4121.29.camel@pasglop>
In-Reply-To: <1378850610.4121.29.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/11/2013 03:33 AM, Benjamin Herrenschmidt wrote:
> On Mon, 2013-09-09 at 18:37 -0700, Guenter Roeck wrote:
>> powerpc allmodconfig build fails with:
>>
>> ERROR: ".cpu_to_chip_id" [drivers/block/mtip32xx/mtip32xx.ko] undefined!
>>
>> The problem was introduced with commit 15863ff3b (powerpc: Make chip-id
>> information available to userspace).
>
> Thanks, I'll send that to Linus asap.
>

Verified on today's Linus tree. This issue is fixed.

Thanks a lot.

-Vasant

> Ben.
>
>> Export the missing symbol.
>>
>> Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
>> Cc: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   arch/powerpc/kernel/smp.c |    1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
>> index 442d8e2..8e59abc 100644
>> --- a/arch/powerpc/kernel/smp.c
>> +++ b/arch/powerpc/kernel/smp.c
>> @@ -611,6 +611,7 @@ int cpu_to_chip_id(int cpu)
>>   	of_node_put(np);
>>   	return of_get_ibm_chip_id(np);
>>   }
>> +EXPORT_SYMBOL(cpu_to_chip_id);
>>
>>   /* Helper routines for cpu to core mapping */
>>   int cpu_core_index_of_thread(int cpu)
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
