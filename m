Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r3HPr4gtVzDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 May 2016 19:38:40 +1000 (AEST)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3r3HPr3fFWz9snl
 for <linuxppc-dev@ozlabs.org>; Mon,  9 May 2016 19:38:40 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Mon, 9 May 2016 19:38:39 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 06EA42CE8046
 for <linuxppc-dev@ozlabs.org>; Mon,  9 May 2016 19:38:37 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u499cSof64880682
 for <linuxppc-dev@ozlabs.org>; Mon, 9 May 2016 19:38:36 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u499c4Km021896
 for <linuxppc-dev@ozlabs.org>; Mon, 9 May 2016 19:38:04 +1000
Subject: Re: [2/3] powerpc/fadump: add support to specify memory range based
 size
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <3r1wDn0JV0z9t3k@ozlabs.org>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Message-ID: <57305A63.80702@linux.vnet.ibm.com>
Date: Mon, 9 May 2016 15:07:39 +0530
MIME-Version: 1.0
In-Reply-To: <3r1wDn0JV0z9t3k@ozlabs.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 05/07/2016 09:41 AM, Michael Ellerman wrote:
> On Fri, 2016-06-05 at 11:50:37 UTC, Hari Bathini wrote:
>> Currently, memory for fadump can be specified with fadump_reserve_mem=size,
>> where only a fixed size can be specified. This patch tries to extend this
>> syntax to support conditional reservation based on memory size, with the
>> below syntax:
>>
>> 	fadump_reserve_mem=<range1>:<size1>[,<range2>:<size2>,...]
>>
>> This syntax helps using the same commandline parameter for different system
>> memory sizes.
> This is basically using the crashkernel= syntax right?

Yep. One of the typical crashkernel syntax..

> So can we please reuse the crashkernel= parsing code?

but crashkernel has a few other variants which don't make sense
for fadump. To reuse the crashkernel parsing code for fadump,
it needs little bit of refactoring. Will try to do that and respin..

> cheers
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
