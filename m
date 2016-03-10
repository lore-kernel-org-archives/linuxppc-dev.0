Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 03A341A0007
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 16:06:09 +1100 (AEDT)
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 10 Mar 2016 10:36:06 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2A55g4D15729080
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 10:35:42 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2AAYpPo029989
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 16:04:54 +0530
Message-ID: <56E100AF.9060501@linux.vnet.ibm.com>
Date: Thu, 10 Mar 2016 10:35:51 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
CC: hughd@google.com, kirill@shutemov.name, n-horiguchi@ah.jp.nec.com,
 mgorman@techsingularity.net, akpm@linux-foundation.org
Subject: Re: [RFC 9/9] selfttest/powerpc: Add memory page migration tests
References: <1457525450-4262-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1457525450-4262-9-git-send-email-khandual@linux.vnet.ibm.com>
 <8737rz1kvq.fsf@linux.vnet.ibm.com>
In-Reply-To: <8737rz1kvq.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/10/2016 01:31 AM, Aneesh Kumar K.V wrote:
> Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:
> 
>> > [ text/plain ]
>> > This adds two tests for memory page migration. One for normal page
>> > migration which works for both 4K or 64K base page size kernel and
>> > the other one is for huge page migration which works only on 64K
>> > base page sized 16MB huge page implemention at the PMD level.
>> >
> can you also add the test in this commit
> e66f17ff717 ("mm/hugetlb: take page table lock in follow_huge_pmd()")

Thought about it but thats kind of bit tricky. All self tests have finite
runtime. Test case in that commit has two processes which execute for ever
and try to create the race condition. We can try to run it for *some time*
looking for races instead ?
