Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sCWwJ6KmGzDr3R
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 20:30:24 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7FASkb7008828
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 06:30:23 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24t029a2w6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 06:30:22 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 15 Aug 2016 06:30:21 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: christophe leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 6/6] powerpc/8xx: implementation of huge pages
In-Reply-To: <55f9f338-a098-96e0-c753-2e83045bedab@c-s.fr>
References: <cover.1471020646.git.christophe.leroy@c-s.fr>
 <15e0fa7a312245e681cb9ca18ffb875c7820e5fc.1471020647.git.christophe.leroy@c-s.fr>
 <8760r3a0md.fsf@skywalker.in.ibm.com>
 <55f9f338-a098-96e0-c753-2e83045bedab@c-s.fr>
Date: Mon, 15 Aug 2016 16:00:14 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <87d1la4955.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

christophe leroy <christophe.leroy@c-s.fr> writes:

> Le 14/08/2016 =C3=A0 16:25, Aneesh Kumar K.V a =C3=A9crit :
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>
>>> The 8xx has 512k and 8M pages. This patch implements hugepages using
>>> those sizes.
>>>
>>> On the 8xx, the size of pages is in the PGD entry,
>>> using PS field (bits 28-29):
>>> 00 : Small pages (4k or 16k)
>>> 01 : 512k pages
>>> 10 : reserved
>>> 11 : 8M pages
>>>
>>> The implementation uses a mix of what is used on BOOKS and BOOKE,
>>> as 512k pages are in HUGEPTE tables while for 8M pages we have
>>> several PGD entries pointing on a leaf HUGEPTE entry
>>>
>>> For the time being, we do not support CPU15 ERRATA if HUGETLB is
>>> selected
>>
>> Can you also document here the format for linux page table with different
>> huge page size. ?
>
> Euh ... isn't it what I do when explaining the use of the PS field in=20
> the PGD entry ? That's the thing, that's how the 8xx knows how it is a=20
> huge page, and that's how Linux will know it is one. On the 8xx, the=20
> Linux PGD entry (almost) match the L1 MMU entry and the Linux PTE almost=
=20
> match the L2 MMU entry (some bits are copied from the PTE to the L1=20
> entry and then removed from the value writen to the L2 MMU entry)
>

Sorry if that answer was obvious in the commit message. I haven't looked
at 8xx pagetable format closely to understand the details. Now with your
reply to the earlier email, I looked at the changes again and wonder
whether we can document details like.

8xx uses a two level page table with two different linux page size
support (4k and 16k). 8xx also support two different hugepage sizes
512k and 8M. Inorder to support then on linux we define two different
page table layout.

For 512K hugepage size a pgd entry have the below format
[<hugepte address >0100] . The hugepte table allocated will contain <x>
entries pointing to 512K huge pte.

For 8M multiple pgd entries point to the same hugepte address. and pgd
entry will have the below format
[<hugepte address>1100]. The hugepte table allocated will only have one
entry.

I agree that this is the same details you explained in the commit
messages. But calling out all details will help anybody reading the code
later.

-aneesh
