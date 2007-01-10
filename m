Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C446EDDE22
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 07:56:07 +1100 (EST)
In-Reply-To: <20070110231322.12c8add7@localhost.localdomain>
References: <20070110011124.20342.38130.stgit@localhost.localdomain>
	<B1664D59-5C48-45DF-8C53-5E1AE6AEDAF4@kernel.crashing.org>
	<20070110231322.12c8add7@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <21AA3C6D-75E2-4A5D-852A-5D745CA2C5FF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/5] [POWERPC] cpm2: Updates for CPM2 pic
Date: Wed, 10 Jan 2007 14:55:04 -0600
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 10, 2007, at 2:13 PM, Vitaly Bordug wrote:

> On Wed, 10 Jan 2007 11:02:52 -0600
> Kumar Gala wrote:
>
>>
>> On Jan 9, 2007, at 7:11 PM, Vitaly Bordug wrote:
>>
>>>
>>> This contains important fixes for the CPM2 PIC code. Eliminated
>>> CPM_IRQ_OFFSET, pulling the respective interrupt numbers from the
>>> interrupt
>>> mapping. Updated devicetree files to reflect that. Changed direct
>>> IC-related IO accesses to the IO accessors.
>>>
>>> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
>>> ---
>>
>> [snip]
>>
>>> diff --git a/include/asm-powerpc/mpc8260.h b/include/asm-powerpc/
>>> mpc8260.h
>>> new file mode 100644
>>> index 0000000..c2adcb0
>>> --- /dev/null
>>> +++ b/include/asm-powerpc/mpc8260.h
>>> @@ -0,0 +1,32 @@
>>> +/*
>>> + * Since there are many different boards and no standard
>>> configuration,
>>> + * we have a unique include file for each.  Rather than change
>>> every
>>> + * file that has to include MPC8260 configuration, they all include
>>> + * this one and the configuration switching is done here.
>>> + */
>>> +#ifdef __KERNEL__
>>> +#ifndef __ASM_PPC_MPC8260_H__
>>> +#define __ASM_PPC_MPC8260_H__
>>> +
>>> +
>>> +#ifdef CONFIG_8260
>>> +
>>> +#if defined(CONFIG_PQ2ADS) || defined (CONFIG_PQ2FADS)
>>> +#include <platforms/82xx/pq2ads.h>
>>> +#endif
>>
>> What's defined in pq2ads.h that is needed by other code?
>>
> holding CPM_MAP_ADDR -- not everywhere in the current code it could  
> be pulled from the devtree.
> Actually, I have it addressed, but that is pretty big mod that  
> could not be called bugfix and will hopefully be merged in next  
> window.

Ok, do you mind adding a comment about that so we make sure it gets  
cleaned up for 2.6.21

- k
