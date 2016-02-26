Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (unknown [129.33.205.208])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 57ED21A04B8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 20:57:21 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 26 Feb 2016 04:57:18 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 3FDB8C90041
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 04:57:12 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1Q9vEd731523070
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 09:57:15 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1Q9rHUH000998
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 04:53:17 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4 11/18] powerpc/mm: Hugetlbfs is book3s_64 and
 fsl_book3e (32 or 64)
In-Reply-To: <20160225054106.GH18753@oak.ozlabs.ibm.com>
References: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1456202900-5454-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160225054106.GH18753@oak.ozlabs.ibm.com>
Date: Fri, 26 Feb 2016 15:27:10 +0530
Message-ID: <8737sfkd55.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@ozlabs.org> writes:

> On Tue, Feb 23, 2016 at 10:18:13AM +0530, Aneesh Kumar K.V wrote:
>> We move large part of fsl related code to hugetlbpage-book3e.c.
>> Only code movement. This also avoid #ifdef in the code.
>> 
>> Eventhough we allow hugetlbfs only for book3s 64 and fsl book3e, I am
>> still retaining the #ifdef in hugetlbpage-book3e.c. It looks like there
>> was an attempt to support hugetlbfs on other non hash platforms. I
>> didn't want to loose that work.
>
> Well... that stuff is always in git.  It seems that the only 64-bit
> non-Freescale Book E platform we had was A2, and that code got deleted
> because the product was never released.
>
> You get rid of some but not all of the ifdefs in hugetlbpage-book3e.c,
> and the result is a bit confusing (see below).  In fact that file will
> only get compiled for Freescale Book E processors, because the
> Makefile has an ifdef on HUGETLB_PAGE, which ultimately depends on
> SYS_SUPPORTS_HUGETLBFS, which is only set for Freescale Book E and
> 64-bit server.
>
> However, a larger question is why this cleanup is necessary for
> preparing for the radix tree.  Nothing in the following patches in
> this series seems to depend on this patch.


I am putting together radix changes on top of the PTE rewrite patch
series and I thought of retaining most of the code cleanup because
that makes the applying further patches easy. This was mostly needed so
that we can update hugetlb for radix easily. 

https://github.com/kvaneesh/linux/commit/31e7c351e8a2fd9e347f9837e9e765b648786e7a

I haven't got that change on top of my current tree yet. IMHO I
found the cleanup easier. I agree that I was focusing mostly on book3s
and was trying to keep nonhash as close to the original version. 

I can move this cleanup as a separate series if it is confusing to look
at it related to radix preparation. If the cleanup is not helping, let
me know, we can add them later along with rest of radix changes if
needed.

The most important change in this series that we need to get merged in
the next merge window is the 4 level page table. Rest of the patches are
all code movement/cleanups.

-aneesh
