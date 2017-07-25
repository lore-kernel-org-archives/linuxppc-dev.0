Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGmSr3JWWzDrCs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 15:07:24 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6P53gAm049937
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 01:07:21 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bwwq43xcp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 01:07:21 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 25 Jul 2017 01:07:20 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6P57IrX25755880
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 05:07:18 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF797AC03F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 01:07:29 -0400 (EDT)
Received: from [9.124.35.86] (unknown [9.124.35.86])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP id 61FA4AC03A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 01:07:29 -0400 (EDT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/mm: Disable registering 16G hugepage size for
 powernv platform
To: linuxppc-dev@lists.ozlabs.org
References: <1500881167-9389-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87wp6yjfia.fsf@concordia.ellerman.id.au>
Date: Tue, 25 Jul 2017 10:37:14 +0530
MIME-Version: 1.0
In-Reply-To: <87wp6yjfia.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <5f0f7a59-1d8d-039a-9176-2e2b947b2318@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07/24/2017 03:58 PM, Michael Ellerman wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>
>> We don't support allocating them runtime. Only supported mechanism as of now is
>> HMC based hypervisor interface. So disable 16G hugetlb on powernv platform
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>
>> May be this should go to -stable ?. To show the 16G pagesize in
>> /sys/kernel/mm/hugepages/ confuse users
> It's a bit of a hack :/
>
> 16G also shows up on pseries, when there are no pages pre-allocated,
> which is also confusing.
>
> Ideally we'd only show sizes that can be allocated at runtime, OR were
> preallocated, regardless of platform.
>
> Is there an easy way to do that?
>
>


That is tricky, we are are going to enable 16G hugetlb on powernv with a 
followup patch. In that series we depend on the specifying hugetlb page 
count via kernel command line. The way above kernel command line parsing 
work is by looking at the hugetlb hstate which got allocated before and 
then assign the number of hugepages to that hstate. What you are asking 
is to fail the creating of hstate based on number of hugepages.

For now there is no way of using 16G hugepage on powernv. This patch 
address that issue by not showing 16G as a supported hugetlb page. In 
the later series, we will enable 16G hugetlb for powernv
and at which point both pseries and powernv behavior will remain consistent.

-aneesh
