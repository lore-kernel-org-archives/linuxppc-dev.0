Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A82E1A0007
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 16:13:14 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 10 Mar 2016 15:13:13 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CC1543578057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 16:13:04 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2A5CuMb59900042
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 16:13:04 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2A5CVk2021205
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 16:12:32 +1100
Message-ID: <56E10227.2010608@linux.vnet.ibm.com>
Date: Thu, 10 Mar 2016 10:42:07 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
CC: hughd@google.com, kirill@shutemov.name, n-horiguchi@ah.jp.nec.com,
 mgorman@techsingularity.net, akpm@linux-foundation.org
Subject: Re: [RFC 6/9] powerpc/hugetlb: Enable ARCH_WANT_GENERAL_HUGETLB for
 BOOK3S 64K
References: <1457525450-4262-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1457525450-4262-6-git-send-email-khandual@linux.vnet.ibm.com>
 <8760wv1kzr.fsf@linux.vnet.ibm.com>
In-Reply-To: <8760wv1kzr.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/10/2016 01:28 AM, Aneesh Kumar K.V wrote:
> Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:
> 
>> > [ text/plain ]
>> > This enables ARCH_WANT_GENERAL_HUGETLB for BOOK3S 64K in Kconfig.
>> > It also implements a new function 'pte_huge' which is required by
>> > function 'huge_pte_alloc' from generic VM. Existing BOOK3S 64K
>> > specific functions 'huge_pte_alloc' and 'huge_pte_offset' (which
>> > are no longer required) are removed with this change.
>> >
> You want this to be the last patch isn't it ? And you are mixing too

Yeah, it should be the last one.

> many things in this patch. Why not do this
> 
> * book3s specific hash pte routines
> * book3s add conditional based on GENERAL_HUGETLB
> * Enable GENERAL_HUGETLB for 64k page size config

which creates three separate patches ?
