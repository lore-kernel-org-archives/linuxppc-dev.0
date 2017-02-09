Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJld12KPVzDqGj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2017 15:35:49 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v194YXtu078600
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 23:35:47 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28gcn7hjxn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Feb 2017 23:35:46 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 9 Feb 2017 14:35:44 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D086B2BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2017 15:35:41 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v194ZXJ736831248
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Feb 2017 15:35:41 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v194Z9pe007767
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Feb 2017 15:35:09 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] powerpc/mm/radix: Update pte update sequence for pte
 clear case
In-Reply-To: <1486613729.3401.15.camel@kernel.crashing.org>
References: <1486609101-5231-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1486612188.3401.14.camel@kernel.crashing.org>
 <1486613729.3401.15.camel@kernel.crashing.org>
Date: Thu, 09 Feb 2017 10:04:51 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87zihwouc4.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Thu, 2017-02-09 at 14:49 +1100, Benjamin Herrenschmidt wrote:
>> On Thu, 2017-02-09 at 08:28 +0530, Aneesh Kumar K.V wrote:
>> > In the kernel we do follow the below sequence in different code
>> > paths.
>> > pte = ptep_get_clear(ptep)
>> > ....
>> > set_pte_at(ptep, pte)
>> > 
>> > We do that for mremap, autonuma protection update and softdirty
>> > clearing. This
>> > implies our optimization to skip a tlb flush when clearing a pte
>> > update is
>> > not valid, because for DD1 system that followup set_pte_at will be
>> > done witout
>> > doing the required tlbflush. Fix that by always doing the dd1 style
>> > pte update
>> > irrespective of new_pte value. In a later patch we will optimize
>> > the application
>> > exit case.
>> 
>> What about my change to set_pte_at() ? We seem to be overwriting
>> valid PTEs,
>> shouldn't we deal with that ?
>
> So the HW guys confirmed that the TLB will never cache a valid entry
> that has all permissions clear. That leaves the THP write problem
> though.


Which is fixed by the autonuma related changes posted at
https://lkml.kernel.org/r/1486609259-6796-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com

Right now i am running a kernel compile in loop with parallel perf
bench numa mem run to make sure we got most of the details correct.
(this is on p8)

-aneesh
