Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7Bdq6qXFzDqQp
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 19:17:51 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s7Bdq3SvQz9sDf
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Aug 2016 19:17:51 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u789Dw6F013828
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Aug 2016 05:17:49 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24nbyqc3hr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 08 Aug 2016 05:17:49 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 8 Aug 2016 19:17:47 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5C45E2CE8056
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Aug 2016 19:17:45 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u789HjSQ30408872
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Aug 2016 19:17:45 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u789HikJ019572
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Aug 2016 19:17:45 +1000
Subject: Re: [RESEND PATCH v3 2/2] powernv: Fix MCE handler to avoid trashing
 CR0/CR1 registers.
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <147064569946.6908.3260124681746222838.stgit@jupiter.in.ibm.com>
 <147064570604.6908.10782297574634779096.stgit@jupiter.in.ibm.com>
 <87shufskm3.fsf@concordia.ellerman.id.au>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Mon, 8 Aug 2016 14:47:41 +0530
MIME-Version: 1.0
In-Reply-To: <87shufskm3.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <27a2e7fc-5cf5-9008-4695-769dcbfd0914@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/08/2016 02:28 PM, Michael Ellerman wrote:
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
> 
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> The current implementation of MCE early handling modifies CR0/1 registers
>> without saving its old values. Fix this by moving early check for
>> powersaving mode to machine_check_handle_early().
>>
>> The power architecture 2.06 or later allows the possibility of getting
>> machine check while in nap/sleep/winkle. The last bit of HSPRG0 is set
>> to 1, if thread is woken up from winkle. Hence, clear the last bit of
>> HSPRG0 (r13) before MCE handler starts using it as paca pointer.
>>
>> Also, the current code always puts the thread into nap state irrespective
>> of whatever idle state it woke up from. Fix that by looking at
>> paca->thread_idle_state and put the thread back into same state where it
>> came from.
>>
>> Cc: stable@vger.kernel.org
> 
> The information I need is "which commit introduced the bug".

It fixes commit 1c51089: powerpc/book3s: Return from interrupt if coming
from evil context.

> Given that I can work out which stable releases we should backport the
> patch to.

It will need an backport to stable once it hits upstream.

-Mahesh.

> 
> cheers
> 
