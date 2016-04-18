Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpDZW11Q4zDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 13:45:55 +1000 (AEST)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qpDZV5wNwz9sDb
 for <linuxppc-dev@ozlabs.org>; Mon, 18 Apr 2016 13:45:54 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Mon, 18 Apr 2016 13:45:53 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B09FA3578058
 for <linuxppc-dev@ozlabs.org>; Mon, 18 Apr 2016 13:45:44 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3I3ja6m10485934
 for <linuxppc-dev@ozlabs.org>; Mon, 18 Apr 2016 13:45:44 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3I3jBXF031174
 for <linuxppc-dev@ozlabs.org>; Mon, 18 Apr 2016 13:45:12 +1000
Subject: Re: [v4, 2/3] ppc64/book3s: make some room for common interrupt
 vector code
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <3qmZVp4lgdz9t5C@ozlabs.org>
 <1460725197.22415.7.camel@ellerman.id.au>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Message-ID: <5714582D.7070606@linux.vnet.ibm.com>
Date: Mon, 18 Apr 2016 09:14:45 +0530
MIME-Version: 1.0
In-Reply-To: <1460725197.22415.7.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 04/15/2016 06:29 PM, Michael Ellerman wrote:
> On Fri, 2016-04-15 at 21:06 +1000, Michael Ellerman wrote:
>> Hi Hari,
>>
>> Thanks for persisting with this.
>>
>> On Thu, 2016-07-04 at 21:58:50 UTC, Hari Bathini wrote:
>>> With the previous patch, we choke out whatever little space is left
>>> below 0x7000 (FWNMI hard block) while there is a hole of ~1400 bytes
>>> below __end_interrupts marker when CONFIG_CBE_RAS is disabled.
>>> Considering CONFIG_CBE_RAS is not enabled by default for BOOK3S, this
>>> is not a desirable scenario especially when we have to worry about
>>> each additional instruction that goes below 0x7000.
>>>
>>> Memory region from 0x1800 to 0x4000 is dedicated for common interrupt
>>> vector code. Also, we never hit an interrupt below 0x300 when IR=DR=1
>>> implying memory region between 0x4000 to 0x4300 can also be used for
>>> common interrupt vector code. So, we can effectively use memory region
>>> between 0x1800 to 0x4300 for common interrupt vector code.
>> On Power9 the system-call-vectored instruction will use the region at 0x3000, so
>> moving code into that space is not a good long term plan.
>>
>> I'll take your v2 and put it in next next week.
> I'll add this fixes line, which I think is correct:
>
> Fixes: c1fb6816fb1b ("powerpc: Add relocation on exception vector handlers")

Yeah. Thanks!

> cheers
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
