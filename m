Return-Path: <B10716@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 033402C0097
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 22:36:37 +1000 (EST)
Received: from mail149-co1 (localhost [127.0.0.1])	by
 mail149-co1-R.bigfish.com (Postfix) with ESMTP id 5B2415C0100	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 12:36:30 +0000 (UTC)
Received: from CO1EHSMHS013.bigfish.com (unknown [10.243.78.238])	by
 mail149-co1.bigfish.com (Postfix) with ESMTP id F02E9D0004A	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 12:36:27 +0000 (UTC)
Message-ID: <51CAE047.8030605@freescale.com>
Date: Wed, 26 Jun 2013 15:36:23 +0300
From: Tudor Laurentiu <Laurentiu.Tudor@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: powerpc/85xx: Move ePAPR paravirt initialization earlier
References: <1362498756-395-1-git-send-email-Laurentiu.Tudor@freescale.com>
 <20130625231404.GA29587@home.buserror.net>
In-Reply-To: <20130625231404.GA29587@home.buserror.net>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/26/2013 02:14 AM, Scott Wood wrote:
> On Tue, Mar 05, 2013 at 05:52:36PM +0200, Laurentiu TUDOR wrote:
>> From: Tudor Laurentiu<laurentiu.tudor@freescale.com>
>>
>> The ePAPR para-virtualization needs to happen very early
>> otherwise the bytechannel based console will silently
>> drop some of the early boot messages.
>>
>> Before this patch, this is how the kernel log started:
>> -----------------------------------------------------
>>   >  Brought up 2 CPUs
>>   >  devtmpfs: initialized
>>   >  NET: Registered protocol family 16
>>   [...]
>> -----------------------------------------------------
>>
>> After the patch the early messages show up:
>> -----------------------------------------------------
>>   >  Using P5020 DS machine description
>>   >  MMU: Supported page sizes
>>   >           4 KB as direct
>>   >        4096 KB as direct
>>   [...]
>> -----------------------------------------------------
>>
>> At console init, the kernel tried to flush the log buffer.
>> Since the paravirt was not yet initialized the console write
>> function failed silently, thus losing the buffered messages.
> [snip]
>> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
>> index 6da881b..ce092ac 100644
>> --- a/arch/powerpc/kernel/setup_64.c
>> +++ b/arch/powerpc/kernel/setup_64.c
>> @@ -66,6 +66,7 @@
>>   #include<asm/code-patching.h>
>>   #include<asm/kvm_ppc.h>
>>   #include<asm/hugetlb.h>
>> +#include<asm/epapr_hcalls.h>
>>
>>   #include "setup.h"
>>
>> @@ -599,6 +600,8 @@ void __init setup_arch(char **cmdline_p)
>>   	/* Initialize the MMU context management stuff */
>>   	mmu_context_init();
>>
>> +	epapr_paravirt_init();
>> +
>>   	kvm_linear_init();
>>
>>   	/* Interrupt code needs to be 64K-aligned */
>
> Is this early enough?  There's udbg activity before this.  Maybe it
> should even go before udbg_early_init...

Right. I'll try moving it in machine_init().

> This would require converting
> the code to use the early device tree functions.
>

I see. Had a look at that api and it seems pretty limited.
I couldn't find a simple way of reading a property other than scanning 
the entire tree with of_scan_flat_dt().

---
Best Regards, Laurentiu
