Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41BE41A045A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 15:34:02 +1100 (AEDT)
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8CDCC1400D2
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2014 15:34:01 +1100 (AEDT)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 5 Dec 2014 10:03:59 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4C4521258043
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2014 10:04:16 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB54YYwU48103542
 for <linuxppc-dev@ozlabs.org>; Fri, 5 Dec 2014 10:04:34 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB54Xuh7029983
 for <linuxppc-dev@ozlabs.org>; Fri, 5 Dec 2014 10:03:56 +0530
Message-ID: <548135B4.20902@linux.vnet.ibm.com>
Date: Fri, 05 Dec 2014 10:03:56 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/book3s: Fix flush_tlb cpu_spec hook to take a generic
 argument.
References: <20141128223838.B21E51401B1@ozlabs.org>
 <547D7FF2.3010901@linux.vnet.ibm.com> <1417685753.31400.1.camel@concordia>
In-Reply-To: <1417685753.31400.1.camel@concordia>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/04/2014 03:05 PM, Michael Ellerman wrote:
> On Tue, 2014-12-02 at 14:31 +0530, Mahesh Jagannath Salgaonkar wrote:
>> On 11/29/2014 04:08 AM, Michael Ellerman wrote:
>>> On Tue, 2014-23-09 at 03:53:54 UTC, Mahesh Salgaonkar wrote:
>>>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>>>
>>>> The flush_tlb hook in cpu_spec was introduced as a generic function hook
>>>> to invalidate TLBs. But the current implementation of flush_tlb hook
>>>> takes IS (invalidation selector) as an argument which is architecture
>>>> dependent. Hence, It is not right to have a generic routine where caller
>>>> has to pass non-generic argument.
>>>>
>>>> This patch fixes this and makes flush_tlb hook as high level API.
>>>>
>>>> The old code used to call flush_tlb hook with IS=0 (single page) resulting
>>>> partial invalidation of TLBs which is not right. This fix now makes
>>>> sure that whole TLB is invalidated to be able to successfully recover from
>>>> TLB and ERAT errors.
>>>
>>> Which old code? You mean the MCE code I think. That's a bug fix, so it should
>>> be a separate patch.
>>
>> Yes. MCE code. Since this patch re-factors the code that takes IS as
>> direct argument, having a separate fix patch does not make any sense and
>> would get overwritten by this patch anyway.
> 
> That's irrelevant.
> 
> The fix will go to stable, the refactor will not.
> 
> Please do the MCE fix as a separate, preceeding patch.

Done. Sent out a separate fix patch for stable
https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-December/123310.html

Thanks,
-Mahesh.
