Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sCWxw37jHzDr3S
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 20:31:48 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7FASpEC059636
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 06:31:46 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24tgxt2rj6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 06:31:45 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 15 Aug 2016 04:31:45 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: christophe leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] powerpc/8xx: implementation of huge pages
In-Reply-To: <a86b0ad2-3a9f-c782-735d-da8072d7b0e1@c-s.fr>
References: <cover.1471020646.git.christophe.leroy@c-s.fr>
 <8737m7a0j7.fsf@skywalker.in.ibm.com>
 <a86b0ad2-3a9f-c782-735d-da8072d7b0e1@c-s.fr>
Date: Mon, 15 Aug 2016 16:01:37 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <87a8ge492u.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

christophe leroy <christophe.leroy@c-s.fr> writes:

> Le 14/08/2016 =C3=A0 16:27, Aneesh Kumar K.V a =C3=A9crit :
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>
>>> This set provides implementation of huge pages on the 8xx
>>>
>>> Christophe Leroy (6):
>>>   powerpc: port 64 bits pgtable_cache to 32 bits
>>>   powerpc: fix usage of _PAGE_RO in hugepage
>>>   powerpc/8xx: use r3 to scratch CR in ITLBmiss
>>>   powerpc/8xx: Move additional DTLBMiss handlers out of exception area
>>>   powerpc/8xx: make user addr DTLB miss the short path
>>>   powerpc/8xx: implementation of huge pages
>>
>> Patch 2,3,4,5 are not really related to hugepage implementation right ?
>> May be that can be sent as a separate series ?
>>
>
> Patch 2 is a lack in gup_hugepte: on 8xx, _PAGE_RW (hence _PAGE_WRITE)=20
> is defined as 0 and _PAGE_RO must be set when the page in not writeable.=
=20
> So that's a prerequisite to implementation of huge page
>
> Patch 3, 4, 5 are prerequisits for the implementation of huge page=20
> handling in the TLB miss handlers:
> * 3: for huge pages implementation we need to branch base of value of=20
> bit 28 and 29 of the PGD entry. For this we need to preserve CR.
> * 4: With the instructions related to hugepages, there is not enough=20
> space anymore in the TLB Exception areas, so part of the it has to be=20
> moved away.
> * 5: That one might be seen as not directly related to hugepages, but it=
=20
> requires patch 3.
>
> Maybe I should reorder into 3, 4, 5, 2, 1, 6 ?
>

Can't 3,4,5,2 be merged independent of the series ? Reading then
suggested they are either fixes or performance improvements ?

-aneesh
