Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A0B61A0657
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 17:54:47 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 10 Dec 2015 23:54:45 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id B5B8E19D8026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 23:42:45 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBB6seNE27000868
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 23:54:40 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBB6seB5001609
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 23:54:40 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: =?utf-8?B?6JKy5paH?= <wen.pu@powercore.com.cn>
Subject: Re: [PATCH] powerpc/powernv: pr_warn_once on unsupported OPAL_MSG type
In-Reply-To: <1449800465.21866.6.camel@ellerman.id.au>
References: <1449796103-7700-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1449800465.21866.6.camel@ellerman.id.au>
Date: Fri, 11 Dec 2015 17:54:27 +1100
Message-ID: <87zixha318.fsf@linux.vnet.ibm.com>
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

Michael Ellerman <mpe@ellerman.id.au> writes:
> On Fri, 2015-12-11 at 12:08 +1100, Stewart Smith wrote:
>> When running on newer OPAL firmware that supports sending extra
>> OPAL_MSG types, we would print a warning on *every* message received.
>> 
>> This could be a problem for kernels that don't support OPAL_MSG_OCC
>> on machines that are running real close to thermal limits and the
>> OCC is throttling the chip. For a kernel that is paying attention to
>> the message queue, we could get these notifications quite often.
>> 
>> Conceivably, future message types could also come fairly often,
>> and printing that we didn't understand them 10,000 times provides
>> no further information than printing them once.
>> 
>> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
>> index 4296d55e88f3..57cffb80bc36 100644
>> --- a/arch/powerpc/platforms/powernv/opal.c
>> +++ b/arch/powerpc/platforms/powernv/opal.c
>> @@ -278,7 +278,7 @@ static void opal_handle_message(void)
>>  
>>  	/* Sanity check */
>>  	if (type >= OPAL_MSG_TYPE_MAX) {
>> -		pr_warning("%s: Unknown message type: %u\n", __func__, type);
>> +		pr_warn_once("%s: Unknown message type: %u\n", __func__, type);
>>  		return;
>
> This will only print once, even if there are multiple unknown message types,
> are we happy with that?

I am - it's just "your firmware knows more than you do". From that, when
diagnosing, you can grab firmware version to know how many it has, and
from kernel version you'll know how many it has. There'll probably be
something printed in OPAL logs if somebody starts to care about it.

We could always hexdump out what the message is and create Yet Another
Unreadable Error Message.....
