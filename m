Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7FDCC1A005D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 16:33:51 +1100 (AEDT)
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 10 Mar 2016 11:03:48 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2A5XW9v16908746
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 11:03:32 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2A5XjJD024426
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 11:03:46 +0530
Message-ID: <56E10738.7020204@linux.vnet.ibm.com>
Date: Thu, 10 Mar 2016 11:03:44 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
CC: hughd@google.com, kirill@shutemov.name, n-horiguchi@ah.jp.nec.com,
 mgorman@techsingularity.net, akpm@linux-foundation.org
Subject: Re: [RFC 4/9] powerpc/mm: Split huge_pte_alloc function for BOOK3S 64K
References: <1457525450-4262-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1457525450-4262-4-git-send-email-khandual@linux.vnet.ibm.com>
 <878u1r1l4m.fsf@linux.vnet.ibm.com>
In-Reply-To: <878u1r1l4m.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/10/2016 01:25 AM, Aneesh Kumar K.V wrote:
> Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:
> 
>> > [ text/plain ]
>> > From: root <root@ltcalpine2-lp8.aus.stglabs.ibm.com>
>> >
>> > Currently the 'huge_pte_alloc' function has two versions, one for the
>> > BOOK3S and the other one for the BOOK3E platforms. This change splits
>> > the BOOK3S version into two parts, one for the 4K page size based
>> > implementation and the other one for the 64K page sized implementation.
>> > This change is one of the prerequisites towards enabling GENERAL_HUGETLB
>> > implementation for BOOK3S 64K based huge pages.
> I really wish we reduce #ifdefs in C code and start splitting hash
> and nonhash code out where ever we can.

Okay but here we are only dealing with 64K and 4K configs inside book3s.
I guess it covers both hash and no hash implementations. Not sure if I
got it correctly.

> 
> What we really want here is a book3s version and in book3s version use
> powerpc specific huge_pte_alloc only if GENERAL_HUGETLB was not defined.

got it.

> Don't limit it to 64k linux page size. We should select between powerpc
> specific implementation and generic code using GENERAL_HUGETLB define.

Got it. will try.
