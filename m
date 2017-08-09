Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xS7D20PkGzDr2Q
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 20:43:45 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v79AcmAx036079
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Aug 2017 06:43:43 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c80byst6h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Aug 2017 06:43:43 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Wed, 9 Aug 2017 11:43:41 +0100
Subject: Re: [PATCH 05/16] mm: Protect VMA modifications using VMA sequence
 count
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, ak@linux.intel.com, mhocko@kernel.org,
 dave@stgolabs.net, jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
 benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
References: <1502202949-8138-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1502202949-8138-6-git-send-email-ldufour@linux.vnet.ibm.com>
 <20170809101241.ek4fqinqaq5qfkq4@node.shutemov.name>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Wed, 9 Aug 2017 12:43:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170809101241.ek4fqinqaq5qfkq4@node.shutemov.name>
Content-Type: text/plain; charset=utf-8
Message-Id: <f935091a-d8f9-1951-8397-f5c464a2b922@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/08/2017 12:12, Kirill A. Shutemov wrote:
> On Tue, Aug 08, 2017 at 04:35:38PM +0200, Laurent Dufour wrote:
>> The VMA sequence count has been introduced to allow fast detection of
>> VMA modification when running a page fault handler without holding
>> the mmap_sem.
>>
>> This patch provides protection agains the VMA modification done in :
>> 	- madvise()
>> 	- mremap()
>> 	- mpol_rebind_policy()
>> 	- vma_replace_policy()
>> 	- change_prot_numa()
>> 	- mlock(), munlock()
>> 	- mprotect()
>> 	- mmap_region()
>> 	- collapse_huge_page()
> 
> I don't thinks it's anywhere near complete list of places where we touch
> vm_flags. What is your plan for the rest?

The goal is only to protect places where change to the VMA is impacting the
page fault handling. If you think I missed one, please advise.

Thanks,
Laurent.
