Return-Path: <srs0=mtoa=kx=linux.ibm.com=aneesh.kumar@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lwVp70WBzDqhV
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 01:37:22 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41lwVp5NTKz8svK
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 01:37:22 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41lwVp0cdlz9s1c
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2018 01:37:21 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w78FOJu3058948
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2018 11:37:20 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kr1evnpe4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 08 Aug 2018 11:37:19 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 8 Aug 2018 09:37:19 -0600
Subject: Re: [PATCH v7 8/9] powerpc/mce: Add sysctl control for recovery
 action on MCE.
To: Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>, Ananth Narayan <ananth@in.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
References: <153365127532.14256.1965469477086140841.stgit@jupiter.in.ibm.com>
 <153365146712.14256.11869543914717297278.stgit@jupiter.in.ibm.com>
 <87o9ecaovz.fsf@concordia.ellerman.id.au>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Wed, 8 Aug 2018 21:07:11 +0530
MIME-Version: 1.0
In-Reply-To: <87o9ecaovz.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d08a7794-e5c2-2b05-c21a-ae5a7baa7d88@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/08/2018 08:26 PM, Michael Ellerman wrote:
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> Introduce recovery action for recovered memory errors (MCEs). There are
>> soft memory errors like SLB Multihit, which can be a result of a bad
>> hardware OR software BUG. Kernel can easily recover from these soft errors
>> by flushing SLB contents. After the recovery kernel can still continue to
>> function without any issue. But in some scenario's we may keep getting
>> these soft errors until the root cause is fixed. To be able to analyze and
>> find the root cause, best way is to gather enough data and system state at
>> the time of MCE. Hence this patch introduces a sysctl knob where user can
>> decide either to continue after recovery or panic the kernel to capture the
>> dump.
> 
> I'm not convinced we want this.
> 
> As we've discovered it's often not possible to reconstruct what happened
> based on a dump anyway.
> 
> The key thing you need is the content of the SLB and that's not included
> in a dump.
> 
> So I think we should dump the SLB content when we get the MCE (which
> this series does) and any other useful info, and then if we can recover
> we should.
> 

The reasoning there is what if we got multi-hit due to some corruption 
in slb_cache_ptr. ie. some part of kernel is wrongly updating the paca 
data structure due to wrong pointer. Now that is far fetched, but then 
possible right?. Hence the idea that, if we don't have much insight into 
why a slb multi-hit occur from the dmesg which include slb content, 
slb_cache contents etc, there should be an easy way to force a dump that 
might assist in further debug.

-aneesh
