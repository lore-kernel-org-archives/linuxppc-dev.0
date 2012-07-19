Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C77D62C009B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2012 18:02:01 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Thu, 19 Jul 2012 07:41:45 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6J7r6Ij64487516
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2012 17:53:06 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6J81GHw026192
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2012 18:01:16 +1000
Message-ID: <5007BEB2.5060405@in.ibm.com>
Date: Thu, 19 Jul 2012 13:30:50 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] [powerpc] Export memory limit via device tree
References: <20120702114855.22333.95335.stgit@suzukikp.in.ibm.com>
 <1341985013.18850.29.camel@pasglop>
In-Reply-To: <1341985013.18850.29.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: mahesh@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/11/2012 11:06 AM, Benjamin Herrenschmidt wrote:
>> diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
>> index c957b12..0c9695d 100644
>> --- a/arch/powerpc/kernel/machine_kexec.c
>> +++ b/arch/powerpc/kernel/machine_kexec.c
>> @@ -207,6 +207,12 @@ static struct property crashk_size_prop = {
>>   	.value = &crashk_size,
>>   };
>>
>> +static struct property memory_limit_prop = {
>> +	.name = "linux,memory-limit",
>> +	.length = sizeof(phys_addr_t),
>> +	.value = &memory_limit,
>> +};
>> +
>
> AFAIK. phys_addr_t can change size, so instead make it point to a known
> fixes size quantity (a u64).
Ben,

Sorry for the delay in the response.

Some of the other properties are also of phys_addr_t, (e.g 
linux,crashkernel-base, linux,kernel-end ). Should we fix them as well ?

Or

Should we leave this also a phys_addr_t and let the userspace handle it ?

>
>> +
>> +	/* memory-limit is needed for constructing the crash regions */
>> +	prop = of_find_property(node, memory_limit_prop.name, NULL);
>> +	if (prop)
>> +		prom_remove_property(node, prop);
>> +
>> +	if (memory_limit)
>> +		prom_add_property(node, &memory_limit_prop);
>> +
>
> There's a patch floating around making prom_update_property properly
> handle both pre-existing and non-pre-existing props, you should probably
> base yourself on top of it. I'm about to stick that patch in powerpc
> -next
>
OK. I am testing the new patch based on the above commit. I will wait
for the clarification on the issue of the type, before I post it here.

Thanks
Suzuki
