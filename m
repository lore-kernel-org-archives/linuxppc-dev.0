Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2nK20tgKzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 12:03:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Oliver O'Halloran <oohall@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, arbab@linux.vnet.ibm.com,
 linux-nvdimm@lists.01.org
Subject: Re: [PATCH 6/9] powerpc, mm: Enable ZONE_DEVICE on powerpc
In-Reply-To: <20170412104337.535c5abb@canb.auug.org.au>
References: <20170411174233.21902-1-oohall@gmail.com>
 <20170411174233.21902-7-oohall@gmail.com>
 <20170412104337.535c5abb@canb.auug.org.au>
Date: Wed, 12 Apr 2017 12:03:47 +1000
Message-ID: <87h91uv0u4.fsf@concordia.ellerman.id.au>
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

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi Oliver,
>
> On Wed, 12 Apr 2017 03:42:30 +1000 Oliver O'Halloran <oohall@gmail.com> wrote:
>>
>> Flip the switch. Running around and screaming "IT'S ALIVE" is optional,
>> but recommended.
>> 
>> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
>> ---
>>  mm/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 43d000e44424..d696af58f97f 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -724,7 +724,7 @@ config ZONE_DEVICE
>>  	depends on MEMORY_HOTPLUG
>>  	depends on MEMORY_HOTREMOVE
>>  	depends on SPARSEMEM_VMEMMAP
>> -	depends on X86_64 #arch_add_memory() comprehends device memory
>> +	depends on (X86_64 || PPC_BOOK3S_64)  #arch_add_memory() comprehends device memory
>>  
>
> That's fine, but at what point do we create
> CONFIG_ARCH_HAVE_ZONE_DEVICE, replace the "depends on
> <archs/platforms>" above with "depends on ARCH_HAVE_ZONE_DEVICE" and
> select that from the appropriate places?

You mean CONFIG_HAVE_ZONE_DEVICE :)

A patch to do that, and update x86, would be a good precursor to this
series. It could probably go in right now, and be in place for when this
series lands.

cheers
