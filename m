Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D32D91A005D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 14:38:36 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 10 Mar 2016 13:38:34 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 910F72BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 14:38:19 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2A3cBek57213116
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 14:38:19 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2A3bksW005534
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 14:37:47 +1100
Message-ID: <56E0EBF7.3040104@linux.vnet.ibm.com>
Date: Thu, 10 Mar 2016 09:07:27 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
CC: hughd@google.com, aneesh.kumar@linux.vnet.ibm.com, kirill@shutemov.name,
 n-horiguchi@ah.jp.nec.com, mgorman@techsingularity.net,
 akpm@linux-foundation.org
Subject: Re: [RFC 5/9] powerpc/mm: Split huge_pte_offset function for BOOK3S
 64K
References: <1457525450-4262-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1457525450-4262-5-git-send-email-khandual@linux.vnet.ibm.com>
 <56E0AA59.4030905@intel.com>
In-Reply-To: <56E0AA59.4030905@intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/10/2016 04:27 AM, Dave Hansen wrote:
> On 03/09/2016 04:10 AM, Anshuman Khandual wrote:
>> > Currently the 'huge_pte_offset' function has only one version for
>> > all the configuations and platforms. This change splits the function
>> > into two versions, one for 64K page size based BOOK3S implementation
>> > and the other one for everything else. This change is also one of the
>> > prerequisites towards enabling GENERAL_HUGETLB implementation for
>> > BOOK3S 64K based huge pages.
> I think there's a bit of background missing here for random folks on
> linux-mm to make sense of these patches.
> 
> What is BOOK3S and what does it mean for these patches?  Why is its 64K

BOOK3S is the server type in powerpc family of processors which can support
multiple base page sizes like 64K and 4K.

> page size implementation different than all the others?  Is there a 4K
> page size BOOK3S?

It supports huge pages of size 16M as well as 16G and their implementations
are different with respect to base page sizes of 64K and 4K.

Patches 1, 2 and 3 are generic VM changes and the rest are powerpc specific
changes. Should I have split them accordingly and send out differently for
generic and powerpc specific reviews ?
