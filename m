Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B5D71A04D4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 22:23:25 +1100 (AEDT)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 052EC140BA7
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2016 22:23:25 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 24 Feb 2016 21:23:24 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id F34943578056
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2016 22:23:21 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1OBNDjf8716606
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2016 22:23:21 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1OBMnkN032566
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2016 22:22:49 +1100
Message-ID: <56CD9276.9040105@linux.vnet.ibm.com>
Date: Wed, 24 Feb 2016 16:52:30 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Kirill A. Shutemov" <kirill@shutemov.name>
CC: Linux PPC dev <linuxppc-dev@ozlabs.org>, Hugh Dickins <hughd@google.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 kirill.shutemov@linux.intel.com
Subject: Re: Question on follow_page_mask
References: <56CC5B59.4030902@linux.vnet.ibm.com>
 <20160223140349.GA21820@node.shutemov.name>
In-Reply-To: <20160223140349.GA21820@node.shutemov.name>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/23/2016 07:33 PM, Kirill A. Shutemov wrote:
> On Tue, Feb 23, 2016 at 06:45:05PM +0530, Anshuman Khandual wrote:
>> Not able to understand the first code block of follow_page_mask
>> function. follow_huge_addr function is expected to find the page
>> struct for the given address if it turns out to be a HugeTLB page
>> but then when it finds the page we bug on if it had been called
>> with FOLL_GET flag.
>>
>> 	page = follow_huge_addr(mm, address, flags & FOLL_WRITE);
>> 	if (!IS_ERR(page)) {
>> 		BUG_ON(flags & FOLL_GET);
>> 		return page;
>> 	}
>>
>> do_move_page_to_node_array calls follow_page with FOLL_GET which
>> in turn calls follow_page_mask with FOLL_GET. On POWER, the
>> function follow_huge_addr is defined and does not return -EINVAL
>> like the generic one. It returns the page struct if its a HugeTLB
>> page. Just curious to know what is the purpose behind the BUG_ON.
> 
> I would guess requesting pin on non-reclaimable page is considered
> useless, meaning suspicius behavior. BUG_ON() is overkill, I think.
> WARN_ON_ONCE() would make it.

pin on non-reclaimable page ? I thought the page reference is obtained
for page migration purpose only. I may be missing something here.

> 
> Not that this follow_huge_addr() on Power is not reachable via
> do_move_page_to_node_array(), because the vma is !vma_is_migratable().

Was experimenting with that enabled via ARCH_ENABLE_HUGEPAGE_MIGRATION.
