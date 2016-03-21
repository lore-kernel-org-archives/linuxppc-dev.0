Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qT35d45GTzDq7K
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 15:39:49 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 21 Mar 2016 14:39:46 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 70ED42BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 15:39:37 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2L4dT4Z54263856
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 15:39:37 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2L4d46J025321
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 15:39:05 +1100
Subject: Re: [PATCH] cxl: fix setting of _PAGE_USER bit when handling page
 faults
To: Ian Munsie <imunsie@au1.ibm.com>
References: <1458273681-18588-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <1458282296-sup-2460@x230.ozlabs.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, benh@kernel.crashing.org
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56EF7ACF.5020506@au1.ibm.com>
Date: Mon, 21 Mar 2016 15:38:39 +1100
MIME-Version: 1.0
In-Reply-To: <1458282296-sup-2460@x230.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18/03/16 17:30, Ian Munsie wrote:
> Excerpts from andrew.donnellan's message of 2016-03-18 15:01:21 +1100:
>> Fixes: f204e0b8cedd ("cxl: Driver code for powernv PCIe based cards for
>> userspace access")
>
> It doesn't fix that since there was no cxl kernel API support at the
> time, so this wasn't a regression - just something we missed when the
> kernel api was added (I believe the broken test in the code was a left
> over from some early bringup work and would never have been exercised on
> an upstream kernel until then).

Ah, fair enough - I just looked at what git blame told me. You're right, 
it's not a fix to that commit per se. Happy to drop this tag.

> We haven't run into any problems because of this that I am aware of - do
> we have a test case for this?

I'd be surprised if it caused noticeable problems - the presence of the 
_PAGE_USER bit when it's not necessary shouldn't break anything, as 
opposed to the absence of _PAGE_USER when it is necessary. Not entirely 
sure what the test case would be.

>
>> -    if ((!ctx->kernel) || ~(dar & (1ULL << 63)))
>> +    if ((!ctx->kernel) || !(dar & (1ULL << 63)))
>
> Should it be the top two bits?

benh told me that the top bit should be enough - anything above 0x8000* 
should be kernel space.

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
